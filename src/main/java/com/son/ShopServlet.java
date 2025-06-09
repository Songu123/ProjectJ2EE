package com.son;

import com.son.data.Impl.ProductImpl;
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
        super.doGet(req, resp);

        // Get total number of products for pagination
        List<Product> allProducts = productDao.findAll();

        for (Product p: allProducts) {
            System.out.println(p);
        }
        int total = allProducts.size();

        // Default to page 1 if not specified or invalid
        int page = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Calculate total number of pages (round up)
        int numberPage = (int) Math.ceil((double) total / Constants.PER_PAGE);

        // Get products for the current page
        int offset = (page - 1) * Constants.PER_PAGE;
        List<Product> productList = productDao.getProducts(offset, Constants.PER_PAGE);

        req.setAttribute("productList", productList);
        req.setAttribute("total", total);
        req.setAttribute("page", page);
        req.setAttribute("numberPage", numberPage);

        req.getRequestDispatcher("shop.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}