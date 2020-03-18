<%-- 
    Document   : newjsp
    Created on : Nov 15, 2018, 3:03:22 PM
    Author     : DELL
--%>


<%@page import="java.nio.charset.Charset"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.oreilly.servlet.MultipartRequest" %>

<%
    final Charset ISO_8859_1 = Charset.forName("ISO-8859-1");
    final Charset UTF_8 = Charset.forName("UTF-8");
    final String UPLOAD_DIRECTORY = "../../web/images/SP";
    final String UPLOAD_DIRECTORY1 = "images/SP";
    final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB
    
    int kt=request.getContentLength();
    if(kt > 194)
    {
        if (!ServletFileUpload.isMultipartContent(request)) {
            // kiểm tra form có multipart không, nếu ko thì stop
            PrintWriter writer = response.getWriter();
            writer.println("Error: Form must has enctype=multipart/form-data.");
            writer.flush();
            return;
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        // đặt vùng nhớ dựa vào vùng chọn file
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // đặt đường dẫn tạm lưu file
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        // sặt kích thước lớn nhất cho file up
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // đặt kích thước lớn nhất cho file up (bao gồm file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);

        // tạo đường dẫn lưu file (đường dẫn tương đối)
        String uploadPath = getServletContext().getRealPath("")
                + File.separator + UPLOAD_DIRECTORY;
        byte ptext[] = uploadPath.getBytes(ISO_8859_1); 
        uploadPath = new String(ptext, UTF_8); 
        // tạo đường dẫn nếu dd ko tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
        // tạo đường dẫn lưu file (đường dẫn tương đối) lưu trong build
        String uploadPath1 = getServletContext().getRealPath("")
                + File.separator + UPLOAD_DIRECTORY1;
        byte ptext1[] = uploadPath1.getBytes(ISO_8859_1); 
        uploadPath1 = new String(ptext1, UTF_8); 
        // tạo đường dẫn nếu dd ko tồn tại
        File uploadDir1 = new File(uploadPath1);
        if (!uploadDir1.exists()) {
            uploadDir1.mkdir();
        }
        
        try {
            
            List<FileItem> formItems = upload.parseRequest(request);

            if (formItems != null && formItems.size() > 0) {
                for (FileItem item : formItems) {
                    if (!item.isFormField()) {
                        
                        String fileName = new File(item.getName()).getName();
                        byte pt[] = fileName.getBytes(ISO_8859_1); 
                        fileName= new String(pt, UTF_8);
                        String filePath = uploadPath + File.separator + fileName;
                        byte ptxt[] = filePath.getBytes(ISO_8859_1); 
                        filePath= new String(ptxt, UTF_8); 
                        File storeFile = new File(filePath);
                        
                        String filePath1 = uploadPath1 + File.separator + fileName;
                        byte ptxt1[] = filePath1.getBytes(ISO_8859_1); 
                        filePath1= new String(ptxt1, UTF_8); 
                        File storeFile1 = new File(filePath1);
                        
                        // lưu file vào đĩa
                        item.write(storeFile);
                        item.write(storeFile1);//lưu vào build
                    }
                }
            }
        } catch (Exception ex) {
            out.print(ex);
        }
        %>
<!--        <script>
            location.replace("../qlsp");
        </script>-->
        <%
    }
    else
    {
        %>
        <script>
            location.replace("../qlsp");
        </script>
        <%
    }

%> 