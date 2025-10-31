package com.abcnews.utils;

import java.util.Locale;
import java.util.ResourceBundle;
import jakarta.servlet.http.HttpServletRequest;

public class MessageUtil {
    
    private static final String BUNDLE_NAME = "global";
    private static final String DEFAULT_LANGUAGE = "vi";
    
    /**
     * Lấy message từ properties file dựa trên ngôn ngữ trong session
     */
    public static String getMessage(HttpServletRequest request, String key) {
        String language = getLanguageFromSession(request);
        return getMessage(language, key);
    }
    
    /**
     * Lấy message từ properties file với ngôn ngữ cụ thể
     */
    public static String getMessage(String language, String key) {
        try {
            Locale locale = new Locale(language);
            ResourceBundle bundle = ResourceBundle.getBundle(BUNDLE_NAME, locale);
            return bundle.getString(key);
        } catch (Exception e) {
            // Nếu không tìm thấy, dùng ngôn ngữ mặc định
            try {
                Locale defaultLocale = new Locale(DEFAULT_LANGUAGE);
                ResourceBundle defaultBundle = ResourceBundle.getBundle(BUNDLE_NAME, defaultLocale);
                return defaultBundle.getString(key);
            } catch (Exception ex) {
                // Nếu vẫn không tìm thấy, trả về key
                return key;
            }
        }
    }
    
    /**
     * Lấy ngôn ngữ từ session, mặc định là tiếng Việt
     */
    public static String getLanguageFromSession(HttpServletRequest request) {
        String language = (String) request.getSession().getAttribute("lang");
        return (language != null) ? language : DEFAULT_LANGUAGE;
    }
    
    /**
     * Kiểm tra xem ngôn ngữ có được hỗ trợ không
     */
    public static boolean isSupportedLanguage(String language) {
        return "vi".equals(language) || "en".equals(language) || "zh".equals(language);
    }
}