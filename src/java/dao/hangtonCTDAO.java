/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.hangtonct;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class hangtonCTDAO {
    
    //lấy danh sách chi tiết
    public static ArrayList<hangtonct> getDSHDNCT() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hangtonct ORDER BY SLTon DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<hangtonct> list = new ArrayList<>();
    
        while (rs.next()) {
            hangtonct htct = new hangtonct();
            htct.setIdHT(rs.getString("IdHT"));
            htct.setIdSP(rs.getString("IdSP"));
            htct.setSLTon(rs.getLong("SLTon"));
            list.add(htct);
        }
        return list;
    }
    
    //lấy danh sách chi tiết theo idht
    public static ArrayList<hangtonct> getDSHDNCTtheoIdHT(String mht) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hangtonct WHERE IdHT = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, mht);
        ResultSet rs = ps.executeQuery();
        ArrayList<hangtonct> list = new ArrayList<>();
    
        while (rs.next()) {
            hangtonct htct = new hangtonct();
            htct.setIdHT(rs.getString("IdHT"));
            htct.setIdSP(rs.getString("IdSP"));
            htct.setSLTon(rs.getLong("SLTon"));
            list.add(htct);
        }
        return list;
    }
    
    //lấy hàng tồn chi tiết theo mã ht và mã sp
    public static hangtonct getHTCT(String idht, String idsp) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hangtonct WHERE IdHT = ? and IdSP = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idht);
        ps.setString(2, idsp);
        ResultSet rs = ps.executeQuery();
        hangtonct htct = new hangtonct();
        while (rs.next()) {           
            htct.setIdHT(rs.getString("IdHT"));
            htct.setIdSP(rs.getString("IdSP"));
            htct.setSLTon(rs.getLong("SLTon"));        
        }
        return htct;
    }
    
    //lấy hàng tồn chi tiết theo mã hàng tồn
    public static hangtonct getHTCTtheoIdHT(String idht) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hangtonct WHERE IdHT = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idht);
        ResultSet rs = ps.executeQuery();
        hangtonct htct = new hangtonct();
        while (rs.next()) {           
            htct.setIdHT(rs.getString("IdHT"));
            htct.setIdSP(rs.getString("IdSP"));
            htct.setSLTon(rs.getLong("SLTon"));   
        }
        return htct;
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemHTCT(String mht) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanpham";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                sql = "INSERT INTO hangtonct VALUES(?,?,?)";
                ps = connection.prepareCall(sql);
                ps.setString(1, mht);
                ps.setString(2, rs.getString("IdSP")); 
                ps.setLong(3, rs.getLong("SLNhap"));
                ps.executeUpdate();
            }
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hangtonCTDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatHTCT(String mht) throws SQLException{
        try {
            XoaHTCTtheoIdHT(mht);
            ThemHTCT(mht);
            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    // xóa hàng tồn ct theo idht
    public static boolean XoaHTCTtheoIdHT(String idht) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hangtonct WHERE IdHT = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idht);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hangtonCTDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    // xóa hàng tồn ct theo idsp
    public static boolean XoaHTCTtheoIdSP(String idsp) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hangtonct WHERE IdSP = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idsp);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hangtonCTDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
}
