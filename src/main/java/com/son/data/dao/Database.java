package com.son.data.dao;

import com.son.data.Impl.CategoryImpl;
import com.son.data.Impl.OrderImpl;
import com.son.data.Impl.ProductImpl;

public class Database extends DatabaseDao {

    @Override
    public ProductDao getProductDao() {
        // TODO Auto-generated method stub
        return new ProductImpl();
    }

    @Override
    public CategoryDao getCategoryDao() {
        // TODO Auto-generated method stub
        return new CategoryImpl();
    }

    @Override
    public OrderItemDao getOrderItemDao() {
        // TODO Auto-generated method stub
//        return new OrderItemImpl();
        return null;
    }

    @Override
    public OrderDao getOrderDao() {
        // TODO Auto-generated method stub
        return new OrderImpl();
//        return null;

    }

    @Override
    public UserDAO getUserDao() {
        // TODO Auto-generated method stub
        return null;
//        return new UserImpl();
    }

}