<%-- 
    Document   : proccess
    Created on : Nov 6, 2018, 10:02:21 PM
    Author     : DELL
--%>
<%@page import="java.util.Date"%>
<%@page import="javafx.scene.control.Alert"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="bus.nguoidungBUS"%>
<%@page import="bus.nhanvienBUS"%>
<%@page import="dto.nguoidung"%>
<%@page import="dto.nhanvien"%>
<%@page import="Common.CommonCommand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String username=request.getParameter("username");
    String pass=request.getParameter("pass");
    if(username != null && pass !=null){
        byte[] mahoa=CommonCommand.encrypt(pass); //mã hoá mk
        String mkmh= new String(mahoa, "UTF-8");
        nguoidung nd=nguoidungBUS.KTTKND(username, mkmh);
        if(nd != null){ 
            String mand=nd.getIdND();
            String tennd= nd.getTenTK();
            Short tt=nd.getTrangThai();
            
            if(tt.toString().equals("0")){
                out.print("bikhoa");
            }
            else{
                //cập nhật trạng thái người dùng đăng nhập
                nguoidungBUS.CapnhatKhoaTK(mand, Short.valueOf("1"));
                session.setAttribute("tennd", tennd);
                session.setAttribute("mand", mand);
                //dữ liệu trả về
                out.print(mand+"|"+tennd);
            }
            
        }
    }
    
    String hd=request.getParameter("hd");
    String manv=request.getParameter("manv");
    String tentk=request.getParameter("tentk");
    String mk=request.getParameter("mk");
    String mand=request.getParameter("mand");
    String mkcu=request.getParameter("mkcu");
    String mkmoi=request.getParameter("mkmoi");
    
    //xử lý tạo mã ngẫu nhiên
    if(hd!=null){
        if(hd.equals("dktk")){
            if(manv != null && tentk != null && mk != null){
                Short id=0;
                if(manv.substring(0, 4).equals("NVQT")){
                    id=1;
                }
                else if(manv.substring(0, 4).equals("NVKT")){
                    id=2;
                }
                else if(manv.substring(0, 4).equals("NVBH")){
                    id=3;
                }
                else if(manv.substring(0, 4).equals("NVTK")){
                    id=4;
                    
                }
                
                if(!id.equals(0)){
                    String ma=nguoidungBUS.TaoMNN(id);
//                    final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//định dạng ngày giờ tuỳ ý 
                    Timestamp ngaytaotk = new Timestamp(System.currentTimeMillis());
                    Timestamp suamklancuoi = new Timestamp(System.currentTimeMillis());

                    //hoặc sdf.format(date)->string : định dạng ngày theo biến sdf
                    
                    byte[] mahoa=CommonCommand.encrypt(mk); //mã hoá mk
                    String mkmh= new String(mahoa,"UTF-8");
//                    String giaima=CommonCommand.decrypt(mahoa);//giải mã

                    nguoidung nd= new nguoidung(ma,manv,tentk, mkmh, ngaytaotk, suamklancuoi, Short.valueOf("1"), id);
                    if(nguoidungBUS.ThemND(nd)){
                        session.setAttribute("tennd", tentk);
                        session.setAttribute("mand", ma);
                        out.print("tc|"+ma);
                    }
                    else{
                        out.print("tb");
                    }
                }
                else{
                    out.print("tb");
                }
                
            }
        }
        else if(hd.equals("kttentk")){
            if(tentk != null){   
                nguoidung nd=nguoidungBUS.getNDtheoTenTK(tentk);
                String mnd=nd.getIdND();
                if(mnd == null){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(hd.equals("ktmanv")){
            if(manv != null){   
                nhanvien nv=nhanvienBUS.getNV(manv);
                String mnv=nv.getIdNV();
                if(mnv != null){
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
        }
        else if(hd.equals("ktmkcu")){
            
            if(mand != null && mkcu != null){
                byte[] mahoa=CommonCommand.encrypt(mkcu); //mã hoá mk
                String mkmh= new String(mahoa, "UTF-8");
                if(nguoidungBUS.KTMK(mand, mkmh)){//giải mã mk trước
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
            else{
                out.print("tb");
            }       
        }
        else if(hd.equals("doimk")){
            
            if(mand != null && mkmoi != null){
                byte[] mahoa=CommonCommand.encrypt(mkmoi); //mã hoá mk
                String mkmh= new String(mahoa, "UTF-8");
                if(nguoidungBUS.CapnhatMK(mand, mkmh)){//giải mã mk trước
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
            else{
                out.print("tb");
            }
            
        }
        else if(hd.equals("dangxuat")){
            if(mand != null){
                if(nguoidungBUS.CapnhatKhoaTK(mand, Short.valueOf("2"))){
                    session = request.getSession(false);
                    if (session != null) {
                        session.invalidate();
                    }
                    out.print("tc");
                }
                else{
                    out.print("tb");
                }
            }
            else{
                out.print("tb");
            }
            
        }
    }
    
%>
