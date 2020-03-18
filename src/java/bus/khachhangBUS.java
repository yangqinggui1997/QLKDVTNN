/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import dao.khachhangDAO;
import dto.khachhang;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class khachhangBUS {
    
    public static ArrayList<khachhang> getDSKH() throws Exception{
        return khachhangDAO.getDSKH();
    }
    
    public static khachhang getKH(String idkh) throws SQLException{
        return khachhangDAO.getKH(idkh);
    }
    
    public static Boolean ThemKH(khachhang kh) throws SQLException{
        return khachhangDAO.ThemKH(kh);
    }
    
    public static Boolean CapnhatKH(khachhang kh) throws SQLException{
        return khachhangDAO.CapnhatKH(kh);
    }
    
    public static Boolean XoaKH(String idkh) throws SQLException{
        return khachhangDAO.XoaKH(idkh);
    }
    
    public static ArrayList<khachhang> TKKH(String key) throws Exception{
        return khachhangDAO.TKKH(key);
    }
   
}
