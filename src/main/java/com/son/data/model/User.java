package com.son.data.model;

import java.time.LocalDateTime;

public class User {
    private int id;
    private String email;
    private String password;
    private String role;
    private String resetToken;
    private LocalDateTime resetTokenExpire;

    public User(String email, String password, String role) {
        super();
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public User(int id, String email, String password, String role) {
        super();
        this.id = id;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    public void setResetToken(String resetToken) {
        this.resetToken = resetToken;
    }

    public void setResetTokenExpire(LocalDateTime resetTokenExpire) {
        this.resetTokenExpire = resetTokenExpire;
    }

    public String getResetToken() {
        return resetToken;
    }

    public LocalDateTime getResetTokenExpire() {
        return resetTokenExpire;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", role='" + role + '\'' +
                ", resetToken='" + resetToken + '\'' +
                ", resetTokenExpire='" + resetTokenExpire + '\'' +
                '}';
    }
}