<%-- 
    Document   : main.jsp
    Created on : Nov 1, 2018, 8:27:32 PM
    Author     : DELL
--%>

<%@page import="bus.nguoidungBUS"%>
<%@page import="dto.nguoidung"%>
<%@page import="bus.hangtonBUS"%>
<%@page import="dto.hangton"%>
<%@page import="Common.CommonCommand"%>
<!--<system.web>
    <globalization
    requestEncoding="utf-8"
    responseEncoding="utf-8"
    culture="en-GB"
    uiCulture="en-GB" />    
</system.web>-->
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
    if(manguoidung.substring(0,4).equals("NDQT") || manguoidung.substring(0,4).equals("NDBH") || manguoidung.substring(0,4).equals("NDTK")){
        out.print("<center><h1 style='color: red;'> Bạn không có quyền thao tác trên khu vực này!</h1></center>");
    }
    else{
        %>
<% request.setAttribute("daughter", "daughter"); request.setAttribute("tkht", "Yang - Thống kê hàng tồn"); %>
<jsp:include page="../../../View/top.jsp"></jsp:include>
                    <!--lấy mã nhân viên phục vụ thêm-->
                    <% nguoidung nd=nguoidungBUS.getND(manguoidung);%>
                    <p id="manv" hidden=""><%= nd.getIdNV()%></p> 
                    <h2>Thống kê hàng tồn</h2><br>
                    <div class="row">
                        <div class="col-sm-2" style="margin-bottom: 40px;">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#fthem" id="btnthem" style=" position: fixed; z-index: 99;">
                                <span class="glyphicon glyphicon-plus"></span> Thêm thống kê
                            </button>
                        </div>
                        <div class="col-sm-6">
                            <form>
                                <div class="row" >
                                    <div class="col-sm-7" style="margin-bottom: 50px;">
                                        <div class="form-group">
                                            <%
                                                //lấy giá trị từ textbox search
                                                String keyse=request.getParameter("keysearch");
                                                if(keyse !=null){
                                                    if(keyse != ""){
                                            %>
                                            <input class="form-control" type="text" name="keysearch"  value="<%= keyse  %>" style=" position: fixed; z-index: 99; width: 270px;">
                                            <% }else{ %>
                                            <input class="form-control" type="text" name="keysearch" placeholder="Bạn cần tìm gì?" style=" position: fixed; z-index: 99; width: 270px;">
                                            <% }}else{ %>
                                            <input class="form-control" type="text" name="keysearch" placeholder="Bạn cần tìm gì?" style=" position: fixed; z-index: 99; width: 270px;">
                                            <% } %>
                                        </div>
                                    </div>
                                    <div class="col-sm-5" style="margin-bottom: 30px;">
                                        <button class="btn btn-info" type="submit" name="action" value="tk" formmethod="get" style=" position: fixed; z-index: 99;">
                                            &nbsp;&nbsp;<span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-sm-2"></div>
                        <div class="col-sm-2"></div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2" style="margin-bottom: 30px;">
                            <div class="form-group">
                                <label style=" position: fixed; z-index: 99;">Mã thống kê</label>                                        
                            </div>
                        </div>
                        <div class="col-sm-2" style="margin-bottom: 40px;">
                            <div class="form-group">
                                <input type="text" class="form-control" id="txtmtk" style=" position: fixed; z-index: 99; width: 140px;">
                            </div>
                        </div>
                        <div class="col-sm-1" style="margin-bottom: 40px; margin-right: 20px">
                            <div class="form-group">
                                <button class="btn btn-info" data-toggle="modal" id="btnxemct" style=" position: fixed; z-index: 99;">Xem chi tiết</button>
                            </div>
                        </div>
                        <div class="col-sm-1" style="margin-bottom: 40px;">
                            <div class="form-group">
                                <button class="btn btn-success" id="btnlammoi" style=" position: fixed; z-index: 99;">Làm mới</button>
                            </div>
                        </div>
                        <div class="col-sm-1" style="margin-bottom: 40px;">
                            <div class="form-group">
                                <button class="btn btn-warning" id="btnsua" data-toggle="modal" style=" position: fixed; z-index: 99;">Cập nhật</button>
                            </div>
                        </div>
                        <div class="col-sm-1" style="margin-bottom: 20px;">
                            <div class="form-group">
                                <button class="btn btn-danger" id="btnxoa" style=" position: fixed; z-index: 99;">Xoá</button>
                            </div>
                        </div>
                        
                        <div class="col-sm-4">
                        </div>
                    </div>                       
                    <!-- Danh sách thống kê -->
                    <br>
                    <table class="table table-hover" id="tbltk">   
                        <tr>
                            <th hidden=""></th> 
                            <th>Nhân viên lập</th>
                            <th>Tổng số lượng tồn trong tháng</th>
                            <th>Ngày thống kê</th>
                            <th>Ngày cập nhật</th>
                        </tr>
                        <% String ac=request.getParameter("action");
                                if(ac != null){  
                                    if(keyse != ""){
                                        for (hangton ht : hangtonBUS.TKHT(keyse)) {
                        %>
                        <tr>
                            <td hidden=""><%= ht.getIdHT()%></td>
                            <% nhanvien nv=nhanvienBUS.getNV(ht.getIdNV()); %>
                            <td><%= nv.getTenNV() %></td>
                            <td><%= String.format("%,d",ht.getTongSLTNgay())%></td>
                            <td><%= CommonCommand.dedateformat(ht.getNgayTK().toString()) %></td>
                            <td><%= CommonCommand.dedateformat(ht.getNgayCN().toString()) %></td>
                        </tr>
                        <% }} else{ %>
                        <% for (hangton ht : hangtonBUS.getDSHT()) { %>
                        <tr>
                            <td hidden=""><%= ht.getIdHT()%></td>
                            <% nhanvien nv=nhanvienBUS.getNV(ht.getIdNV()); %>
                            <td><%= nv.getTenNV() %></td>
                            <td><%= String.format("%,d",ht.getTongSLTNgay())%></td>
                            <td><%= CommonCommand.dedateformat(ht.getNgayTK().toString()) %></td>
                            <td><%= CommonCommand.dedateformat(ht.getNgayCN().toString()) %></td>
                        </tr>
                        <% } %>
                        <script type="text/javascript">
                            alert("Bạn chưa nhập thông tin tìm kiếm!");
                        </script>    
                        <% }} else{%>
                        <%
                            for (hangton ht : hangtonBUS.getDSHT()) {
                        %>
                        <tr>   
                            <td hidden=""><%= ht.getIdHT()%></td>
                            <% nhanvien nv=nhanvienBUS.getNV(ht.getIdNV()); %>
                            <td><%= nv.getTenNV() %></td>
                            <td><%= String.format("%,d",ht.getTongSLTNgay())%></td>
                            <td><%= CommonCommand.dedateformat(ht.getNgayTK().toString()) %></td>
                            <td><%= CommonCommand.dedateformat(ht.getNgayCN().toString()) %></td>
                        </tr>
                        <% }} %>  
                    </table>

                     <!-- Hộp modal chứa table chi tiết -->
                    <div class="modal fade" id="fchitiet" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title text-center" id="modalttct">Chi tiết thống kê</h4>
                                </div>
                                <div class="modal-body">
                                    <div id="tbltkct">
                                        <!--Vùng hiển thị danh sách chi tiết-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                  
                    <script>
                        //thêm
                        $('#btnthem').click(function (){
                            var manv=$('#manv').text().toString().trim();
                            $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {tt: "kttkthang"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt==="tc"){
                                            //duoc them
                                            $.ajax({
                                                type: "POST",
                                                url: "proccess.jsp",
                                                data: {manv: manv, tt: "them"},
                                                success: function(data) {
                                                    let dt=data;
                                                    dt=dt.toString().trim();
                                                    if(dt!==null){
                                                        if(dt==="tc"){
                                                            alert("Thêm thành công!");
                                                            location.replace("../tkht");
                                                        }
                                                        else{
                                                            alert("Thêm thất bại, hãy thử lại lần nữa!");
                                                            return false;
                                                        }
                                                    }
                                                    else{
                                                        alert("Thêm thất bại, có thể đã xảy ra lỗi!");
                                                        return false;
                                                    } 
                                                },
                                                error: function() {
                                                    alert("Thêm thất bại, đã có lỗi xảy ra!");
                                                    return false;
                                                }
                                            });
                                        }
                                        else{
                                            alert("Thêm thất bại, đã có thống kê trong tháng này, hãy thao tác cập nhật!");
                                            return false;
                                        }
                                    }
                                    else{
                                        alert("Thêm thất bại, đã có lỗi xảy ra, không thể kiểm tra các thống kê gần đây!");
                                        return false;
                                    } 
                                },
                                error: function() {
                                    alert("Thêm thất bại, đã có lỗi xảy ra!");
                                    return false;
                                }
                            });
                        });

                        let kttk="";
                        //lấy mã tk phục vụ sửa xoá
                        $("#tbltk").find("tr").find("td").click(function(){
                           var listOfCell=$(this).siblings(); //biến kết quả trả về thành mảng chứa nội dung trong các ô (giá trị index tương ứng với số cột)
                           $("#tbltk").find("tr").find("td").css({"background-color":"white"});               
                           $(listOfCell[1]).css({"background-color":"lightgray"});
                           $(listOfCell[2]).css({"background-color":"lightgray"});
                           $(listOfCell[3]).css({"background-color":"lightgray"});
                           $(listOfCell[4]).css({"background-color":"lightgray"});
                           $(this).css({"background-color":"lightgray"});
                           $("#txtmtk").val($(listOfCell[0]).text());

                           kttk=""; //khởi tạo flag kiểm tra.
                           $('#btnxemct').removeAttr("data-target");
                           //kiểm tra mã hoá đơn trước khi xem chi tiết, sửa hoặc xoá
                           $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {mht: $('#txtmtk').val(), tt: "ktht"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt === "tc"){
                                            kttk=dt;
                                            $('#btnxemct').attr({"data-target":"#fchitiet"});
                                        }
                                        else{
                                            kttk="tb";
                                        }
                                    }
                                    else{
                                        kttk="tb";
                                    } 
                                },
                                error: function() {
                                    kttk="tb";
                                }
                            });
                        });
                        
                        function laydshtct(mht) {
                            $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {mht: mht, tt: "laydshtct"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    let dtarr=dt.split('|');
                                    if(dt!==null){
                                        if(dtarr[0].toString().trim() !== "null"){
                                            $('#tbltkct').html(dtarr[0]);
                                        }
                                        else{
                                            alert("Thống kê không có chi tiết nào!");
                                            $('#tbltkct').html(dtarr[1]);
                                        }
                                    }
                                    else{
                                        alert("Đã có lỗi xảy ra, không thể lấy danh sách hàng tồn chi tiết!");
                                        return false;
                                    } 
                                },
                                error: function() {
                                    alert("Đã có lỗi xảy ra, không thể lấy danh sách hàng tồn chi tiết!");
                                    return false;
                                }
                            });
                        };
                        
                        //xem chi tiết hàng tồn
                        $('#btnxemct').click(function() {
                            let mht=$("#txtmtk").val();
                            if(mht === ""){
                                alert("Bạn chưa chọn thống kê nào!");
                                return false;
                            }
                            else{
                                if(kttk === "tc"){
                                    laydshtct(mht);
                                }
                                else{
                                    alert("Thống kê không tồn tại!");
                                    return false;
                                }
                            }

                        });
                        
                        //cập nhật tk
                        $('#btnsua').click(function() {
                            let maht=$("#txtmtk").val();
                            if(maht === ""){
                                alert("Bạn chưa chọn thống kê nào!");
                                return false;
                            }else{
                                if(kttk === "tc"){
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {mht: maht, tt: "sua"},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt==="tc"){
                                                    alert("Cập nhật thành công!");
                                                    location.replace("../tkht");
                                                }
                                                else{
                                                    alert("Cập nhật thất bại, hãy thử lại lần nữa!");
                                                    return false;
                                                }
                                            }
                                            else{
                                                alert("Cập nhật thất bại, có thể đã xảy ra lỗi!");
                                                return false;
                                            } 
                                        },
                                        error: function() {
                                            alert("Cập nhật thất bại, đã có lỗi xảy ra!");
                                            return false;
                                        }
                                    });
                                }
                                else{
                                    alert("Thống kê không tồn tại!");
                                    return false;
                                }
                            }  
                        });

                        //xoá
                        $('#btnxoa').click(function(){
                            let maht=$("#txtmtk").val();
                            if(maht === ""){
                                alert("Bạn chưa chọn thống kê nào!");
                                return false;
                            }
                            else{
                                var r=confirm("Bạn có chắc chắn muốn xoá thống kê có mã "+ maht+"!");
                                if(r == true){
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {mht: maht, tt: "xoa"},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt==="tc"){
                                                    alert("Xoá thành công!");
                                                    location.replace("../tkht");
                                                }
                                                else{
                                                    alert("Xoá thất bại, hãy thử lại lần nữa!");
                                                    return false;
                                                }
                                            }
                                            else{
                                                alert("Xoá thất bại, có thể đã xảy ra lỗi!");
                                                return false;
                                            }
                                        },
                                        error: function() {
                                            alert("Xoá thất bại, đã có lỗi xảy ra!");
                                            return false;
                                        }
                                    });
                                }

                            }
                        });

                        $('#btnlammoi').click(function() {
                            location.replace("../tkht");
                        });
                    </script>
<jsp:include page="../../../View/bottom.jsp"></jsp:include>
<% request.removeAttribute("daughter"); %>

<%
    }
}else{
       %>
       <script>
           location.replace("../../../");
       </script>
    
    <%
}
%>