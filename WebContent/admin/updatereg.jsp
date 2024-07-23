<%@include file="header.jsp" %>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Registration</title>
</head>
<body>

<%
    String fullname = request.getParameter("fullname");
    String address = request.getParameter("address");
    String phoneno = request.getParameter("phoneno");
    String password = request.getParameter("password");
    String category = request.getParameter("category");
    String gender = request.getParameter("gender");
    String email = request.getParameter("email");

    if (fullname != null && !fullname.isEmpty() && 
        address != null && !address.isEmpty() &&
        phoneno != null && !phoneno.isEmpty() &&
        password != null && !password.isEmpty() &&
        category != null && !category.isEmpty() &&
        gender != null && !gender.isEmpty() &&
        email != null && !email.isEmpty()) {
        
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
            PreparedStatement pst = con.prepareStatement("UPDATE register SET fullname = ?, address = ?, phoneno = ?, password = ?, category = ?, gender = ? WHERE email = ?");
            pst.setString(1, fullname);
            pst.setString(2, address);
            pst.setString(3, phoneno);
            pst.setString(4, password);
            pst.setString(5, category);
            pst.setString(6, gender);
            pst.setString(7, email);

            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                out.println("<script>alert('Registration updated successfully.'); window.location='viewregistration.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to update registration.'); window.location='viewregistration.jsp';</script>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred while updating the registration.'); window.location='viewregistration.jsp';</script>");
        }
    } else {
        out.println("<script>alert('All fields are required.'); window.location='modifyreg.jsp?email=" + email + "';</script>");
    }
%>

</body>
</html>
<%@include file="footer.jsp" %>

