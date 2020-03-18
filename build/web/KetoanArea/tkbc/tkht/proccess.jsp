<%-- 
    Document   : newjsp
    Created on : Nov 3, 2018, 9:22:14 PM
    Author     : DELL
--%>

<%@page import="dto.hangtonct"%>
<%@page import="bus.hangtonCTBUS"%>
<%@page import="org.eclipse.persistence.internal.xr.ValueObject"%>
<%@page import="bus.hangtonBUS"%>
<%@page import="dto.hangton"%>
<%@page import="java.util.Calendar"%>
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
    String mht=request.getParameter("mht");
    String tt=request.getParameter("tt");
    String manv=request.getParameter("manv");
    if(tt != null){
        if(tt.equals("kttkthang")){
            Calendar now = Calendar.getInstance();
            Integer m=now.get(Calendar.MONTH) + 1;
            Integer y=now.get(Calendar.YEAR);
            hangton ht=hangtonBUS.getHTtheoMonthYear(m.toString(), y.toString());
            String maht=ht.getIdHT();
            if(maht != null){
                out.print("tb");
            }
            else{
                out.print("tc");
            }
        }
        else if(tt.equals("them")){//them thống kê
            
            String ma=hangtonBUS.TaoMaNN();

            hangton ht=new hangton(ma, manv, Long.valueOf("0"), new Timestamp(System.currentTimeMillis()), new Timestamp(System.currentTimeMillis()));
            if(hangtonBUS.ThemHT(ht) && hangtonCTBUS.ThemHTCT(ma)){
                out.print("tc");
            }
            else{
                out.print("tb");
            }
        }
        else if(tt.equals("ktht")){ // kiểm tra ht có tồn tại không
            hangton ht=hangtonBUS.getHT(mht);
            String maht=ht.getIdHT();
            if(maht != null){
                out.print("tc");
            }
            else{
                out.print("tb");
            }
        }
        else if(tt.equals("laydshtct")){ // lấy danh sách htct
            if(!hangtonCTBUS.getDSHDNCTtheoIdHT(mht).isEmpty()){
                %>
                <table class="table table-hover">
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng tồn</th>
                </tr>
                <%
                for (hangtonct htct : hangtonCTBUS.getDSHDNCTtheoIdHT(mht)) {
                    %>
                    <tr>
                        <% sanpham sp= sanphamBUS.getSP(htct.getIdSP()); %>
                        <td><%= sp.getTenSP() %></td>
                        <td><%= htct.getSLTon() %></td>
                    </tr>
                    <%
                }
            %>
                </table>
            <%
            }
            else{
                out.print("null |");
                %>
                <table class="table table-hover">
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng tồn</th>
                    </tr>
                </table>
                <%
            }
        }
        else if(tt.equals("xoa")){ //xoá
            if(mht != null){
                if(hangtonCTBUS.XoaHTCTtheoIdHT(mht) && hangtonBUS.XoaHT(mht)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
            
        }
        else if(tt.equals("sua")){ //sửa hdbct chỉ quan tâm mã và ngày cn
            hangton ht=new hangton(mht, "NULL", Long.valueOf("0"), new Timestamp(System.currentTimeMillis()), new Timestamp(System.currentTimeMillis()));
            if(hangtonCTBUS.CapnhatHTCT(mht) && hangtonBUS.CapnhatHT(ht)){
                out.print("tc");
            }
            else{
                out.print("tb");
            }
        }   
    }
    
%>

