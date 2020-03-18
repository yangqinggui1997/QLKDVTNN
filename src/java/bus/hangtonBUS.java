/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;


import dao.hangtonDAO;
import dto.hangton;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class hangtonBUS {
    
    //lấy danh sách hàng tồn
    public static ArrayList<hangton> getDSHT() throws SQLException {
        return hangtonDAO.getDSHT();
    }
    
    //lấy hàng tồn theo mã
    public static hangton getHT(String idht) throws SQLException {
        return hangtonDAO.getHT(idht);
    }
    
    //lấy hàng tồn theo tháng và năm
    public static hangton getHTtheoMonthYear(String month, String year) throws SQLException {
        return hangtonDAO.getHTtheoMonthYear(month, year);
    }
    
    //lấy mã hàng tồn theo mã nhân viên
    public static hangton getHTtheoIdNV(String idnv) throws SQLException {
        return hangtonDAO.getHTtheoIdNV(idnv);
    }

    // thêm mới dữ liệu
    public static Boolean ThemHT(hangton ht) throws SQLException{
        return hangtonDAO.ThemHT(ht);
    }

    // cập nhật dữ liệu
    public static boolean CapnhatHT(hangton ht) throws SQLException{
        return hangtonDAO.CapnhatHT(ht);
    }

    // cập nhật dữ liệu khi idv thay doi
    public static boolean CapnhatIdNV(String idht, String idnv) throws SQLException{
        return hangtonDAO.CapnhatIdNV(idht, idnv);
    }
    
    // xóa dữ liệu
    public static boolean XoaHT(String idht) throws SQLException{
        return hangtonDAO.XoaHT(idht);
    }
    
    // tìm kiếm
    public static ArrayList<hangton> TKHT(String key) throws Exception{
        return hangtonDAO.TKHT(key);
    }
    
    public static String TaoMaNN() throws SQLException{
        return hangtonDAO.TaoMaNN();
    }
    
    // xóa hang ton theo idnv
    public static boolean XoaHTtheoIdNV(String idnv) throws SQLException{
        return hangtonDAO.XoaHTtheoIdNV(idnv);
    }
}
