package com.son.data.Impl;

import com.son.data.dao.CategoryDao;
import com.son.data.db.DatabaseConnection;
import com.son.data.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryImpl implements CategoryDao {
    Connection con = DatabaseConnection.getInstance().getConnection();
    @Override
    public boolean insert(Category category) {
        String sql = "INSERT INTO CATEGORIES(id, name, description, thumbnail) VALUES(NULL, ?, ?,?)";
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getThumbnail());
            stmt.setString(3, category.getThumbnail());

            stmt.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;    }

    @Override
    public boolean update(Category category) {
        String sql = "UPDATE CATEGORIES SET name = ?, thumbnail = ? WHERE id = ?";
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getThumbnail());
            stmt.setInt(3, category.getId());
            return stmt.execute();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM CATEGORIES WHERE ID = ?";
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);

            return stmt.execute();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Category find(int id) {
        String sql = "SELECT * FROM CATEGORIES WHERE ID = ?";
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                String thumbnail = rs.getString("thumbnail");

                return new Category(id, name, thumbnail);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Category> findAll() {
        List<Category> cateList = new ArrayList<>();
        String sql = "SELECT * FROM CATEGORIES";
        try {
            PreparedStatement stmt = con.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String thumbnail = rs.getString("thumbnail");

                cateList.add(new Category(id, name, thumbnail));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return cateList;    }

    @Override
    public List<Category> hotCategory() {
        List<Category> cateList = new ArrayList<>();
        String sql = "SELECT * FROM CATEGORIES LIMIT 4";
        try {
            PreparedStatement stmt = con.prepareStatement(sql);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String thumbnail = rs.getString("thumbnail");

                cateList.add(new Category(id, name, thumbnail));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return cateList;    }
}
