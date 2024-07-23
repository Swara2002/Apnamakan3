<%@include file="header.jsp" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: View Registrations</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f1f3fb;
    color: #333;
}

.container {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    border-radius: 10px;
    margin-top: 50px;
}

h2 {
    text-align: center;
    color: #2E8B57;
    margin-bottom: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

table, th, td {
    border: 1px solid #ddd;
}

th, td {
    padding: 10px;
    text-align: left;
}

th {
    background-color: #2E8B57;
    color: #fff;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}

tr:hover {
    background-color: #f1f3fb;
}

.action-icons img {
    width: 20px;
    height: 20px;
    cursor: pointer;
}

.add-new {
    text-align: center;
    margin-bottom: 20px;
}

.add-new a {
    background-color: #2E8B57;
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
}

.add-new a:hover {
    background-color: #246c49;
}
</style>
</head>
<body>

<div class="container">
    <h2>Registrations</h2>
    <div class="add-new">
        <a href="register.jsp">Add New Registration</a>
    </div>
    <table>
        <tr>
            <th>Full Name</th>
            <th>Address</th>
            <th>Email</th>
            <th>Phone No</th>
            <th>Password</th>
            <th>Category</th>
            <th>Gender</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
        <%
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
            String sql = "SELECT * FROM register";
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("fullname") + "</td>");
                out.println("<td>" + rs.getString("address") + "</td>");
                out.println("<td>" + rs.getString("email") + "</td>");
                out.println("<td>" + rs.getString("phoneno") + "</td>");
                out.println("<td>" + rs.getString("password") + "</td>");
                out.println("<td>" + rs.getString("category") + "</td>");
                out.println("<td>" + rs.getString("gender") + "</td>");
                out.println("<td>" + rs.getString("date") + "</td>");
                out.println("<td class='action-icons'><a href='modifyreg.jsp?email=" + rs.getString("email") + "'>Modify</a>");
                out.println("<a href='deletereg.jsp?email=" + rs.getString("email") + "'>Delete</a></td>");
                out.println("</tr>");
            }
            con.close();
        } catch (Exception ex) {
            out.println(ex);
        }
        %>
    </table>
</div>


</body>
</html>
