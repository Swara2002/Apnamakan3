<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<%
   File file;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");

   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File("c:\\temp"));
      
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setSizeMax(maxFileSize);
      try { 
         List<FileItem> fileItems = upload.parseRequest(request);

         Iterator<FileItem> i = fileItems.iterator();
         String imagePath1 = null;
         String imagePath2 = null;

         while (i.hasNext()) {
            FileItem fi = i.next();
            if (!fi.isFormField()) {
               String fileName = fi.getName();
               if (fileName != null && !fileName.isEmpty()) {
                  String fieldName = fi.getFieldName();
                  if (fileName.lastIndexOf("\\") >= 0) {
                     file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
                  } else {
                     file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
                  }
                  fi.write(file);

                  if ("image".equals(fieldName)) {
                     imagePath1 = filePath + fileName.substring(fileName.lastIndexOf("\\") + 1);
                  } else if ("image2".equals(fieldName)) {
                     imagePath2 = filePath + fileName.substring(fileName.lastIndexOf("\\") + 1);
                  }
               }
            }
         }

         if (imagePath1 != null && imagePath2 != null) {
            session.setAttribute("imagePath1", imagePath1);
            session.setAttribute("imagePath2", imagePath2);
            response.sendRedirect("addproperty.jsp");
         } else {
            out.println("<p>Both images are required.</p>");
         }
      } catch (Exception ex) {
         System.out.println(ex);
      }
   } else {
      out.println("<p>No file uploaded</p>");
   }
%>
