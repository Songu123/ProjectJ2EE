package com.son.data.db;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionPool {
    private static HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl("jdbc:mysql://localhost:3306/shop_db");
        config.setUsername("root");
        config.setPassword("mat_khau");

        // Cấu hình pool (tuỳ chỉnh)
        config.setMaximumPoolSize(10);
        config.setMinimumIdle(2);
        config.setIdleTimeout(30000); // 30s
        config.setMaxLifetime(600000); // 10 phút

        dataSource = new HikariDataSource(config);
    }

    // Trả về một connection từ pool
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
