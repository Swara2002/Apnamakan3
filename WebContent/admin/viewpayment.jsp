<%@include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #2E8B57;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        #totalAmount {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin-right: 20%;
        }
        #totalButton {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #2E8B57;
            color: white;
            border: none;
            cursor: pointer;
        }
        #totalButton:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        function calculateTotal() {
            var table = document.getElementById("paymentTable");
            var rows = table.getElementsByTagName("tr");
            var total = 0;
            for (var i = 1; i < rows.length; i++) { // Start from 1 to skip the header row
                var cells = rows[i].getElementsByTagName("td");
                var amount = cells[4].innerText.replace(/[^0-9.-]+/g,""); // Removing any currency symbols if present
                total += parseFloat(amount);
            }
            document.getElementById("totalAmount").innerText = "Total Amount: Rs. " + total.toFixed(2);
        }
    </script>
</head>
<body>
    <h1>View Payment</h1>
    <table id="paymentTable">
        <tr>
            <th>PID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Contact</th>
            <th>Amount</th>
            <th>Section</th>
            <th>Payment Mode</th>
            <th>Date</th>
            <th>Time</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                // Load the JDBC driver
                Class.forName("com.mysql.jdbc.Driver");
                // Establish a connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
                // Create a statement
                stmt = conn.createStatement();
                // Execute a query
                String sql = "SELECT pid, name, address, contact, amount, section, paymentmode, date, time FROM payment";
                rs = stmt.executeQuery(sql);

                // Extract data from result set
                while (rs.next()) {
                    int pid = rs.getInt("pid");
                    String name = rs.getString("name");
                    String address = rs.getString("address");
                    String contact = rs.getString("contact");
                    String amount = rs.getString("amount"); // Treat amount as a string
                    String section = rs.getString("section");
                    String paymentmode = rs.getString("paymentmode");
                    String date = rs.getString("date");
                    String time = rs.getString("time");
        %>
        <tr>
            <td><%= pid %></td>
            <td><%= name %></td>
            <td><%= address %></td>
            <td><%= contact %></td>
            <td><%= amount %></td>
            <td><%= section %></td>
            <td><%= paymentmode %></td>
            <td><%= date %></td>
            <td><%= time %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close resources
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </table>
    <div id="totalAmount">Total Amount: Rs. 0.00</div>
    <button id="totalButton" onclick="calculateTotal()">Calculate Total</button>
</body>
</html>
