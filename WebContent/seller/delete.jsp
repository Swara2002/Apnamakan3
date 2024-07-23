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

<%-- 
<%
String pid =request.getParameter("pid");
try
{
	
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection cn= DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse","root","");
            PreparedStatement pst=cn.prepareStatement("delete * from property where pid=?");
            pst.setString(1,pid);
            pst.executeUpdate();
            out.println("<script>alert('Property Has Been Deleted Successfully');window.location='myproperties.jsp';</script>");

}
catch(Exception ex)
{
	ex.printStackTrace();
}	 

%>
--%>




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
                out.println("<script>alert('Property deleted successfully');</script>");
            } else {
                out.println("<script>alert('Failed to delete property');</script>");
            }
            
            pst.close();
            cn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            out.println("<script>alert('Failed to delete property: " + ex.getMessage() + "');</script>");
        }
    } else {
        out.println("<script>alert('Invalid property ID');</script>");
    }
    
    // Redirect back to the properties list
    response.sendRedirect("myproperties.jsp");
%>


</body>
</html>