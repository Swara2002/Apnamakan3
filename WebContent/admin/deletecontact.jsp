<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
    String email = request.getParameter("email");
    if (email != null && !email.isEmpty()) {
        try {
        	Class.forName("com.mysql.jdbc.Driver");
           	Connection cn= DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse","root",""); 
            PreparedStatement pst = cn.prepareStatement("DELETE FROM contact WHERE email = ?");
            pst.setString(1,email);
            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                out.println("<script>alert('Contact deleted successfully.'); window.location='viewcontact.jsp';</script>");
            } else {
                out.println("<script>alert('Contact not found.'); window.location='viewcontact.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred while deleting the contact.'); window.location='viewcontact.jsp';</script>");
        }
    } else {
        out.println("<script>alert('Invalid contact ID.'); window.location='viewcontact.jsp';</script>");
    }
%>

<%@include file="footer.jsp" %>
</body>
</html>


