<%-- 
    Document   : newjsp
    Created on : Nov 3, 2018, 9:22:14 PM
    Author     : DELL
--%>

<%@page import="bus.sanphambanCTBUS"%>
<%@page import="bus.sanphambanBUS"%>
<%@page import="bus.hoadonbanCTBUS"%>
<%@page import="bus.hangtonCTBUS"%>
<%@page import="java.sql.SQLException"%>
<%@page import="dto.sanpham"%>
<%@page import="bus.sanphamBUS"%>
<%@page import="bus.nhacungungBUS"%>
<%@page import="dto.nhacungung"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Common.CommonCommand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%   
    //Kiểm tra ncu có tồn tại không
    String mncu=request.getParameter("mncu");
    if(mncu!=null){
        nhacungung ncu=nhacungungBUS.getNCU(mncu);
        String mancu=ncu.getIdNCU();
        if(mancu != null){
            out.print("tc");
            
        }
        else{
            out.print("tb");
        }
    }
    
    String idncu=request.getParameter("idncu");
    if(idncu != null){
        nhacungung ncu=nhacungungBUS.getNCU(idncu);
        if(ncu != null){
            out.print(ncu.getTenNCU()+"|"+ncu.getDiaChi()+"|"+ncu.getSDT()+"|"+ncu.getEmail()+"|"+ncu.getQuyMo()+"|"+ncu.getDanhGia());
        }
    }

    //lấy thông tin ncu
    String tt=request.getParameter("tt");
    String mancu=request.getParameter("mancu");
    String tenncu=request.getParameter("tenncu");
    String quymo=request.getParameter("quymo");
    String sdt=request.getParameter("sdt");
    String diachi=request.getParameter("diachi");
    String email=request.getParameter("email");
    String danhgia=request.getParameter("danhgia");
    if(tt != null){
        if(tt.equals("them")){//them
            if(tenncu != null && diachi !=null && email !=null && sdt !=null && quymo !=null){
                
                String ma=nhacungungBUS.TaoMaNN();
                
                nhacungung ncu=new nhacungung(ma, tenncu, diachi, sdt, email, Short.valueOf(quymo), danhgia);
                if(nhacungungBUS.ThemNCU(ncu)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(tt.equals("sua")){ //sửa
            if(mancu != null && tenncu != null && diachi !=null && email !=null && sdt !=null && quymo !=null){
                nhacungung ncu=new nhacungung(mancu, tenncu, diachi, sdt, email, Short.valueOf(quymo), danhgia);
                if(nhacungungBUS.CapnhatNCU(ncu)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(tt.equals("xoa")){ //xoá
            if(mancu != null){
                
                if(!sanphamBUS.getDSSP().isEmpty()){
                    try{
                        for (sanpham sp : sanphamBUS.getDSSP()) {
                            
                            if(sp!=null){
                                String msp=sp.getIdSP();
                                String manhac=sp.getIdNCU();
                                if(manhac.equals(mancu)){
                                    hangtonCTBUS.XoaHTCTtheoIdSP(msp);
                                    hoadonbanCTBUS.XoaHDBCTtheoIdSP(msp);
                                    sanphambanCTBUS.XoaSPBCTtheoIdSP(msp);
                                    sanphamBUS.XoaSP(msp);
                                }
                                
                            }
                        }
                        if( nhacungungBUS.XoaNCU(mancu)){
                            out.print("tc");
                        }
                        else{
                            out.print("tb");
                        }
                    }
                    catch (SQLException ex){
                        out.print("tb");
                    }
                }
                else{
                   if( nhacungungBUS.XoaNCU(mancu)){
                        out.print("tc");
                    }
                   else{
                        out.print("tc");
                   }
                }
            }
            else
            {
                out.print("tb");
            }
        }
    }
    
%>

