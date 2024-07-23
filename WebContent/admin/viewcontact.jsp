
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin:View Contact</title>
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


<body>

<div class="container">
    <h2>Contact Messages</h2>
    
    <table>
        <tr>
           
            <th>Full Name</th>
            <th>Email</th>
            <th>Subject</th>
            <th>Message</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
        <%
            try {
            	
            	Class.forName("com.mysql.jdbc.Driver");
               	Connection cn= DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse","root","");   
                Statement stmt = cn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM contact");
                while (rs.next()) {
                    String fullname = rs.getString("fullname");
                    String email = rs.getString("email");
                    String subject = rs.getString("subject");
                    String message = rs.getString("message");
                    String date = rs.getString("date");
        %>
        <tr>
            
            <td><%= fullname %></td>
            <td><%= email %></td>
            <td><%= subject %></td>
            <td><%= message %></td>
            <td><%= date %></td>
            <td class="action-icons">
                
                <a href="deletecontact.jsp?email=<%= email %>">Delete</a>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</div>

</body>
</html>
