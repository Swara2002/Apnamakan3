<%@page import="java.sql.*" %>
<%@page import="header.jsp.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Property</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
   
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        .card-header {
            background-color: #28a745;
            color: white;
        }
        .form-group img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }
        .btn-primary {
            background-color: #28a745;
            border: none;
        }
        .btn-primary:hover {
            background-color: #218838;
        }
        h2 {
            margin-bottom: 30px;
            color: #333;
        }
    </style>
</head>
    
<body>
<%
String pid = request.getParameter("pid");
if (pid != null) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
        PreparedStatement pst = cn.prepareStatement("SELECT * FROM property WHERE pid = ?");
        pst.setString(1, pid);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            String pname = rs.getString("propertyname");
            String image1 = rs.getString("image1");
            String image2 = rs.getString("image2");
            String price = rs.getString("price");
            String section = rs.getString("section");
%>
<div class="container">
    <div class="card">
        <div class="card-header text-center">
            <h2>Book Property</h2>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <form action="payment.jsp" method="get">
                    
                        <input type="hidden" name="pid" value="<%= pid %>">
                        <div class="form-group">
                            <label for="pname">Property Name:</label>
                            <input type="text" class="form-control" id="pname" name="pname" value="<%= pname %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="price">Price:</label>
                            <input type="text" class="form-control" id="price" name="price" value="<%= price %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="section">Section:</label>
                            <input type="text" class="form-control" id="section" name="section" value="<%= section %>" readonly>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Proceed to Pay</button>
                    </form>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label for="image">Images:</label>
                        <div class="row">
                            <div class="col-md-6">
                                <img src="<%= image1 %>" alt="Property Image 1" class="img-fluid">
                            </div>
                            <div class="col-md-6">
                                <img src="<%= image2 %>" alt="Property Image 2" class="img-fluid">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
        } else {
            out.println("<script>alert('No property found with the given ID.');</script>");
            response.sendRedirect("myproperties.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Failed to retrieve property details: " + e.getMessage() + "');</script>");
    }
} else {
    response.sendRedirect("mybookproperties.jsp");
}
%>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
