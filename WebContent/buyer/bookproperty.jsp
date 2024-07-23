<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Property</title>
    <link rel="stylesheet" href="css/style.css">
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
            String image = rs.getString("image");
            String price = rs.getString("price");
%>
<div class="container">
    <h2>Book Property</h2>
    <form action="payment.jsp" method="get">
        <input type="hidden" name="pid" value="<%= pid %>">
        <div class="form-group">
            <label for="pname">Property Name:</label>
            <input type="text" id="pname" name="pname" value="<%= pname %>" readonly>
        </div>
        <div class="form-group">
            <label for="price">Price:</label>
            <input type="text" id="price" name="price" value="<%= price %>" readonly>
        </div>
        <div class="form-group">
            <label for="image">Image:</label>
            <img src="<%= image %>" alt="Property Image" class="img-fluid">
        </div>
        <button type="submit" class="btn btn-primary">Pay</button>
    </form>
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
    response.sendRedirect("myproperties.jsp");
}
%>
</body>
</html>