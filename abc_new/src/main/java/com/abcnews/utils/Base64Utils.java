package com.abcnews.utils;

import java.util.Base64;

/**
 * Lớp tiện ích (Utility Class) Base64Utils:
 * Cung cấp các phương thức tĩnh (static methods) để thực hiện
 * Mã hóa và Giải mã chuỗi theo chuẩn Base64.
 */
public class Base64Utils {
    
    /**
     * Phương thức Mã hóa (Encoding): Chuyển đổi chuỗi văn bản (String)
     * sang định dạng Base64 (String).
     * @param value Chuỗi văn bản gốc cần mã hóa (ví dụ: "admin,password123").
     * @return Chuỗi Base64 đã mã hóa.
     */
    public static String encode(String value) {
        try {
            // 1. Chuyển đổi chuỗi ký tự sang một mảng byte.
            // Phương thức này sử dụng bộ mã hóa mặc định của hệ thống (thường là UTF-8).
            byte[] bytes = value.getBytes("UTF-8");
            
            // 2. Lấy bộ mã hóa Base64 (Encoder) và mã hóa mảng byte đó thành một chuỗi.
            String encodedText = Base64.getEncoder().encodeToString(bytes);
            
            // 3. Trả về chuỗi Base64.
            return encodedText;
        } catch (Exception e) {
            System.err.println("Lỗi mã hóa Base64: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Phương thức Giải mã (Decoding): Chuyển đổi chuỗi Base64
     * trở lại chuỗi văn bản gốc (String).
     * @param value Chuỗi Base64 đã mã hóa.
     * @return Chuỗi văn bản gốc.
     */
    public static String decode(String value) {
        try {
            // 1. Lấy bộ giải mã Base64 (Decoder) và giải mã chuỗi Base64
            // trở lại thành mảng byte nhị phân gốc.
            byte[] bytes = Base64.getDecoder().decode(value);
            
            // 2. Chuyển đổi mảng byte nhị phân đã giải mã trở lại thành chuỗi ký tự.
            // Phương thức này sử dụng bộ mã hóa mặc định của hệ thống để khôi phục ký tự.
            String decodedText = new String(bytes, "UTF-8");
            
            // 3. Trả về chuỗi văn bản đã giải mã.
            return decodedText;
        } catch (Exception e) {
            System.err.println("Lỗi giải mã Base64: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Kiểm tra chuỗi có phải Base64 hợp lệ không
     */
    public static boolean isValidBase64(String value) {
        try {
            Base64.getDecoder().decode(value);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}