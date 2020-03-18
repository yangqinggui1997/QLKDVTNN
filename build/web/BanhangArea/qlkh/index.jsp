<%-- 
    Document   : main.jsp
    Created on : Nov 1, 2018, 8:27:32 PM
    Author     : DELL
--%>

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
<%@page import="bus.khachhangBUS"%>
<%@page import="dto.khachhang" %>
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
<% request.setAttribute("child", "child"); request.setAttribute("qlkh", "Yang - Quản lý khách hàng"); %>
<jsp:include page="../../View/top.jsp"></jsp:include>
                    <h2>Quản lý khách hàng</h2><br>
                    <div class="row">
                        <div class="col-sm-2" style="margin-bottom: 40px;">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#fthem" id="btnthem" style=" position: fixed; z-index: 99;">
                                <span class="glyphicon glyphicon-plus"></span> Thêm khách hàng
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
                                <label style=" position: fixed; z-index: 99;">Mã khách hàng</label>                                        
                            </div>
                        </div>
                        <div class="col-sm-2" style="margin-bottom: 40px;">
                            <div class="form-group">
                                <input type="text" class="form-control" id="txtmkh" readonly="" style=" position: fixed; z-index: 99; width: 140px;">
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
                    <!-- Danh sách khách hàng -->
                    <br>
                    <table class="table table-hover" id="tblkhachhang">   
                        <tr> 
                            <th hidden=""></th>
                            <th>Họ tên</th>
                            <th>Ngày sinh</th>
                            <th>Giới tính</th>
                            <th>Số CMND</th>
                            <th>SĐT</th>
                            <th>Email</th>
                            <th>Địa chỉ</th>
                            <th>Loại khách hàng</th>
                            <th>Đánh giá</th>
                        </tr>
                        <% String ac=request.getParameter("action");
                                if(ac != null){  
                                    if(keyse != ""){
                                        for (khachhang kh : khachhangBUS.TKKH(keyse)) {
                        %>
                        <tr>
                            <td hidden=""><%= kh.getSoCMND() %></td>
                            <td><%= kh.getTenKH()%></td>
                            <td><%= CommonCommand.dedateformat(kh.getNgaySinh().toString()) %></td>
                            <td><% if(kh.getGioiTinh()== 1){ %>
                              <%= "Nam" %>
                              <% }else{ %>
                              <%= "Nữ" %>

                              <% }%></td>
                            <td><%= kh.getSoCMND() %></td>
                            <td><%= kh.getSDT() %></td>
                            <td><%= kh.getEmail()%></td>
                            <td><%= kh.getDiaChi() %></td>
                            <td><% if(kh.getLoaiKH()== 1){ %>
                              <%= "Đại lý cấp 1" %>
                              <% }else if(kh.getLoaiKH()== 2){ %>
                              <%= "Đại lý cấp 2" %>

                              <% } else if(kh.getLoaiKH()== 3){%>
                              <%= "Khác" %>
                              <% }%>
                            </td>
                            <td><%= kh.getDanhGia() %></td>

                        </tr>
                        <% }} else{ %>
                        <% for (khachhang kh : khachhangBUS.getDSKH()) { %>
                        <tr>
                            <td hidden=""><%= kh.getSoCMND() %></td>
                            <td><%= kh.getTenKH()%></td>
                            <td><%= CommonCommand.dedateformat(kh.getNgaySinh().toString()) %></td>
                            <td><% if(kh.getGioiTinh()== 1){ %>
                              <%= "Nam" %>
                              <% }else{ %>
                              <%= "Nữ" %>

                              <% }%></td>
                            <td><%= kh.getSoCMND() %></td>
                            <td><%= kh.getSDT() %></td>
                            <td><%= kh.getEmail()%></td>
                            <td><%= kh.getDiaChi() %></td>
                            <td><% if(kh.getLoaiKH()== 1){ %>
                              <%= "Đại lý cấp 1" %>
                              <% }else if(kh.getLoaiKH()== 2){ %>
                              <%= "Đại lý cấp 2" %>

                              <% } else if(kh.getLoaiKH()== 3){%>
                              <%= "Khác" %>
                              <% }%>
                            </td>
                            <td><%= kh.getDanhGia() %></td>
                        </tr>
                        <% } %>
                        <script type="text/javascript">
                            alert("Bạn chưa nhập thông tin tìm kiếm!");
                        </script>    
                        <% }} else{%>
                        <%
                            for (khachhang kh : khachhangBUS.getDSKH()) {
                        %>
                        <tr>
                            <td hidden=""><%= kh.getSoCMND() %></td>
                            <td><%= kh.getTenKH()%></td>
                            <td><%= CommonCommand.dedateformat(kh.getNgaySinh().toString()) %></td>
                            <td><% if(kh.getGioiTinh()== 1){ %>
                              <%= "Nam" %>
                              <% }else{ %>
                              <%= "Nữ" %>

                              <% }%></td>
                            <td><%= kh.getSoCMND() %></td>
                            <td><%= kh.getSDT() %></td>
                            <td><%= kh.getEmail()%></td>
                            <td><%= kh.getDiaChi() %></td>
                            <td><% if(kh.getLoaiKH()== 1){ %>
                              <%= "Đại lý cấp 1" %>
                              <% }else if(kh.getLoaiKH()== 2){ %>
                              <%= "Đại lý cấp 2" %>

                              <% } else if(kh.getLoaiKH()== 3){%>
                              <%= "Khác" %>
                              <% }%>
                            </td>
                            <td><%= kh.getDanhGia() %></td>      
                        </tr>
                        <% }} %>  
                    </table>
                    <!-- Hộp modal chứa form thêm mới -->
                    <div class="modal fade" id="fthem" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    <h4 class="modal-title text-center" id="modaltt">Thêm khách hàng</h4>
                                </div>
                                <div class="modal-body">
                                    <form>
                                        <div class="form-group">
                                            <label>Tên khách hàng</label>
                                            <input type="text" class="form-control" id="tenkh" placeholder="Tên khách hàng" required="">
                                        </div>
                                        <div class="form-group">
                                            <label>Ngày sinh</label>
                                            <div class='input-group date' id="datetimepicker1">
                                                <input type='text' class="form-control" id="ngaysinh"/>
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Giới tính</label>
                                            <select class="form-control" id="loaigt">
                                                <option value="0" >Nữ</option>
                                                <option value="1" selected="">Nam</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Số CMND</label>
                                            <input type="number" class="form-control" id="socmnd" placeholder="Số chứng minh nhân dân" required="">
                                        </div>
                                        <div class="form-group">
                                            <label>Số điện thoại</label>
                                            <input type="number" class="form-control" id="sdt" placeholder="Số điện thoại" required="">
                                        </div>
                                        <div class="form-group">
                                            <label>Email</label>
                                            <input type="email" class="form-control" id="email" placeholder="Email">
                                        </div>
                                        <div class="form-group">
                                            <label>Địa chỉ</label>
                                            <input type="text" class="form-control" id="diachi" placeholder="Địa chỉ" required="">
                                        </div>
                                        <div class="form-group">
                                            <label>Loại khách hàng</label>
                                            <select class="form-control" id="loaikh">
                                                <option value="1" selected="">Đại lý cấp 1</option>
                                                <option value="2" >Đại lý cấp 2</option>
                                                <option value="3" >Khác</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Đánh giá</label>
                                            <input type="text" class="form-control" id="danhgia" placeholder="Đánh giá">
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
                    <script >
                        var d=new Date();
                        $('#datetimepicker1').datetimepicker({
                            allowInputToggle: true,
                            defaultDate: d,
                            format: 'DD/MM/YYYY HH:mm:ss '
                        });

                        //thêm
                        $('#btnthem').click(function (){
                            $("#modaltt").text("Thêm khách hàng");
                            $("#txtmkh").val("");
                            
                            $('#tennv').val("");
                            $('#datetimepicker1').datetimepicker();
                            $('#loaigt').val(1);
                             $('#loaikh').val(1);
                            $('#socmnd').val("");
                            $('#sdt').val("");
                            $('#diachi').val("");
                            $('#email').val("");
                            $('#danhgia').val("");
                            
                            $('#nutsua').removeClass('hidden');
                            $('#nutsua').addClass('hidden');
                            $('#nutthem').removeClass('hidden');
                        });
                        
                        function ktemail(){
                            var s = $('#email').val();
                            var acarr=s.toString().split('@');
                            var acong = s.indexOf('@');
                            var daucham = s.lastIndexOf('.');
                            var khoangtrang = s.indexOf(' ');
                            if ((acong < 1) || (daucham < 1) || (acarr.length > 2)||
                                (daucham == acong+1) || (daucham < acong)||
                                (daucham == s.length-1) || 
                                (khoangtrang != -1)){
                                return false;
                            }
                            else{
                                return true;
                            }
                            
                        };
                        
                        $('#nutthem').click(function() {
                            var tenkh= $('#tenkh').val();
                            var socmnd=$('#socmnd').val();
                            var sdt=$('#sdt').val();
                            var email= $('#email').val();
                            var diachi=$('#diachi').val(); 
                            var danhgia=$('#danhgia').val(); 
                            if(socmnd.length !== 9){
                                alert("Số chứng minh nhân dân phải có 9 chữ số!");
                                return false;
                            }
                            else if(sdt.length < 10 || sdt.length > 11){
                                alert("Số Số điện thoại phải có 10 hoặc 11 chữ số!");
                                return false;
                            }
                            else if(socmnd.length !== 9){
                                alert("Số chứng minh nhân dân phải có 9 chữ số!");
                                return false;
                            }
                            else if(!ktemail()){
                                alert('Email không hợp lệ!');
                                return false;
                            }
                            else{
                                if(tenkh !=="" && socmnd !== "" && sdt !== "" && diachi !== ""){           
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {makh: socmnd, tenkh: tenkh, ngaysinh: $("#ngaysinh").val(), gioitinh: $('#loaigt').val(), sdt: $('#sdt').val(), diachi: $('#diachi').val(), loaikh: $('#loaikh').val(), email: email, danhgia: danhgia, tt: "them"},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt==="tc"){
                                                    alert("Thêm thành công!");
                                                    location.replace("../qlkh");
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
                                            alert("Thêm thất bại, hãy thử lại lần nữa!");
                                            return false;
                                        }
                                    });
                                }      
                            }
                        });
                        
                        let ktkh="";
                        //lấy khách hàng phục vụ sửa xoá
                        $("#tblkhachhang").find("tr").find("td").click(function(){
                           var listOfCell=$(this).siblings(); //biến kết quả trả về thành mảng chứa nội dung trong các ô (giá trị index tương ứng với số cột)
                           $("#tblkhachhang").find("tr").find("td").css({"background-color":"white"});
                           
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
                           
                           $("#txtmkh").val($(listOfCell[0]).text());
                           ktkh=""; //khởi tạo flag kiểm tra.
                           $('#btnsua').removeAttr("data-target");
                           //kiểm tra mã kh trước khi sửa hoặc xoá
                           $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {mkh: $('#txtmkh').val()},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt === "tc"){
                                            ktkh=dt;
                                            $('#btnsua').attr({"data-target":"#fthem"});
                                            
                                        }
                                        else{
                                            ktkh="tb";
                                        }
                                    }
                                    else{
                                        ktkh="tb";
                                    } 
                                },
                                error: function() {
                                    ktkh="tb";
                                }
                            });
                        });

                        //sửa
                        $('#btnsua').click(function() {
                            let mkh=$("#txtmkh").val();
                            if(mkh === ""){
                                alert("Bạn chưa chọn khách hàng nào!");
                                return false;
                            }else{
                                if(ktkh === "tc"){
                                    $("#modaltt").text("Sửa khách hàng");
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {idkh: $('#txtmkh').val()},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            let dtarr= dt.split('|');
                                            $('#tenkh').val(dtarr[0]);
                                            $('#ngaysinh').val(dtarr[1]);
                                            $('#loaigt').val(dtarr[2]);
                                            $('#socmnd').val(dtarr[3]);
                                            $('#sdt').val(dtarr[4]);
                                            $('#email').val(dtarr[5]);
                                            $('#diachi').val(dtarr[6]);
                                            $('#loaikh').val(dtarr[7]);
                                            $('#danhgia').val(dtarr[8]);
                                        }
                                    });
                                    $('#nutthem').removeClass('hidden');
                                    $('#nutthem').addClass('hidden');
                                    $('#nutsua').removeClass('hidden');
                                }
                                else{
                                    alert("Khách hàng không tồn tại!");
                                    return false;
                                }
                            }  
                        });
                        
                        $('#nutsua').click(function() {
                            var tenkh= $('#tenkh').val();
                            var socmnd=$('#socmnd').val();
                            var sdt=$('#sdt').val();
                            var email= $('#email').val();
                            var diachi=$('#diachi').val(); 
                            var danhgia=$('#danhgia').val(); 
                            if(socmnd.length !== 9){
                                alert("Số chứng minh nhân dân phải có 9 chữ số!");
                                return false;
                            }
                            if(sdt.length < 10 || sdt.length > 11){
                                alert("Số Số điện thoại phải có 10 hoặc 11 chữ số!");
                                return false;
                            }       
                            if(tenkh !=="" && socmnd !== "" && sdt !== "" && diachi !== ""){   
                                let hts="";

                                if($('#socmnd').val()!==$('#txtmkh').val()){
                                    hts="doiscm";
                                }
                                else{
                                    hts="scmcu";
                                }
                                $.ajax({
                                    type: "POST",
                                    url: "proccess.jsp",
                                    data: {makh: socmnd, tenkh: tenkh, ngaysinh: $("#ngaysinh").val(), gioitinh: $('#loaigt').val(), sdt: $('#sdt').val(), diachi: $('#diachi').val(), loaikh: $('#loaikh').val(), email: email, danhgia: danhgia, tt: "sua", hts: hts, scmcu: $('#txtmkh').val()},
                                    success: function(data) {   
                                        let dt=data;
                                        dt=dt.toString().trim();
                                        if(dt !== null){
                                            if(dt==="tc"){
                                                alert("Sửa thành công!");
                                                location.replace("../qlkh");
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
                                        alert("Sửa thất bại, hãy thử lại lần nữa!");
                                        return false;
                                    }
                                });
                            }   
                        });
                        
                        //xoá
                        $('#btnxoa').click(function(){
                            let mkh=$("#txtmkh").val();
                            if(mkh === ""){
                                alert("Bạn chưa chọn khách hàng nào!");
                                return false;
                            }
                            else{
                                var r=confirm("Bạn có chắc chắn muốn xoá khách hàng có mã "+ mkh+"!");
                                if(r == true){
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {makh: mkh, tt: "xoa"},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            if(dt!==null){
                                                if(dt==="tc"){
                                                    alert("Xoá thành công!");
                                                    location.replace("../qlkh");
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
                                location.replace("../qlkh");
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