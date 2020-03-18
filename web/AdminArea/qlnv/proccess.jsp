<%-- 
    Document   : newjsp
    Created on : Nov 3, 2018, 9:22:14 PM
    Author     : DELL
--%>

<%@page import="com.sun.org.apache.bcel.internal.generic.GOTO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="dto.nguoidung"%>
<%@page import="bus.sanphambanCTBUS"%>
<%@page import="bus.hangtonCTBUS"%>
<%@page import="bus.hoadonbanCTBUS"%>
<%@page import="bus.sanphambanBUS"%>
<%@page import="dto.sanphamban"%>
<%@page import="bus.hangtonBUS"%>
<%@page import="dto.hangton"%>
<%@page import="bus.hoadonbanBUS"%>
<%@page import="dto.hoadonban"%>
<%@page import="bus.nguoidungBUS"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bus.nhanvienBUS"%>
<%@page import="dto.nhanvien"%>
<%@page import="Common.CommonCommand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%   //xử lý tạo mã ngẫu nhiên
    String s=request.getParameter("id");
  
    if(s != null){
        Short id=Short.parseShort(s);
        String ma=nhanvienBUS.TaoMNN(id);
        out.print(ma);
      }
    
    //Kiểm tra nhân viên có tồn tại không
    String mnv=request.getParameter("mnv");
    if(mnv!=null){
        nhanvien nv=nhanvienBUS.getNV(mnv);
        String manv=nv.getIdNV();
        if(manv != null){
            out.print("tc");
            
        }
        else{
            out.print("tb");
        }
    }
    
    String idnv=request.getParameter("idnv");
    if(idnv != null){
        nhanvien nv=nhanvienBUS.getNV(idnv);
        if(nv != null){
            out.print(nv.getIdNV()+"|"+nv.getTenNV()+"|"+CommonCommand.deDateFormatForUpdate(nv.getNgaySinh().toString())+"|"+nv.getGioiTinh()+"|"+nv.getSoCMND()+"|"+nv.getSDT()+"|"+nv.getDiaChi()+"|"+nv.getChucVu()+"|"+CommonCommand.deDateFormatForUpdate(nv.getNgayVaoLam().toString()));
        }
    }

    //lấy thông tin nhân viên
    String tt=request.getParameter("tt");
    String hts=request.getParameter("hts");
    String macu=request.getParameter("macu");
    String manv=request.getParameter("manv");
    String tennv=request.getParameter("tennv");
    String ngaysinh=request.getParameter("ngaysinh");
    String gioitinh=request.getParameter("gioitinh");
    String socmnd=request.getParameter("socmnd");
    String sdt=request.getParameter("sdt");
    String diachi=request.getParameter("diachi");
    String chucvu=request.getParameter("chucvu");
    String nvl=request.getParameter("nvl");
    if(tt != null){
        if(tt.equals("them")){//them
            if(manv != null && tennv != null && ngaysinh !=null && gioitinh !=null && socmnd != null && sdt !=null && diachi !=null && chucvu !=null && nvl !=null){
                nhanvien nv=new nhanvien(manv, tennv, Timestamp.valueOf(CommonCommand.endateformat(ngaysinh)) , Short.valueOf(gioitinh), socmnd, sdt, diachi, Short.valueOf(chucvu), Timestamp.valueOf(CommonCommand.endateformat(nvl)));
                if(nhanvienBUS.ThemNV(nv)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(tt.equals("sua") && hts.equals("macu")){ //sửa
            if(manv != null && tennv != null && ngaysinh !=null && gioitinh !=null && socmnd != null && sdt !=null && diachi !=null && chucvu !=null && nvl !=null){
                nhanvien nv=new nhanvien(manv, tennv, Timestamp.valueOf(CommonCommand.endateformat(ngaysinh)) , Short.valueOf(gioitinh), socmnd, sdt, diachi, Short.valueOf(chucvu), Timestamp.valueOf(CommonCommand.endateformat(nvl)));
                
                if(nhanvienBUS.CapnhatNV(nv)){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(tt.equals("sua") && hts.equals("doima") && macu!=null){ //sửa
            if(manv != null && tennv != null && ngaysinh !=null && gioitinh !=null && socmnd != null && sdt !=null && diachi !=null && chucvu !=null && nvl !=null){
                nhanvien nv=new nhanvien(manv, tennv, Timestamp.valueOf(CommonCommand.endateformat(ngaysinh)) , Short.valueOf(gioitinh), socmnd, sdt, diachi, Short.valueOf(chucvu), Timestamp.valueOf(CommonCommand.endateformat(nvl)));   
                
                if(nhanvienBUS.ThemNV(nv)){
                    boolean flag1=true;
                    if(!nguoidungBUS.getDSND().isEmpty()){
                        for (nguoidung nd : nguoidungBUS.getDSND()) {
                            if(nd !=null){
                                String mnd=nd.getIdND();
                                String mnhanv=nd.getIdNV();
                                if(mnhanv.equals(macu)){
                                    
                                    if(!nguoidungBUS.CapnhatIdNV(mnd, manv)){
                                        flag1=false;
                                        
                                        break; 
                                    }
                                    
                                }

                            }

                        }
                    }
                    boolean flag2=true;
                    if(!hoadonbanBUS.getDSHDB().isEmpty()){
                        for (hoadonban hdb : hoadonbanBUS.getDSHDB()) {
                            if(hdb !=null){
                                String mhdb=hdb.getIdHDB();
                                String mnhanv=hdb.getIdNV();
                                if(mnhanv.equals(macu)){
                                    if(!hoadonbanBUS.CapnhatIdNV(mhdb, manv)){
                                        flag2=false;
                                        break; 
                                    }
                                }

                            }

                        }
                    }
                    boolean flag3=true;
                    if(!hangtonBUS.getDSHT().isEmpty()){
                        for (hangton ht : hangtonBUS.getDSHT()) {
                            if(ht !=null){
                                String mht=ht.getIdHT();
                                String mnhanv=ht.getIdNV();
                                if(mnhanv.equals(macu)){
                                    if(!hangtonBUS.CapnhatIdNV(mht, manv)){
                                        flag3=false;
                                        break; 
                                    }
                                }

                            }

                        }
                    }
                    boolean flag4=true;
                    if(!sanphambanBUS.getDSSPB().isEmpty()){
                        for (sanphamban spb : sanphambanBUS.getDSSPB()) {
                            if(spb !=null){
                                String mspb=spb.getIdSPB();
                                String mnhanv=spb.getIdNV();
                                if(mnhanv.equals(macu)){
                                    if(!sanphambanBUS.CapnhatIdNV(mspb, manv)){
                                        flag4=false;
                                        break; 
                                    }
                                }

                            }

                        }
                    }
                    
                    boolean flag5=true;
                    if(!nhanvienBUS.XoaNV(macu)){
                        flag5=false;
                    }
                    String ss="";
                    String ma="";
                    boolean flag6=true;
                    if(!nguoidungBUS.getDSND().isEmpty()){
                        for (nguoidung nd : nguoidungBUS.getDSND()) {
                            if(nd != null){
                                String mnhanvien=nd.getIdNV();
                                String manguoidung=nd.getIdND();
                                if(mnhanvien.equals(manv)){
                                    String mandmoi="";
                                    if(manv.toString().substring(0, 4).equals("NVQT")){
                                        mandmoi=nguoidungBUS.TaoMNN(Short.valueOf("1"));
                                    }
                                    else if(manv.toString().substring(0, 4).equals("NVKT")){
                                        mandmoi=nguoidungBUS.TaoMNN(Short.valueOf("2"));
                                    }
                                    else if(manv.toString().substring(0, 4).equals("NVBH")){
                                        mandmoi=nguoidungBUS.TaoMNN(Short.valueOf("3"));
                                    }
                                    else if(manv.toString().substring(0, 4).equals("NVTK")){
                                        mandmoi=nguoidungBUS.TaoMNN(Short.valueOf("4"));
                                    }

                                    if(!nguoidungBUS.CapnhatIdND(mandmoi, manguoidung)){
                                        flag6=false;
                                        break; 
                                    }
                                }
                            }
                        }
                    }
                    if(flag1 == false || flag2== false || flag3 == false || flag4 == false || flag5 == false || flag6 == false){
                        out.print("tb");
                    }
                    else{
                        out.print("tc");
                    }
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(tt.equals("xoa")){ //xoá
            if(manv != null){
                Boolean flag1=true;
                if(!hoadonbanBUS.getDSHDB().isEmpty()){
                    
                    for (hoadonban hdb : hoadonbanBUS.getDSHDB()) {
                        String mahdb=hdb.getIdHDB();
                        String manhanv=hdb.getIdNV();
                        if(manhanv.equals(manv)){
                            if(!hoadonbanCTBUS.XoaHDBCTtheoIdHDB(mahdb)){
                                flag1=false;
                                break; 
                            }
                        }
                        
                    }
                }
                
                Boolean flag2=true;
                if(!hangtonBUS.getDSHT().isEmpty()){
                    
                    for (hangton ht : hangtonBUS.getDSHT()) {
                        String maht=ht.getIdHT();
                        String manhanv=ht.getIdNV();
                        if(manhanv.equals(manv)){
                            if(!hangtonCTBUS.XoaHTCTtheoIdHT(maht)){
                                flag2=false;
                                break; 
                            }
                        }
                    }
                }
                
                Boolean flag3=true;
                if(!sanphambanBUS.getDSSPB().isEmpty()){
                    
                    for (sanphamban spb : sanphambanBUS.getDSSPB()) {
                        String maspb=spb.getIdSPB();
                        String manhanv=spb.getIdNV();
                        if(manhanv.equals(manv)){
                            if(!sanphambanCTBUS.XoaSPBCTtheoIdSPB(maspb)){
                                flag3=false;
                                break; 
                            }
                        }
                    }
                }
                
                Boolean flag4=true;
                if(!nguoidungBUS.XoaNDtheoIdNV(manv)){
                    flag4=false;
                }

                if(flag1.equals(false) || flag2.equals(false) || flag3.equals(false) || flag4.equals(false)){
                    out.print("tb");
                }
                else{
                    if(hoadonbanBUS.XoaHDBtheoIdNV(manv) && hangtonBUS.XoaHTtheoIdNV(manv) && sanphambanBUS.XoaSPBtheoIdNV(manv) && nhanvienBUS.XoaNV(manv)){
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

