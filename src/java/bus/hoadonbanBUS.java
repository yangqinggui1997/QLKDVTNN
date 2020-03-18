/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import dao.hoadonbanDAO;
import dto.hoadonban;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class hoadonbanBUS {
    
    //lấy danh sách hoá đơn bán
    public static ArrayList<hoadonban> getDSHDB() throws SQLException {
        return hoadonbanDAO.getDSHDB();
    }
    
    //lấy hoá đơn bán theo mã
    public static hoadonban getHDB(String idhdb) throws SQLException {
        return hoadonbanDAO.getHDB(idhdb);
    }
    
    //lấy mã hoá đơn theo mã nhân viên
    public static hoadonban getHDBtheoIdNV(String idnv) throws SQLException {
        return hoadonbanDAO.getHDBtheoIdNV(idnv);
    }
    
    //lấy hoá đơn bán theo mã khách hàng
    public static hoadonban getHDBtheoIdKH(String idkh) throws SQLException {
        return hoadonbanDAO.getHDBtheoIdKH(idkh);
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemHDB(hoadonban hdb) throws SQLException{
        return  hoadonbanDAO.ThemHDB(hdb);
    }

    // cập nhật dữ liệu
    public static boolean CapnhatHDB(hoadonban hdb) throws SQLException{
        return hoadonbanDAO.CapnhatHDB(hdb);
    }
    
    // cập nhật dữ liệu khi idnv thay doi
    public static boolean CapnhatIdNV(String idhdb, String idnv) throws SQLException{
        return hoadonbanDAO.CapnhatIdNV(idhdb, idnv);
    }
    
    // cập nhật dữ liệu khi idkh thay doi
    public static boolean CapnhatIdKH(String idhdb, String idkh) throws SQLException{
        return hoadonbanDAO.CapnhatIdKH(idhdb, idkh);
    }
    
    // xóa dữ liệu
    public static boolean XoaHDB(String idhdb) throws SQLException{
        return hoadonbanDAO.XoaHDB(idhdb);
    }
    
    // tìm kiếm
    public static ArrayList<hoadonban> TKHDB(String key) throws Exception{
        return hoadonbanDAO.TKHDB(key);
    }
    
    public static String TaoMaNN() throws SQLException{
        return hoadonbanDAO.TaoMaNN();
    }
    
    // xóa hdb theo idnv
    public static boolean XoaHDBtheoIdNV(String idnv) throws SQLException{
        return hoadonbanDAO.XoaHDBtheoIdNV(idnv);
    }
    
    // tính tổng số lượng
    public static Boolean TongSLUpdate(String idhdb) throws SQLException{
        return hoadonbanDAO.TongSLUpdate(idhdb);
    }
    
     // tính tổng tiền
    public static Boolean TongTienUpdate(String idhdb) throws SQLException{
        return hoadonbanDAO.TongTienUpdate(idhdb);
    }
    
    // xóa hdb theo idkh
    public static boolean XoaHDBtheoIdKH(String idkh) throws SQLException{
        return hoadonbanDAO.XoaHDBtheoIdKH(idkh);
    }
}
