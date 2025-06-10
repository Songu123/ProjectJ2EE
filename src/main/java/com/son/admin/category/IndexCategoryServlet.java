package com.son.admin.category;

import com.son.admin.BaseAdminServlet;
import com.son.data.dao.CategoryDao;
import com.son.data.dao.DatabaseDao;
import com.son.data.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/indexCategory")
public class IndexCategoryServlet extends BaseAdminServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CategoryDao categoryDao = DatabaseDao.getInstance().getCategoryDao();
        List<Category> categoryList = categoryDao.findAll();

        req.setAttribute("categoryList", categoryList);
        req.getRequestDispatcher("./admin/category/index.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
