/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import dao.sanphambanDAO;
import dto.sanphamban;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class sanphambanBUS {
    
    //lấy danh sách spb
    public static ArrayList<sanphamban> getDSSPB() throws SQLException {
        return sanphambanDAO.getDSSPB();
    }
    
    //lấy spb theo mã
    public static sanphamban getSPB(String idspb) throws SQLException {
        return sanphambanDAO.getSPB(idspb);
    }
    
    //lấy hàng tồn theo tháng và năm
    public static sanphamban getSPBtheoMonthYear(String month, String year) throws SQLException {
        return sanphambanDAO.getSPBtheoMonthYear(month, year);
    }
    //lấy mã spb theo mã nhân viên
    public static sanphamban getSPBtheoIdNV(String idnv) throws SQLException {
        return sanphambanDAO.getSPBtheoIdNV(idnv);
    }

    // thêm mới dữ liệu
    public static boolean ThemSPB(String month, String year, sanphamban spb) throws SQLException{
        return sanphambanDAO.ThemSPB(month, year, spb);
    }

    // cập nhật dữ liệu
    public static boolean CapnhatSPB(String month, String year, sanphamban spb) throws SQLException{
        return sanphambanDAO.CapnhatSPB(month, year, spb);
    }

    // cập nhật idnv
    public static boolean CapnhatIdNV(String idspb, String idnv) throws SQLException{
        return sanphambanDAO.CapnhatIdNV(idspb, idnv);
    }
    
    // xóa dữ liệu
    public static boolean XoaSPB(String idspb) throws SQLException{
        return sanphambanDAO.XoaSPB(idspb);
    }
    
    // tìm kiếm
    public static ArrayList<sanphamban> TKSPB(String key) throws Exception{
        return sanphambanDAO.TKSPB(key);
    }
    
    public static String TaoMaNN() throws SQLException{
        return sanphambanDAO.TaoMaNN();
    }
    
    // xóa spb theo idnv
    public static boolean XoaSPBtheoIdNV(String idnv) throws SQLException{
        return sanphambanDAO.XoaSPBtheoIdNV(idnv);
    }
}
