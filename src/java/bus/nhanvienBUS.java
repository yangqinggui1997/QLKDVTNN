/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bus;

import java.util.ArrayList;
import dto.nhanvien;
import dao.nhanvienDAO;
import java.sql.SQLException;

/**
 *
 * @author DELL
 */
public class nhanvienBUS {
    
    public static ArrayList<nhanvien> getDSNV() throws Exception{
        return nhanvienDAO.getDSNV();
    }
    
     //lấy danh sách nhân viên thủ kho
    public static ArrayList<nhanvien> getDSNVTK() throws SQLException {
        return nhanvienDAO.getDSNVTK();
    }
    
    //lấy danh sách nhân viên kế toán
    public static ArrayList<nhanvien> getDSNVKT() throws SQLException {
        return nhanvienDAO.getDSNVKT();
    }
    
     //lấy danh sách nhân viên bán hàng
    public static ArrayList<nhanvien> getDSNVBH() throws SQLException {
        return nhanvienDAO.getDSNVBH();
    }
    
    public static nhanvien getNV(String idnv) throws SQLException{
        return nhanvienDAO.getNV(idnv);
    }
    
    public static Boolean ThemNV(nhanvien nv) throws SQLException{
        return nhanvienDAO.ThemNV(nv);
    }
    
    public static Boolean CapnhatNV(nhanvien nv) throws SQLException{
        return nhanvienDAO.CapnhatNV(nv);
    }
    
    public static Boolean XoaNV(String idnv) throws SQLException{
        return nhanvienDAO.XoaNV(idnv);
    }
    
    public static ArrayList<nhanvien> TKNV(String key) throws Exception{
        return nhanvienDAO.TKNV(key);
    }
    
    public static String TaoMNN(Short loainv) throws SQLException{
        return nhanvienDAO.TaoMaNN(loainv);
    }
}
