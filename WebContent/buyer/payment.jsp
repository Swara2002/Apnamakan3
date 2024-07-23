<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.time.*" %>
<%@page import="java.time.format.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment</title>
<link rel="stylesheet" href="css/style.css">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<style>
    body {
        background-color: #f8f9fa;
    }
    .container {
        margin-top: 50px;
    }
    .card {
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border: none;
    }
    .card-header {
        background-color: #2E8B57;
        color: white;
    }
    .btn-primary {
        background-color: #2E8B57;
        width: 50%;
        align: center;
        border: none;
    }
    .btn-primary:hover {
        background-color: #218838;
    }
    h2 {
        margin-bottom: 30px;
        color: #333;
    }
    .form-group label {
        font-weight: bold;
    }
</style>
<script>
    function handleSubmit(event) {
        event.preventDefault();
        var paymentMode = document.getElementById("paymentmode").value;
        if (paymentMode === "cash") {
            document.getElementById("paymentForm").action = "paymentprocess.jsp";
        } else if (paymentMode === "online payment") {
            document.getElementById("paymentForm").action = "razorpay.jsp"; // or any other URL for online payment processing
        }
        document.getElementById("paymentForm").submit();
    }
</script>
</head>
<body>
<%
int pid = Integer.parseInt(request.getParameter("pid"));
String pname = request.getParameter("pname");
String price = request.getParameter("price");
String image = request.getParameter("image");
String section = request.getParameter("section");
%>
<div class="container">
    <div class="card">
        <div class="card-header">
            <center><h2>Payment Details</h2></center>
        </div>
        <div class="card-body">
            <form id="paymentForm" onsubmit="handleSubmit(event)" method="post">
                <input type="hidden" name="pid" value="<%= pid %>">
                <input type="hidden" id="hiddenPrice" value="<%= price %>">
                
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="contact">Contact:</label>
                    <input type="text" id="contact" name="contact" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="text" id="price" name="price" class="form-control" value="<%= price %> Rs" readonly>
                </div>
                <div class="form-group">
                    <label for="section">Section:</label>
                    <input type="text" id="section" name="section" class="form-control" value="<%= section %>" readonly>
                </div>
                <div class="form-group">
                    <label for="paymentmode">Payment Mode:</label>
                    <select id="paymentmode" name="paymentmode" class="form-control" required>
                        <option value="cash">Cash</option>
                        <option value="online payment">Online Payment</option>
                    </select>
                </div>
                <input type="hidden" id="time" name="time" value="<%= LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) %>">
                <button type="submit" class="btn btn-primary">Pay</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
