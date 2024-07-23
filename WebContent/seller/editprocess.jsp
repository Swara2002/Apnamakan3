<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ include file="header.jsp" %>
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
if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("submit") != null) {
    String pid = request.getParameter("pid");
    String newPropertyName = request.getParameter("propertyname");
    String newImage1 = request.getParameter("image1"); // Corrected parameter name
    String newImage2 = request.getParameter("image2");
    String newEmail = request.getParameter("email");
    String newPhoneNo = request.getParameter("phoneno");
    String newPropertyType = request.getParameter("propertytype");
    String newSection = request.getParameter("section");
    String newPrice = request.getParameter("price");
    String newDetails = request.getParameter("details");
    String newAddress = request.getParameter("address");
    String newArea = request.getParameter("area");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
        PreparedStatement pst = cn.prepareStatement("UPDATE property SET propertyname = ?, image1 = ?, image2 = ?, email = ?, phoneno = ?, propertytype = ?, section = ?, price = ?, details = ?, address = ?, area = ? WHERE pid = ?");
        pst.setString(1, newPropertyName);
        pst.setString(2, newImage1);
        pst.setString(3, newImage2);
        pst.setString(4, newEmail);
        pst.setString(5, newPhoneNo);
        pst.setString(6, newPropertyType);
        pst.setString(7, newSection);
        pst.setString(8, newPrice);
        pst.setString(9, newDetails);
        pst.setString(10, newAddress);
        pst.setString(11, newArea);
        pst.setString(12, pid);
        int rowsAffected = pst.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<script>alert('Property updated successfully');</script>");
        } else {
            out.println("<script>alert('Failed to update property');</script>");
        }

        pst.close();
        cn.close();
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("<script>alert('Failed to update property: " + ex.getMessage() + "');</script>");
    }

    // Redirect back to the properties list
    response.sendRedirect("myproperties.jsp");
}
%>

</body>
</html>

<%@ include file="footer.jsp" %>

