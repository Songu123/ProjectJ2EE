package com.son;

import com.son.data.model.OrderItem;
import com.son.utils.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CartServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<OrderItem>();
        }

        for (OrderItem o : cart) {
            System.out.println(o);
        }

        req.setAttribute("cart", cart);
        req.setAttribute("total", Helper.total(cart));
        req.setAttribute("cartSize", cart.size());
        req.getRequestDispatcher("shopping-cart.jsp").include(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println("Action: " + action);
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
        HttpSession session = req.getSession();
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            System.out.println("Cart is empty, nothing to update");
            return;
        }

        String[] productIds = req.getParameterValues("productId");
        String[] quantities = req.getParameterValues("quantity");


        if (productIds != null && quantities != null && productIds.length == quantities.length) {
            Map<Integer, Integer> updatedQuantities = new HashMap<>();

            for (int i = 0; i < productIds.length; i++) {
                try {
                    int productId = Integer.parseInt(productIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);
                    updatedQuantities.put(productId, quantity);
                    System.out.println("Product ID: " + productId + ", Quantity: " + quantity);
                } catch (NumberFormatException e) {
                    System.err.println("Error parsing at index " + i + ": " + e.getMessage());
                }
            }

            List<OrderItem> updatedCart = new ArrayList<>();
            for (OrderItem item : cart) {
                int productId = item.getProductId();
                if (updatedQuantities.containsKey(productId)) {
                    int newQuantity = updatedQuantities.get(productId);
                    if (newQuantity > 0) {
                        OrderItem updatedItem = new OrderItem(
                                newQuantity,
                                item.getPrice(),
                                item.getOrderId(),
                                productId
                        );
                        updatedCart.add(updatedItem);
                        System.out.println("Updated product " + productId + " to quantity " + newQuantity);
                    } else {
                        System.out.println("Removed product " + productId + " (quantity <= 0)");
                    }
                } else {
                    // Keep items that weren't in the form
                    updatedCart.add(item);
                    System.out.println("Kept product " + productId + " (not in form submission)");
                }
            }

            session.setAttribute("cart", updatedCart);
            System.out.println("Cart updated successfully. Items: " + updatedCart.size());
        } else {
            System.err.println("Error: Missing or mismatched product IDs and quantities");
        }
    }

    private void deleteOrder(HttpServletRequest req) {
        int productId = Integer.parseInt(req.getParameter("productId"));
        HttpSession session = req.getSession();
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

        if (cart != null) {
            // Use removeIf to safely remove items while iterating
            boolean removed = cart.removeIf(orderItem -> orderItem.getProductId() == productId);

            if (removed) {
                System.out.println("Removed product " + productId + " from cart");
            } else {
                System.out.println("Product " + productId + " not found in cart");
            }
        }

        session.setAttribute("cart", cart);
    }
}