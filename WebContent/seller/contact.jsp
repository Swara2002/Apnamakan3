<%@page import="java.sql.*" %>
<%@page import="java.time.*" %>
<%@page import="java.time.format.*" %>
<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Rental House</title>
<style>
/* Your existing CSS here */
.contact {
    padding: 130px 0;
}
.contact .heading h2 {
    font-size: 30px;
    font-weight: 700;
    margin: 0;
    padding: 0;
}
.contact .heading h2 span {
    color: #ff9100;
}
.contact .heading p {
    font-size: 15px;
    font-weight: 400;
    line-height: 1.7;
    color: #999999;
    margin: 20px 0 60px;
    padding: 0;
}
.contact .form-control {
    padding: 25px;
    font-size: 13px;
    margin-bottom: 10px;
    background: #f9f9f9;
    border: 0;
    border-radius: 10px;
}
.contact button.btn {
    padding: 10px;
    border-radius: 10px;
    font-size: 15px;
    background:  #2E8B57;
    color: #ffffff;
}
.contact .title h3 {
    font-size: 18px;
    font-weight: 600;
}
.contact .title p {
    font-size: 14px;
    font-weight: 400;
    color: #999;
    line-height: 1.6;
    margin: 0 0 40px;
}
.contact .content .info {
    margin-top: 30px;
}
.contact .content .info i {
    font-size: 30px;
    padding: 0;
    margin: 0;
    color: #02434b;
    margin-right: 20px;
    text-align: center;
    width: 20px;
}
.contact .content .info h4 {
    font-size: 13px;
    line-height: 1.4;
}
.contact .content .info h4 span {
    font-size: 13px;
    font-weight: 300;
    color: #999999;
}
</style>
</head>
<body>
<section class="contact" id="contact">
    <div class="container">
        <div class="heading text-center">
            <h2>Contact Us</h2>
            <p>Have a question or want to get in touch? Send us a message using the form below, and we'll get back to you as soon as possible.</p>
        </div>
        <div class="row">
            <div class="col-md-5">
                <div class="title">
                    <h3>Contact detail</h3>
                </div>
                <div class="content">
                    <!-- Info-1 -->
                    <div class="info">
                        <i class="fas fa-mobile-alt"></i>
                        <h4 class="d-inline-block">PHONE :<br>
                            <span>+12457836913 , +12457836913</span></h4>
                    </div>
                    <!-- Info-2 -->
                    <div class="info">
                        <i class="far fa-envelope"></i>
                        <h4 class="d-inline-block">EMAIL :<br>
                            <span>ApnaMakan.com</span></h4>
                    </div>
                    <!-- Info-3 -->
                    <div class="info">
                        <i class="fas fa-map-marker-alt"></i>
                        <h4 class="d-inline-block">ADDRESS :<br>
                            <span>Gurwar peth, Powai naka, Satara</span></h4>
                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <form method="post" autocomplete="on">
                    <div class="row">
                        <div class="col-sm-6">
                            <input type="text" class="form-control" placeholder="Full Name" name="fullname" id="fullname" required>
                        </div>
                        <div class="col-sm-6">
                            <input type="email" class="form-control" placeholder="Email" name="email" id="email" required>
                        </div>
                        <div class="col-sm-12">
                            <input type="text" class="form-control" placeholder="Subject" name="subject" id="subject" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <textarea class="form-control" rows="5" placeholder="Message" name="message" id="message" required></textarea>
                    </div>
                    <button class="btn btn-block" type="submit" name="submit" value="submit">Send Now!</button>
                </form>
            </div>
        </div>
    </div>
</section>
<%
if ("submit".equals(request.getParameter("submit"))) {
    String nm = request.getParameter("fullname");
    String em = request.getParameter("email");
    String sub = request.getParameter("subject");
    String msg = request.getParameter("message");
    java.sql.Date date = new java.sql.Date(System.currentTimeMillis());

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
        PreparedStatement pst = cn.prepareStatement("INSERT INTO contact (fullname, email, subject, message, date) VALUES (?, ?, ?, ?, ?)");
        pst.setString(1, nm);
        pst.setString(2, em);
        pst.setString(3, sub);
        pst.setString(4, msg);
        pst.setDate(5, date);
        pst.executeUpdate();
        out.println("<script> alert('Message sent successfully'); window.location='index.jsp'; </script>");
    } catch (Exception ex) {
        ex.printStackTrace();
    }
}
%>
<%@include file="footer.jsp" %>
</body>
</html>
