<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.time.*" %>
<%@page import="java.time.format.*" %>
<%@page import="header.jsp.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Process Payment</title>
</head>
<body>




<%
int pid = Integer.parseInt(request.getParameter("pid"));
String name = request.getParameter("name");
String address = request.getParameter("address");
String contact = request.getParameter("contact");
String price = request.getParameter("price");
String section = request.getParameter("section");
String paymentmode = request.getParameter("paymentmode");
String date = LocalDate.now().toString();
String time = request.getParameter("time");

if (time == null || time.isEmpty()) {
    time = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss"));
}

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
    
    // Start transaction
    cn.setAutoCommit(false);
    
    // Insert payment details
    String sqlInsert = "INSERT INTO payment (pid, name, address, contact, amount, section, paymentmode, date, time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pstInsert = cn.prepareStatement(sqlInsert);
    pstInsert.setInt(1, pid);
    pstInsert.setString(2, name);
    pstInsert.setString(3, address);
    pstInsert.setString(4, contact);
    pstInsert.setString(5, price);
    pstInsert.setString(6, section);
    pstInsert.setString(7, paymentmode);
    pstInsert.setString(8, date);
    pstInsert.setString(9, time);
    int rowsAffectedInsert = pstInsert.executeUpdate();
    
    // Commit transaction
    if (rowsAffectedInsert > 0) {
        cn.commit();
        response.sendRedirect("receipt.jsp?pid=" + pid);
    } else {
        cn.rollback();
        out.println("<script>alert('Failed to process payment.');window.location='payment.jsp';</script>");
    }

    // Close resources
    pstInsert.close();
    cn.close();
} catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('Error: " + e.getMessage() + "');window.location='payment.jsp';</script>");
}
%>

</body>
</html>
