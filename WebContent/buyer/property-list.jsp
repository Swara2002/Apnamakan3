<%@page import="java.sql.*" %>
<%@include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<
<style>
    .property-item img {
        width: 200px; /* Adjust image width */
        height: auto; /* Auto height to maintain aspect ratio */
        margin-right: 10px; /* Optional: Add some margin between images and other content */
        cursor: pointer; /* Change cursor to pointer when hovering over image */
    }
    .property-item .image-container {
        display: flex; /* Use flexbox to align images horizontally */
        align-items: center; /* Align items vertically */
    }
    .modal {
        display: none; /* Hide the modal by default */
        position: fixed; /* Position the modal */
        z-index: 1; /* Set the modal to be on top of other elements */
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto; /* Enable scrolling if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.9); /* Black with opacity */
    }
    .modal-content {
        margin: auto;
        display: block;
        width: 80%;
        max-width: 800px; /* Set maximum width of the modal content */
    }
    .close {
        color: #fff;
        position: absolute;
        top: 10px;
        right: 25px;
        font-size: 35px;
        font-weight: bold;
        transition: 0.3s;
    }
    .close:hover,
    .close:focus {
        color: #bbb;
        text-decoration: none;
        cursor: pointer;
    }
</style>

<!-- Include JavaScript for image zoom -->
<script>
    function zoomImage(src) {
        document.getElementById("zoomedImage").src = src;
        document.getElementById("imageModal").style.display = "block";
    }

    function closeImageModal() {
        document.getElementById("imageModal").style.display = "none";
    }
</script>

<!-- Modal for zoomed image -->
<div id="imageModal" class="modal" onclick="closeImageModal()">
    <span class="close" onclick="closeImageModal()">&times;</span>
    <img class="modal-content" id="zoomedImage" onclick="event.stopPropagation()">
</div>

<!-- Property List Start -->
<div class="container-xxl py-5">
    <div class="container">
        <div class="row g-0 gx-5 align-items-end">
            <div class="col-lg-6">
                <div class="text-start mx-auto mb-5 wow slideInLeft" data-wow-delay="0.1s">
                    <h1 class="mb-3">Property Listing</h1>
                </div>
            </div>
        </div>

        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rentalhouse", "root", "");
                String sql = "SELECT * FROM property";
                PreparedStatement pst = cn.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();

                int i = 0;
        %>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        if (i % 2 == 0) {
                            out.println("<tr>");
                        }

                        String pid = rs.getString("pid");
                        String pname = rs.getString("propertyname");
                        String image1 = rs.getString("image1");
                        String image2 = rs.getString("image2");  // Second image path
                        String em = rs.getString("email");
                        String phno = rs.getString("phoneno");
                        String ptype = rs.getString("propertytype");
                        String sec = rs.getString("section");
                        String price = rs.getString("price");
                        String details = rs.getString("details");
                        String add = rs.getString("address");
                        String area = rs.getString("area");
                %>
                <td>
                    <div class="property-item rounded overflow-hidden">
                        <div class="image-container position-relative overflow-hidden">
                            <img class="img-fluid" src="<%= image1 %>" alt="photo" onclick="zoomImage('<%= image1 %>')">
                            <img class="img-fluid" src="<%= image2 %>" alt="photo2" onclick="zoomImage('<%= image2 %>')">
                        </div>
                        <div class="position-relative overflow-hidden">
                            <div class="bg-primary rounded text-white position-absolute start-0 top-0 m-4 py-1 px-3"><%= sec %></div>
                            <div class="bg-white rounded-top text-primary position-absolute start-0 bottom-0 mx-4 pt-1 px-3"><%= ptype %></div>
                        </div>
                        <div class="p-4 pb-0">
                            <h5 class="text-primary mb-3"><%= price %> Rs</h5>
                            <a class="d-block h5 mb-2" href="#"><%= pname %></a>
                            <p><i class="fa fa-map-marker-alt text-primary me-2"></i><%= add %></p>
                            <p><i class="fa fa-list-alt" aria-hidden="true"></i><%= details %></p>
                        </div>
                        <div class="d-flex border-top">
                            <small class="flex-fill text-center border-end py-2"><i class="fa fa-ruler-combined text-primary me-2"></i><%= area %></small>
                            <small class="flex-fill text-center border-end py-2"><i class="fa fa-bed text-primary me-2"></i><%= em %></small>
                            <small class="flex-fill text-center py-2"><i class="fa fa-bath text-primary me-2"></i><%= phno %></small>
                        </div>
                        <a href="mybookproperties.jsp?pid=<%= pid %>" class="btn btn-primary mt-1">Book Now</a>
                    </div>
                </td>

                <%
                        i++;
                        if (i % 2 == 0) {
                            out.println("</tr>");
                        }
                    }
                    if (i % 2 != 0) {
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
        <%
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        %>
    </div>
</div>
