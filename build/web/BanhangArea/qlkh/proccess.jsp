<%-- 
    Document   : newjsp
    Created on : Nov 3, 2018, 9:22:14 PM
    Author     : DELL
--%>

<%@page import="bus.nhanvienBUS"%>
<%@page import="bus.hoadonbanCTBUS"%>
<%@page import="dto.hoadonbanct"%>
<%@page import="bus.hoadonbanBUS"%>
<%@page import="dto.hoadonban"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bus.khachhangBUS"%>
<%@page import="dto.khachhang"%>
<%@page import="Common.CommonCommand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%   
    //Kiểm tra khách hàng có tồn tại không
    String mkh=request.getParameter("mkh");
    if(mkh!=null){
        khachhang kh=khachhangBUS.getKH(mkh);
        String makh=kh.getSoCMND();
        if(makh != null){
            out.print("tc");
            
        }
        else{
            out.print("tb");
        }
    }
    
    String idkh=request.getParameter("idkh");
    if(idkh != null){
        khachhang kh=khachhangBUS.getKH(idkh);
        if(kh != null){
            out.print(kh.getTenKH()+"|"+CommonCommand.deDateFormatForUpdate(kh.getNgaySinh().toString())+"|"+kh.getGioiTinh()+"|"+kh.getSoCMND()+"|"+kh.getSDT()+"|"+kh.getEmail()+"|"+kh.getDiaChi()+"|"+kh.getLoaiKH()+"|"+kh.getDanhGia());
        }
    }

    //lấy thông tin khách hàng
    String tt=request.getParameter("tt");
    String hts=request.getParameter("hts");
    String makh=request.getParameter("makh");
    String macu=request.getParameter("scmcu");
    String tenkh=request.getParameter("tenkh");
    String ngaysinh=request.getParameter("ngaysinh");
    String gioitinh=request.getParameter("gioitinh");
    String sdt=request.getParameter("sdt");
    String diachi=request.getParameter("diachi");
    String loaikh=request.getParameter("loaikh");
    String email=request.getParameter("email");
    String danhgia=request.getParameter("danhgia");
    
    if(tt != null){
        if(tt.equals("them")){//them
            if(makh != null && tenkh != null && ngaysinh !=null && gioitinh !=null && sdt !=null && diachi !=null && loaikh !=null){
                khachhang kh=new khachhang(tenkh, Timestamp.valueOf(CommonCommand.endateformat(ngaysinh)) , Short.valueOf(gioitinh), makh, sdt, email, diachi, Short.valueOf(loaikh), danhgia);
                if(khachhangBUS.ThemKH(kh)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(tt.equals("sua") && hts.equals("scmcu")){ //sửa
            if(makh != null && tenkh != null && ngaysinh !=null && gioitinh !=null && sdt !=null && diachi !=null && loaikh !=null){
                khachhang kh=new khachhang(tenkh, Timestamp.valueOf(CommonCommand.endateformat(ngaysinh)) , Short.valueOf(gioitinh), makh, sdt, email, diachi, Short.valueOf(loaikh), danhgia);
                if(khachhangBUS.CapnhatKH(kh)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(tt.equals("sua") && hts.equals("doiscm") && macu!=null){ //sửa
            if(makh != null && tenkh != null && ngaysinh !=null && gioitinh !=null && sdt !=null && diachi !=null && loaikh !=null){
                khachhang kh=new khachhang(tenkh, Timestamp.valueOf(CommonCommand.endateformat(ngaysinh)) , Short.valueOf(gioitinh), makh, sdt, email, diachi, Short.valueOf(loaikh), danhgia);
                
                if(khachhangBUS.ThemKH(kh)){
                    boolean flag=true;
                    if(!hoadonbanBUS.getDSHDB().isEmpty()){
                        for (hoadonban hdb : hoadonbanBUS.getDSHDB()) {
                            if(hdb != null){
                                String mahdban=hdb.getIdHDB();
                                String makhach=hdb.getIdKH();
                                if(makhach.equals(macu)){
                                    if(!hoadonbanBUS.CapnhatIdKH(mahdban, makh)){
                                        flag=false;
                                        break;
                                    }
                                }
                            }


                        }
                    }
                    if(flag==false){
                        out.print("tb");
                    }
                    else{
                        if(khachhangBUS.XoaKH(macu)){
                            out.print("tc");
                        }
                        else{
                            out.print("tb");
                        }
                    }
                    
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(tt.equals("xoa")){ //xoá
            if(makh != null){
                boolean flag=true;
                if(!hoadonbanBUS.getDSHDB().isEmpty()){
                    for (hoadonban hdb : hoadonbanBUS.getDSHDB()) {
                        if(hdb != null){
                            String mahdban=hdb.getIdHDB();
                            String makhach=hdb.getIdKH();
                            if(makhach.equals(makh)){
                                if(!hoadonbanCTBUS.XoaHDBCTtheoIdHDB(mahdban)){
                                    flag=false;
                                    break;
                                }
                            }
                        }
                        
                        
                    }
                }
                if(flag == false){
                    out.print("tb");
                }
                else{
                    if(hoadonbanBUS.XoaHDBtheoIdKH(makh) && khachhangBUS.XoaKH(makh)){
                        out.print("tc");
                    }
                    else{
                        out.print("tb");
                    }
                }
                
            }
            
        }
    }
    
%>

