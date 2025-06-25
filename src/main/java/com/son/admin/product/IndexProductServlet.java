package com.son.admin.product;

import com.son.admin.BaseAdminServlet;
import com.son.data.dao.DatabaseDao;
import com.son.data.dao.ProductDao;
import com.son.data.model.Product;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/ProductsServlet")
public class IndexProductServlet extends BaseAdminServlet {

    private ProductDao productDao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        productDao = DatabaseDao.getInstance().getProductDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Logic to retrieve and display products will go here
        List<Product> productList = productDao.findAll();

        req.setAttribute("productList", productList);

        req.getRequestDispatcher("./admin/product/index.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Logic for handling product-related POST requests will go here
        super.doPost(req, resp);
    }
}
