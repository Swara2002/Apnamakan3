<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>

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
    <div   align="center" "title"> <h2> Admin Login </h2></div>
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
        
        
        
      </form>
    </div>
  </div>

</body>
</html>

<%
if(request.getParameter("submit")!=null)
{
String ps,em;

em=request.getParameter("email");

ps=request.getParameter("password");

try
{
Class.forName("com.mysql.jdbc.Driver");
Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse","root","");
PreparedStatement pst=cn.prepareStatement("select * from adminlogin where email=? and password=?");
pst.setString(1,em);
pst.setString(2,ps);

ResultSet rs=pst.executeQuery();
if(rs.next())
{
	session.setAttribute("email",em);
  out.println("<script>alert('Login Successful');window.location='admin/index.jsp';</script>");
}
else
{
	out.println("<script>alert('Invalid Username Or Password');</script>");	
}
}
catch(Exception ex)
{
ex.printStackTrace();	
}
}

%>


<%@include file="footer.jsp" %> 





</body>
</html>