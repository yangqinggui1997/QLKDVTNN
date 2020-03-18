/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import dao.nguoidungDAO;
import java.util.ArrayList;
import dto.nguoidung;
import java.sql.SQLException;

/**
 *
 * @author DELL
 */
public class nguoidungBUS {
    
    public static ArrayList<nguoidung> getDSND() throws Exception{
        return nguoidungDAO.getDSND();
    }
    
    //Kiểm tra đăng nhập
    public static nguoidung KTTKND(String username, String PassWord) throws SQLException{
        return nguoidungDAO.KTTKDN(username, PassWord);
    }
    
    //kiểm tra mật khẩu trước khi đổi
    public static Boolean KTMK(String idnd, String mk) throws SQLException {
        return nguoidungDAO.KTMK(idnd, mk);
    }
    
    public static nguoidung getND(String idnd) throws SQLException{
        return nguoidungDAO.getND(idnd);
    }
    
    //lấy người dùng theo tk
    public static nguoidung getNDtheoTenTK(String tentk) throws SQLException {
        return nguoidungDAO.getNDtheoTenTK(tentk);
    }
    
    //lấy người dùng theo mã nhân viên
    public static nguoidung getNDtheoIdNV(String idnv) throws SQLException {
        return nguoidungDAO.getNDtheoIdNV(idnv);
    }
    
    public static Boolean ThemND(nguoidung nd) throws SQLException{
        return nguoidungDAO.ThemND(nd);
    }
    
    public static Boolean CapnhatKhoaTK(String idnd, Short khoa) throws SQLException{
        return nguoidungDAO.CapnhatKhoaTK(idnd, khoa);
    }
    
    public static Boolean CapnhatNhomND(String idnd, Short nnd) throws SQLException{
        return nguoidungDAO.CapnhatNhomND(idnd, nnd);
    }
    
    // cập nhật mnv
    public static boolean CapnhatIdNV(String idnd, String idnv) throws SQLException{
        return nguoidungDAO.CapnhatIdNV(idnd, idnv);
    }
    
    public static boolean CapnhatMK(String idnd, String mkmoi) throws SQLException{
        return nguoidungDAO.CapnhatMK(idnd, mkmoi);
    }
    
    // cập nhật mnd khi mnv thay doi
    public static boolean CapnhatIdND(String idndmoi, String idndcu) throws SQLException{
        return nguoidungDAO.CapnhatIdND(idndmoi, idndcu);
    }
    
    public static Boolean XoaND(String idnd) throws SQLException{
        return nguoidungDAO.XoaND(idnd);
    }
    
    // xóa người dùng theo mã nv
    public static boolean XoaNDtheoIdNV(String idnv) throws SQLException{
        return nguoidungDAO.XoaNDtheoIdNV(idnv);
    }
    
    public static ArrayList<nguoidung> TKND(String key) throws Exception{
        return nguoidungDAO.TKND(key);
    }
    
    public static String TaoMNN(Short loaind) throws SQLException{
        return nguoidungDAO.TaoMaNN(loaind);
    }
}
