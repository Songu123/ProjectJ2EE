package com.son;

import com.son.data.dao.CategoryDao;
import com.son.data.dao.DatabaseDao;
import com.son.data.dao.ProductDao;
import com.son.data.model.Category;
import com.son.data.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/search")
public class SearchServlet extends BaseServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        List<Product> productList = productDao.findByName(keyword);

        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();

        List<Category> categoryList = categoryDao.findAll();
        Map<Integer, Integer> categoryProductCount = new HashMap<>();
        for (Category category : categoryList) {
            List<Product> productsInCategory = productDao.findByCategory(category.getId());
            categoryProductCount.put(category.getId(), productsInCategory.size());
        }

        req.setAttribute("categoryList", categoryList);
        req.setAttribute("categoryProductCount", categoryProductCount);
        req.setAttribute("keyword", keyword);
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("search.jsp").include(req, resp);    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}