<%-- 
    Document   : newjsp
    Created on : Nov 3, 2018, 9:22:14 PM
    Author     : DELL
--%>

<%@page import="dto.sanphambanct"%>
<%@page import="bus.sanphambanCTBUS"%>
<%@page import="bus.sanphambanBUS"%>
<%@page import="dto.sanphamban"%>
<%@page import="org.eclipse.persistence.internal.xr.ValueObject"%>
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
    String mspb=request.getParameter("mspb");
    String tt=request.getParameter("tt");
    String manv=request.getParameter("manv");
    if(tt != null){
        if(tt.equals("kttkthang")){
            Calendar now = Calendar.getInstance();
            Integer m=now.get(Calendar.MONTH) + 1;
            Integer y=now.get(Calendar.YEAR);
            sanphamban spb=sanphambanBUS.getSPBtheoMonthYear(m.toString(), y.toString());
            String maspb=spb.getIdSPB();
            if(maspb != null){
                out.print("tb");
            }
            else{
                out.print("tc");
            }
        }
        else if(tt.equals("them")){//them thống kê
            
            String ma=sanphambanBUS.TaoMaNN();
            
            Calendar now = Calendar.getInstance();
            Integer m=now.get(Calendar.MONTH) + 1;
            Integer y=now.get(Calendar.YEAR);
            String month=m.toString();
            String year=y.toString();
            sanphamban spb=new sanphamban(ma, manv, Long.valueOf("0"), new Timestamp(System.currentTimeMillis()), new Timestamp(System.currentTimeMillis()));
            if(sanphambanBUS.ThemSPB(month, year, spb) && sanphambanCTBUS.ThemSPBCT(month, year, ma)){
                out.print("tc");
            }
            else{
                out.print("tb");
            }
        }
        else if(tt.equals("ktspb")){ // kiểm tra spb có tồn tại không
            sanphamban spb=sanphambanBUS.getSPB(mspb);
            String maspb=spb.getIdSPB();
            if(maspb != null){
                out.print("tc");
            }
            else{
                out.print("tb");
            }
        }
        else if(tt.equals("laydsspbct")){ // lấy danh sách htct
            if(!sanphambanCTBUS.getDSSPBCTtheoIdSPB(mspb).isEmpty()){
                %>
                <table class="table table-hover">
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng bán</th>
                </tr>
                <%
                for (sanphambanct spbct : sanphambanCTBUS.getDSSPBCTtheoIdSPB(mspb)) {
                    %>
                    <tr>
                        <% sanpham sp= sanphamBUS.getSP(spbct.getIdSP()); %>
                        <td><%= sp.getTenSP() %></td>
                        <td><%= spbct.getSLBan()%></td>
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
                        <th>Số lượng bán</th>
                    </tr>
                </table>
                <%
            }
        }
        else if(tt.equals("xoa")){ //xoá
            if(mspb != null){
                if(sanphambanCTBUS.XoaSPBCTtheoIdSPB(mspb) && sanphambanBUS.XoaSPB(mspb)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
            
        }
        else if(tt.equals("sua")){ //sửa hdbct chỉ quan tâm mã và ngày cn
            Calendar now = Calendar.getInstance();
            Integer m=now.get(Calendar.MONTH) + 1;
            Integer y=now.get(Calendar.YEAR);

            sanphamban spb=new sanphamban(mspb, "NULL", Long.valueOf("0"), new Timestamp(System.currentTimeMillis()), new Timestamp(System.currentTimeMillis()));
            if(sanphambanCTBUS.CapnhatSPBCT(m.toString(), y.toString(), mspb) && sanphambanBUS.CapnhatSPB(m.toString(), y.toString(), spb)){
                out.print("tc");
            }
            else{
                out.print("tb");
            }
        }   
    }
    
%>

