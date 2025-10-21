package com.abcnews.servlet;

import com.abcnews.dao.CategoryDAO;
import com.abcnews.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

@WebServlet({"/admin/categories", "/admin/categories/index", "/admin/categories/edit/*", 
             "/admin/categories/create", "/admin/categories/update", "/admin/categories/delete", 
             "/admin/categories/reset"})
public class AdminCategoryServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        if (!checkAdminPermission(request, response)) return;
        
        // Tạo form object để bind dữ liệu
        Category form = new Category();
        String message = null;
        String error = null;
        
        try {
            // Sử dụng BeanUtils để populate form từ request parameters
            BeanUtils.populate(form, request.getParameterMap());
        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new ServletException("Lỗi bind dữ liệu form: " + e.getMessage(), e);
        }
        
        CategoryDAO dao = new CategoryDAO();
        String path = request.getServletPath();
        String pathInfo = request.getPathInfo();
        
        // Debug log
        System.out.println("AdminCategoryServlet - Path: " + path + ", PathInfo: " + pathInfo);
        System.out.println("AdminCategoryServlet - Form name: " + form.getName() + ", Form id: " + form.getId());
        
        try {
            if (path.contains("edit")) {
                // /admin/categories/edit/{id}
                if (pathInfo != null && pathInfo.length() > 1) {
                    String id = pathInfo.substring(1); // Bỏ dấu / đầu
                    try {
                        Category category = dao.getCategoryById(id);
                        if (category != null) {
                            form = category;
                        } else {
                            error = "Không tìm thấy danh mục với ID: " + id;
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        error = "Lỗi khi tải danh mục: " + e.getMessage();
                    }
                } else {
                    error = "ID danh mục không hợp lệ";
                }
                
            } else if (path.contains("create")) {
                // Thêm mới danh mục
                if (form.getName() != null && !form.getName().trim().isEmpty()) {
                    // Tạo ID tự động nếu chưa có
                    if (form.getId() == null || form.getId().trim().isEmpty()) {
                        form.setId(generateCategoryId(form.getName()));
                    }
                    
                    // Kiểm tra ID đã tồn tại chưa
                    if (dao.isCategoryExists(form.getId())) {
                        error = "❌ ID danh mục đã tồn tại: " + form.getId();
                    } else {
                        boolean success = dao.addCategory(form);
                        if (success) {
                            message = "✅ Thêm danh mục thành công!";
                            form = new Category(); // Reset form
                        } else {
                            error = "❌ Lỗi thêm danh mục!";
                        }
                    }
                } else {
                    error = "❌ Tên danh mục không được để trống!";
                }
                
            } else if (path.contains("update")) {
                // Cập nhật danh mục
                if (form.getId() != null && form.getName() != null && !form.getName().trim().isEmpty()) {
                    boolean success = dao.updateCategory(form);
                    if (success) {
                        message = "✅ Cập nhật danh mục thành công!";
                    } else {
                        error = "❌ Lỗi cập nhật danh mục!";
                    }
                } else {
                    error = "❌ Thông tin danh mục không hợp lệ!";
                }
                
            } else if (path.contains("delete")) {
                // Xóa danh mục
                if (form.getId() != null) {
                    boolean success = dao.deleteCategory(form.getId());
                    if (success) {
                        message = "✅ Xóa danh mục thành công!";
                        form = new Category(); // Reset form
                    } else {
                        error = "❌ Lỗi xóa danh mục! Có thể danh mục đang được sử dụng.";
                    }
                } else {
                    error = "❌ ID danh mục không hợp lệ!";
                }
                
            } else if (path.contains("reset") || path.contains("index") || path.equals("/admin/categories")) {
                // Reset form hoặc hiển thị danh sách
                form = new Category();
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            error = "❌ Lỗi hệ thống: " + e.getMessage();
        }
        
        // Set attributes cho JSP
        request.setAttribute("item", form);
        request.setAttribute("message", message);
        request.setAttribute("error", error);
        
        // Lấy danh sách tất cả danh mục
        try {
            List<Category> categories = dao.getAllCategories();
            request.setAttribute("list", categories);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi tải danh sách danh mục: " + e.getMessage());
        }
        
        // Forward đến JSP
        request.getRequestDispatcher("/views/admin/category-manage.jsp").forward(request, response);
    }
    
    /**
     * Kiểm tra quyền admin
     */
    private boolean checkAdminPermission(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;
    }
    
    /**
     * Tạo ID danh mục tự động từ tên
     */
    private String generateCategoryId(String name) {
        if (name == null || name.trim().isEmpty()) {
            return "CAT_" + System.currentTimeMillis();
        }
        
        // Chuyển thành chữ thường, bỏ dấu, thay khoảng trắng bằng _
        String id = name.trim().toLowerCase()
                       .replaceAll("[àáạảãâầấậẩẫăằắặẳẵ]", "a")
                       .replaceAll("[èéẹẻẽêềếệểễ]", "e")
                       .replaceAll("[ìíịỉĩ]", "i")
                       .replaceAll("[òóọỏõôồốộổỗơờớợởỡ]", "o")
                       .replaceAll("[ùúụủũưừứựửữ]", "u")
                       .replaceAll("[ỳýỵỷỹ]", "y")
                       .replaceAll("[đ]", "d")
                       .replaceAll("[^a-z0-9\\s]", "") // Chỉ giữ chữ, số, khoảng trắng
                       .replaceAll("\\s+", "_") // Thay khoảng trắng bằng _
                       .replaceAll("_+", "_"); // Loại bỏ _ liên tiếp
        
        // Đảm bảo không quá dài
        if (id.length() > 20) {
            id = id.substring(0, 20);
        }
        
        // Thêm timestamp để đảm bảo unique
        return id + "_" + (System.currentTimeMillis() % 10000);
    }
}