<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>  


<%
    String pid = request.getParameter("pid");

    if (pid != null && !pid.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
            PreparedStatement pst = cn.prepareStatement("DELETE FROM property WHERE pid = ?");
            pst.setString(1, pid);
            int rowsAffected = pst.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("<script>alert('Property deleted successfully');window.location='manageproperty-list.jsp';</script>");
                
            } else {
                out.println("<script>alert('Failed to delete property');window.location='manageproperty-list.jsp';</script>");
            }
            
            pst.close();
            cn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            out.println("<script>alert('Failed to delete property: " + ex.getMessage() + "');window.location='manageproperty-list.jsp';</script>");
        }
    } else {
        out.println("<script>alert('Invalid property ID');window.location='manageproperty-list.jsp';</script>");
    }
    
    // Redirect back to the properties list
   // response.sendRedirect("manageproperty-list.jsp");
%>


</body>
</html>
