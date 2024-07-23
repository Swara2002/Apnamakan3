<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Rental House</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">    
  <!-- Link to external CSS file -->
    <link rel="stylesheet" href="css/formstyle.css" >  
</head>
<body>


<%
String email = (String) session.getAttribute("email");
if (email == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<div class="container">
    <div align="center" class="title">
        <h2>Add Property</h2>
    </div>
    <div class="content">
        <form method="post" autocomplete="on" action="upload.jsp" enctype="multipart/form-data">
            <div style="width:60%;">
                <div class="user-details">
                    <div class="input-box">
                        <span class="details">Upload Image</span>
                        <input type="file" name="image" id="image" placeholder="Upload property Image" required>
                        <span class="details">Upload 2nd Image</span>
                        <input type="file" name="image2" id="image2" placeholder="Upload property Image" required>
                    </div>
                </div>
                <button style="align:center" type="submit" class="btn btn-primary" name="btns">Submit</button>
            </div>
        </form>

        <form method="post" autocomplete="on">
            <div class="user-details">
                <div class="input-box">
                    <span class="details">Property Name</span>
                    <input type="text" placeholder="Enter your property name" name="propertyname" id="propertyname" required>
                </div>
                <div class="input-box">
                    <span class="details">Email</span>
                    <input type="text" name="email" id="email" value="<%= email %>" readonly>
                </div>
                <div class="input-box">
                    <span class="details">Phone Number</span>
                    <input type="text" placeholder="Enter your number" pattern="\d{10}" name="phoneno" id="phoneno" required>
                </div>
                <div class="input-box">
                    <span class="details">Select Property Type</span>
                    <select name="property-type" id="property-type" required>
                        <option value="">Select Property Type</option>
                        <option value="apartment">Apartment</option>
                        <option value="villa">Villa</option>
                        <option value="house">House</option>
                        <option value="office">Office</option>
                        <option value="shop">Shop</option>
                    </select>
                </div>
                <div class="input-box">
                    <span class="details">This Property for</span>
                    <select name="section" id="section" required>
                        <option value="">Select Section</option>
                        <option value="sell">For Sell</option>
                        <option value="rent">For Rent</option>
                    </select>
                </div>
                <div class="input-box">
                    <span class="details">Price (incl. Deposit)</span>
                    <input type="text" placeholder="Enter the Price" name="price" id="price" required>
                    <div>Rs</div>
                </div>
                <div class="input-box">
                    <span class="details">Details of property</span>
                    <input type="text" placeholder="Enter other details or description of property" name="details" id="details" required>
                </div>
                <div class="input-box">
                    <span class="details">Address</span>
                    <input type="text" placeholder="Enter your address" name="address" id="address" required>
                </div>
                <div class="input-box">
                    <span class="details">Area</span>
                    <input type="text" placeholder="Enter Area in Sqft" name="area" id="area" required>
                    <div>Sqft</div>
                </div>
            </div>
            <div class="button">
                <input type="submit" name="submit" value="Add">
            </div>
        </form>
    </div>
</div>

<%
if(request.getParameter("submit") != null) {
    String pname, em, phno, image1, image2, propertytype, sec, price, details, add, area;
    image1 = (String)session.getAttribute("imagePath1");
    image2 = (String)session.getAttribute("imagePath2");
    pname = request.getParameter("propertyname");
    em = request.getParameter("email");
    phno = request.getParameter("phoneno");
    propertytype = request.getParameter("property-type");
    sec = request.getParameter("section");
    price = request.getParameter("price");
    details = request.getParameter("details");
    add = request.getParameter("address");
    area = request.getParameter("area");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
        PreparedStatement pst = cn.prepareStatement("INSERT INTO property (image1, image2, propertyname, email, phoneno, propertytype, section, price, details, address, area) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        pst.setString(1, image1);
        pst.setString(2, image2);
        pst.setString(3, pname);
        pst.setString(4, em);
        pst.setString(5, phno);
        pst.setString(6, propertytype);
        pst.setString(7, sec);
        pst.setString(8, price);
        pst.setString(9, details);
        pst.setString(10, add);
        pst.setString(11, area);
        pst.executeUpdate();
        out.println("<script>alert('Property Added Successfully')</script>");
    } catch(Exception ex) {
        ex.printStackTrace();
    }
}
%>

</body>
</html>
