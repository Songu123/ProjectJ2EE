package com.son;

import com.son.data.dao.DatabaseDao;
import com.son.data.dao.ProductDao;
import com.son.data.model.Product;
import com.son.util.Constants;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ShopServlet extends BaseServlet {
    private ProductDao productDao;

    @Override
    public void init() throws ServletException {
        super.init();
        // Use DatabaseDao to get the ProductDao instance for consistency
        productDao = DatabaseDao.getInstance().getProductDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> productList = productDao.findAll();
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
        req.setAttribute("totalPages", (int) Math.ceil((double) total / Constants.PER_PAGE));

        req.setAttribute("current", currentPage);
        req.setAttribute("productList", productDao.getProducts((currentPage - 1) * perPage, perPage));
        req.setAttribute("total", total);
        req.getRequestDispatcher("shop.jsp").forward(req, resp);
    }

    @Override
    // In your ShopServlet doPost method
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        System.out.println(keyword);
        ProductDao productDao = DatabaseDao.getInstance().getProductDao();
        List<Product> productList = productDao.findByName(keyword);

        req.setAttribute("keyword", keyword);
        req.setAttribute("productList", productList);
        System.out.println(productList.size());
        req.getRequestDispatcher("shop.jsp").include(req, resp);
    }
}