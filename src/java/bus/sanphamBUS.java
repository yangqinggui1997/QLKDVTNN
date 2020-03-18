/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import dao.sanphamDAO;
import dto.sanpham;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class sanphamBUS {
    public static ArrayList<sanpham> getDSSP() throws Exception{
        return sanphamDAO.getDSSP();
    }
    
    public static sanpham getSP(String idsp) throws SQLException{
        return sanphamDAO.getSP(idsp);
    }
    
    //lấy sản phẩm theo mã
    public static sanpham getSPtheoIdNCU(String idncu) throws SQLException {
        return sanphamDAO.getSPtheoIdNCU(idncu);
    }
    
    public static Boolean ThemSP(sanpham sp) throws SQLException{
        return sanphamDAO.ThemSP(sp);
    }
    
    public static Boolean CapnhatSP(sanpham sp, Integer htd) throws SQLException{
        return sanphamDAO.CapnhatSP(sp, htd);
    }
    
    // cập nhật dữ liệu
    public static boolean CapnhatSLSP(String masp, Integer sl) throws SQLException{
        return sanphamDAO.CapnhatSLSP(masp, sl);
    }
    
    public static Boolean XoaSP(String idsp) throws SQLException{
        return sanphamDAO.XoaSP(idsp);
    }
    
    public static ArrayList<sanpham> TKSP(String key) throws Exception{
        return sanphamDAO.TKSP(key);
    }
    
    public static String TaoMaNN() throws SQLException{
        return sanphamDAO.TaoMaNN();
    }
    
    // xóa sản phẩm theo idncu
    public static boolean XoaSPtheoIdNCU(String idncu) throws SQLException{
        return sanphamDAO.XoaSPtheoIdNCU(idncu);
    }
}
