package com.son;

import com.son.data.dao.DatabaseDao;
import com.son.data.dao.ProductDao;
import com.son.data.model.Product;
import com.son.utils.Constants;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        Product product = productDao.find(productId);
        List<Product> newsProductList = productDao.news(Constants.NUMBER_LIMIT);

        req.setAttribute("newsProductList", newsProductList);
        req.setAttribute("product", product);
        req.getRequestDispatcher("product.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
