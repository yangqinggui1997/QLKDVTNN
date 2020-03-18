<%-- 
    Document   : menu_s
    Created on : Oct 31, 2018, 11:13:13 PM
    Author     : DELL
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav class="navbar navbar-inverse visible-xs">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
        <a class="navbar-brand" href="#">
          <h3 style="margin: 0;">          
              <span class="label label-primary">Y</span>
              <span class="label label-warning">A</span>
              <span class="label label-success">N</span>
              <span class="label label-danger">G</span>
            </h3>
      </a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a style="cursor: pointer;" id="qtsmall"><span class="glyphicon glyphicon-cog"></span> Khu vực quản trị</a></li>      
      <% String pa=(String) request.getAttribute("par");
        String ch=(String) request.getAttribute("chi");
        
            if(pa!=null){ %>
      <li><a href="../AdminArea/qlnd"><span class="glyphicon glyphicon-user"></span> Quản lý người dùng</a></li>   
      <li ><a href="../AdminArea/qlnv"><span class="glyphicon glyphicon-briefcase"></span> Quản lý nhân viên</a></li>
      <% }else if(ch!=null){ 
      %>
      <li><a href="../qlnd"><span class="glyphicon glyphicon-user"></span> Quản lý người dùng</a></li>   
      <li><a href="../qlnv"><span class="glyphicon glyphicon-briefcase"></span> Quản lý nhân viên</a></li>
     <% } %>
     
      </ul>
     <script>
        $('#qtsmall').click(function() {
            $('#qt').click();
        });
    </script>
    </div>
  </div>
</nav>