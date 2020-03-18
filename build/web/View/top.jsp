<%-- 
    Document   : top
    Created on : Oct 31, 2018, 10:47:04 PM
    Author     : DELL
--%>


<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <%  
            //hiển thị cho quản trị viên
            String par=(String) request.getAttribute("parent");
            String chi=(String) request.getAttribute("child");
            
            //hiển thị cho nhan vien kế toán
            String dter=(String) request.getAttribute("daughter");

            if(par!=null){ request.setAttribute("par", "par");%>
        <link rel="shortcut icon" href="../images/favicon.png">
        <% String adminarea= (String) request.getAttribute("adminarea");
        if(adminarea !=null){ %>
        <title><%= adminarea %></title>
        <% request.removeAttribute("adminarea");} %>

        <% String banhangarea= (String) request.getAttribute("banhangarea");
        if(banhangarea !=null){ %>
        <title><%= banhangarea %></title>
        <% request.removeAttribute("banhangarea");} %>
        
        <% String ketoanarea= (String) request.getAttribute("ketoanarea");
        if(ketoanarea !=null){ %>
        <title><%= ketoanarea %></title>
        <% request.removeAttribute("ketoanarea");} %>

        <% String thukhoarea= (String) request.getAttribute("thukhoarea");
        if(thukhoarea !=null){ %>
        <title><%= thukhoarea %></title>
        <% request.removeAttribute("thukhoarea");} %>

        <script src="../js/moment.js"></script>
        <script src="../js/jquery-3.3.1.js"></script>
        <script src="../js/bootstrap.js"></script>
        <script src="../js/bootstrap-datetimepicker.js"></script>
        <link rel="stylesheet" href="../css/bootstrap.css">
        <link href="../css/bootstrap-datetimepicker.css" rel="stylesheet"/>
    </head>
    <body id="body"> 
        <% if(adminarea != null){ %>
        <jsp:include page="../menu_s_admin.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row content">
                <jsp:include page="../menu_l_admin.jsp"></jsp:include>
                <br>
                <div class="col-sm-9">
                    <div class="container-fluid">
                        <% } %>
                        
        <% if(thukhoarea != null){ %>
        <jsp:include page="../menu_s_tk.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row content">
                <jsp:include page="../menu_l_tk.jsp"></jsp:include>
                <br>
                <div class="col-sm-9">
                    <div class="container-fluid">
                        <% } %>
                        
        <% if(banhangarea != null){ %>
        <jsp:include page="../menu_s_bh.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row content">
                <jsp:include page="../menu_l_bh.jsp"></jsp:include>
                <br>
                <div class="col-sm-9">
                    <div class="container-fluid">
                        <% } %>
                        
        <% if(ketoanarea != null){ %>
        <jsp:include page="../menu_s_kt.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row content">
                <jsp:include page="../menu_l_kt.jsp"></jsp:include>
                <br>
                <div class="col-sm-9">
                    <div class="container-fluid">
                        <% } %>
                        
                        <!-- Nhúng phần menu người dùng -->    
                        <jsp:include page="../menunguoidung.jsp"></jsp:include>
                    </div>
                    <%  request.removeAttribute("par"); 
                    } else if(chi != null) { request.setAttribute("chi", "chi"); %>
                    
        <link rel="shortcut icon" href="../../images/favicon.png">
        
        <% String qlnv= (String) request.getAttribute("qlnv");
        if(qlnv !=null){ %>
        <title><%= qlnv %></title>
        <% request.removeAttribute("qlnv");} %>
        
        <% String qlnd= (String) request.getAttribute("qlnd");
        if(qlnd !=null){ %>
        <title><%= qlnd %></title>
        <% request.removeAttribute("qlnd");} %>

        <% String qlkh= (String) request.getAttribute("qlkh");
        if(qlkh !=null){ %>
        <title><%= qlkh %></title>
        <% request.removeAttribute("qlkh");} %>
        
        <% String qlhdb= (String) request.getAttribute("qlhdb");
        if(qlhdb !=null){ %>
        <title><%= qlhdb %></title>
        <% request.removeAttribute("qlhdb");} %>

        <% String qlncu= (String) request.getAttribute("qlncu");
        if(qlncu !=null){ %>
        <title><%= qlncu %></title>
        <% request.removeAttribute("qlncu");} %>
        
        <% String qlsp= (String) request.getAttribute("qlsp");
        if(qlsp !=null){ %>
        <title><%= qlsp %></title>
        <% request.removeAttribute("qlsp");} %>
        
        <% String qlhdn= (String) request.getAttribute("qlhdn");
        if(qlhdn !=null){ %>
        <title><%= qlhdn %></title>
        <% request.removeAttribute("qlhdn");} %>
        
        <script src="../../js/moment.js"></script>
        <script src="../../js/jquery-3.3.1.js"></script>
        <script src="../../js/bootstrap.js"></script>
        <script src="../../js/bootstrap-datetimepicker.js"></script>
        <link rel="stylesheet" href="../../css/bootstrap.css">
        <link href="../../css/bootstrap-datetimepicker.css" rel="stylesheet"/>
       
    </head>
    <body> 
        <% if(qlnd != null || qlnv != null){ %>
        <jsp:include page="../menu_s_admin.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row content">
                <jsp:include page="../menu_l_admin.jsp"></jsp:include>
                
                <br>
                <div class="col-sm-9">
                    <div class="container-fluid">
                        <!-- Nhúng phần menu người dùng -->    
                        <% } %>
        
        <% if(qlkh != null || qlhdb != null){ %>
        <jsp:include page="../menu_s_bh.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row content">
                <jsp:include page="../menu_l_bh.jsp"></jsp:include>
                
                <br>
                <div class="col-sm-9">
                    <div class="container-fluid">
                        <!-- Nhúng phần menu người dùng -->    
                        <% } %>
                        
        <% if(qlncu != null || qlsp != null || qlhdn != null){ %>
        <jsp:include page="../menu_s_tk.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row content">
                <jsp:include page="../menu_l_tk.jsp"></jsp:include>
                
                <br>
                <div class="col-sm-9">
                    <div class="container-fluid">
                        <!-- Nhúng phần menu người dùng -->    
                        <% } %>
                        
                        <jsp:include page="../menunguoidung.jsp"></jsp:include>
                    </div>
                    <% request.removeAttribute("child");
                       } else if(dter != null) { request.setAttribute("dter", "dter"); %>
        <link rel="shortcut icon" href="../../../images/favicon.png">
        
        <% String tkht= (String) request.getAttribute("tkht");
        if(tkht !=null){ %>
        <title><%= tkht %></title>
        <% request.removeAttribute("tkht");} %>
        
        <% String tkspb= (String) request.getAttribute("tkspb");
        if(tkspb !=null){ %>
        <title><%= tkspb %></title>
        <% request.removeAttribute("tkspb");} %>

        <script src="../../../js/moment.js"></script>
        <script src="../../../js/jquery-3.3.1.js"></script>
        <script src="../../../js/bootstrap.js"></script>
        <script src="../../../js/bootstrap-datetimepicker.js"></script>
        <link rel="stylesheet" href="../../../css/bootstrap.css">
        <link href="../../../css/bootstrap-datetimepicker.css" rel="stylesheet"/>
      
    </head>
    <body> 
        <jsp:include page="../menu_s_kt.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row content">
                <jsp:include page="../menu_l_kt.jsp"></jsp:include>
                
                <br>
                <div class="col-sm-9">
                    <div class="container-fluid">
                        <!-- Nhúng phần menu người dùng -->    
                        
                        <jsp:include page="../menunguoidung.jsp"></jsp:include>
                    </div>
                    <% request.removeAttribute("daughter"); }
%>