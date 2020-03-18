/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import dao.nhacungungDAO;
import dto.nhacungung;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author DELL
 */
public class nhacungungBUS {
    
    public static ArrayList<nhacungung> getDSNCU() throws Exception{
        return nhacungungDAO.getDSNCU();
    }
    
    public static nhacungung getNCU(String idncu) throws SQLException{
        return nhacungungDAO.getNCU(idncu);
    }
    
    public static Boolean ThemNCU(nhacungung ncu) throws SQLException{
        return nhacungungDAO.ThemNCU(ncu);
    }
    
    public static Boolean CapnhatNCU(nhacungung ncu) throws SQLException{
        return nhacungungDAO.CapnhatNCU(ncu);
    }
    
    public static Boolean XoaNCU(String idncu) throws SQLException{
        return nhacungungDAO.XoaNCU(idncu);
    }
    
    public static ArrayList<nhacungung> TKNCU(String key) throws Exception{
        return nhacungungDAO.TKNCU(key);
    }
    
    public static String TaoMaNN() throws SQLException{
        return nhacungungDAO.TaoMaNN();
    }
}
