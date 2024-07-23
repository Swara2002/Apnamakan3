<%@page import="javax.servlet.http.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    .property-item {
        margin-bottom: 20px;
    }
    
    .property-item img {
        width: 200px;
        height: auto;
        margin-right: 10px;
    }
    
    .property-item .info {
        display: inline-block;
        vertical-align: top;
        width: calc(100% - 120px); /* Adjust based on image width */
    }
</style>

<%
    if(session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
    } else {
        String email = (String) session.getAttribute("email");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
            PreparedStatement pst = cn.prepareStatement("select * from property where email = ?");
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
%>

<!-- Property List Start -->
<div class="container-xxl py-5">
    <div class="container">
        <div class="row g-4">
        <%  
            int i = 0;
            while(rs.next()) {
                String pid, pname, image1, image2, emaildb, phno, ptype, sec, price, details, add, area;
                pid = rs.getString("pid");
                pname = rs.getString("propertyname");
                image1 = rs.getString("image1");
                image2 = rs.getString("image2");
                emaildb = rs.getString("email");
                phno = rs.getString("phoneno");
                ptype = rs.getString("propertytype");
                sec = rs.getString("section");
                price = rs.getString("price");
                details = rs.getString("details");
                add = rs.getString("address");
                area = rs.getString("area");
        %>
            <div class="col-lg-6 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                <div class="property-item rounded overflow-hidden">
                    <div class="image-container">
                        <img class="img-fluid" src="<%=image1%>" alt="photo1">
                        <img class="img-fluid" src="<%=image2%>" alt="photo2">
                    </div>
                    <div class="info">
                        <div class="position-relative overflow-hidden">
                            <div class="bg-primary rounded text-white position-absolute start-0 top-0 m-4 py-1 px-3"><%=sec %></div>
                            <div class="bg-white rounded-top text-primary position-absolute start-0 bottom-0 mx-4 pt-1 px-3"><%=ptype %></div>
                        </div>
                        <div class="p-4 pb-0">
                            <h5 class="text-primary mb-3"><%=price %> Rs</h5>
                            <a class="d-block h5 mb-2" href="#"><%=pname %> </a>
                            <p><i class="fa fa-map-marker-alt text-primary me-2"></i><%=add%></p>
                            <p><i class="fa fa-list-alt" aria-hidden="true"></i><%=details%></p>
                        </div>
                        <div class="d-flex border-top">
                            <small class="flex-fill text-center border-end py-2"><i class="fa fa-ruler-combined text-primary me-2"></i><%=area %></small>
                            <small class="flex-fill text-center border-end py-2"><i class="fa fa-bed text-primary me-2"></i><%=emaildb%></small>
                            <small class="flex-fill text-center py-2"><i class="fa fa-bath text-primary me-2"></i><%=phno%></small>
                        </div>
                        <a href="delete.jsp?pid=<%=pid%>" class="btn btn-primary mt-1">Delete</a>
                        <a href="edit.jsp?pid=<%=pid%>" class="btn btn-primary mt-1">Edit</a>
                    </div>
                </div>
            </div>
        <%  
                i++;
            }
        %>
        </div>
    </div>
</div>

<%
        } catch (Exception ex) {
            ex.printStackTrace();
            out.println("<script>alert('Failed to load properties: " + ex.getMessage() + "');</script>");
        }
    }
%>
