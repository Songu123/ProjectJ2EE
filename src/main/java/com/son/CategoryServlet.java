package com.son;

import com.son.data.dao.CategoryDao;
import com.son.data.dao.DatabaseDao;
import com.son.data.dao.ProductDao;
import com.son.data.model.Category;
import com.son.data.model.Product;
import com.son.utils.Constants;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/category")
public class CategoryServlet extends BaseServlet{
    private ProductDao productDao;
    private CategoryDao categoryDao;    @Override
    public void init() throws ServletException {
        productDao = DatabaseDao.getInstance().getProductDao();
        categoryDao = DatabaseDao.getInstance().getCategoryDao();    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        List<Product> productList = productDao.findByCategory(categoryId);
        List<Category> categoryList = categoryDao.findAll();

        Map<Integer, Integer> categoryProductCount = new HashMap<>();
        for (Category category : categoryList) {
            List<Product> productsInCategory = productDao.findByCategory(category.getId());
            categoryProductCount.put(category.getId(), productsInCategory.size());
        }

        int total = productList.size();
        int perPage = Constants.PER_PAGE;
        int totalPages = (int) Math.ceil((double) total / perPage);
        int currentPage = 1;
        if (req.getParameter("page") != null) {
            try {
                currentPage = Integer.parseInt(req.getParameter("page"));
                if (currentPage < 1) currentPage = 1;
                if (currentPage > totalPages) currentPage = totalPages;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        req.setAttribute("categoryList", categoryList);
        req.setAttribute("categoryProductCount", categoryProductCount);
        req.setAttribute("totalPages", (int) Math.ceil((double) total / Constants.PER_PAGE));
        req.setAttribute("current", currentPage);
        req.setAttribute("productList", productDao.getProducts((currentPage - 1) * perPage, perPage));
        req.setAttribute("total", total);
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("category.jsp").include(req, resp);    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
