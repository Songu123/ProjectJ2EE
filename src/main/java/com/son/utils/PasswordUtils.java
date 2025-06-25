package com.son.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Tiện ích cho các thao tác mật khẩu: kiểm tra, mã hóa (hash), xác thực.
 */
public class PasswordUtils {

    // Regex kiểm tra độ mạnh mật khẩu
    private static final String PASSWORD_PATTERN =
            "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$";
    private static final Pattern pattern = Pattern.compile(PASSWORD_PATTERN);

    /**
     * Kiểm tra mật khẩu có đủ mạnh không theo quy tắc:
     * - Ít nhất 8 ký tự
     * - Có số, chữ thường, chữ hoa, ký tự đặc biệt
     */
    public static boolean isValidPassword(String password) {
        if (password == null) return false;
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }

    /**
     * Sinh hash bảo mật cho mật khẩu bằng BCrypt.
     */
    public static String hashPassword(String plainTextPassword) {
        if (plainTextPassword == null) return null;
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(12));
    }

    /**
     * Kiểm tra password với hash đã lưu.
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null ||
                plainPassword.isEmpty() || hashedPassword.isEmpty()) return false;
        // Normalize $2y$ to $2a$ if needed
        if (hashedPassword.startsWith("$2y$")) {
            hashedPassword = "$2a$" + hashedPassword.substring(4);
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (IllegalArgumentException e) {
            System.out.println("BCrypt exception: " + e.getMessage());
            return false;
        }
    }

    /**
     * Đánh giá độ mạnh mật khẩu. Trả về điểm từ 0-4.
     */
    public static int checkPasswordStrength(String password) {
        int score = 0;
        if (password == null || password.trim().isEmpty()) return 0;
        if (password.length() >= 8) score++;
        if (password.length() >= 12) score++;
        if (password.matches(".*[0-9].*")) score++;
        if (password.matches(".*[a-z].*") && password.matches(".*[A-Z].*")) score++;
        if (password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*")) score++;
        return Math.min(4, score);
    }

    /**
     * Mô tả độ mạnh mật khẩu theo điểm.
     */
    public static String getPasswordStrengthDescription(String password) {
        int score = checkPasswordStrength(password);
        switch (score) {
            case 0: return "Rất yếu";
            case 1: return "Yếu";
            case 2: return "Trung bình";
            case 3: return "Mạnh";
            case 4: return "Rất mạnh";
            default: return "Không xác định";
        }
    }
}