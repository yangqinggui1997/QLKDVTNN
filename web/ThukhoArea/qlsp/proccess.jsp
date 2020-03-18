<%-- 
    Document   : newjsp
    Created on : Nov 3, 2018, 9:22:14 PM
    Author     : DELL
--%>

<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.nio.charset.Charset"%>
<%@page import="bus.sanphambanCTBUS"%>
<%@page import="dao.hangtonCTDAO"%>
<%@page import="bus.hoadonbanCTBUS"%>
<%@page import="dto.nhacungung"%>
<%@page import="bus.nhacungungBUS"%>
<%@page import="bus.sanphamBUS"%>
<%@page import="dto.sanpham"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="Common.CommonCommand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%   
    //Kiểm tra sp có tồn tại không
    String msp=request.getParameter("msp");
    if(msp!=null){
        sanpham sp=sanphamBUS.getSP(msp);
        String masp=sp.getIdSP();
        if(masp != null){
            out.print("tc");
            
        }
        else{
            out.print("tb");
        }
    }
    
    String idsp=request.getParameter("idsp");
    if(idsp != null){
        sanpham sp=sanphamBUS.getSP(idsp);
        if(sp != null){
            out.print(sp.getIdNCU()+"|"+sp.getTenSP()+"|"+CommonCommand.deDateFormatForUpdate(sp.getNgaySX().toString())+"|"+CommonCommand.deDateFormatForUpdate(sp.getNgayHH().toString())+"|"+sp.getNhaSX()+"|"+CommonCommand.deDateFormatForUpdate(sp.getNgayNhap().toString())+"|"+sp.getSLNhap()+"|"+sp.getDonGiaNhap()+"|"+sp.getDonGiaTienMat()+"|"+sp.getDonGiaThanhToanSau()+"|"+sp.getGiamGia());
        }
    }
    
    
        
    //lấy thông tin sp
    String tt=request.getParameter("tt");
    String mancu=request.getParameter("mancu");
    String masp=request.getParameter("masp");
    String tensp=request.getParameter("tensp");
    String ngaysx=request.getParameter("ngaysx");
    String ngayhh=request.getParameter("ngayhh");
    String nhasx=request.getParameter("nhasx");
    String ngaynhap=request.getParameter("ngaynhap");
    String slnhap=request.getParameter("slnhap");
    String dongianhap=request.getParameter("dongianhap");
    String dongiatm=request.getParameter("dongiatm");
    String dongiatts=request.getParameter("dongiatts");
    String anhsp=request.getParameter("anhsp");
    String giamgia=request.getParameter("giamgia");
    if(tt != null){
        if(tt.equals("laydsncu")){
            if(!nhacungungBUS.getDSNCU().isEmpty()){
                for (nhacungung ncu : nhacungungBUS.getDSNCU()) {
                    out.print("<option value='"+ncu.getIdNCU()+"'>"+ncu.getTenNCU()+"</option>");
                }
            }
            else{
                out.print("null");
            }
        }
        else if(tt.equals("them")){//them
            if(tensp != null && nhasx != null && slnhap !=null && dongianhap !=null && dongiatm !=null && dongiatts !=null){
                
                String ma=sanphamBUS.TaoMaNN();
                sanpham sp=new sanpham(ma, mancu, tensp, Timestamp.valueOf(CommonCommand.endateformat(ngaysx)), Timestamp.valueOf(CommonCommand.endateformat(ngayhh)), nhasx, Timestamp.valueOf(CommonCommand.endateformat(ngaynhap)), Integer.valueOf(slnhap), Long.valueOf(dongianhap), Long.valueOf(dongiatm), Long.valueOf(dongiatts), Short.valueOf(giamgia), anhsp, new Timestamp(System.currentTimeMillis()));
                if(sanphamBUS.ThemSP(sp)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
                   
            }
            
        }
        else if(tt.equals("sua")){ //sửa
            if(masp != null && tensp != null && nhasx != null && slnhap !=null && dongianhap !=null && dongiatm !=null && dongiatts !=null){
                sanpham sp=new sanpham(masp, mancu, tensp, Timestamp.valueOf(CommonCommand.endateformat(ngaysx)), Timestamp.valueOf(CommonCommand.endateformat(ngayhh)), nhasx, Timestamp.valueOf(CommonCommand.endateformat(ngaynhap)), Integer.valueOf(slnhap), Long.valueOf(dongianhap), Long.valueOf(dongiatm), Long.valueOf(dongiatts), Short.valueOf(giamgia), anhsp, new Timestamp(System.currentTimeMillis()));
                Integer htd;
                if(anhsp.equals("Chưa chọn ảnh")){
                    htd=0;
                    if(sanphamBUS.CapnhatSP(sp, htd)){
                        out.print("tc");
                    }
                    else{
                        out.print("tb");
                    }
                }
                else{
                    htd=1;
                    if(sanphamBUS.CapnhatSP(sp, htd)){
                        out.print("tc");
                    }
                    else{
                        out.print("tb");
                    }
                }
                
            }
            else{
                out.print("nul");
            }
        }
        else if(tt.equals("xoa")){ //xoá
            if(masp != null){
                if(hoadonbanCTBUS.XoaHDBCTtheoIdSP(masp) && hangtonCTDAO.XoaHTCTtheoIdSP(masp) && sanphambanCTBUS.XoaSPBCTtheoIdSP(masp) && sanphamBUS.XoaSP(masp)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
            
        }
    }

    
%>

