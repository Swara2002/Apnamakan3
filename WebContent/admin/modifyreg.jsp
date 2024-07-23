<%@include file="header.jsp" %>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Registration</title>
<style>
body {
    font-family: 'Arial', sans-serif;
    background: linear-gradient(to right, #ece9e6, #ffffff);
    margin: 0;
    padding: 0;
}

.container {
    width: 50%;
    margin: 50px auto;
    background-color: #fff;
    padding: 30px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

h2 {
    text-align: center;
    color: #333;
    font-size: 24px;
    margin-bottom: 20px;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    color: #555;
    margin-bottom: 8px;
    font-size: 14px;
    font-weight: bold;
}

.form-group input,
.form-group select {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    color: #333;
}

.form-group input[type="text"],
.form-group input[type="password"] {
    height: 45px;
}

button[type="submit"] {
    width: 100%;
    padding: 15px;
    background-color: #4CAF50;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 18px;
    cursor: pointer;
    transition: background-color 0.3s;
}

button[type="submit"]:hover {
    background-color: #45a049;
}

</style>
</head>
<body>

<%
    String email = request.getParameter("email");
    if (email != null && !email.isEmpty()) {
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
            PreparedStatement pst = con.prepareStatement("SELECT * FROM register WHERE email = ?");
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                // Fetch existing registration details
                String fullname = rs.getString("fullname");
                String address = rs.getString("address");
                String phoneno = rs.getString("phoneno");
                String password = rs.getString("password");
                String category = rs.getString("category");
                String gender = rs.getString("gender");
                
                // Display a form with pre-filled values for modification
%>

<div class="container">
    <h2>Modify Registration</h2>
    <form method="post" action="updatereg.jsp">
        <div class="form-group">
            <label for="fullname">Full Name</label>
            <input type="text" id="fullname" name="fullname" value="<%= fullname %>" required>
        </div>
        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" id="address" name="address" value="<%= address %>" required>
        </div>
        <div class="form-group">
            <label for="phoneno">Phone No</label>
            <input type="text" id="phoneno" name="phoneno" value="<%= phoneno %>" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" value="<%= password %>" required>
        </div>
        <div class="form-group">
            <label for="category">Category</label>
            <select id="category" name="category" required>
                <option value="buyer" <%= category.equals("buyer") ? "selected" : "" %>>Buyer</option>
                <option value="seller" <%= category.equals("seller") ? "selected" : "" %>>Seller</option>
            </select>
        </div>
        <div class="form-group">
            <label for="gender">Gender</label>
            <select id="gender" name="gender" required>
                <option value="male" <%= gender.equals("male") ? "selected" : "" %>>Male</option>
                <option value="female" <%= gender.equals("female") ? "selected" : "" %>>Female</option>
                <option value="other" <%= gender.equals("other") ? "selected" : "" %>>Other</option>
            </select>
        </div>
        <input type="hidden" name="email" value="<%= email %>">
        <button type="submit">Update Registration</button>
    </form>
</div>

<%
            } else {
                out.println("<script>alert('Registration not found.'); window.location='viewregistration.jsp';</script>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred while modifying the registration.'); window.location='viewregistration.jsp';</script>");
        }
    } else {
        out.println("<script>alert('Invalid registration email.'); window.location='viewregistration.jsp';</script>");
    }
%>

</body>
</html>
<%@include file="footer.jsp" %>
