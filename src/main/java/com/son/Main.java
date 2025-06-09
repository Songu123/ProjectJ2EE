package com.son;

import com.son.data.Impl.ProductImpl;
import com.son.data.Impl.UserImpl;
import com.son.data.dao.DatabaseDao;
import com.son.data.dao.ProductDao;
import com.son.data.db.DatabaseConnection;
import com.son.data.model.Product;
import com.son.data.model.User;

import java.sql.Connection;
import java.util.List;

public class Main {
    public static void main(String[] args) {
//        Connection connection = DatabaseConnection.getInstance().getConnection();
//            User user = new UserImpl().getUser("vans72092@gmail.com", "sadfdsadsadsaf");
//            if (user != null) {
//                System.out.println(user);
//        }
        ProductDao productDao = new ProductImpl();
        List<Product> productList = productDao.findAll();
        for (Product p: productList) {
            System.out.println(p);
        }
    }
}
