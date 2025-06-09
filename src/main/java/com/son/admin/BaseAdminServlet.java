package com.son.admin;

import com.son.data.dao.Database;
import com.son.data.dao.DatabaseDao;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;

public class BaseAdminServlet extends HttpServlet {
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init();
        DatabaseDao.init(new Database());
    }
}
