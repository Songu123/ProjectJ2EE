package com.son.data.dao;

import com.son.data.model.Order;

import java.util.List;

public interface OrderDao {
    public boolean insert(Order order);

    public boolean update(Order order);

    public boolean delete(int id);

    public Order find(int id);

    public List<Order> findAll();

    public List<Order> findByUser(int userId);

    public Order findByCode(String code);

    public List<Order> findByStatus(String status);
    public int countOrderByDay(String date);

    public double earningOrderByDay(String date);

}
