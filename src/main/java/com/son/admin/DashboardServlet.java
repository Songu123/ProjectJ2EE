package com.son.admin;

import com.son.data.dao.DatabaseDao;
import com.son.data.dao.OrderDao;
import com.son.data.model.Order;
import com.son.util.GetDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends BaseAdminServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderDao orderDao = DatabaseDao.getInstance().getOrderDao();

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        LocalDateTime now = LocalDateTime.now();
        int numberOrderToday = orderDao.countOrderByDay(dtf.format(now));

        List<Order> orderList = orderDao.findAll();
        int numberOrderAll = orderList.size();
        List<Order> orderPendingList = orderDao.findByStatus("pending");

        int numberOrderPending = orderPendingList.size();
        int numberOrderFinished = numberOrderAll - numberOrderPending;


        req.setAttribute("numberOrderToday", numberOrderToday);
        req.setAttribute("numberOrderAll", numberOrderAll);
        req.setAttribute("numberOrderPending", numberOrderPending);
        req.setAttribute("numberOrderFinished", numberOrderFinished);

//        Chart
        List<String> dateList = GetDateTime.get7Date();
        List<Integer> orderByDateList = new ArrayList<>();
        for (String d : dateList) {
            int n = orderDao.countOrderByDay(d);
            orderByDateList.add(n);
        }

        req.setAttribute("dateList", dateList);
        req.setAttribute("orderByDateList", orderByDateList);
        req.setAttribute("orderPendingList", orderPendingList);
        req.getRequestDispatcher("./admin/dashboard.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
