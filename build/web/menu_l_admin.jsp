<%-- 
    Document   : menu_l
    Created on : Oct 31, 2018, 11:14:56 PM
    Author     : DELL
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-sm-3 sidenav hidden-xs">
    <h3 style="margin-left: 80px">          
      <span class="label label-primary">Y</span>
      <span class="label label-warning">A</span>
      <span class="label label-success">N</span>
      <span class="label label-danger">G</span>
    </h3><br>
    <ul class="nav nav-pills nav-stacked">
        
        <li class="active"><a style="cursor: pointer;" id="qt"><span class="glyphicon glyphicon-cog"></span> Khu vực quản trị</a></li>
      <% String pa=(String) request.getAttribute("par");
        String ch=(String) request.getAttribute("chi");
        
            if(pa!=null){ %>
      <li><a href="../AdminArea/qlnd"><span class="glyphicon glyphicon-user"></span> Quản lý người dùng</a></li>   
      <li ><a href="../AdminArea/qlnv"><span class="glyphicon glyphicon-briefcase"></span> Quản lý nhân viên</a></li>
      
      <%  
      } else if(ch!=null){ 
      %>
      <li><a href="../qlnd"><span class="glyphicon glyphicon-user"></span> Quản lý người dùng</a></li>   
      <li><a href="../qlnv"><span class="glyphicon glyphicon-briefcase"></span> Quản lý nhân viên</a></li>
     <% } %>
    </ul><br>
      <script>
        $('#qt').click(function() {
            if(window.location.pathname.toString().split('/').length === 4){
                location.replace('');
            }
            else if(window.location.pathname.toString().split('/').length === 5){

                location.replace('../');
            }
        });
    </script>        
</div>
