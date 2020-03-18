/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.sanphamban;
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
public class sanphambanDAO {
    
    //lấy danh sách spb
    public static ArrayList<sanphamban> getDSSPB() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanphamban ORDER BY DATE(NgayTK) DESC, NgayTK DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<sanphamban> list = new ArrayList<>();
    
        while (rs.next()) {
            sanphamban spb = new sanphamban();
            spb.setIdSPB(rs.getString("IdSPB"));
            spb.setIdNV(rs.getString("IdNV"));
            spb.setNgayTK(Timestamp.valueOf(rs.getTimestamp("NgayTK").toString()));
            spb.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            spb.setTSLBanNgay(rs.getLong("TSLBanNgay"));
            list.add(spb);
        }
        return list;
    }
    
    //lấy spb theo mã
    public static sanphamban getSPB(String idspb) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanphamban WHERE IdSPB = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idspb);
        ResultSet rs = ps.executeQuery();
        sanphamban spb = new sanphamban();
        while (rs.next()) {           
            spb.setIdSPB(rs.getString("IdSPB"));
            spb.setIdNV(rs.getString("IdNV"));
            spb.setNgayTK(Timestamp.valueOf(rs.getTimestamp("NgayTK").toString()));
            spb.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            spb.setTSLBanNgay(rs.getLong("TSLBanNgay"));    
        }
        return spb;
    }
    
    //lấy hàng tồn theo tháng và năm
    public static sanphamban getSPBtheoMonthYear(String month, String year) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanphamban WHERE MONTH(NgayTK) = ? and YEAR(NgayTK) = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, month);
        ps.setString(2, year);
        ResultSet rs = ps.executeQuery();
        sanphamban spb = new sanphamban();
        while (rs.next()) {           
            spb.setIdSPB(rs.getString("IdSPB"));
        }
        return spb;
    }
    
    //lấy mã spb theo mã nhân viên
    public static sanphamban getSPBtheoIdNV(String idnv) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanphamban WHERE IdNV = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idnv);
        ResultSet rs = ps.executeQuery();
        sanphamban spb = new sanphamban();
        while (rs.next()) {           
            spb.setIdSPB(rs.getString("IdSPB"));
            spb.setIdNV(rs.getString("IdNV"));
            spb.setNgayTK(Timestamp.valueOf(rs.getTimestamp("NgayTK").toString()));
            spb.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            spb.setTSLBanNgay(rs.getLong("TSLBanNgay"));          
        }
        return spb;
    }

    // thêm mới dữ liệu
    public static boolean ThemSPB(String month, String year, sanphamban spb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT SUM(hdbct.SL) as TSL FROM hdbchitiet hdbct INNER JOIN hoadonban hdb ON hdb.IdHDB=hdbct.IdHDB AND MONTH(hdb.`NgayLap`) = ? AND YEAR(hdb.`NgayLap`) = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, month);
            ps.setString(2, year);
            ResultSet rs=ps.executeQuery();
            Long slban = 0L;
            while (rs.next()) {           
                slban=rs.getLong("TSL");
            }
            sql = "INSERT INTO sanphamban VALUES(?,?,?,?,?)";
            ps = connection.prepareCall(sql);
            ps.setString(1, spb.getIdSPB());
            ps.setString(2, spb.getIdNV());
            ps.setLong(3, slban);
            ps.setTimestamp(4, spb.getNgayTK());
            ps.setTimestamp(5, spb.getNgayCN());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatSPB(String month, String year, sanphamban spb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT SUM(hdbct.SL) as TSL FROM hdbchitiet hdbct INNER JOIN hoadonban hdb ON hdb.IdHDB=hdbct.IdHDB AND MONTH(hdb.`NgayLap`) = ? AND YEAR(hdb.`NgayLap`) = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, month);
            ps.setString(2, year);
            ResultSet rs=ps.executeQuery();
            Long slban = 0L;
            while (rs.next()) {           
                slban=rs.getLong("TSL");
            }
            sql = "UPDATE sanphamban SET TSLBanNgay = ?, NgayCN = ? WHERE IdSPB = ?";
            ps = connection.prepareCall(sql);
            ps.setLong(1, slban);
            ps.setTimestamp(2, spb.getNgayCN());
            ps.setString(3, spb.getIdSPB());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }

    // cập nhật idnv
    public static boolean CapnhatIdNV(String idspb, String idnv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE sanphamban SET IdNV = ? WHERE IdSPB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setString(1, idnv);
            ps.setString(2, idspb);

            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // xóa dữ liệu
    public static boolean XoaSPB(String idspb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM sanphamban WHERE IdSPB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idspb);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // xóa spb theo idnv
    public static boolean XoaSPBtheoIdNV(String idnv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM sanphamban WHERE IdNV = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idnv);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // tìm kiếm
    public static ArrayList<sanphamban> TKSPB(String key) throws Exception{
        Connection connection = CommonCommand.getConnection();
         
        String sql = "SELECT * FROM sanphamban WHERE (IdSPB like N'%"+key+"%') or (IdNV like N'%"+key+"%') or (DATE_FORMAT(NgayTK, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (TSLBanNgay like N'%"+key+"%') or (DATE_FORMAT(NgayCN, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%')";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<sanphamban> list = new ArrayList<>();
        while (rs.next()) {
            sanphamban spb = new sanphamban();
            spb.setIdSPB(rs.getString("IdSPB"));
            spb.setIdNV(rs.getString("IdNV"));
            spb.setNgayTK(Timestamp.valueOf(rs.getTimestamp("NgayTK").toString()));
            spb.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            spb.setTSLBanNgay(rs.getLong("TSLBanNgay"));
            list.add(spb);
        }
        return list;
    }
    
    public static String TaoMaNN() throws SQLException{
        Random ran=new Random();
        int ma=ran.nextInt(9000000)+1000000;
        String kq="SPB"+ma;
        Boolean flag=true;
        if(!(getDSSPB().isEmpty())){
            while(flag){
                try {
                    for (sanphamban spb : getDSSPB()) {
                        if(spb.getIdSPB().equals(kq)){
                            ma=ran.nextInt(9000000)+1000000;
                            kq="SPB"+ma;
                            flag=true;
                            break;
                        }
                        else{
                            flag=false;
                        } 
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(sanphambanDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }      
        return kq;
    }
}
