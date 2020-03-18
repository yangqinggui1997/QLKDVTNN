/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import dao.hangtonCTDAO;
import dto.hangtonct;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class hangtonCTBUS {
    
    //lấy danh sách hoá đơn nhập chi tiết
    public static ArrayList<hangtonct> getDSHDNCT() throws SQLException {
        return hangtonCTDAO.getDSHDNCT();
    }
    
    //lấy danh sách chi tiết theo idht
    public static ArrayList<hangtonct> getDSHDNCTtheoIdHT(String mht) throws SQLException {
        return hangtonCTDAO.getDSHDNCTtheoIdHT(mht);
    }
    
    //lấy hàng tồn chi tiết theo mã ht và mã sp
    public static hangtonct getHTCT(String idht, String idsp) throws SQLException {
        return hangtonCTDAO.getHTCT(idht, idsp);
    }
    
    //lấy hàng tồn chi tiết theo mã hàng tồn
    public static hangtonct getHTCTtheoIdHT(String idht) throws SQLException {
        return hangtonCTDAO.getHTCTtheoIdHT(idht);
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemHTCT(String  mht) throws SQLException{
        return  hangtonCTDAO.ThemHTCT(mht);
    }

    // cập nhật dữ liệu
    public static boolean CapnhatHTCT(String mht) throws SQLException{
        return hangtonCTDAO.CapnhatHTCT(mht);
    }

    // xóa hàng tồn ct theo idht
    public static boolean XoaHTCTtheoIdHT(String idht) throws SQLException{
        return hangtonCTDAO.XoaHTCTtheoIdHT(idht);
    }
    
    // xóa hàng tồn ct theo idsp
    public static boolean XoaHTCTtheoIdSP(String idsp) throws SQLException{
        return hangtonCTDAO.XoaHTCTtheoIdSP(idsp);
    }
}
