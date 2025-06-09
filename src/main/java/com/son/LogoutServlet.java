package com.son;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the current session
        HttpSession session = request.getSession(false);

        // If session exists, invalidate it
        if (session != null) {
            // Remove the user attribute
            session.removeAttribute("currentUser");

            // Invalidate the session
            session.invalidate();
        }

        // Redirect to login page
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests the same as GET
        doGet(request, response);
    }
}
