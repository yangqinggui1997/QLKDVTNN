<%-- 
    Document   : newjsp
    Created on : Nov 3, 2018, 9:22:14 PM
    Author     : DELL
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="dto.sanpham"%>
<%@page import="bus.sanphamBUS"%>
<%@page import="dao.hoadonbanDAO"%>
<%@page import="dto.khachhang"%>
<%@page import="bus.khachhangBUS"%>
<%@page import="bus.nhanvienBUS"%>
<%@page import="dto.nhanvien"%>
<%@page import="bus.hoadonbanCTBUS"%>
<%@page import="dto.hoadonbanct"%>
<%@page import="bus.hoadonbanBUS"%>
<%@page import="dto.hoadonban"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Common.CommonCommand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%   
    //Kiểm tra hdb có tồn tại không
    String mhdb=request.getParameter("mhdb");
    String idhdb=request.getParameter("idhdb");
    String hd=request.getParameter("hd");
    String masp=request.getParameter("masp");
    
    if(hd != null){
        if(hd.equals("kthdb")){
            hoadonban hdb=hoadonbanBUS.getHDB(idhdb);
            String mahdb=hdb.getIdHDB();
            Short dnhang=hdb.getDaNhan();
            if(mahdb != null){
                out.print("tc |"+dnhang);

            }
            else{
                out.print("tb |");
            }
        }

        //Kiểm tra hdbct có tồn tại không
        else if(hd.equals("kthdbct") ){
            hoadonbanct hdbct=hoadonbanCTBUS.getHDBCT(idhdb, masp);
            String mahdb=hdbct.getIdHDB();
            if(mahdb != null){
                out.print("tc");

            }
            else{
                out.print("tb");
            }
        }

        //lấy thông tin hoá đơn chi tiết
        else if(hd.equals("laytthdbct")){
            hoadonbanct hdbct=hoadonbanCTBUS.getHDBCT(idhdb, masp);
            if(hdbct != null){
                out.print(hdbct.getIdSP()+"|"+hdbct.getSL()+"|"+hdbct.getDonGia()+"|"+hdbct.getGiamGia()+"|"+hdbct.getThanhTien());
            }
        }
        
        //lấy tt hdb
        else if(hd.equals("laytthdb")){
            hoadonban hdb=hoadonbanBUS.getHDB(idhdb);
            if(hdb != null){
                out.print(hdb.getIdNV()+"|"+hdb.getIdKH()+"|"+CommonCommand.deDateFormatForUpdate(hdb.getNgayLap().toString())+"|"+hdb.getHinhThucTT()+"|"+hdb.getDaThanhToan()+"|"+hdb.getTongSL()+"|"+hdb.getTongTien()+"|"+hdb.getTinhTrang()+"|"+hdb.getDaNhan());
            }
        }
    }
    

    //lấy thông tin hdb
    String tt=request.getParameter("tt");
    String manv=request.getParameter("manv");
    String makh=request.getParameter("makh");
    String hinhthuctt=request.getParameter("hinhthuctt");
    String dathanhtoan=request.getParameter("dathanhtoan");
    String tongsl=request.getParameter("tongsl");
    String tongtien=request.getParameter("tongtien");
    String tinhtrang=request.getParameter("tinhtrang");
    String danhan=request.getParameter("danhan");
    
    //lấy thông tin hdbct
    String sl=request.getParameter("sl");
    String dongia=request.getParameter("dongia");
    String giamgia=request.getParameter("giamgia");
    String thanhtien=request.getParameter("thanhtien");
    if(tt != null){
        if(tt.equals("laydsnv")){
            if(!nhanvienBUS.getDSNVBH().isEmpty()){
                for (nhanvien nv : nhanvienBUS.getDSNVBH()) {
                    out.print("<option value='"+nv.getIdNV()+"'>"+nv.getTenNV()+"</option>");
                }
            }
            else{
                out.print("null");
            }
        }
        else if(tt.equals("laydskh")){
            if(!khachhangBUS.getDSKH().isEmpty()){
                for (khachhang kh : khachhangBUS.getDSKH()) {
                    out.print("<option value='"+kh.getSoCMND()+"'>"+kh.getTenKH()+"</option>");
                }
            }
            else{
                out.print("null");
            }
        }
        else if(tt.equals("ktnvl")){
            nhanvien nv=nhanvienBUS.getNV(manv);
            out.print(nv.getIdNV());
        }
        else if(tt.equals("ktkh")){
            khachhang kh=khachhangBUS.getKH(makh);
            out.print(kh.getSoCMND());
        }
        else if(tt.equals("ktslsp")){
            sanpham sp=sanphamBUS.getSP(masp);
            out.print(sp.getSLNhap());
        }
        else if(tt.equals("them")){//them hoá đơn
            
            String ma=hoadonbanBUS.TaoMaNN();

            hoadonban hdb=new hoadonban(ma, manv, makh, new Timestamp(System.currentTimeMillis()), Short.valueOf(hinhthuctt), Long.valueOf("0"), Long.valueOf("0"), Long.valueOf("0"), Short.valueOf(tinhtrang), Short.valueOf("0"), new Timestamp(System.currentTimeMillis()));
            if(hoadonbanDAO.ThemHDB(hdb)){
                out.print("tc");
            }
            else{
                out.print("tb");
            }
        }
        else if(tt.equals("sua")){ //sửa
            hoadonban hdb=new hoadonban(mhdb, manv, makh, new Timestamp(System.currentTimeMillis()), Short.valueOf(hinhthuctt), Long.valueOf(dathanhtoan), Long.valueOf(tongsl), Long.valueOf(tongtien), Short.valueOf(tinhtrang), Short.valueOf(danhan), new Timestamp(System.currentTimeMillis()));
            hoadonban hb=hoadonbanBUS.getHDB(mhdb);
            Short kt=hb.getDaNhan();
            if(hoadonbanCTBUS.getDSHDBCTTheoIdHDB(mhdb).isEmpty() || kt.toString().equals("1")){
                if(hoadonbanBUS.CapnhatHDB(hdb)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }else{
                if(danhan.equals("0")){
                    if(hoadonbanBUS.CapnhatHDB(hdb)){
                        out.print("tc");
                    }
                    else{
                        out.print("tb");
                    }
                }
                else{
                    if(hoadonbanBUS.CapnhatHDB(hdb)){
                    //cập nhật sl vào bảng sp
                    try {
                        for (hoadonbanct hdbct : hoadonbanCTBUS.getDSHDBCTTheoIdHDB(mhdb)) {
                            sanpham sp=sanphamBUS.getSP(hdbct.getIdSP());
                            Integer slcu= sp.getSLNhap();
                            Integer slcthd=hdbct.getSL();
                            Integer slmoi=slcu-slcthd;
                            sanphamBUS.CapnhatSLSP(hdbct.getIdSP(), slmoi);
                        }
                        out.print("tc");
                    } catch (SQLException e) {
                        out.print("tb");
                        }
                    }
                    else{
                        out.print("tb");
                    }
                }
            }
        }
        else if(tt.equals("xoa")){ //xoá
            if(mhdb != null){
                if(hoadonbanCTBUS.XoaHDBCTtheoIdHDB(mhdb) && hoadonbanBUS.XoaHDB(mhdb)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
            
        }
        else if(tt.equals("laydshdbct")){
            if(!hoadonbanCTBUS.getDSHDBCTTheoIdHDB(idhdb).isEmpty()){
                %>
                <table class="table table-hover" id="tblhoadonbanct">
                <tr>
                    <th hidden=""></th> 
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Giảm giá</th>
                    <th>Thành tiền</th>
                </tr>
                <%
                for (hoadonbanct hdbct : hoadonbanCTBUS.getDSHDBCTTheoIdHDB(idhdb)) {
                    %>
                    <tr>
                        <td hidden=""><%= hdbct.getIdSP()%></td>
                        <td><%= sanphamBUS.getSP(hdbct.getIdSP()).getTenSP() %></td>
                        <td><%= String.format("%,d",hdbct.getSL())%></td>
                        <td><%= String.format("%,d",hdbct.getDonGia()) + " VNĐ" %></td>
                        <td><%= hdbct.getGiamGia() %></td>
                        <td><%= String.format("%,d",hdbct.getThanhTien()) + " VNĐ" %></td>
                    </tr>
                    <%
                }
            %>
                </table>
                <script >

                    //lấy mã sản phẩm phục vụ sửa xoá
                    $("#tblhoadonbanct").find("tr").find("td").click(function(){
                       var listOfCell=$(this).siblings(); //biến kết quả trả về thành mảng chứa nội dung trong các ô (giá trị index tương ứng với số cột)
                       $("#tblhoadonbanct").find("tr").find("td").css({"background-color":"white"});          
                       $(listOfCell[1]).css({"background-color":"lightgray"});
                       $(listOfCell[2]).css({"background-color":"lightgray"});
                       $(listOfCell[3]).css({"background-color":"lightgray"});
                       $(listOfCell[4]).css({"background-color":"lightgray"});
                       $(listOfCell[5]).css({"background-color":"lightgray"});
                       $(this).css({"background-color":"lightgray"});
                       $("#masp").val($(listOfCell[0]).text());

                       kthdbct=""; //khởi tạo flag kiểm tra.
                       $('#btnsuact').removeAttr("data-target");
                       //kiểm tra mã sản phẩm trước khi xem chi tiết, sửa hoặc xoá
                       $.ajax({
                            type: "POST",
                            url: "proccess.jsp",
                            data: {idhdb: $('#txtmhdb').val(), masp: $('#masp').val(), hd: "kthdbct"},
                            success: function(data) {
                                let dt=data;
                                dt=dt.toString().trim();
                                if(dt!==null){
                                    if(dt === "tc"){
                                        kthdbct=dt;
                                        $('#btnsuact').attr({"data-target":"#fthemct"});
                                    }
                                    else{
                                        kthdbct="tb";
                                    }
                                }
                                else{
                                    kthdbct="tb";
                                } 
                            },
                            error: function() {
                                kthdbct="tb";
                            }
                        });
                    });
                </script>
            <%
            }
            else{
                out.print("null |");
                %>
                <table class="table table-hover" id="tblhoadonbanct">
                    <tr>
                        <th hidden=""></th> 
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Giảm giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </table>
                <%
            }
        }
        else if(tt.equals("laydssp")){
            if(!sanphamBUS.getDSSP().isEmpty()){
                for (sanpham sp : sanphamBUS.getDSSP()) {
                    out.print("<option value='"+sp.getIdSP()+"'>"+sp.getTenSP()+"</option>");
                }
            }
            else{
                out.print("null");
            }
        }
        else if(tt.equals("layttsp")){
            sanpham sp=sanphamBUS.getSP(masp);
            if(sp != null){
                out.print(sp.getDonGiaTienMat()+"|"+sp.getDonGiaThanhToanSau()+"|"+sp.getGiamGia());
            }
        }
        else if(tt.equals("kthttt")){
            hoadonban hdb=hoadonbanBUS.getHDB(idhdb);
            if(hdb != null){
                if(hdb.getHinhThucTT() == 0){
                    out.print("ttm");
                }
                else{
                    out.print("tts");
                }               
            }
        }
        else if(tt.equals("themhdbct")){//them hdbct
            
            hoadonbanct hdbct=new hoadonbanct(mhdb, masp, Integer.valueOf(sl), Long.valueOf(dongia), Short.valueOf(giamgia), Long.valueOf(thanhtien));
            if(hoadonbanCTBUS.ThemHDBCT(hdbct) && hoadonbanBUS.TongSLUpdate(mhdb) && hoadonbanBUS.TongTienUpdate(mhdb)){
                out.print("tc");
            }
            else{
                out.print("tb");
            }
        }
        else if(tt.equals("suahdbct")){ //sửa hdbct
            if(mhdb != null && masp != null && sl != null){
                hoadonbanct hdbct=new hoadonbanct(mhdb, masp, Integer.valueOf(sl), Long.valueOf(dongia), Short.valueOf(giamgia), Long.valueOf(thanhtien));
                if(hoadonbanCTBUS.CapnhatHDBCT(hdbct) && hoadonbanBUS.TongSLUpdate(mhdb) && hoadonbanBUS.TongTienUpdate(mhdb)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(tt.equals("xoahdbct")){ //xoá hdbct
            if(mhdb != null & masp != null){
                if(hoadonbanCTBUS.XoaHDBCT(mhdb, masp) && hoadonbanBUS.TongSLUpdate(mhdb) && hoadonbanBUS.TongTienUpdate(mhdb)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
            
        }
    }
    
%>

