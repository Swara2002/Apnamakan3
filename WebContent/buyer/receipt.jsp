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
<title>Receipt</title>

<script>
function printAndDeleteProperty(pid) {
    // Print the receipt
    window.print();

    // Send AJAX request to delete property
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "receipt.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            // Redirect to home page after printing and deleting
            window.location.href = 'index.jsp';
        }
    };
    xhr.send("delete=true&pid=" + pid);
}
</script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding: 0;
    }
    .container {
        max-width: 800px;
        margin: 50px auto;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }
    h1 {
        color: #333;
        text-align: center;
    }
    .details {
        margin-bottom: 20px;
    }
    .details p {
        font-size: 16px;
        color: #555;
        margin: 5px 0;
    }
    .button-container {
        text-align: center;
    }
    .button {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 20px 10px;
        cursor: pointer;
        border: none;
        border-radius: 5px;
    }
    .button:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
<div class="container">
<%
int pid = Integer.parseInt(request.getParameter("pid"));

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");

    // Check if delete request is made
    String delete = request.getParameter("delete");
    if (delete != null && delete.equals("true")) {
        // Delete property record
        String sqlDelete = "DELETE FROM property WHERE pid = ?";
        PreparedStatement pstDelete = cn.prepareStatement(sqlDelete);
        pstDelete.setInt(1, pid);
        int rowsAffectedDelete = pstDelete.executeUpdate();

        // Close resources
        pstDelete.close();
        cn.close();

        if (rowsAffectedDelete > 0) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        return; // Exit the JSP after handling the delete request
    }

    // Fetch payment details
    String sqlSelect = "SELECT name, address, contact, amount, section FROM payment WHERE pid = ?";
    PreparedStatement pstSelect = cn.prepareStatement(sqlSelect);
    pstSelect.setInt(1, pid);
    ResultSet rs = pstSelect.executeQuery();

    if (rs.next()) {
        String name = rs.getString("name");
        String address = rs.getString("address");
        String contact = rs.getString("contact");
        String amount = rs.getString("amount");
        String section = rs.getString("section");
%>

<h1>Payment Receipt</h1>
<div class="details">
    <p><strong>Name:</strong> <%= name %></p>
    <p><strong>Address:</strong> <%= address %></p>
    <p><strong>Contact:</strong> <%= contact %></p>
    <p><strong>Section:</strong> <%= section %></p>
    <p><strong>Amount:</strong> <%= amount %></p>
</div>

<div class="button-container">
    <button class="button" onclick="printAndDeleteProperty(<%= pid %>)">Print and Save</button>
</div>

<%
    } else {
        out.println("<script>alert('No payment record found for the provided ID.');window.location='index.jsp';</script>");
    }

    // Close resources
    rs.close();
    pstSelect.close();
    cn.close();
} catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('Error: " + e.getMessage() + "');window.location='index.jsp';</script>");
}
%>
</div>
</body>
</html>
