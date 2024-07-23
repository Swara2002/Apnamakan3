<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<%
String pid = request.getParameter("pid");
String propertyname = null, image1 = null, image2 = null, email = null, phoneno = null, propertytype = null, section = null, price = null, details = null, address = null, area = null;

if (pid != null && !pid.isEmpty()) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
        PreparedStatement pst = cn.prepareStatement("SELECT * FROM property WHERE pid = ?");
        pst.setString(1, pid);
        ResultSet rs = pst.executeQuery();
        
        if (rs.next()) {
            propertyname = rs.getString("propertyname");
            image1 = rs.getString("image1");
            image2 = rs.getString("image2");
            email = rs.getString("email");
            phoneno = rs.getString("phoneno");
            propertytype = rs.getString("propertytype");
            section = rs.getString("section");
            price = rs.getString("price");
            details = rs.getString("details");
            address = rs.getString("address");
            area = rs.getString("area");
        }
        
        rs.close();
        pst.close();
        cn.close();
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("<script>alert('Failed to load property details: " + ex.getMessage() + "');</script>");
    }
} else {
    out.println("<script>alert('Invalid property ID');</script>");
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Property</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .form-container h2 {
            margin-bottom: 20px;
        }
        .form-group label {
            font-weight: bold;
        }
        .form-group input, .form-group select, .form-group textarea {
            border-radius: 5px;
        }
        .btn-green {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
        }
        .btn-green:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2>Edit Property</h2>
            <form method="post" action="editprocess.jsp">
                <input type="hidden" name="pid" value="<%= pid %>">
                <div class="form-group">
                    <label for="propertyname">Property Name:</label>
                    <input type="text" class="form-control" id="propertyname" name="propertyname" value="<%= propertyname %>" required>
                </div>
                <div class="form-group">
                    <label for="image">Image1 URL:</label>
                    <input type="text" class="form-control" id="image1" name="image1" value="<%= image1 %>" readonly>
                </div>
                <div class="form-group">
                    <label for="image">Image2 URL:</label>
                    <input type="text" class="form-control" id="image2" name="image2" value="<%= image2 %>" readonly>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
                </div>
                <div class="form-group">
                    <label for="phoneno">Phone Number:</label>
                    <input type="text" class="form-control" id="phoneno" name="phoneno" value="<%= phoneno %>" required>
                </div>
                <div class="form-group">
                    <label for="propertytype">Property Type:</label>
                    <select class="form-control" id="propertytype" name="propertytype" required>
                        <option value="Apartment" <%= propertytype.equals("Apartment") ? "selected" : "" %>>Apartment</option>
                        <option value="Villa" <%= propertytype.equals("Villa") ? "selected" : "" %>>Villa</option>
                        <option value="House" <%= propertytype.equals("House") ? "selected" : "" %>>House</option>
                        <option value="Office" <%= propertytype.equals("Office") ? "selected" : "" %>>Office</option>
                        <option value="Shop" <%= propertytype.equals("Shop") ? "selected" : "" %>>Shop</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="section">Section:</label>
                    <select class="form-control" id="section" name="section" required>
                        <option value="Sell" <%= section.equals("Sell") ? "selected" : "" %>>For Sell</option>
                        <option value="Rent" <%= section.equals("Rent") ? "selected" : "" %>>For Rent</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="price">Price(incl.Deposit):</label>
                    <input type="text" class="form-control" id="price" name="price" value="<%= price %>" required>
                </div>
                <div class="form-group">
                    <label for="details">Details:</label>
                    <textarea class="form-control" id="details" name="details" required><%= details %></textarea>
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" class="form-control" id="address" name="address" value="<%= address %>" required>
                </div>
                <div class="form-group">
                    <label for="area">Area:</label>
                    <input type="text" class="form-control" id="area" name="area" value="<%= area %>" required>
                </div>
                <button type="submit" name="submit" class="btn btn-green">Update</button>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
   
