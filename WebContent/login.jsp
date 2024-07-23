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

<div class="container">
    <div   align="center" "title"> <h2>Login </h2></div>
    <div class="content">
      <form  method= "post"   autocomplete="on">
             
        <div class="user-details">
          
          <div class="input-box">
            <span class="details">Email</span>
            <input type="text" placeholder="Enter your email" name="email" id="email" required>
          </div>
         
          <div class="input-box">
            <span class="details">Password</span>
            <input type="password" placeholder="Enter your password" name="password" id="password" required>
          </div>
          
           
          </div>
      
        <div class="button">
          <input type="submit" name="submit" value="submit">
        </div>
        
        <center>    <p><a href="register.jsp">New User.....Register Here</a></p>  
        
      </form>
    </div>
  </div>

</body>
</html>

<%
if(request.getParameter("submit")!=null)
{ 
	String email = request.getParameter("email");
    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse","root","");
        PreparedStatement pst=cn.prepareStatement("select * from register where email=? and password=? ");
        pst.setString(1,request.getParameter("email"));
        pst.setString(2,request.getParameter("password"));
        ResultSet rs=pst.executeQuery();
    
        if (rs.next()) {
            // Fetch category from the result set
            String category = rs.getString("category");
           

            
            if (category != null && (category.equals("buyer") || category.equals("seller"))) {
                // Set session attribute
                session.setAttribute("email", request.getParameter("email"));
                
                // Redirect based on category
                if (category.equals("buyer")) {
                    response.sendRedirect("buyer/index.jsp");
                } else {
                    response.sendRedirect("seller/index.jsp");
                }
            } else {
                out.println("<script>alert('Invalid category');</script>");
            }
        } else {
            out.println("<script>alert('Invalid Email or Password');</script>");
        }   
    } 
    catch (Exception ex) {
        ex.printStackTrace();
    }
}
%>