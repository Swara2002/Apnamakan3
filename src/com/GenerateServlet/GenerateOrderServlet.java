package com.GenerateServlet;
import java.util.UUID;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/generateOrder")
public class GenerateOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Generate a unique order_id
        String orderId = UUID.randomUUID().toString();
        
        // Store orderId in session or request attribute
        request.setAttribute("order_id", orderId);
        
        // Forward to razorpay.jsp where the payment will be initialized
        request.getRequestDispatcher("/buyer/razorpay.jsp").forward(request, response);
    }
}
