<%@page import="java.sql.*" %>
<%@page import="java.time.*" %>
<%@page import="java.time.format.*" %>
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
    <div   align="center" "title"> <h2>Register Now </h2></div>
    <div class="content">
      <form  method= "post"    autocomplete="on">
        <div class="user-details">
          <div class="input-box">
            <span class="details">Full Name</span>
            <input type="text" placeholder="Enter your name" name="fullname" id="fullname" required>
          </div>
           <div class="input-box">
            <span class="details">Address</span>
            <input type="text" placeholder="Enter your address" name="address" id="address" required>
          </div>
         
          <div class="input-box">
            <span class="details">Email</span>
            <input type="text" placeholder="Enter your email" name="email" id="email" required>
          </div>
          <div class="input-box">
            <span class="details">Phone Number</span>
            <input type="text" placeholder="Enter your number" pattern="\d{10}" name="phoneno" id="phoneno" required>
          </div>
          <div class="input-box">
            <span class="details">Password</span>
            <input type="password" placeholder="Enter your password" name="password" id="password" required>
          </div>
          <div class="input-box">
            <span class="details">Select Category</span>
          <select value="categoery" name="category" id="category" required="">
                                    <option value="category">Category</option>
                                    <option name="buyer" id="buyer">buyer</option>
                                    <option name="seller" id="seller">seller</option>
                                   
            </select>
            </div>               
        </div>
        
       <div class="gender-details">
          <input type="radio" name="gender" id="dot-1" value="Male" required>
          <input type="radio" name="gender" id="dot-2" value="Female" required>
          <input type="radio" name="gender" id="dot-3" value="Prefer not to say" required>
          <span class="gender-title">Gender</span>
          <div class="category">
            <label for="dot-1">
              <span class="dot one"></span>
              <span class="gender">Male</span>
            </label>
            <label for="dot-2">
              <span class="dot two"></span>
              <span class="gender">Female</span>
            </label>
            <label for="dot-3">
              <span class="dot three"></span>
              <span class="gender">Prefer not to say</span>
            </label>
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
    long millis= System.currentTimeMillis();
	String nm,add,em,phno,psw,ctg,gen,date;
	nm=request.getParameter("fullname");
	add=request.getParameter("address");
	em=request.getParameter("email");
	phno=request.getParameter("phoneno");
	psw=request.getParameter("password");
	ctg=request.getParameter("category");
	gen=request.getParameter("gender");
	java.sql.Date d=new java.sql.Date(millis);
	date= String.valueOf(d);   
	
    try
	{
		Class.forName("com.mysql.jdbc.Driver");
		Connection cn= DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse","root","");
		PreparedStatement pst=cn.prepareStatement("insert into register values (?,?,?,?,?,?,?,?)");
		pst.setString(1,nm);
		pst.setString(2,add);
		pst.setString(3,em);
		pst.setString(4,phno);
		pst.setString(5,psw);
		pst.setString(6,ctg);
		pst.setString(7,gen);
		pst.setString(8,date);
		pst.executeUpdate();
		out.println("<script>alert('Registration Successful');window.location='./index.jsp';</script>");
	}
		
    catch(SQLIntegrityConstraintViolationException ex) {
        out.println("<script>alert('Registration Failed: This email has already been used.');window.location='register.jsp';</script>");
    } catch(Exception ex) {
        ex.printStackTrace();
        out.println("<script>alert('Registration Failed: " + ex.getMessage() + "');window.location='register.jsp';</script>");
    }
	
	

} 
%>