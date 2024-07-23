<%@include file="header.jsp" %>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Registration</title>
</head>
<body>

<%
    String email = request.getParameter("email");
    if (email != null && !email.isEmpty()) {
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
            PreparedStatement pst = con.prepareStatement("DELETE FROM register WHERE email = ?");
            pst.setString(1, email);
            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                out.println("<script>alert('Registration deleted successfully.'); window.location='viewregistration.jsp';</script>");
            } else {
                out.println("<script>alert('Registration not found.'); window.location='viewregistration.jsp';</script>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred while deleting the registration.'); window.location='viewregistration.jsp';</script>");
        }
    } else {
        out.println("<script>alert('Invalid registration email.'); window.location='viewregistration.jsp';</script>");
    }
%>

<%@include file="footer.jsp" %>
</body>
</html>

</body>
</html>