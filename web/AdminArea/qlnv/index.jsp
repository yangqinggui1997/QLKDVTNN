<%-- 
    Document   : main.jsp
    Created on : Nov 1, 2018, 8:27:32 PM
    Author     : DELL
--%>

<%@page import="Common.CommonCommand"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@page import="java.sql.Timestamp"%>
<%@page import="bus.nhanvienBUS"%>
<%@page import="dto.nhanvien" %>
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
<% request.setAttribute("child", "child"); request.setAttribute("qlnv", "Yang - Quản lý nhân viên");%>
<jsp:include page="../../View/top.jsp"></jsp:include>
                    <h2>Quản lý nhân viên</h2><br>
                    <div class="row">
                        <div class="col-sm-2" style="margin-bottom: 40px;">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#fthem" id="btnthem" style=" position: fixed; z-index: 99;">
                                <span class="glyphicon glyphicon-plus"></span> Thêm nhân viên
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
                                <label style=" position: fixed; z-index: 99;">Mã nhân viên</label>                                        
                            </div>
                        </div>
                        <div class="col-sm-2" style="margin-bottom: 40px;">
                            <div class="form-group">
                                <input type="text" class="form-control" id="txtmnv" readonly="" style=" position: fixed; z-index: 99; width: 140px;">
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
                    <!-- Danh sách nhân viên -->
                    <br>
                    <table class="table table-hover" id="tblnhanvien">   
                        <tr>
                            <th hidden=""></th> 
                            <th>Họ tên</th>
                            <th>Ngày sinh</th>
                            <th>Giới tính</th>
                            <th>Số CMND</th>
                            <th>SĐT</th>
                            <th>Địa chỉ</th>
                            <th>Chức vụ</th>
                            <th>Ngày vào làm</th>
                        </tr>
                        <% String ac=request.getParameter("action");
                                if(ac != null){  
                                    if(keyse != ""){
                                        for (nhanvien nv : nhanvienBUS.TKNV(keyse)) {
                        %>
                        <tr>
                            <td hidden=""><%= nv.getIdNV()%></td>
                            <td><%= nv.getTenNV() %></td>
                            <td><%= CommonCommand.dedateformat(nv.getNgaySinh().toString()) %></td>
                            <td><% if(nv.getGioiTinh()== 1){ %>
                              <%= "Nam" %>
                              <% }else{ %>
                              <%= "Nữ" %>

                              <% }%></td>
                            <td><%= nv.getSoCMND() %></td>
                            <td><%= nv.getSDT() %></td>
                            <td><%= nv.getDiaChi() %></td>
                            <td><% if(nv.getChucVu()== 1){ %>
                              <%= "Nhân viên quản trị" %>
                              <% }else if(nv.getChucVu()== 2){ %>
                              <%= "Nhân viên kế toán" %>

                              <% } else if(nv.getChucVu()== 3){%>
                              <%= "Nhân viên bán hàng" %>
                              <% } else{%>
                              <%= "Nhân viên thủ kho" %>
                              <% } %>
                            </td>
                            <td><%= CommonCommand.dedateformat(nv.getNgayVaoLam().toString()) %></td>

                        </tr>
                        <% }} else{ %>
                        <% for (nhanvien nv : nhanvienBUS.getDSNV()) { %>
                        <tr>
                            <td hidden=""><%= nv.getIdNV()%></td>
                            <td><%= nv.getTenNV() %></td>
                            <td><%= CommonCommand.dedateformat(nv.getNgaySinh().toString()) %></td>
                            <td><% if(nv.getGioiTinh()== 1){ %>
                                <%= "Nam" %>
                                <% }else{ %>
                                <%= "Nữ" %>
                                <% }%>
                            </td>
                            <td><%= nv.getSoCMND() %></td>
                            <td><%= nv.getSDT() %></td>
                            <td><%= nv.getDiaChi() %></td>
                            <td><% if(nv.getChucVu()== 1){ %>
                                <%= "Nhân viên quản trị" %>
                                <% }else if(nv.getChucVu()== 2){ %>
                                <%= "Nhân viên kế toán" %>

                                <% } else if(nv.getChucVu()== 3){%>
                                <%= "Nhân viên bán hàng" %>
                                <% } else{%>
                                <%= "Nhân viên thủ kho" %>
                                <% } %>
                            </td>
                            <td><%= CommonCommand.dedateformat(nv.getNgayVaoLam().toString()) %></td>                            
                        </tr>
                        <% } %>
                        <script type="text/javascript">
                            alert("Bạn chưa nhập thông tin tìm kiếm!");
                        </script>    
                        <% }} else{%>
                        <%
                            for (nhanvien nv : nhanvienBUS.getDSNV()) {
                        %>
                        <tr>   
                            <td hidden=""><%= nv.getIdNV()%></td>
                            <td><%= nv.getTenNV() %></td>
                            <td><%= CommonCommand.dedateformat(nv.getNgaySinh().toString()) %></td>
                            <td><% if(nv.getGioiTinh()== 1){ %>
                                <%= "Nam" %>
                                <% }else{ %>
                                <%= "Nữ" %>
                                <% }%>
                            </td>
                            <td><%= nv.getSoCMND() %></td>
                            <td><%= nv.getSDT() %></td>
                            <td><%= nv.getDiaChi() %></td>
                            <td><% if(nv.getChucVu()== 1){ %>
                                <%= "Nhân viên quản trị" %>
                                <% }else if(nv.getChucVu()== 2){ %>
                                <%= "Nhân viên kế toán" %>
                                <% } else if(nv.getChucVu()== 3){%>
                                <%= "Nhân viên bán hàng" %>
                                <% } else{%>
                                <%= "Nhân viên thủ kho" %>
                                <% } %>
                            </td>
                            <td><%= CommonCommand.dedateformat(nv.getNgayVaoLam().toString()) %></td>      
                        </tr>
                        <% }} %>  
                    </table>
                    <!-- Hộp modal chứa form thêm mới -->
                    <div class="modal fade" id="fthem" role="dialog">
                        <div class="modal-dialog">
                            <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title text-center" id="modaltt">Thêm nhân viên</h4>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group">
                                        <label>Chọn nhóm nhân viên</label>
                                        <select class="form-control" id="optloainv">
                                            <option value="1" selected="">Nhóm quản trị</option>
                                            <option value="2" >Nhóm kế toán</option>
                                            <option value="3">Nhóm bán hàng</option>
                                            <option value="4" >Nhóm thủ kho</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Mã nhân viên</label>
                                        <input type="text" class="form-control" name="txtmanv" id="manv" readonly="">
                                    </div>
                                    <div class="form-group">
                                        <label>Tên nhân viên</label>
                                        <input type="text" class="form-control" name="txttennv" id="tennv" placeholder="Tên nhân viên" required="">
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày sinh</label>
                                        <div class='input-group date' id="datetimepicker1">
                                            <input type='text' class="form-control" name="txtngaysinh" id="ngaysinh"/>
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Giới tính</label>
                                        <select class="form-control" name="optloaind" id="loaigt">
                                            <option value="0" >Nữ</option>
                                            <option value="1" selected="">Nam</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Số CMND</label>
                                        <input type="number" class="form-control" name="txtsocmnd" id="socmnd" placeholder="Số chứng minh nhân dân" required="">
                                    </div>
                                    <div class="form-group">
                                        <label>Số điện thoại</label>
                                        <input type="number" class="form-control" name="txtsdt" id="sdt" placeholder="Số điện thoại" required="">
                                    </div>
                                    <div class="form-group">
                                        <label>Địa chỉ</label>
                                        <input type="text" class="form-control" name="txtdiaxhi" id="diachi" placeholder="Địa chỉ" required="">
                                    </div>
                                    <div class="form-group">
                                        <label>Chức vụ</label>
                                        <input type="text" class="form-control" name="txtchucvu" id="chucvu" readonly="">
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày vào làm</label>
                                        <div class='input-group date' id="datetimepicker2">
                                            <input type='text' class="form-control" name="txtngayvaolam" id="nvl"/>
                                            <span class="input-group-addon">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
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
                        $('#datetimepicker2').datetimepicker({
                            allowInputToggle: true,
                            defaultDate: d,
                            format: 'DD/MM/YYYY HH:mm:ss '
                        });

                        //Chọn nhóm để tạo mã nhân viên ngẫu nhiên
                        $("#optloainv").change(function() {
                            let mnv=$('#txtmnv').val();
                            var v = $("#optloainv").val();
                            if(mnv === ""){
                                $('#chucvu').val(v);
                                $.post("proccess.jsp", {"id": v}, function(data){
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt !== null){
                                        $("#manv").val(dt);                              
                                    }
                                });
                            }
                            else{  
                                if((mnv.toString().substring(0,4) === "NVQT" && v == 1)
                                    || (mnv.toString().substring(0,4) === "NVKT" && v == 2)
                                    || (mnv.toString().substring(0,4) === "NVBH" && v == 3)
                                    || (mnv.toString().substring(0,4) === "NVTK" && v == 4)){
                                    $('#manv').val(mnv);
                                    $('#chucvu').val(v);
                                    $.ajax({
                                        type: "POST",
                                        url: "proccess.jsp",
                                        data: {idnv: mnv},
                                        success: function(data) {
                                            let dt=data;
                                            dt=dt.toString().trim();
                                            let dtarr= dt.split('|');
                                            $('#tennv').val(dtarr[1]);
                                            $('#ngaysinh').val(dtarr[2]);
                                            $('#loaigt').val(dtarr[3]);
                                            $('#socmnd').val(dtarr[4]);
                                            $('#sdt').val(dtarr[5]);
                                            $('#diachi').val(dtarr[6]);
                                            $('#nvl').val(dtarr[8]);

                                        },
                                        error: function() {
                                            alert("Đã có lỗi xảy ra, thao tác lại sau!");
                                            return false;
                                        }
                                    });
                                }else{
                                    $('#chucvu').val(v);
                                    $.post("proccess.jsp", {"id": v}, function(data){
                                        let dt=data;
                                        dt=dt.toString().trim();
                                        if(dt !== null){
                                            $("#manv").val(dt);
                                        }
                                    });
                                }                       
                            }                   
                        });

                        //thêm
                        $('#btnthem').click(function (){
                            $("#modaltt").text("Thêm nhân viên");
                            $("#txtmnv").val("");
                            $("#optloainv").val(1);
                            $("#optloainv").change();
                            $('#tennv').val("");
                            $('#datetimepicker1').datetimepicker();
                            $('#loaigt').val(1);
                            $('#socmnd').val("");
                            $('#sdt').val("");
                            $('#diachi').val("");
                            $('#datetimepicker2').datetimepicker();

                            $('#nutsua').removeClass('hidden');
                            $('#nutsua').addClass('hidden');
                            $('#nutthem').removeClass('hidden');
                        });

                        $('#nutthem').click(function() {
                            var tennv= $('#tennv').val();
                            var socmnd=$('#socmnd').val();
                            var sdt=$('#sdt').val();
                            var diachi=$('#diachi').val();      
                            if(socmnd.length !== 9){
                                alert("Số chứng minh nhân dân phải có 9 chữ số!");
                                return false;
                            }
                            if(sdt.length < 10 || sdt.length > 11){
                                alert("Số Số điện thoại phải có 10 hoặc 11 chữ số!");
                                return false;
                            }      
                            if(tennv !=="" && socmnd !== "" && sdt !== "" && diachi !== ""){           
                                $.ajax({
                                    type: "POST",
                                    url: "proccess.jsp",
                                    data: {manv: $('#manv').val(), tennv: $('#tennv').val(), ngaysinh: $("#ngaysinh").val(), gioitinh: $('#loaigt').val(), socmnd: $('#socmnd').val(), sdt: $('#sdt').val(), diachi: $('#diachi').val(), chucvu: $('#chucvu').val(), nvl: $('#nvl').val(), tt: "them"},
                                    success: function(data) {
                                        let dt=data;
                                        dt=dt.toString().trim();
                                        if(dt!==null){
                                            if(dt==="tc"){
                                                alert("Thêm thành công!");
                                                location.replace("../qlnv");
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
                        });
                        
                        let ktnv="";
                        //lấy mã nhân viên phục vụ sửa xoá
                        $("#tblnhanvien").find("tr").find("td").click(function(){
                           var listOfCell=$(this).siblings(); //biến kết quả trả về thành mảng chứa nội dung trong các ô (giá trị index tương ứng với số cột)
                           $("#tblnhanvien").find("tr").find("td").css({"background-color":"white"});               
                           $(listOfCell[1]).css({"background-color":"lightgray"});
                           $(listOfCell[2]).css({"background-color":"lightgray"});
                           $(listOfCell[3]).css({"background-color":"lightgray"});
                           $(listOfCell[4]).css({"background-color":"lightgray"});
                           $(listOfCell[5]).css({"background-color":"lightgray"});
                           $(listOfCell[6]).css({"background-color":"lightgray"});
                           $(listOfCell[7]).css({"background-color":"lightgray"});
                           $(listOfCell[8]).css({"background-color":"lightgray"});
                           $(this).css({"background-color":"lightgray"});
                           $("#txtmnv").val($(listOfCell[0]).text());
                           
                           ktnv=""; //khởi tạo flag kiểm tra.
                           $('#btnsua').removeAttr("data-target");
                           //kiểm tra mã nhân viên trước khi sửa hoặc xoá
                           $.ajax({
                                type: "POST",
                                url: "proccess.jsp",
                                data: {mnv: $('#txtmnv').val()},
                                success: function(data) {
                                    let dt=data;
                                    dt=dt.toString().trim();
                                    if(dt!==null){
                                        if(dt === "tc"){
                                            ktnv=dt;
                                            $('#btnsua').attr({"data-target":"#fthem"});
                                        }
                                        else{
                                            ktnv="tb";
                                        }
                                    }
                                    else{
                                        ktnv="tb";
                                    } 
                                },
                                error: function() {
                                    ktnv="tb";
                                }
                            });
                        });

                        //sửa
                        $('#btnsua').click(function() {
                            let mnv=$("#txtmnv").val();
                            if(mnv === ""){
                                alert("Bạn chưa chọn nhân viên nào!");
                                return false;
                            }else{
                                                
                                if(mnv.toString().substring(0,4)==="NVQT"){
                                    $('#optloainv').val(1);
                                }
                                else if(mnv.toString().substring(0,4)==="NVKT"){
                                    $('#optloainv').val(2);
                                }
                                else if(mnv.toString().substring(0,4)==="NVBH"){
                                    $('#optloainv').val(3);
                                }
                                else if(mnv.toString().substring(0,4)==="NVTK"){
                                    $('#optloainv').val(4);
                                }
                                else{
                                    alert("Mã nhân viện không hợp lệ!");
                                    return false;
                                }
                                
                                if(ktnv === "tc"){
                                    $("#modaltt").text("Sửa nhân viên");
                                    $("#optloainv").change();
                                    $('#nutthem').removeClass('hidden');
                                    $('#nutthem').addClass('hidden');
                                    $('#nutsua').removeClass('hidden');
                                }
                                else{
                                    alert("Nhân viên không tồn tại!");
                                    return false;
                                }
                            }  
                        });
                        
                        $('#nutsua').click(function() {
                            var tennv= $('#tennv').val();
                            var socmnd=$('#socmnd').val();
                            var sdt=$('#sdt').val();
                            var diachi=$('#diachi').val();      
                            if(socmnd.length !== 9){
                                alert("Số chứng minh nhân dân phải có 9 chữ số!");
                                return false;
                            }
                            if(sdt.length < 10 || sdt.length > 11){
                                alert("Số Số điện thoại phải có 10 hoặc 11 chữ số!");
                                return false;
                            }      
                            if(tennv !=="" && socmnd !== "" && sdt !== "" && diachi !== ""){   
                                let hts="";
                                let macu="";
                                if($('#manv').val()!==$('#txtmnv').val()){
                                    hts="doima";
                                    macu=$('#txtmnv').val();
                                }
                                else{
                                    hts="macu";
                                }
                                $.ajax({
                                    type: "POST",
                                    url: "proccess.jsp",
                                    data: {manv: $('#manv').val(), tennv: $('#tennv').val(), ngaysinh: $("#ngaysinh").val(), gioitinh: $('#loaigt').val(), socmnd: $('#socmnd').val(), sdt: $('#sdt').val(), diachi: $('#diachi').val(), chucvu: $('#chucvu').val(), nvl: $('#nvl').val(), tt: "sua", hts: hts, macu: macu},
                                    success: function(data) {   
                                        let dt=data;
                                        dt=dt.toString().trim();
                                        if(dt !== null){
                                            if(dt==="tc"){
                                                alert("Sửa thành công!");
                                                location.replace("../qlnv");
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
                            let mnv=$("#txtmnv").val();
                            if(mnv === ""){
                                alert("Bạn chưa chọn nhân viên nào!");
                                return false;
                            }
                            else{
                                var r=confirm("Bạn có chắc chắn muốn xoá nhân viên có mã "+ mnv+"!");
                                if(r == true){
                                    if(mnv.toString().substring(0,4) === "NVQT"){
                                        alert("Không thể xoá người dùng là nhân viên quản trị, nhân viên này được bảo vệ!");
                                        return false;
                                    }
                                    else{
                                        $.ajax({
                                            type: "POST",
                                            url: "proccess.jsp",
                                            data: {manv: mnv, tt: "xoa"},
                                            success: function(data) {
                                                let dt=data;
                                                dt=dt.toString().trim();
                                                if(dt!==null){
                                                    if(dt==="tc"){
                                                        alert("Xoá thành công!");
                                                        location.replace("../qlnv");
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

                            }
                        });
                        
                        $('#btnlammoi').click(function() {
                                location.replace("../qlnv");
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