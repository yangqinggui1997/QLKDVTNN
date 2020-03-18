/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import dao.sanphambanCTDAO;
import dto.sanphambanct;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class sanphambanCTBUS {
    
    //lấy danh sách spb chi tiết
    public static ArrayList<sanphambanct> getDSSPBCT() throws SQLException {
        return sanphambanCTDAO.getDSSPBCT();
    }
    
    //lấy danh sách spb chi tiết theo mspb
    public static ArrayList<sanphambanct> getDSSPBCTtheoIdSPB(String mspb) throws SQLException {
        return sanphambanCTDAO.getDSSPBCTtheoIdSPB(mspb);
    }
    
    //lấy spb chi tiết theo mã ht và mã sp
    public static sanphambanct getHTCT(String idspb, String idsp) throws SQLException {
        return sanphambanCTDAO.getHTCT(idspb, idsp);
    }
    
    //lấy spb chi tiết theo mã spb
    public static sanphambanct getSPBCTtheoIdSPB(String ihspb) throws SQLException {
        return sanphambanCTDAO.getSPBCTtheoIdSPB(ihspb);
    }
    
    // thêm mới dữ liệu
    public static boolean ThemSPBCT(String month, String year, String mspb) throws SQLException{
        return  sanphambanCTDAO.ThemSPBCT(month, year, mspb);
    }

    // cập nhật dữ liệu
    public static boolean CapnhatSPBCT(String month, String year, String mspb) throws SQLException{
        return sanphambanCTDAO.CapnhatSPBCT(month, year, mspb);
    }

    // xóa dữ liệu
    public static boolean XoaSPBCT(String idspb, String idsp) throws SQLException{
        return sanphambanCTDAO.XoaSPBCT(idspb, idsp);
    }
    
    // xóa spbct thep idspb
    public static boolean XoaSPBCTtheoIdSPB(String idspb) throws SQLException{
        return sanphambanCTDAO.XoaSPBCTtheoIdSPB(idspb);
    }
    
    // xóa spbct theo idsp
    public static boolean XoaSPBCTtheoIdSP(String idsp) throws SQLException{
        return sanphambanCTDAO.XoaSPBCTtheoIdSP(idsp);
    }
}
