<%-- 
    Document   : main.jsp
    Created on : Nov 1, 2018, 8:27:32 PM
    Author     : DELL
--%>

<%@page import="bus.khachhangBUS"%>
<%@page import="dto.khachhang"%>
<%@page import="bus.hoadonbanBUS"%>
<%@page import="dto.hoadonban"%>
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
    if(manguoidung.substring(0,4).equals("NDQT") || manguoidung.substring(0,4).equals("NDKT") || manguoidung.substring(0,4).equals("NDTK")){
        out.print("<center><h1 style='color: red;'> Bạn không có quyền thao tác trên khu vực này!</h1></center>");
    }
    else{
        %>
<% request.setAttribute("child", "child"); request.setAttribute("qlhdb", "Yang - Quản lý hoá đơn bán"); %>
<jsp:include page="../../View/top.jsp"></jsp:include>
                    <h2>Quản lý hoá đơn bán hàng</h2><br>
                    <div class="row">
                        <div class="col-sm-2" style="margin-bottom: 40px;">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#fthem" id="btnthem" style=" position: fixed; z-index: 99;">
                                <span class="glyphicon glyphicon-plus"></span> Thêm hoá đơn
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
                                <label style=" position: fixed; z-index: 99;">Mã hoá đơn</label>                                        
                            </div>
                        </div>
                        <div class="col-sm-2" style="margin-bottom: 40px;">
                            <div class="form-group">
                                <input type="text" class="form-control" id="txtmhdb" style=" position: fixed; z-index: 99; width: 140px;">
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
                                <button class="btn btn-warning" id="btnsua" data-toggle="modal" style=" position: fixed; z-index: 99;">Sửa</button>
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
                    <!-- Danh sách hoá đơn bán -->
                    <br>
                    <table class="table table-hover" id="tblhoadonban">   
                        <tr>
                            <th hidden=""></th> 
                            <th>Nhân viên lập</th>
                            <th>Khách hàng</th>
                            <th>Ngày lập</th>
                            <th>Hình thức thanh toán</th>
                            <th>Đã thanh toán</th>
                            <th>Tổng số lượng</th>
                            <th>Tổng tiền</th>
                            <th>Tình trạng</th>
                            <th>Tình trạng nhận hàng</th>
                            <th>Ngày cập nhật</th>
                        </tr>
                        <% String ac=request.getParameter("action");
                                if(ac != null){  
                                    if(keyse != ""){
                                        for (hoadonban hdb : hoadonbanBUS.TKHDB(keyse)) {
                        %>
                        <tr>
                            <td hidden=""><%= hdb.getIdHDB()%></td>
                            <% nhanvien nv=nhanvienBUS.getNV(hdb.getIdNV()); %>
                            <td><%= nv.getTenNV() %></td>
                            <% khachhang kh=khachhangBUS.getKH(hdb.getIdKH()); %>
                            <td><%= kh.getTenKH()%></td>
                            <td><%= CommonCommand.dedateformat(hdb.getNgayLap().toString()) %></td>
                            <td><% if(hdb.getHinhThucTT()== 0){ %>
                              <%= "Trả tiền mặt" %>
                              <% }else{ %>
                              <%= "Thanh toán sau" %>
                              <% }%></td>
                            <td><%= String.format("%,d",hdb.getDaThanhToan()) + " VNĐ"%></td>
                            <td><%= String.format("%,d",hdb.getTongSL()) + " VNĐ" %></td>
                            <td><%= String.format("%,d",hdb.getTongTien()) + " VNĐ"%></td>
                            <td><% if(hdb.getTinhTrang()== 0){ %>
                              <%= "Chưa thanh toán" %>
                              <% }else{ %>
                              <%= "Đã thanh toán" %>
                              <% }%></td>
                            <td><% if(hdb.getDaNhan()== 0){ %>
                              <%= "Chưa nhận hàng" %>
                              <% }else{ %>
                              <%= "Đã nhân hàng" %>
                              <% }%></td>
                            <td><%= CommonCommand.dedateformat(hdb.getNgayCN().toString()) %></td>
                        </tr>
                        <% }} else{ %>
                        <% for (hoadonban hdb : hoadonbanBUS.getDSHDB()) { %>
                        <tr>
                            <td hidden=""><%= hdb.getIdHDB()%></td>
                            <% nhanvien nv=nhanvienBUS.getNV(hdb.getIdNV()); %>
                            <td><%= nv.getTenNV() %></td>
                            <% khachhang kh=khachhangBUS.getKH(hdb.getIdKH()); %>
                            <td><%= kh.getTenKH()%></td>
                            <td><%= CommonCommand.dedateformat(hdb.getNgayLap().toString()) %></td>
                            <td><% if(hdb.getHinhThucTT()== 0){ %>
                              <%= "Trả tiền mặt" %>
                              <% }else{ %>
                              <%= "Thanh toán sau" %>
                              <% }%></td>
                            <td><%= String.format("%,d",hdb.getDaThanhToan()) + " VNĐ"%></td>
                            <td><%= String.format("%,d",hdb.getTongSL()) + " VNĐ" %></td>
                            <td><%= String.format("%,d",hdb.getTongTien()) + " VNĐ"%></td>
                            <td><% if(hdb.getTinhTrang()== 0){ %>
                              <%= "Chưa thanh toán" %>
                              <% }else{ %>
                              <%= "Đã thanh toán" %>
                              <% }%></td>
                            <td><% if(hdb.getDaNhan()== 0){ %>
                              <%= "Chưa nhận hàng" %>
                              <% }else{ %>
                              <%= "Đã nhân hàng" %>
                              <% }%></td>
                            <td><%= CommonCommand.dedateformat(hdb.getNgayCN().toString()) %></td>
                        </tr>
                        <% } %>
                        <script type="text/javascript">
                            alert("Bạn chưa nhập thông tin tìm kiếm!");
                        </script>    
                        <% }} else{%>
                        <%
                            for (hoadonban hdb : hoadonbanBUS.getDSHDB()) {
                        %>
                        <tr>   
                            <td hidden=""><%= hdb.getIdHDB()%></td>
                            <% nhanvien nv=nhanvienBUS.getNV(hdb.getIdNV()); %>
                            <td><%= nv.getTenNV() %></td>
                            <% khachhang kh=khachhangBUS.getKH(hdb.getIdKH()); %>
                            <td><%= kh.getTenKH()%></td>
                            <td><%= CommonCommand.dedateformat(hdb.getNgayLap().toString()) %></td>
                            <td><% if(hdb.getHinhThucTT()== 0){ %>
                              <%= "Trả tiền mặt" %>
                              <% }else{ %>
                              <%= "Thanh toán sau" %>
                              <% }%></td>
                            <td><%= String.format("%,d",hdb.getDaThanhToan()) + " VNĐ"%></td>
                            <td><%= String.format("%,d",hdb.getTongSL()) + " VNĐ" %></td>
                            <td><%= String.format("%,d",hdb.getTongTien()) + " VNĐ"%></td>
                            <td><% if(hdb.getTinhTrang()== 0){ %>
                              <%= "Chưa thanh toán" %>
                              <% }else{ %>
                              <%= "Đã thanh toán" %>
                              <% }%></td>
                            <td><% if(hdb.getDaNhan()== 0){ %>
                              <%= "Chưa nhận hàng" %>
                              <% }else{ %>
                              <%= "Đã nhân hàng" %>
                              <% }%></td>
                            <td><%= CommonCommand.dedateformat(hdb.getNgayCN().toString()) %></td>  
                        </tr>
                        <% }} %>  
                    </table>
                    
                    <!-- Hộp modal chứa form thêm mới hoá đơn -->
                    <div class="modal fade" id="fthem" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title text-center" id="modaltt">Thêm hoá đơn bán</h4>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group">
                                        <label>Chọn nhân viên lập</label>
                                        <select class="form-control" id="optnvlap">
                                            <!--Lấy danh sách nhân viên bán hàng-->
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Chọn khách hàng</label>
                                        <select class="form-control" id="optkhachang">
                                            <!--Lấy danh sách khách hàng-->
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày lập</label>
                                        <div class='input-group date' id="datetimepicker1" >
                                            <input type='text' class="form-control" id="ngaylap" readonly=""/>
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Chọn hình thức thanh toán</label>
                                        <select class="form-control" id="opthttt">
                                            <option value="0" selected="">Trả tiền mặt</option>
                                            <option value="1" >Thanh toán sau</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Đã thanh toán</label>
                                        <input type="number" class="form-control" id="Dathanhtoan" placeholder="Số tiền đã thanh toán">
                                    </div>
                                    <div class="form-group">
                                        <label>Tổng số lượng</label>
                                        <input type="number" class="form-control" id="tongsl" readonly="">
                                    </div>
                                    <div class="form-group">
                                        <label>Tổng tiền</label>
                                        <input type="number" class="form-control" id="tt" readonly="">
                                    </div> 
                                    <div class="form-group">
                                        <label>Chọn tình trạng hoá đơn</label>
                                        <select class="form-control" id="opttinhtrang">
                                            <option value="0" selected="">Chưa thanh toán</option>
                                            <option value="1" >Đã thanh toán</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Tình trạng nhận hàng</label>
                                        <select class="form-control" id="optnhanhang">
                                            <option value="0" selected="">Chưa nhận hàng</option>
                                            <option value="1" >Đã nhận hàng</option>
                                        </select>
                                    </div>
                                </form>          
                            </div>
                            <div class="modal-footer">
                                <div class="form-group align-content-center">
                                    <button class="btn btn-primary hidden" id="nutthem">Thêm</button>
                                    <button class="btn btn-primary hidden" id="nutsua">Sửa</button>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                    
                     <!-- Hộp modal chứa table chi tiết -->
                    <div class="modal fade" id="fchitiet" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title text-center" id="modalttct">Chi tiết hoá đơn</h4>
                                </div>
                                <div class="modal-body">
                                     <div class="row">
                                         <div class="col-sm-3">
                                             <div class="form-group">
                                                 <label>Mã sản phẩm</label>
                                             </div>
                                         </div>
                                         <div class="col-sm-4">
                                             <div class="form-group">
                                                 <input class="form-control" type="text" id="masp" readonly="">
                                             </div>
                                         </div>
                                        <div class="col-sm-5"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <button class="btn btn-success" id="btnthemct" data-toggle="modal" data-target="#fthemct">Thêm chi tiết</button>
                                             </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <button class="btn btn-info" id="btnsuact" data-toggle="modal">Sửa chi tiết</button>
                                             </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group">
                                                <button class="btn btn-danger" id="btnxoact" >Xoá chi tiết</button>
                                             </div>
                                        </div>
                                        <div class="col-sm-6"></div>
                                    </div>
                                    <div id="tblhdbct">
                                        <script>
                                            let kthdbct=""; //khởi tạo biến kiểm tra hoá đơn chi tiết
                                        </script>
                                        <!--Vùng hiển thị danh sách hoá đơn bán chit iết-->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Hộp modal chứa form thêm mới chi tiết -->
                    <div class="modal fade" id="fthemct" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title text-center" id="modalttthemct">Thêm hoá đơn bán chi tiết</h4>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group">
                                        <label>Chọn sản phẩm</label>
                                        <select class="form-control" id="optdssp">
                                            <!--Lấy danh sách sản phẩm-->
                                        </select>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label>Số lượng</label>
                                        <input type="number" class="form-control" id="sl" placeholder="Số lượng mua">
                                    </div>
                                    <div class="form-group">
                                        <label>Đơn giá</label>
                                        <input type="number" class="form-control" id="dongia" readonly="">
                                    </div>
                                    <div class="form-group">
                                        <label>Giảm giá</label>
                                        <input type="number" class="form-control" id="giamgia" readonly="">
                                    </div>
                                    <div class="form-group">
                                        <label>Thành tiền</label>
                                        <input type="number" class="form-control" id="thanhtien" readonly="">
                                    </div> 
                                </form>          
                            </div>
                            <div class="modal-footer">
                                <div class="form-group align-content-center">
                                    <button class="btn btn-primary hidden" id="nutthemct">Thêm</button>
                                    <button class="btn btn-primary hidden" id="nutsuact">Sửa</button>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                    
                    <script>
                        //lấy danhsách nhân viên
                        var laydsnv = function() {
                            $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {tt: "laydsnv"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt!=="null"){
                                            $('#optnvlap').html(dt);
                                            return true;
                                        }
                                        else{
                                            alert("Không có nhân viên nào trong danh sách, hãy thêm một vài nhân viên vào!");                                            
                                            return false;
                                        }
                                    }
                                    else{
                                        alert("Đã có lỗi xảy ra, không thể lấy danh sách nhân viên!");
                                        return false;
                                    } 
                                },
                                error: function() {
                                    alert("Đã có lỗi xảy ra, không thể lấy danh sách nhân viên!");
                                    return false;
                                }
                            });
                        };

                        //lấy danh sách khách hàng
                        var laydskh = function() {
                            //nếu có nhân viên thì lấy ds khách hàng
                            $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {tt: "laydskh"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt!=="null"){
                                            $('#optkhachang').html(dt);
                                            return true;
                                        }
                                        else{
                                            alert("Không có khách hàng nào trong danh sách, hãy thêm một vài khách hàng vào!");                                            
                                             return false;
                                        }
                                    }
                                    else{
                                        alert("Đã có lỗi xảy ra, không thể lấy danh sách khách hàng!");
                                         return false;
                                    } 
                                },
                                error: function() {
                                    alert("Đã có lỗi xảy ra, không thể lấy danh sách khách hàng!");
                                     return false;
                                }
                            });
                        };

                        //kiểm tra nhân viên lập có tồn tại không khi chọn nhân viên
                        $("#optnvlap").change(function() {
                            var manv = $("#optnvlap").val();
                            $.ajax({
                               type: 'POST',
                               url: "proccess.jsp",
                               data:{manv: manv, tt: "ktnvl"},
                               success: function(data) {
                                   let dt=data;
                                   dt=dt.toString().trim();
                                   if(dt !== "null"){
                                       //done
                                   }
                                   else{
                                       alert("Nhân viên không tồn tại, có thể đã bị xoá!");
                                       //load lại danh sách nhân viên lập
                                       laydsnv();
                                   }
                               },
                               error: function() {
                                   alert("Đã có lỗi xảy ra, không thể kiểm tra nhân viên!");
                                   //load lại danh sách nhân viên lập
                                   laydsnv();
                                }
                            });              
                        });

                        //kiểm tra khách hàng có tồn tại không khi chọn khách hàng
                        $("#optkhachang").change(function() {
                            var makh = $("#optkhachang").val();
                             $.ajax({
                               type: 'POST',
                               url: "proccess.jsp",
                               data:{makh: makh, tt: "ktkh"},
                               success: function(data) {
                                   let dt=data;
                                   dt=dt.toString().trim();
                                   if(dt !== "null"){
                                       //done
                                   }
                                   else{
                                       alert("Khách hàng không tồn tại, có thể đã bị xoá!");
                                       //load lại danh sách khách hàng
                                       laydskh();
                                   }
                               },
                               error: function() {
                                   alert("Đã có lỗi xảy ra, không thể kiểm tra khách hàng!");
                                   laydskh();
                                }
                            });  
                        });

                        //khi chọn hình thức thanh toán
                        $("#opthttt").change(function() {
                            var v = $("#opthttt").val();
                            if(v == 0){
                                $('#Dathanhtoan').attr({"readonly":""});
                                $('#Dathanhtoan').val($('#tt').val());
                            }
                            else{
                                if($('#tt').val() != null){
                                    if($('#tt').val().toString().trim() !== "" && $('#tt').val().toString().trim() !== "0" ){
                                        $('#Dathanhtoan').removeAttr("readonly");
                                        $('#Dathanhtoan').val("");
                                    }
                                }

                            }
                        });
                        
                        //thêm
                        $('#btnthem').click(function (){
                            $("#modaltt").text("Thêm hoá đơn bán");
                            $("#txtmhdb").val("");
                            $('#ngaylap').val("");
                            laydsnv();
                            laydskh();

                            $('#Dathanhtoan').val("");
                            $('#optnhanhang').val("0");
                            $('#optnhanhang').removeAttr("disabled");
                            $('#tongsl').val("0");
                            $('#tt').val("0");
                            $("#opthttt").val("0");
                            $("#opthttt").change();
                            $('#nutsua').removeClass('hidden');
                            $('#nutsua').addClass('hidden');
                            $('#nutthem').removeClass('hidden');
                        });

                        //thêm hoá đơn
                        $('#nutthem').click(function() {
                            var manv= $('#optnvlap').val();
                            var makh= $('#optkhachang').val();
                            var hinhthuctt=$('#opthttt').val();
                            var dathantoan=$('#Dathanhtoan').val(); 
                            var tongsl= $('#tongsl').val();
                            var tongtien=$('#tt').val();
                            var tinhtrang=$('#opttinhtrang').val();
                            
                            if(dathantoan.toString().trim() === ""){
                                dathantoan=0;
                            }
                            if(manv === null || makh === null){
                                alert("Nhân viên lập và khách hàng không được để trống!");
                                return false;
                            }
                            $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {manv: manv, makh: makh, hinhthuctt: hinhthuctt, dathanhtoan: dathantoan, tongsl: tongsl, tongtien: tongtien, tinhtrang: tinhtrang, tt: "them"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt==="tc"){
                                            alert("Thêm thành công!");
                                            location.replace("../qlhdb");
                                        }
                                        else{
                                            alert("Thêm thất bại, hãy thử lại lần nữa!");
                                            location.replace("../qlhdb");
                                        }
                                    }
                                    else{
                                        alert("Thêm thất bại, hãy thử lại lần nữa!");
                                        location.replace("../qlhdb");
                                    } 
                                },
                                error: function() {
                                    alert("Thêm thất bại, Đã có lỗi xảy ra!");
                                    location.replace("../qlhdb");
                                }
                            });
                        });

                        let kthdb="";
                        //lấy mã hoá đơn phục vụ sửa xoá
                        $("#tblhoadonban").find("tr").find("td").click(function(){
                           var listOfCell=$(this).siblings(); //biến kết quả trả về thành mảng chứa nội dung trong các ô (giá trị index tương ứng với số cột)
                           $("#tblhoadonban").find("tr").find("td").css({"background-color":"white"});               
                           $(listOfCell[1]).css({"background-color":"lightgray"});
                           $(listOfCell[2]).css({"background-color":"lightgray"});
                           $(listOfCell[3]).css({"background-color":"lightgray"});
                           $(listOfCell[4]).css({"background-color":"lightgray"});
                           $(listOfCell[5]).css({"background-color":"lightgray"});
                           $(listOfCell[6]).css({"background-color":"lightgray"});
                           $(listOfCell[7]).css({"background-color":"lightgray"});
                           $(listOfCell[8]).css({"background-color":"lightgray"});
                           $(listOfCell[9]).css({"background-color":"lightgray"});
                           $(this).css({"background-color":"lightgray"});
                           $("#txtmhdb").val($(listOfCell[0]).text());

                           kthdb=""; //khởi tạo flag kiểm tra.
                           $('#btnsua').removeAttr("data-target");
                           $('#btnxemct').removeAttr("data-target");
                           //kiểm tra mã hoá đơn trước khi xem chi tiết, sửa hoặc xoá
                           $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {idhdb: $('#txtmhdb').val(), hd: "kthdb"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    var dtarr=dt.split('|');
                                    if(dt!==null){
                                        if(dtarr[0].toString().trim() === "tc"){
                                            kthdb="tc";
                                            $('#btnsua').attr({"data-target":"#fthem"});
                                            $('#btnxemct').attr({"data-target":"#fchitiet"});
                                            if(dtarr[1].toString().trim() === "1"){
                                                $('#btnthemct').attr({"disabled":""});
                                                $('#btnxoact').attr({"disabled":""});
                                                $('#btnsuact').attr({"disabled":""});
                                            }
                                            else{
                                                $('#btnthemct').removeAttr("disabled");
                                                $('#btnxoact').removeAttr("disabled");
                                                $('#btnsuact').removeAttr("disabled");
                                            }
                                        }
                                        else{
                                            kthdb="tb";
                                        }
                                    }
                                    else{
                                        kthdb="tb";
                                    } 
                                },
                                error: function() {
                                    kthdb="tb";
                                }
                            });
                        });

                        //sửa hoá đơn
                        $('#btnsua').click(function() {
                            let mahdb=$("#txtmhdb").val();
                            if(mahdb === ""){
                                alert("Bạn chưa chọn hoá đơn bán nào!");
                                return false;
                            }else{

                                if(kthdb === "tc"){
                                    
                                    $("#modaltt").text("Sửa hoá đơn bán");
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {tt: "laydsnv"},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt!=="null"){
                                                    $('#optnvlap').html(dt);
                                                    //nếu có nhân viên thì lấy ds khách hàng
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "proccess.jsp",
                                                        data: {tt: "laydskh"},
                                                        success: function(data) {
                                                            let dt=data;
                                                            dt=dt.toString().trim();
                                                            if(dt!==null){
                                                                if(dt!=="null"){
                                                                    $('#optkhachang').html(dt);

                                                                    //lấy thông tin hoá đơn cần sửa
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "proccess.jsp",
                                                                        data: {idhdb: mahdb, hd: "laytthdb"},
                                                                        success: function(data) {
                                                                            let dt=data;
                                                                            dt=dt.toString().trim();
                                                                            let dtarr= dt.split('|');
                                                                            $('#optnvlap').val(dtarr[0]);
                                                                            $('#optkhachang').val(dtarr[1]);
                                                                            $('#ngaylap').val(dtarr[2]);
                                                                            $('#opthttt').val(dtarr[3]);
                                                                            $('#Dathanhtoan').val(dtarr[4]);
                                                                            $('#tongsl').val(dtarr[5]);
                                                                            $('#tt').val(dtarr[6]);
                                                                            $('#opttinhtrang').val(dtarr[7]);
                                                                            $('#optnhanhang').val(dtarr[8]);
                                                                            var dn=$('#optnhanhang').val();
                                                                            if(dn.toString() === "1"){
                                                                                $('#optnhanhang').attr({"disabled":""});
                                                                            }
                                                                            else{
                                                                                $('#optnhanhang').removeAttr("disabled");
                                                                            }
                                                                        },
                                                                        error: function() {
                                                                            alert("Đã có lỗi xảy ra, không thể lấy thông tin hoá đơn hiện tại!");
                                                                            return false;
                                                                        }
                                                                    });
                                                                }
                                                                else{
                                                                    alert("Không có khách hàng nào trong danh sách, hãy thêm một vài khách hàng vào!");                                            
                                                                     return false;
                                                                }
                                                            }
                                                            else{
                                                                alert("Đã có lỗi xảy ra, không thể lấy danh sách khách hàng!");
                                                                 return false;
                                                            } 
                                                        },
                                                        error: function() {
                                                            alert("Đã có lỗi xảy ra, không thể lấy danh sách khách hàng!");
                                                             return false;
                                                        }
                                                    });
                                                }
                                                else{
                                                    alert("Không có nhân viên nào trong danh sách, hãy thêm một vài nhân viên vào!");                                            
                                                    return false;
                                                }
                                            }
                                            else{
                                                alert("Đã có lỗi xảy ra, không thể lấy danh sách nhân viên!");
                                                return false;
                                            } 
                                        },
                                        error: function() {
                                            alert("Đã có lỗi xảy ra, không thể lấy danh sách nhân viên!");
                                            return false;
                                        }
                                    });

                                    $('#nutthem').removeClass('hidden');
                                    $('#nutthem').addClass('hidden');
                                    $('#nutsua').removeClass('hidden');
                                }
                                else{
                                    alert("Hoá đơn không tồn tại!");
                                    return false;
                                }
                            }  
                        });

                        $('#nutsua').click(function() {
                            var mahdb= $('#txtmhdb').val();
                            var manv= $('#optnvlap').val();
                            var makh= $('#optkhachang').val();
                            var hinhthuctt=$('#opthttt').val();
                            var dathantoan=$('#Dathanhtoan').val(); 
                            var tongsl= $('#tongsl').val();
                            var tongtien=$('#tt').val();
                            var tinhtrang=$('#opttinhtrang').val();
                            var danhan=$('#optnhanhang').val();
                            if(dathantoan.toString().trim() === ""){
                                dathantoan=0;
                            }
                            if(manv.toString().trim() === "" || makh.toString().trim() === ""){
                                alert("Nhân viên lập và khách hàng không được để trống!");
                                return false;
                            }
                            if(manv.toString().trim() === "" || makh.toString().trim() === ""){
                                alert("Nhân viên lập và khách hàng không được để trống!");
                                return false;
                            }
                            var sln1=dathantoan.toString().indexOf(".");
                            var sln2=dathantoan.toString().indexOf(",");
                            var sln3=dathantoan.toString().indexOf("-");
                            var sln4=dathantoan.toString().indexOf("0");
                            var dtt=parseInt(dathantoan, 10);
                            var tt=parseInt(tongtien, 10);
                            if(sln1 >=0 || sln2 >=0 || sln3 >=0 || sln4 == 0 || dtt > tt){
                                alert("Số tiền đã thanh toán phải có giá trị số nguyên không âm và phải nhỏ hơn tổng số tiền phải thanh toán!");
                                return false;
                            }
                            $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {mhdb: mahdb, manv: manv, makh: makh, hinhthuctt: hinhthuctt, dathanhtoan: dathantoan, tongsl: tongsl, tongtien: tongtien, tinhtrang: tinhtrang, danhan: danhan, tt: "sua"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt==="tc"){
                                            alert("Sửa thành công!");
                                            location.replace("../qlhdb");
                                        }
                                        else{
                                            alert("Sửa thất bại, hãy thử lại lần nữa!");
                                            location.replace("../qlhdb");
                                        }
                                    }
                                    else{
                                        alert("Sửa thất bại, hãy thử lại lần nữa!");
                                        location.replace("../qlhdb");
                                    } 
                                },
                                error: function() {
                                    alert("Sửa thất bại, Đã có lỗi xảy ra!");
                                    location.replace("../qlhdb");
                                }
                            });
                        });

                        //xoá
                        $('#btnxoa').click(function(){
                            let mahdb=$("#txtmhdb").val();
                            if(mahdb === ""){
                                alert("Bạn chưa chọn hoá đơn nào!");
                                return false;
                            }
                            else{
                                var r=confirm("Bạn có chắc chắn muốn xoá hoá đơn có mã "+ mahdb+"!");
                                if(r == true){
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {mhdb: mahdb, tt: "xoa"},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt==="tc"){
                                                    alert("Xoá thành công!");
                                                    location.replace("../qlhdb");
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
                                            alert("Xoá thất bại, đã có lỗi xảy ra!");
                                            return false;
                                        }
                                    });
                                }

                            }
                        });

                        //khu vực xử lý hoá đơn chi tiết
                        //lấy dds hdbct

                        function laydshdbct(mahdb) {
                            $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {idhdb: mahdb, tt: "laydshdbct"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    let dtarr=dt.split('|');
                                    if(dt!==null){
                                        if(dtarr[0].toString().trim() !== "null"){
                                            $('#tblhdbct').html(dtarr[0]);
                                            $('#masp').val("");
                                        }
                                        else{
                                            alert("Hoá đơn không có chi tiết nào!");
                                            $('#tblhdbct').html(dtarr[1]);
                                            $('#masp').val("");
                                        }
                                    }
                                    else{
                                        alert("Đã có lỗi xảy ra, không thể lấy danh sách hoá đơn bán chi tiết!");
                                        return false;
                                    } 
                                },
                                error: function() {
                                    alert("Đã có lỗi xảy ra, không thể lấy danh sách hoá đơn bán chi tiết!");
                                    return false;
                                }
                            });
                        };

                        //Lấy thông tin sản phẩm khi chọn sản phẩm
                        $("#optdssp").change(function() {
                            var masp = $("#optdssp").val();
                            $.ajax({
                               type: 'POST',
                               url: "proccess.jsp",
                               data:{masp: masp, tt: "layttsp"},
                               success: function(data) {
                                   let dt=data;
                                   dt=dt.toString().trim();
                                    let dtarr= dt.split('|');
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {idhdb: $('#txtmhdb').val(), tt: "kthttt"},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt === "ttm"){
                                                    $('#dongia').val(dtarr[0]);
//                                                    tính thành tiền nếu ô số lượng hợp lệ
                                                    var sl=$('#sl').val();
                                                    var dongia=$('#dongia').val();
                                                    var giamgia=$('#giamgia').val();
                                                    var sln1=sl.toString().indexOf(".");
                                                    var sln2=sl.toString().indexOf(",");
                                                    var sln3=sl.toString().indexOf("-");
                                                    var sln4=sl.toString().indexOf("0");
                                                    if(sln1 >=0 || sln2 >=0 || sln3 >=0 || sln4 == 0){
                                                        $('#thanhtien').val("0");
                                                        
                                                    }
                                                    else if(sl.toString().trim() === "" || sl == null || sl.toString().trim() === "null" || giamgia.toString().trim() === "" ||  giamgia == null || giamgia.toString().trim() === "null"){
                                                        
                                                        $('#thanhtien').val("0");
                                                    }
                                                    else{
                                                        var thanhtien=(sl*dongia)-(sl*dongia*(giamgia/100));
                                                        $('#thanhtien').val(thanhtien);
                                                    }
                                                }
                                                else if(dt === "tts"){
                                                    $('#dongia').val(dtarr[1]);
                                                }
                                            }
                                            else{
                                                $('#dongia').val("0");
                                                $('#thanhtien').val("0");
                                                $('#sl').val("0");
                                            } 
                                        },
                                        error: function() {
                                            $('#dongia').val("0");
                                            $('#thanhtien').val("0");
                                            $('#sl').val("0");
                                        }
                                    });

                                    $('#giamgia').val(dtarr[2]);
                               },
                               error: function() {
                                   alert("Đã có lỗi xảy ra, không thể lấy thông tin sản phẩm!");
                                   //load lại danh sách sp
                                   laydssp();
                                }
                            });              
                        });

                        //lấy ds sp
                        function laydssp() {
                            $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {tt: "laydssp"},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt!=="null"){
                                            $('#optdssp').html(dt);
                                            $('#optdssp').change();
                                        }
                                        else{
                                            alert("Không có sản phẩm nào trong danh sách, hãy thêm một vài sản phẩm vào!");                                            
                                            return false;
                                        }
                                    }
                                    else{
                                        alert("Đã có lỗi xảy ra, không thể lấy danh sách sản phẩm!");
                                        return false;
                                    } 
                                },
                                error: function() {
                                    alert("Đã có lỗi xảy ra, không thể lấy danh sách sản phẩm!");
                                    return false;
                                }
                            });
                        };
                                    
                        //xem xhi tiết hoá đơn
                        $('#btnxemct').click(function() {
                            let mhdb=$("#txtmhdb").val();
                            if(mhdb === ""){
                                alert("Bạn chưa chọn hoá đơn nào!");
                                return false;
                            }
                            else{
                                if(kthdb === "tc"){
                                    $('#masp').val("");
                                    laydshdbct(mhdb);

                                }
                                else{
                                    alert("Hoá đơn bán không tồn tại!");
                                    return false;
                                }
                            }

                        });

                        //tính tiền khi chọn số lượng trên hoá đơn chi tiết
                        const $slchange = document.querySelector('#sl');
                        const typehdl = function() {
                            var sl=$('#sl').val();
                            if(sl.toString().trim() === ""){
                                $('#thanhtien').val("0");
                            }
                            else{
                                var sln1=sl.toString().indexOf(".");
                                var sln2=sl.toString().indexOf(",");
                                var sln3=sl.toString().indexOf("-");
                                var sln4=sl.toString().indexOf("0");
                                if(sln1 >=0 || sln2 >=0 || sln3 >=0 || sln4 == 0){
                                    alert("Số lượng nhập phải là số nguyên không âm, không bắt đầu với ký tự '0'!");
                                    $('#thanhtien').val("0");
                                    return false;
                                }
                                else{
                                    var dongia=$('#dongia').val();
                                    var giamgia=$('#giamgia').val();
                                    var thanhtien=(sl*dongia)-(sl*dongia*(giamgia/100));
                                    $('#thanhtien').val(thanhtien);
                                }
                            }
                        };

                        $slchange.addEventListener('input', typehdl); // register for oninput
                        $slchange.addEventListener('propertychange', typehdl); // for IE8

                        //thêm
                        $('#btnthemct').click(function (){
                            $("#modalttthemct").text("Thêm hoá đơn bán chi tiết");
                            $("#optdssp").removeAttr("disabled"); //enable cb box
                            $("#masp").val("");

                            laydssp();

                            $('#sl').val("0");

                            $('#thanhtien').val("0");

                            $('#nutsuact').removeClass('hidden');
                            $('#nutsuact').addClass('hidden');
                            $('#nutthemct').removeClass('hidden');
                        });

                        //thêm chi tiết
                        $('#nutthemct').click(function(){
                            var masp= $('#optdssp').val();
                            var mahdb= $('#txtmhdb').val();
                            var sl=$('#sl').val();
                            var dongia=$('#dongia').val();
                            var giamgia=$('#giamgia').val(); 
                            var thanhtien= $('#thanhtien').val();
                            
                            var sln1=sl.toString().indexOf(".");
                            var sln2=sl.toString().indexOf(",");
                            var sln3=sl.toString().indexOf("-");
                            var sln4=sl.toString().indexOf("0");
                            
                            if(sl.toString().trim() === "" || masp.toString().trim() === "" || thanhtien == 0){
                                alert("Vui lòng nhập đầy đủ thông tin, chi tiết hoá đơn phải có giá trị!");
                                return false;
                            }
                            else if(sln1 >=0 || sln2 >=0 || sln3 >=0 || sln4 == 0){
                                alert("Số lượng nhập phải là số nguyên không âm, không bắt đầu với ký tự '0'!");
                                return false;
                            }
                            else{
                                //kiểm tra chi tiết trùng
                                $.ajax({
                                    type: "POST",
                                    url: "proccess.jsp",
                                    data: {idhdb: mahdb, masp: masp, hd: "kthdbct"},
                                    success: function(data) {
                                        let dt=data;
                                        dt=dt.toString().trim();
                                        if(dt!==null){
                                            if(dt === "tc"){
                                                alert("Chi tiết đã tồn tại, hãy thêm sản phẩm khác!");
                                                return false;
                                            }
                                            else if(dt === "tb"){
                                                var slm=parseInt(sl,10);
                                                $.ajax({
                                                    type: "POST",
                                                    url: "proccess.jsp",
                                                    data: {masp: masp, sl: sl, tt: "ktslsp"},
                                                    success: function(data) {
                                                        let dt=data;
                                                        dt=dt.toString().trim();
                                                        if(dt!==null){
                                                            if(dt !== "null"){
                                                                var slt=parseInt(dt,10);
                                                                if(slm > slt){
                                                                    alert("Số lượng sản phẩm chỉ còn "+slt+"!");
                                                                    return false;
                                                                }
                                                                else{
                                                                    //them
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "proccess.jsp",
                                                                        data: {mhdb: mahdb, masp: masp, sl: sl, dongia: dongia, giamgia: giamgia, thanhtien: thanhtien, tt: "themhdbct"},
                                                                        success: function(data) {
                                                                            let dt=data;
                                                                            dt=dt.toString().trim();
                                                                            if(dt!==null){
                                                                                if(dt==="tc"){
                                                                                    alert("Thêm thành công!");
                                                                                    laydshdbct(mahdb);
                                                                                }
                                                                                else{
                                                                                    alert("Thêm thất bại, hãy thử lại lần nữa!");
                                                                                    return false;
                                                                                }
                                                                            }
                                                                            else{
                                                                                alert("Thêm thất bại, hãy thử lại lần nữa!");
                                                                                return false;
                                                                            } 
                                                                        },
                                                                        error: function() {
                                                                            alert("Thêm thất bại, Đã có lỗi xảy ra!");
                                                                            return false;
                                                                        }
                                                                    });
                                                                }
                                                            }
                                                            else{
                                                                alert("Thêm thất bại, không thể kiểm tra số lượng sản phẩm tồn!");
                                                                return false;
                                                            }
                                                        }
                                                        else{
                                                            alert("Thêm thất bại, không thể kiểm tra số lượng sản phẩm tồn!");
                                                            return false;
                                                        } 
                                                    },
                                                    error: function() {
                                                        alert("Thêm thất bại, đã có lỗi xảy ra, không thể kiểm tra số lượng sản phẩm tồn!");
                                                        return false;
                                                    }
                                                });
                                            }
                                        }
                                        else{
                                            return false;
                                        } 
                                    },
                                    error: function() {
                                        return false;
                                    }
                                });
                            }

                        });

                        //sửa hoá đơn chi tiết
                        $('#btnsuact').click(function() {
                            let mahdb=$("#txtmhdb").val();
                            let masp=$("#masp").val();
                            $("#optdssp").attr({"disabled":""}); //disable cb box
                            if(masp === ""){
                                alert("Bạn chưa chọn chi tiết nào!");
                                return false;
                            }else{
                                if(kthdbct === "tc"){
                                    $("#modalttthemct").text("Sửa hoá đơn bán chi tiết");
                                    //lấy danh sách sản phẩm 
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {tt: "laydssp"},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt!=="null"){
                                                    $('#optdssp').html(dt);
                                                    //lấy thông tin chi tiết cần sửa
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "proccess.jsp",
                                                        data: {idhdb: mahdb, masp: masp, hd: "laytthdbct"},
                                                        success: function(data) {
                                                            let dt=data;
                                                            dt=dt.toString().trim();
                                                            let dtarr= dt.split('|');
                                                            $('#optdssp').val(dtarr[0]);
                                                            $('#sl').val(dtarr[1]);
                                                            $('#dongia').val(dtarr[2]);
                                                            $('#giamgia').val(dtarr[3]);
                                                            $('#thanhtien').val(dtarr[4]);
                                                        },
                                                        error: function() {
                                                            alert("Đã có lỗi xảy ra, không thể lấy thông tin chi tiết hiện tại!");
                                                            return false;
                                                        }
                                                    });
                                                }
                                                else{
                                                    alert("Không có sản phẩm nào trong danh sách, hãy thêm một vài sản phẩm vào!");                                            
                                                    return false;
                                                }
                                            }
                                            else{
                                                alert("Đã có lỗi xảy ra, không thể lấy danh sách sản phẩm!");
                                                return false;
                                            } 
                                        },
                                        error: function() {
                                            alert("Đã có lỗi xảy ra, không thể lấy danh sách sản phẩm!");
                                            return false;
                                        }
                                    });
                                    
                                    $('#nutthemct').removeClass('hidden');
                                    $('#nutthemct').addClass('hidden');
                                    $('#nutsuact').removeClass('hidden');
                                }
                                else{
                                    alert("Chi tiết không tồn tại!");
                                    return false;
                                }
                            }  
                        });

                        $('#nutsuact').click(function() {
                            var mahdb= $('#txtmhdb').val();
                            var masp= $('#optdssp').val();
                            var mahdb= $('#txtmhdb').val();
                            var sl=$('#sl').val();
                            var dongia=$('#dongia').val();
                            var giamgia=$('#giamgia').val(); 
                            var thanhtien= $('#thanhtien').val();
                            
                            var sln1=sl.toString().indexOf(".");
                            var sln2=sl.toString().indexOf(",");
                            var sln3=sl.toString().indexOf("-");
                            var sln4=sl.toString().indexOf("0");
                            
                            if(sl.toString().trim() === "" || masp.toString().trim() === "" || thanhtien == 0){
                                alert("Vui lòng nhập đầy đủ thông tin, chi tiết hoá đơn phải có giá trị!");
                                return false;
                            }
                            else if(sln1 >=0 || sln2 >=0 || sln3 >=0 || sln4 == 0){
                                alert("Số lượng nhập phải là số nguyên không âm, không bắt đầu với ký tự '0'!");
                                return false;
                            }                       
                            else{
                                var slm=parseInt(sl,10);
                                $.ajax({
                                    type: "POST",
                                    url: "proccess.jsp",
                                    data: {masp: masp, sl: sl, tt: "ktslsp"},
                                    success: function(data) {
                                        let dt=data;
                                        dt=dt.toString().trim();
                                        if(dt!==null){
                                            if(dt !== "null"){
                                                var slt=parseInt(dt,10);
                                                if(slm > slt){
                                                    alert("Số lượng sản phẩm chỉ còn "+slt+"!");
                                                    return false;
                                                }
                                                else{
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "proccess.jsp",
                                                        data: {mhdb: mahdb, masp: masp, sl: sl, dongia: dongia, giamgia: giamgia, thanhtien: thanhtien, tt: "suahdbct"},
                                                        success: function(data) {
                                                            let dt=data;
                                                            dt=dt.toString().trim();
                                                            if(dt!==null){
                                                                if(dt==="tc"){
                                                                    alert("Sửa thành công!");
                                                                    laydshdbct(mahdb);
                                                                }
                                                                else{
                                                                    alert("Sửa thất bại, hãy thử lại lần nữa!");
                                                                    return false;
                                                                }
                                                            }
                                                            else{
                                                                alert("Sửa thất bại, hãy thử lại lần nữa!");
                                                                return false;
                                                            } 
                                                        },
                                                        error: function() {
                                                            alert("Sửa thất bại, Đã có lỗi xảy ra!");
                                                            return false;
                                                        }
                                                    });
                                                }
                                            }
                                            else{
                                                alert("Sửa thất bại, không thể kiểm tra số lượng sản phẩm tồn!");
                                                return false;
                                            }
                                        }
                                        else{
                                            alert("Sửa thất bại, không thể kiểm tra số lượng sản phẩm tồn!");
                                            return false;
                                        } 
                                    },
                                    error: function() {
                                        alert("Sửa thất bại, đã có lỗi xảy ra, không thể kiểm tra số lượng sản phẩm tồn!");
                                        return false;
                                    }
                                });
                                
                            }

                        });

                        //xoá chi tiết
                        $('#btnxoact').click(function(){
                            let mahdb=$("#txtmhdb").val();
                            let masp=$("#masp").val();
                            if(masp === ""){
                                alert("Bạn chưa chọn chi tiết nào!");
                                return false;
                            }
                            else{
                                var r=confirm("Bạn có chắc chắn muốn xoá chi tiết có mã "+ masp+"!");
                                if(r == true){
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {mhdb: mahdb, masp: masp, tt: "xoahdbct"},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt==="tc"){
                                                    alert("Xoá thành công!");
                                                    laydshdbct(mahdb);
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
                                            alert("Xoá thất bại, đã có lỗi xảy ra!");
                                            return false;
                                        }
                                    });
                                }

                            }
                        });


                        $('#btnlammoi').click(function() {
                                location.replace("../qlhdb");
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