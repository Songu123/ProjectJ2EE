package com.son.data.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * Singleton class for managing database connections with a simple connection pool
 */
public class DatabaseConnection {
    private static DatabaseConnection instance;
    private static final String URL = "jdbc:mysql://localhost:3306/shop_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Simple connection pool
    private ConcurrentLinkedQueue<Connection> connectionPool;
    private static final int INITIAL_POOL_SIZE = 5;

    private DatabaseConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            initializeConnectionPool();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load MySQL JDBC driver", e);
        }
    }

    public static synchronized DatabaseConnection getInstance() {
        if (instance == null) {
            instance = new DatabaseConnection();
        }
        return instance;
    }

    private void initializeConnectionPool() {
        connectionPool = new ConcurrentLinkedQueue<>();

        try {
            for (int i = 0; i < INITIAL_POOL_SIZE; i++) {
                connectionPool.add(createNewConnection());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize connection pool", e);
        }
    }

    private Connection createNewConnection() throws SQLException {
        Properties props = new Properties();
        props.setProperty("user", USER);
        props.setProperty("password", PASSWORD);
        props.setProperty("autoReconnect", "true");
        props.setProperty("useSSL", "false");

        return DriverManager.getConnection(URL, props);
    }

    public Connection getConnection() {
        Connection connection = connectionPool.poll();

        try {
            // If connection is null or closed, create a new one
            if (connection == null || connection.isClosed()) {
                connection = createNewConnection();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection = createNewConnection();
            } catch (SQLException ex) {
                throw new RuntimeException("Failed to create database connection", ex);
            }
        }

        return connection;
    }

    public void releaseConnection(Connection connection) {
        try {
            // Check if connection is still valid before returning to pool
            if (connection != null && !connection.isClosed()) {
                connectionPool.add(connection);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Call this method when shutting down the application
    public void closeAllConnections() {
        Connection connection;
        while ((connection = connectionPool.poll()) != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}