<%@page import="java.sql.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="java.time.*" %>
<%@page import="java.time.format.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Razorpay Payment</title>
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
</head>
<body>

<div class="container">
    <div class="card">
        <div class="card-header">
            <center><h2>Razorpay Payment</h2></center>
        </div>
        <div class="card-body">
            <form id="paymentForm" action="onlinepaymentprocess.jsp" method="post">
                <!-- Hidden fields to store Razorpay response -->
                <input type="hidden" id="razorpay_payment_id" name="razorpay_payment_id">
                <input type="hidden" id="razorpay_order_id" name="razorpay_order_id">
                <input type="hidden" id="razorpay_signature" name="razorpay_signature">

                <!-- Hidden fields for transaction details -->
                <input type="hidden" name="pid" value="<%= request.getParameter("pid") %>">
                <input type="hidden" name="name" value="<%= request.getParameter("name") %>">
                <input type="hidden" name="address" value="<%= request.getParameter("address") %>">
                <input type="hidden" name="contact" value="<%= request.getParameter("contact") %>">
                <input type="hidden" id="hiddenPrice" name="price" value="<%= request.getParameter("price") %>">
                <input type="hidden" name="datetime" value="<%= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %>">

                <!-- Display payment details (optional) -->
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" class="form-control" value="<%= request.getParameter("name") %>" readonly>
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" class="form-control" value="<%= request.getParameter("address") %>" readonly>
                </div>
                <div class="form-group">
                    <label for="contact">Contact:</label>
                    <input type="text" id="contact" name="contact" class="form-control" value="<%= request.getParameter("contact") %>" readonly>
                </div>
                <div class="form-group">
                    <label for="amount">Amount:</label>
                    <input type="text" id="amount" class="form-control" value="<%= request.getParameter("price") %> Rs" readonly>
                </div>

                <!-- Proceed to payment button -->
                <button type="submit" class="btn btn-primary" name="submit" onclick="initiateRazorpayPayment()">Proceed to Pay</button>
            </form>
        </div>
    </div>
</div>

<script>

function initiateRazorpayPayment() {
    var priceParam = '<%= request.getParameter("price") %>'; // Retrieve the price parameter as a string

    // Extract numeric part of the string (if any)
    var price = parseFloat(priceParam.replace(/[^\d.-]/g, ''));

    if (isNaN(price) || price <= 0) {
        alert("Invalid or missing price value.");
        return;
    }

    var options = {
        "key": "rzp_test_GReIrheIYKqDCg", // Replace with your actual Razorpay key
        "amount": price * 100, // Amount in paise
        "currency": "INR",
        "name": "Merchant Name",
        "description": "Test Transaction",
        "image": "https://example.com/your_logo",
        "order_id": "<%= request.getAttribute("order_id") %>", // Include actual order_id generated on server-side
        "handler": function (response) {
            document.getElementById("razorpay_payment_id").value = response.razorpay_payment_id;
            document.getElementById("razorpay_order_id").value = response.razorpay_order_id;
            document.getElementById("razorpay_signature").value = response.razorpay_signature;
            document.getElementById("paymentForm").submit(); // Submit the form after successful payment
        },
        "prefill": {
            "name": "<%= request.getParameter("name") %>",
            "email": "customer@example.com",
            "contact": "<%= request.getParameter("contact") %>"
        },
        "notes": {
            "address": "<%= request.getParameter("address") %>",
            "pid": "<%= request.getParameter("pid") %>", // Include product ID
            "datetime": "<%= java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %>" // Include current date/time
        },
        "theme": {
            "color": "#F37254"
        }
    };

    var rzp1 = new Razorpay(options);
    rzp1.open();
}


</script>

</body>
</html>
