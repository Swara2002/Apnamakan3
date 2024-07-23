<%@page import="java.sql.*, java.io.*, java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.time.*"%>
<%@page import="java.time.format.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Online Payment Process</title>
<link rel="stylesheet" href="css/style.css">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #f8f9fa;
    }
    .container {
        margin-top: 50px;
    }
    .card {
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border: none;
    }
    .card-header {
        background-color: #2E8B57;
        color: white;
    }
    .btn-primary {
        background-color: #2E8B57;
        width: 50%;
        align: center;
        border: none;
    }
    .btn-primary:hover {
        background-color: #218838;
    }
    h2 {
        margin-bottom: 30px;
        color: #333;
    }
    .form-group label {
        font-weight: bold;
    }
</style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <center><h2>Online Payment Process</h2></center>
        </div>
        <div class="card-body">
        
        
        
        
        <body>
    <%-- Retrieve Razorpay response parameters --%>
    <% String razorpayPaymentId = request.getParameter("razorpay_payment_id"); %>
    <% String razorpayOrderId = request.getParameter("razorpay_order_id"); %>
    <% String razorpaySignature = request.getParameter("razorpay_signature"); %>
    
    <%-- Retrieve other transaction details --%>
    <% String pid = request.getParameter("pid"); %>
    <% String name = request.getParameter("name"); %>
    <% String address = request.getParameter("address"); %>
    <% String contact = request.getParameter("contact"); %>
    <% String price = request.getParameter("price"); %>
    <% String datetime = request.getParameter("datetime"); %>
    
    <%-- Validate Razorpay payment signature (TODO: Implement signature validation) --%>
    <%-- Process payment and store transaction details into database (TODO: Implement database logic) --%>
    
    <%-- Example code to store transaction into a MySQL database --%>
    <% Connection conn = null;
       PreparedStatement stmt = null;
       try {
           Class.forName("com.mysql.jdbc.Driver");
           conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
           String sql = "INSERT INTO onlinetransactions (pid, name, address, contact, price, datetime, razorpay_payment_id, razorpay_order_id, razorpay_signature) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
           stmt = conn.prepareStatement(sql);
           stmt.setString(1, pid);
           stmt.setString(2, name);
           stmt.setString(3, address);
           stmt.setString(4, contact);
           stmt.setString(5, price);
           stmt.setString(6, datetime);
           stmt.setString(7, razorpayPaymentId);
           stmt.setString(8, razorpayOrderId);
           stmt.setString(9, razorpaySignature);
           int rowsInserted = stmt.executeUpdate();
           if (rowsInserted > 0) {
               out.println("<h1>Payment successful!</h1>");
               out.println("<p>Transaction ID: " + razorpayPaymentId + "</p>");
           }
       } catch (Exception ex) {
           ex.printStackTrace();
       } finally {
           if (stmt != null) {
               try {
                   stmt.close();
               } catch (SQLException e) {
                   e.printStackTrace();
               }
           }
           if (conn != null) {
               try {
                   conn.close();
               } catch (SQLException e) {
                   e.printStackTrace();
               }
           }
       }
    %>
</body>
</html>
        
        
        
        
        
        
        
        
        
     