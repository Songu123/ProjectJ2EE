
package com.son.utils;

import com.github.javafaker.Faker;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

public class DataGenerator {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/shop_db?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    public static void main(String[] args) {
        Faker faker = new Faker();
        Random random = new Random();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // 1. Thêm categories
            int[] categoryIds = new int[5];
            String[] categoryNames = {"Electronics", "Clothing", "Books", "Toys", "Food"};
            try (PreparedStatement categoryStmt = conn.prepareStatement(
                    "INSERT INTO categories (name) VALUES (?)", Statement.RETURN_GENERATED_KEYS)) {
                for (int i = 0; i < 5; i++) {
                    categoryStmt.setString(1, categoryNames[i]);
                    categoryStmt.executeUpdate();
                    try (ResultSet rs = categoryStmt.getGeneratedKeys()) {
                        if (rs.next()) categoryIds[i] = rs.getInt(1);
                    }
                }
            }

            // 2. Thêm products
            int[] productIds = new int[20];
            try (PreparedStatement productStmt = conn.prepareStatement(
                    "INSERT INTO products (category_id, name, price, description, image1, image2, stock) VALUES (?, ?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS)) {
                for (int i = 0; i < 20; i++) {
                    productStmt.setInt(1, categoryIds[random.nextInt(categoryIds.length)]);
                    productStmt.setString(2, faker.commerce().productName());
                    productStmt.setDouble(3, Double.parseDouble(faker.commerce().price(10, 500)));
                    productStmt.setString(4, faker.lorem().sentence());
                    productStmt.setString(5, "image1_" + i + ".jpg");
                    productStmt.setString(6, "image2_" + i + ".jpg");
                    productStmt.setInt(7, random.nextInt(100) + 1);
                    productStmt.executeUpdate();
                    try (ResultSet rs = productStmt.getGeneratedKeys()) {
                        if (rs.next()) productIds[i] = rs.getInt(1);
                    }
                }
            }

            // 3. Thêm users
            int[] userIds = new int[10];
            try (PreparedStatement userStmt = conn.prepareStatement(
                    "INSERT INTO users (username, email, password, full_name, role, created_at) VALUES (?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS)) {
                for (int i = 0; i < 10; i++) {
                    userStmt.setString(1, faker.name().username());
                    userStmt.setString(2, faker.internet().emailAddress());
                    userStmt.setString(3, faker.internet().password());
                    userStmt.setString(4, faker.name().fullName());
                    userStmt.setString(5, "USER");
                    userStmt.setString(6, LocalDateTime.now().minusDays(random.nextInt(30)).format(formatter));
                    userStmt.executeUpdate();
                    try (ResultSet rs = userStmt.getGeneratedKeys()) {
                        if (rs.next()) userIds[i] = rs.getInt(1);
                    }
                }
            }

            // 4. Thêm carts
            try (PreparedStatement cartStmt = conn.prepareStatement(
                    "INSERT INTO carts (user_id, product_id, quantity, created_at) VALUES (?, ?, ?, ?)")) {
                for (int i = 0; i < 30; i++) {
                    cartStmt.setInt(1, userIds[random.nextInt(userIds.length)]);
                    cartStmt.setInt(2, productIds[random.nextInt(productIds.length)]);
                    cartStmt.setInt(3, random.nextInt(5) + 1);
                    cartStmt.setString(4, LocalDateTime.now().minusDays(random.nextInt(10)).format(formatter));
                    cartStmt.executeUpdate();
                }
            }

            // 5. Thêm orders và order_items
            try (
                    PreparedStatement orderStmt = conn.prepareStatement(
                            "INSERT INTO orders (user_id, total_amount, status, created_at) VALUES (?, ?, ?, ?)",
                            Statement.RETURN_GENERATED_KEYS);
                    PreparedStatement orderItemStmt = conn.prepareStatement(
                            "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)")
            ) {
                for (int i = 0; i < 15; i++) {
                    // Thêm order
                    orderStmt.setInt(1, userIds[random.nextInt(userIds.length)]);
                    orderStmt.setDouble(2, faker.number().randomDouble(2, 50, 1000));
                    orderStmt.setString(3, random.nextBoolean() ? "COMPLETED" : "PENDING");
                    orderStmt.setString(4, LocalDateTime.now().minusDays(random.nextInt(20)).format(formatter));
                    orderStmt.executeUpdate();
                    int orderId = -1;
                    try (ResultSet rs = orderStmt.getGeneratedKeys()) {
                        if (rs.next()) orderId = rs.getInt(1);
                    }

                    // Thêm order_items
                    int numItems = random.nextInt(3) + 1;
                    for (int j = 0; j < numItems; j++) {
                        orderItemStmt.setInt(1, orderId);
                        orderItemStmt.setInt(2, productIds[random.nextInt(productIds.length)]);
                        orderItemStmt.setInt(3, random.nextInt(4) + 1);
                        orderItemStmt.executeUpdate();
                    }
                }
            }

            System.out.println("Dữ liệu đã được đẩy thành công!");
        } catch (SQLException e) {
            System.err.println("Lỗi khi sinh dữ liệu: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
