<%-- 
    Document   : menu_l_kt
    Created on : Nov 1, 2018, 10:11:43 AM
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
        
        <li class="active"><a style="cursor: pointer;" id="qt"><span class="glyphicon glyphicon-cog"></span> Khu vực nhân viên kế toán</a></li>
      <% String pa=(String) request.getAttribute("par");
        String dr=(String) request.getAttribute("dter");
        
            if(pa!=null){ %>
      <li><a href="../KetoanArea/tkbc/tkht"><span class="glyphicon glyphicon-user"></span> Thống kê hàng tồn</a></li>   
      <li ><a href="../KetoanArea/tkbc/tkspb"><span class="glyphicon glyphicon-briefcase"></span> Thống kê sản phẩm bán</a></li>
      
      <%  
      } else if(dr!=null){ 
      %>
      <li><a href="../tkht"><span class="glyphicon glyphicon-user"></span> Thống kê hàng tồn</a></li>   
      <li><a href="../tkspb"><span class="glyphicon glyphicon-briefcase"></span> Thống kê sản phẩm bán</a></li>
     <% } %>
    </ul><br>
      <script>
        $('#qt').click(function() {
            if(window.location.pathname.toString().split('/').length === 4){
                location.replace('');
            }
            else if(window.location.pathname.toString().split('/').length === 6){

                location.replace('../../');
            }
        });
    </script> 
</div>