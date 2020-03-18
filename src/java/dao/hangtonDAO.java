/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.hangton;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class hangtonDAO {
    
    //lấy danh sách hàng tồn
    public static ArrayList<hangton> getDSHT() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hangton ORDER BY DATE(NgayTK) DESC, NgayTK DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<hangton> list = new ArrayList<>();
    
        while (rs.next()) {
            hangton ht = new hangton();
            ht.setIdHT(rs.getString("IdHT"));
            ht.setIdNV(rs.getString("IdNV"));
            ht.setNgayTK(Timestamp.valueOf(rs.getTimestamp("NgayTK").toString()));
            ht.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            ht.setTongSLTNgay(rs.getLong("TongSLTNgay"));
            list.add(ht);
        }
        return list;
    }
    
    //lấy hàng tồn theo mã
    public static hangton getHT(String idht) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hangton WHERE IdHT = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idht);
        ResultSet rs = ps.executeQuery();
        hangton ht = new hangton();
        while (rs.next()) {           
            ht.setIdHT(rs.getString("IdHT"));
            ht.setIdNV(rs.getString("IdNV"));
            ht.setNgayTK(Timestamp.valueOf(rs.getTimestamp("NgayTK").toString()));
            ht.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            ht.setTongSLTNgay(rs.getLong("TongSLTNgay"));        
        }
        return ht;
    }
    
    //lấy hàng tồn theo tháng và năm
    public static hangton getHTtheoMonthYear(String month, String year) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hangton WHERE MONTH(NgayTK) = ? and YEAR(NgayTK) = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, month);
        ps.setString(2, year);
        ResultSet rs = ps.executeQuery();
        hangton ht = new hangton();
        while (rs.next()) {           
            ht.setIdHT(rs.getString("IdHT"));
        }
        return ht;
    }
    
    //lấy mã hàng tồn theo mã nhân viên
    public static hangton getHTtheoIdNV(String idnv) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hangton WHERE IdNV = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idnv);
        ResultSet rs = ps.executeQuery();
        hangton ht = new hangton();
        while (rs.next()) {           
            ht.setIdHT(rs.getString("IdHT"));
            ht.setIdNV(rs.getString("IdNV"));
            ht.setNgayTK(Timestamp.valueOf(rs.getTimestamp("NgayTK").toString()));
            ht.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            ht.setTongSLTNgay(rs.getLong("TongSLTNgay"));      
        }
        return ht;
    }

    // thêm mới dữ liệu
    public static Boolean ThemHT(hangton ht) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT SUM(SLNhap) AS SLTon FROM sanpham";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ResultSet rs=ps.executeQuery();
            Long slton = 0L;
            while (rs.next()) {           
                slton=rs.getLong("SLTon");
            }
            
            sql = "INSERT INTO hangton VALUES(?,?,?,?,?)";
            ps = connection.prepareCall(sql);
            ps.setString(1, ht.getIdHT());
            ps.setString(2, ht.getIdNV());
            ps.setLong(3, slton);
            ps.setTimestamp(4, ht.getNgayTK());
            ps.setTimestamp(5, ht.getNgayCN());
            ps.executeUpdate();
            
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hangtonDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatHT(hangton ht) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT SUM(SLNhap) AS SLTon FROM sanpham";
        try {
            PreparedStatement ps = connection.prepareCall(sql);          
            ResultSet rs=ps.executeQuery();
            Long slton = 0L;
            while (rs.next()) {           
                slton=rs.getLong("SLTon");
            }
            
            sql = "UPDATE hangton SET TongSLTNgay = ?, NgayCN = ? WHERE IdHT = ?";
            ps = connection.prepareCall(sql);
            ps.setLong(1, slton);
            ps.setTimestamp(2, ht.getNgayCN());
            ps.setString(3, ht.getIdHT());
            ps.executeUpdate();
            
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hangtonDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // cập nhật dữ liệu khi idv thay doi
    public static boolean CapnhatIdNV(String idht, String idnv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE hangton SET IdNV = ? WHERE IdHT = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            
            ps.setString(1, idnv);
            ps.setString(2, idht);
            
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hangtonDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // xóa dữ liệu
    public static boolean XoaHT(String idht) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hangton WHERE IdHT = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idht);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hangtonDAO.class.getName()).log(Level.SEVERE, null, ex);
             return false;
        }
       
    }
    
    // xóa hang ton theo idnv
    public static boolean XoaHTtheoIdNV(String idnv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hangton WHERE IdNV = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idnv);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hangtonDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    
    // tìm kiếm
    public static ArrayList<hangton> TKHT(String key) throws Exception{
        Connection connection = CommonCommand.getConnection();
         
        String sql = "SELECT * FROM hanton WHERE (IdHT like N'%"+key+"%') or (IdNV like N'%"+key+"%') or (DATE_FORMAT(NgayTK, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (TongSLTNgay like N'%"+key+"%') or (DATE_FORMAT(NgayCN, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%')";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<hangton> list = new ArrayList<>();
        while (rs.next()) {
            hangton ht = new hangton();
            ht.setIdHT(rs.getString("IdHT"));
            ht.setIdNV(rs.getString("IdNV"));
            ht.setNgayTK(Timestamp.valueOf(rs.getTimestamp("NgayTK").toString()));
            ht.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            ht.setTongSLTNgay(rs.getLong("TongSLTNgay"));
            list.add(ht);
        }
        return list;
    }
    
    public static String TaoMaNN() throws SQLException{
        Random ran=new Random();
        int ma=ran.nextInt(90000000)+10000000;
        String kq="HT"+ma;
        Boolean flag=true;
        if(!(getDSHT().isEmpty())){
            while(flag){
                try {
                    for (hangton ht : getDSHT()) {
                        if(ht.getIdHT().equals(kq)){
                            ma=ran.nextInt(90000000)+10000000;
                            kq="HT"+ma;
                            flag=true;
                            break;
                        }
                        else{
                            flag=false;
                        } 
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(hangtonDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }      
        return kq;
    }
}
