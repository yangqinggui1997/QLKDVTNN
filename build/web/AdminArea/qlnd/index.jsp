<%-- 
    Document   : index
    Created on : Nov 1, 2018, 11:20:05 AM
    Author     : DELL
--%>

<%@page import="Common.CommonCommand"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@page import="java.sql.Timestamp"%>
<%@page import="bus.nguoidungBUS"%>
<%@page import="dto.nguoidung" %>
<%@page import="java.nio.charset.Charset"%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    String manguoidung= (String) session.getAttribute("mand");

if(manguoidung != null){
    if(manguoidung.substring(0,4).equals("NDKT") || manguoidung.substring(0,4).equals("NDBH") || manguoidung.substring(0,4).equals("NDTK")){
        out.print("<center><h1 style='color: red;'> Bạn không có quyền thao tác trên khu vực này!</h1></center>");
    }
    else{
        %>
<% request.setAttribute("child", "child"); request.setAttribute("qlnd", "Yang - Quản lý người dùng"); %>
<jsp:include page="../../View/top.jsp"></jsp:include>
                    <h2>Quản lý người dùng</h2><br>
                    <div class="row">                      
                        <div class="col-sm-8">
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
                                <label style=" position: fixed; z-index: 99;">Mã người dùng</label>                                        
                            </div>
                        </div>
                        <div class="col-sm-2" style="margin-bottom: 40px;">
                            <div class="form-group">
                                <input type="text" class="form-control" id="txtmnd" readonly="" style=" position: fixed; z-index: 99; width: 140px;">
                            </div>
                        </div>
                        <div class="col-sm-1" style="margin-bottom: 40px; margin-right: 20px">
                            <div class="form-group">
                                <button class="btn btn-success" id="btnlammoi" style=" position: fixed; z-index: 99;">Làm mới</button>
                            </div>
                        </div>
                        <div class="col-sm-1" style="margin-bottom: 40px;">
                            <div class="form-group">
                                <button class="btn btn-warning" id="btnsua" data-toggle="modal" style=" position: fixed; z-index: 99;">Sửa</button>
                            </div>
                        </div>
                        <div class="col-sm-1" style="margin-bottom: 20px;">
                            <div class="form-group">
                                <button class="btn btn-danger" id="btnxoa" style=" position: fixed; z-index: 99;">Xoá</button>
                            </div>
                        </div>
                        <div class="col-sm-1">
                        </div>
                        <div class="col-sm-1">
                        </div>
                    </div>    
                    <br>
                    <table class="table table-hover" id="tblnguoidung">   
                        <tr>
                            <th hidden=""></th> 
                            <th>Tên tài khoản</th>
                            <th>Ngày tạo tài khoản</th>
                            <th>Sửa mật khẩu lần cuối</th>
                            <th>Trạng thái</th>
                            <th>Nhóm người dùng</th>
                            
                        </tr>
                        <% String ac=request.getParameter("action");
                                if(ac != null){  
                                    if(keyse != ""){
                                        for (nguoidung nd : nguoidungBUS.TKND(keyse)) {
                        %>
                        <tr>
                            <td hidden=""><%= nd.getIdND()%></td>
                            <td><%= nd.getTenTK()%></td>
                            <td><%= CommonCommand.dedateformat(nd.getNgayTaoTK().toString()) %></td>
                            <td><%= CommonCommand.dedateformat(nd.getSuaMKLanCuoi().toString()) %></td>
                            <td><% if(nd.getTrangThai()== 0){ %>
                                <%= "Bị khoá" %>
                                <% }else if(nd.getTrangThai()== 1){ %>
                                <%= "Đang trong hệ thống" %>
                                <% }else if(nd.getTrangThai()== 2){%>
                                <%= "Đã đăng xuất" %>
                                <% }%>
                            </td>
                            <td><% if(nd.getLoaiND()== 1){ %>
                              <%= "Nhóm quản trị hệ thống" %>
                              <% }else if(nd.getLoaiND() == 2){ %>
                              <%= "Nhóm kế toán" %>

                              <% } else if(nd.getLoaiND() == 3){%>
                              <%= "Nhóm bán hàng" %>
                              <% } else{%>
                              <%= "Nhóm thủ kho" %>
                              <% } %>
                            </td>
                        </tr>
                        <% }} else{ %>
                        <% for (nguoidung nd : nguoidungBUS.getDSND()) { %>
                        <tr>
                            <td hidden=""><%= nd.getIdND()%></td>
                            <td><%= nd.getTenTK()%></td>
                            <td><%= CommonCommand.dedateformat(nd.getNgayTaoTK().toString()) %></td>
                            <td><%= CommonCommand.dedateformat(nd.getSuaMKLanCuoi().toString()) %></td>
                            <td><% if(nd.getTrangThai()== 0){ %>
                                <%= "Bị khoá" %>
                                <% }else if(nd.getTrangThai()== 1){ %>
                                <%= "Đang trong hệ thống" %>
                                <% }else if(nd.getTrangThai()== 2){%>
                                <%= "Đã đăng xuất" %>
                                <% }%>
                            </td>
                            <td><% if(nd.getLoaiND()== 1){ %>
                              <%= "Nhóm quản trị hệ thống" %>
                              <% }else if(nd.getLoaiND() == 2){ %>
                              <%= "Nhóm kế toán" %>

                              <% } else if(nd.getLoaiND() == 3){%>
                              <%= "Nhóm bán hàng" %>
                              <% } else{%>
                              <%= "Nhóm thủ kho" %>
                              <% } %>
                            </td>
                        </tr>
                        <% } %>
                        <script type="text/javascript">
                            alert("Bạn chưa nhập thông tin tìm kiếm!");
                        </script>    
                        <% }} else{%>
                        <%
                            for (nguoidung nd : nguoidungBUS.getDSND()) {
                        %>
                        <tr>   
                            <td hidden=""><%= nd.getIdND()%></td>
                            <td><%= nd.getTenTK()%></td>
                            <td><%= CommonCommand.dedateformat(nd.getNgayTaoTK().toString()) %></td>
                            <td><%= CommonCommand.dedateformat(nd.getSuaMKLanCuoi().toString()) %></td>
                            <td><% if(nd.getTrangThai()== 0){ %>
                                <%= "Bị khoá" %>
                                <% }else if(nd.getTrangThai()== 1){ %>
                                <%= "Đang trong hệ thống" %>
                                <% }else if(nd.getTrangThai()== 2){%>
                                <%= "Đã đăng xuất" %>
                                <% }%>
                            </td>
                            <td><% if(nd.getLoaiND()== 1){ %>
                              <%= "Nhóm quản trị hệ thống" %>
                              <% }else if(nd.getLoaiND() == 2){ %>
                              <%= "Nhóm kế toán" %>

                              <% } else if(nd.getLoaiND() == 3){%>
                              <%= "Nhóm bán hàng" %>
                              <% } else{%>
                              <%= "Nhóm thủ kho" %>
                              <% } %>
                            </td>     
                        </tr>
                        <% }} %>
                    </table>    
                    
                    <!-- Hộp modal chứa form sửa -->
                    <div class="modal fade" id="fsua" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title text-center">Cập nhật thông tin người dùng</h4>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group">
                                        <label>Chọn nhóm người dùng (thay đổi quyền hạn)</label>
                                        <select class="form-control" id="optloaind">
                                            <option value="1" selected="">Nhóm quản trị</option>
                                            <option value="2" >Nhóm kế toán</option>
                                            <option value="3">Nhóm bán hàng</option>
                                            <option value="4" >Nhóm thủ kho</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Chọn trạng thái người dùng(thay đổi khoá tài khoản)</label>
                                        <select class="form-control" id="optloaitt">
                                            <option value="0" selected="">Khoá tài khoản</option>
                                            <option value="2" >Mở khoá tài khoản</option>                            
                                        </select>
                                    </div>                                   
                                </form>          
                            </div>
                            <div class="modal-footer">
                                <div class="form-group align-content-center">
                                    <button class="btn btn-primary" id="nutsua">Sửa</button>
                                </div>
                            </div>

                            </div>
                        </div>
                    </div>
                    <script>
                        //lấy mã người dùng phục vụ sửa xoá
                        $("#tblnguoidung").find("tr").find("td").click(function(){
                           var listOfCell=$(this).siblings(); //biến kết quả trả về thành mảng chứa nội dung trong các ô (giá trị index tương ứng với số cột)
                           $("#tblnguoidung").find("tr").find("td").css({"background-color":"white"});               
                           $(listOfCell[1]).css({"background-color":"lightgray"});
                           $(listOfCell[2]).css({"background-color":"lightgray"});
                           $(listOfCell[3]).css({"background-color":"lightgray"});
                           $(listOfCell[4]).css({"background-color":"lightgray"});
                           $(listOfCell[5]).css({"background-color":"lightgray"});
                           $(this).css({"background-color":"lightgray"});                        
                           $("#txtmnd").val($(listOfCell[0]).text());
                           
                           //kiểm tra mã nhân viên trước khi sửa hoặc xoá
                           $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {mnd: $('#txtmnd').val()},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt === "tc"){
                                            $('#btnsua').attr({"data-target":"#fsua"});
                                        }
                                        else{
                                            $('#btnsua').removeAttr("data-target");
                                            alert("Người dùng không tồn tại!");
                                            return false;
                                        }
                                    }
                                    else{
                                        $('#btnsua').removeAttr("data-target");
                                        alert("Người dùng không tồn tại!");
                                        return false;
                                    } 
                                },
                                error: function() {
                                    $('#btnsua').removeAttr("data-target");
                                    alert("Người dùng không tồn tại!");
                                    return false;
                                }
                            });
                        });

                        //sửa
                        $('#btnsua').click(function() {
                            let mnd=$("#txtmnd").val();
                            if(mnd === ""){
                                alert("Bạn chưa chọn người dùng nào!");
                                return false;
                            }else{
                                if(mnd.toString().substring(0,4)==="NDQT"){
                                    $('#optloaind').val(1);
                                }
                                else if(mnd.toString().substring(0,4)==="NDKT"){
                                    $('#optloaind').val(2);
                                }
                                else if(mnd.toString().substring(0,4)==="NDBH"){
                                    $('#optloaind').val(3);
                                }
                                else if(mnd.toString().substring(0,4)==="NDTK"){
                                    $('#optloaind').val(4);
                                }
                                else{
                                    alert("Mã người dùng không hợp lệ!");
                                    return false;
                                }
                            }  
                        });

                        $('#nutsua').click(function() {
                            let loaind= $('#optloaind').val();
                            let loaitt=$('#optloaitt').val();
                            let mand=$('#txtmnd').val();
                            $.ajax({
                               type: "POST",
                               url: 'proccess.jsp',
                               data: {mand: mand, loaind: loaind, loaitt: loaitt, tt: "sua"},
                               success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().split('|');
                                    let d=dt[0].toString().trim(), lnd=dt[1].toString().trim(), ltt=dt[2].toString().trim();
                                    if(d !== "null" && lnd !== "null" && ltt !== "null"){
                                        
                                        if(d === "kodoi"){
                                            alert("Thông tin không thay đổi!");
                                            location.replace('../qlnd');
                                        }
                                        else{
                                            if(lnd === "doi" && ltt=== "doi"){
                                                $.ajax({
                                                   type: "POST",
                                                   url: 'proccess.jsp',
                                                   data: {mand: mand, loaind: loaind, loaitt: loaitt, tt: "sua", htd: "doi|doi"},
                                                   success: function(data) {
                                                       let dt=data;
                                                       dt=dt.toString().trim();
                                                        if(dt !== null){
                                                            if(dt === "tc"){
                                                                alert("Cập nhật thành công!");
                                                                location.replace('../qlnd');
                                                            }
                                                            else{
                                                                alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                                                return false;
                                                            }
                                                        }
                                                        else{
                                                            alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                                                return false;
                                                        }
                                                   },
                                                   error: function() {
                                                        alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                                        return false;
                                                    }
                                                   
                                                });
                                            }
                                            else{
                                                if(lnd === "doi"){
                                                    $.ajax({
                                                       type: "POST",
                                                       url: 'proccess.jsp',
                                                       data: {mand: mand, loaind: loaind, loaitt: loaitt, tt: "sua", htd: "doi|kodoi"},
                                                       success: function(data) {
                                                           let dt=data;
                                                           dt=dt.toString().trim();
                                                            if(dt !== null){
                                                                if(dt === "tc"){
                                                                    alert("Cập nhật thành công!");
                                                                    location.replace('../qlnd');
                                                                }
                                                                else{
                                                                    alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                                                    return false;
                                                                }
                                                            }
                                                            else{
                                                                alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                                                    return false;
                                                            }
                                                       },
                                                       error: function() {
                                                            alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                                            return false;
                                                        }

                                                    });
                                                }
                                                if(ltt=== "doi"){
                                                    $.ajax({
                                                       type: "POST",
                                                       url: 'proccess.jsp',
                                                       data: {mand: mand, loaind: loaind, loaitt: loaitt, tt: "sua", htd: "kodoi|doi"},
                                                       success: function(data) {
                                                           let dt=data;
                                                           dt=dt.toString().trim();
                                                            if(dt !== null){
                                                                if(dt === "tc"){
                                                                    alert("Cập nhật thành công!");
                                                                    location.replace('../qlnd');
                                                                }
                                                                else{
                                                                    alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                                                    return false;
                                                                }
                                                            }
                                                            else{
                                                                alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                                                    return false;
                                                            }
                                                       },
                                                       error: function() {
                                                            alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                                            return false;
                                                        }

                                                    });
                                                }
                                            }
                                        }
                                    }
                                    else{
                                        alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                            return false;
                                    }
                                },
                                error: function() {
                                    alert("Cập nhật thất bại, hãy thử lại lần sau!");
                                    return false;
                                }
                            });
                        });
                        
                        //xoá
                        $('#btnxoa').click(function(){
                            let mnd=$("#txtmnd").val();
                            if(mnd === ""){
                                alert("Bạn chưa chọn người dùng nào!");
                                return false;
                            }
                            else{
                                var r=confirm("Bạn có chắc chắn muốn xoá người dùng có mã "+ mnd+"!");
                                if(r == true){
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {mand: mnd, tt: "xoa"},
                                        success: function(data) {   
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt==="tc"){
                                                    alert("Xoá thành công!");
                                                    location.replace("../qlnd");
                                                }
                                                else if(dt==="ndonline"){
                                                    alert("Không thể xoá người dùng, người dùng này đang trong hệ thống, hãy đợi họ đăng xuất!");
                                                    return false;
                                                }
                                                else if(dt === "xoaqt"){
                                                    alert("Không thể xoá người dùng là nhân viên quản trị, người dùng này được bảo vệ!");
                                                    return false;
                                                }
                                                else{
                                                    alert("Xoá thất bại, hãy thử lại lần nữa!");
                                                    return false;
                                                }
                                            }
                                            else{
                                                alert("Xoá thất bại, hãy thử lại lần nữa!");
                                                return false;
                                            }
                                        },
                                        error: function() {
                                            alert("Xoá thất bại, hãy thử lại lần sau!");
                                            return false;
                                        }

                                    });
                                }

                            }
                        });
                        $('#btnlammoi').click(function() {
                                location.replace("../qlnd");
                        });
                    </script>
<jsp:include page="../../View/bottom.jsp"></jsp:include>
<% request.removeAttribute("child"); %>
<%
    }
}else{
       %>
       <script>
           location.replace("../../");
       </script>
    
    <%
}
%>
