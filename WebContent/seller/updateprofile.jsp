<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Rental House</title>
</head>
<body>

<%
String email = (String) session.getAttribute("email");
if (email != null) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
        PreparedStatement pst = cn.prepareStatement("UPDATE register SET fullname = ?, address = ?, phoneno = ?, password = ?, category = ?, gender = ? WHERE email = ?");
        pst.setString(1, request.getParameter("fullname"));
        pst.setString(2, request.getParameter("address"));
        pst.setString(3, request.getParameter("phoneno"));
        pst.setString(4, request.getParameter("password"));
        pst.setString(5, request.getParameter("category"));
        pst.setString(6, request.getParameter("gender"));
        pst.setString(7, email); // Use email from session in the WHERE clause

        int rowsAffected = pst.executeUpdate();
        if (rowsAffected > 0) {
            out.println("<script>alert('Profile Updated Successfully');window.location='./index.jsp';</script>");
        } else {
            out.println("<script>alert('Profile Update Failed');window.location='./index.jsp';</script>");
        }

        pst.close();
        cn.close();
    } catch (Exception ex) {
        out.println("Contact admin: " + ex);
    }
} else {
    out.println("<script>alert('Please login to update profile');window.location='./login.jsp';</script>");
}
%>
</body>
</html>

