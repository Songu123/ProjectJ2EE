package com.son;

import com.son.data.model.OrderItem;
import com.son.util.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CartServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<OrderItem>();
        }

        req.setAttribute("cart", cart);
        req.setAttribute("total", Helper.total(cart));
        req.getRequestDispatcher("cart.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        switch (action) {
            case "create":
                createOrder(req);
                break;
            case "update":
                updateOrder(req);
                break;
            case "delete":
                deleteOrder(req);
                break;
            default:
                throw new AssertionError();
        }

        resp.sendRedirect("cart");
    }

    private void createOrder(HttpServletRequest req) {
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int productId = Integer.parseInt(req.getParameter("productId"));
        double price = Double.parseDouble(req.getParameter("price"));

        OrderItem orderItem = new OrderItem(quantity, price, 0, productId);

        HttpSession session = req.getSession();
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

        boolean isExistInCart = false;

        if (cart == null) {
            cart = new ArrayList<>();
        } else {
            for (OrderItem ord : cart) {
                if (ord.getProductId() == productId) {
                    ord.setQuantity(ord.getQuantity() + quantity);
                    isExistInCart = true;
                    break;
                }
            }
        }

        if (!isExistInCart) {
            cart.add(orderItem);
        }
        session.setAttribute("cart", cart);
    }

    private void updateOrder(HttpServletRequest req) {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        HttpSession session = req.getSession();
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

        if (cart != null && cart.isEmpty() == false) {
            for (OrderItem ord : cart) {
                if (ord.getProductId() == productId) {
                    ord.setQuantity(quantity);
                }
            }
        }

        session.setAttribute("cart", cart);
    }

    private void deleteOrder(HttpServletRequest req) {
        int productId = Integer.parseInt(req.getParameter("productId"));
        HttpSession session = req.getSession();
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

        if (cart != null) {
            for (int i = 0; i < cart.size(); i++) {
                OrderItem ord = cart.get(i);
                if (ord.getProductId() == productId) {
                    cart.remove(ord);
                }
            }
        }

        session.setAttribute("cart", cart);
    }
}
