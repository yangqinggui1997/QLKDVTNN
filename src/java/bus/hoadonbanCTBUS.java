/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import dao.hoadonbanCTDAO;
import dto.hoadonbanct;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class hoadonbanCTBUS {
    
    //lấy danh sách hoá đơn bán chi tiết
    public static ArrayList<hoadonbanct> getDSHDBCT() throws SQLException {
        return hoadonbanCTDAO.getDSHDBCT();
    }
    
    //lấy danh sách hoá đơn bán chi tiết theo idhdb
    public static ArrayList<hoadonbanct> getDSHDBCTTheoIdHDB(String mhdb) throws SQLException {
        return hoadonbanCTDAO.getDSHDBCTTheoIdHDB(mhdb);
    }
    
    //lấy hoá đơn bán chi tiết theo mã hoá đơn và mã sp
    public static hoadonbanct getHDBCT(String idhdb, String idsp) throws SQLException {
        return hoadonbanCTDAO.getHDBCT(idhdb, idsp);
    }
    
    //lấy hoá đơn bán chi tiết theo mã hoá đơn
    public static hoadonbanct getHDBCTtheoIdHDB(String idhdb) throws SQLException {
        return hoadonbanCTDAO.getHDBCTtheoIdHDB(idhdb);
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemHDBCT(hoadonbanct hdbct) throws SQLException{
        return hoadonbanCTDAO.ThemHDBCT(hdbct);
    }

    // cập nhật dữ liệu
    public static boolean CapnhatHDBCT(hoadonbanct hdbct) throws SQLException{
        return hoadonbanCTDAO.CapnhatHDBCT(hdbct);
    }

    // xóa dữ liệu
    public static boolean XoaHDBCT(String idhb, String idsp) throws SQLException{
        return hoadonbanCTDAO.XoaHDBCT(idhb, idsp);
    }
    
    // xóa hdbct theo idhdb
    public static boolean XoaHDBCTtheoIdHDB(String idhb) throws SQLException{
        return hoadonbanCTDAO.XoaHDBCTtheoIdHDB(idhb);
    }
    
    // xóa hdbct theo idsp
    public static boolean XoaHDBCTtheoIdSP(String idsp) throws SQLException{
        return hoadonbanCTDAO.XoaHDBCTtheoIdSP(idsp);
    }
}
