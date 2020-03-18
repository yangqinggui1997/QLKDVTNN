<%-- 
    Document   : index
    Created on : Nov 6, 2018, 10:52:00 PM
    Author     : DELL
--%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@page import="java.sql.Timestamp"%>
<%@page import="dao.nhanvienDAO"%>
<%@page import="bus.nhanvienBUS"%>
<%@page import="dto.nhanvien" %>
<%@page import="java.nio.charset.Charset"%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    String manguoidung= (String) session.getAttribute("mand"); 
if(manguoidung != null){
    if(manguoidung.substring(0,4).equals("NDQT") || manguoidung.substring(0,4).equals("NDKT") || manguoidung.substring(0,4).equals("NDBH")){
        out.print("<center><h1 style='color: red;'> Bạn không có quyền thao tác trên khu vực này!</h1></center>");
    }
    else{
        %>
<% request.setAttribute("parent", "parent"); request.setAttribute("thukhoarea", "Yang - Trang nhân viên thủ kho");
    %>
<jsp:include page="../View/top.jsp"></jsp:include>
    <h2>Mời bạn chọn danh mục quản lý!</h2>
    
<jsp:include page="../View/bottom.jsp"></jsp:include>
<% request.removeAttribute("child"); %>

<%
    }
}else{
       %>
       <script>
           location.replace("../");
       </script>
    
    <%
}
%>