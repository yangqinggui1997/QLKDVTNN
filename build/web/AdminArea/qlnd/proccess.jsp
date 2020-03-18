<%-- 
    Document   : newjsp
    Created on : Nov 3, 2018, 9:22:14 PM
    Author     : DELL
--%>

<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bus.nguoidungBUS"%>
<%@page import="dto.nguoidung"%>
<%@page import="Common.CommonCommand"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%   
    //Kiểm tra người dùng có tồn tại không
    String mnd=request.getParameter("mnd");
    if(mnd!=null){
        nguoidung nd= nguoidungBUS.getND(mnd);
        String mand=nd.getIdND();
        if(mand != null){
            out.print("tc");
            
        }
        else{
            out.print("tb");
        }
    }

    //lấy thông tin người dùng
    String mand=request.getParameter("mand");
    String loaind=request.getParameter("loaind");
    String loaitt=request.getParameter("loaitt");
    String tt=request.getParameter("tt");
    String htd=request.getParameter("htd");
    String mk=request.getParameter("mk");
    if(tt != null){
        if(tt.equals("sua")){//sửa
            if(mand != null && loaind != null && loaitt != null){
                
                if(htd == null){
                    nguoidung nd= nguoidungBUS.getND(mand);
                    String m=nd.getIdND();
                    Short lnd=nd.getLoaiND();
                    Short ltt=nd.getTrangThai();
                    if(m != null){
                        if(loaind.equals(lnd.toString())){
                            if(loaitt.equals("2")){
                                if(ltt.toString().equals("1") || ltt.toString().equals("2")){
                                    //ko
                                    out.print("kodoi|kodoi|kodoi");
                                }
                                else{
                                    //doi tt
                                    out.print("doi|kodoi|doi");
                                }
                            }
                            else if(loaitt.equals("0")){
                                if(ltt.toString().equals("0")){
                                    //kodoi
                                    out.print("kodoi|kodoi|kodoi");
                                }
                                else{
                                    //doi
                                    out.print("doi|kodoi|doi");
                                }
                            }

                        }
                        else
                        {
                            if(loaitt.equals("2")){
                                if(ltt.toString().equals("1") || ltt.toString().equals("2")){
                                    //ko
                                    out.print("doi|doi|kodoi");
                                }
                                else{
                                    //doi tt
                                    out.print("doi|doi|doi");
                                }
                            }
                            else if(loaitt.equals("0")){
                                if(ltt.toString().equals("0")){
                                    //kodoi
                                    out.print("doi|doi|kodoi");
                                }
                                else{
                                    //doi
                                    out.print("doi|doi|doi");
                                }
                            }
                        }                   
                    } 
                }
                else {
                    if(htd.equals("doi|doi")){
                        if(nguoidungBUS.CapnhatKhoaTK(mand, Short.valueOf(loaitt)) && nguoidungBUS.CapnhatNhomND(mand, Short.valueOf(loaind))){
                           out.print("tc"); 
                        }
                        else{
                            out.print("tb");
                        }

                    }
                    else if(htd.equals("doi|kodoi")){
                        if(nguoidungBUS.CapnhatNhomND(mand, Short.valueOf(loaind))){
                           out.print("tc"); 
                        }
                        else{
                            out.print("tb");
                        }
                    }
                    else if(htd.equals("kodoi|doi")){
                        if(nguoidungBUS.CapnhatKhoaTK(mand, Short.valueOf(loaitt))){
                           out.print("tc"); 
                        }
                        else{
                            out.print("tb");
                        }

                    }
                }
            }
                
        }
        else if(tt.equals("xoa")){
            if(mand != null){
                nguoidung nd= nguoidungBUS.getND(mand);
                Short trangthai=nd.getTrangThai();
                if(trangthai.toString().equals("1")){
                    out.print("ndonline");
                }
                else{
                    if(mand.substring(0,4).equals("NDQT")){
                        out.print("xoaqt");
                    }
                    else{
                        if(nguoidungBUS.XoaND(mand)){
                            out.print("tc");
                        }
                        else{
                            out.print("tb");
                        }
                    }
                    
                }
               
            }
            else{
                out.print("tb");
            }
            
        }
            
    }
%>