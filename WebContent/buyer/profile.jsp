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



<%
//Retrieve user email from session
String userEmail = (String) session.getAttribute("email");
if(userEmail != null) {
   try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse","root","");
    PreparedStatement pst=cn.prepareStatement("select * from register where email=?");
    pst.setString(1,userEmail);
    ResultSet rs =pst.executeQuery();
    if(rs.next()) {
%>
    <center>
        <div class="container">
            <div align="center" class="title">
                <h2>User Profile</h2>
            </div>
            <div class="content">
                <form method="post" action="updateprofile.jsp">
                    <div class="user-details">
                    
                        <div class="input-box">
                            <span class="details">Full Name</span>
                            <input name="fullname" id="fullname" type="text" value="<%=rs.getString("fullname")%>" required>
                        </div>
                        <div class="input-box">
                            <span class="details">Address</span>
                            <input name="address" id="address" type="text" value="<%=rs.getString("address")%>" required>
                        </div>
                        <div class="input-box">
                            <span class="details">Email</span>
                            <input name="email" id="email" type="text"  value="<%=rs.getString("email")%>" readonly>
                        </div>
                        <div class="input-box">
                            <span class="details">Phone Number</span>
                            <input name="phoneno" id="phoneno" type="text" pattern="\d{10}" value="<%=rs.getString("phoneno")%>" required>
                        </div>
                        <div class="input-box">
                            <span class="details">Password</span>
                            <input name="password" id="password" type="text"  value="<%=rs.getString("password")%>" readonly>
                        </div>
                        <div class="input-box">
                            <span class="details">Category</span>
                            <input name="category" id="category" type="text" value="<%=rs.getString("category")%>" readonly>
                        </div>
                        <div class="input-box">
                            <span class="details">Gender</span>
                            <input name="gender" id="gender" type="text" value="<%=rs.getString("gender")%>" readonly>
                        </div>
                        
                    </div>
                    <!-- Add an update button to redirect to updateprofile.jsp -->
                    <div class="button"> 
                        <input type="submit" name="submit" value="Update Profile">
                    </div>
                </form>
            </div>
        </div>
    </center>
<%
    } else {
        out.println("Contact admin: This record does not exist.");
    }
  
} catch(Exception ex) {
    out.println("Contact admin: " + ex);
   }
} else {
    out.println("<script>alert('Please login to view profile');</script>");
}

%>
</body>
</html>

