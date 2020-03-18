/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.hoadonbanct;
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
public class hoadonbanCTDAO {
    
    //lấy danh sách hoá đơn bán chi tiết
    public static ArrayList<hoadonbanct> getDSHDBCT() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hdbchitiet ORDER BY SL DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<hoadonbanct> list = new ArrayList<>();
    
        while (rs.next()) {
            hoadonbanct hdbct = new hoadonbanct();
            hdbct.setIdHDB(rs.getString("IdHDB"));
            hdbct.setIdSP(rs.getString("IdSP"));
            hdbct.setSL(Integer.valueOf(rs.getString("SL")));
            hdbct.setDonGia(rs.getLong("DonGia"));
            hdbct.setGiamGia(rs.getShort("GiamGia"));
            hdbct.setThanhTien(rs.getLong("ThanhTien"));
            list.add(hdbct);
        }
        return list;
    }
    
    //lấy danh sách hoá đơn bán chi tiết theo idhdb
    public static ArrayList<hoadonbanct> getDSHDBCTTheoIdHDB(String mhdb) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hdbchitiet WHERE IdHDB = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, mhdb);
        ResultSet rs = ps.executeQuery();
        ArrayList<hoadonbanct> list = new ArrayList<>();
    
        while (rs.next()) {
            hoadonbanct hdbct = new hoadonbanct();
            hdbct.setIdHDB(rs.getString("IdHDB"));
            hdbct.setIdSP(rs.getString("IdSP"));
            hdbct.setSL(Integer.valueOf(rs.getString("SL")));
            hdbct.setDonGia(rs.getLong("DonGia"));
            hdbct.setGiamGia(rs.getShort("GiamGia"));
            hdbct.setThanhTien(rs.getLong("ThanhTien"));
            list.add(hdbct);
        }
        return list;
    }
    
    //lấy hoá đơn bán chi tiết theo mã hoá đơn và mã sp
    public static hoadonbanct getHDBCT(String idhdb, String idsp) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hdbchitiet WHERE IdHDB = ? and IdSP = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idhdb);
        ps.setString(2, idsp);
        ResultSet rs = ps.executeQuery();
        hoadonbanct hdbct = new hoadonbanct();
        while (rs.next()) {           
            hdbct.setIdHDB(rs.getString("IdHDB"));
            hdbct.setIdSP(rs.getString("IdSP"));
            hdbct.setSL(Integer.valueOf(rs.getString("SL")));
            hdbct.setDonGia(rs.getLong("DonGia"));
            hdbct.setGiamGia(rs.getShort("GiamGia"));
            hdbct.setThanhTien(rs.getLong("ThanhTien"));         
        }
        return hdbct;
    }
    
    //lấy hoá đơn bán chi tiết theo mã hoá đơn
    public static hoadonbanct getHDBCTtheoIdHDB(String idhdb) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hdbchitiet WHERE IdHDB = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idhdb);
        ResultSet rs = ps.executeQuery();
        hoadonbanct hdbct = new hoadonbanct();
        while (rs.next()) {           
            hdbct.setIdHDB(rs.getString("IdHDB"));
            hdbct.setIdSP(rs.getString("IdSP"));
            hdbct.setSL(Integer.valueOf(rs.getString("SL")));
            hdbct.setDonGia(rs.getLong("DonGia"));
            hdbct.setGiamGia(rs.getShort("GiamGia"));
            hdbct.setThanhTien(rs.getLong("ThanhTien"));         
        }
        return hdbct;
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemHDBCT(hoadonbanct hdbct) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "INSERT INTO hdbchitiet VALUES(?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, hdbct.getIdHDB());
            ps.setString(2, hdbct.getIdSP());
            ps.setInt(3, hdbct.getSL());
            ps.setLong(4, hdbct.getDonGia());
            ps.setShort(5, hdbct.getGiamGia());
            ps.setLong(6, hdbct.getThanhTien());  
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanCTDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatHDBCT(hoadonbanct hdbct) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE hdbchitiet SET SL = ?, DonGia = ?, GiamGia = ?, ThanhTien = ? WHERE IdHDB = ? and IdSP = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            
            ps.setInt(1, hdbct.getSL());
            ps.setLong(2, hdbct.getDonGia());
            ps.setShort(3, hdbct.getGiamGia());
            ps.setLong(4, hdbct.getThanhTien());
            ps.setString(5, hdbct.getIdHDB());
            ps.setString(6, hdbct.getIdSP()); 
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanCTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // xóa dữ liệu
    public static boolean XoaHDBCT(String idhb, String idsp) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hdbchitiet WHERE IdHDB = ? and IdSP= ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idhb);
            ps.setString(2, idsp);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanCTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // xóa hdbct theo idhdb
    public static boolean XoaHDBCTtheoIdHDB(String idhb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hdbchitiet WHERE IdHDB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idhb);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanCTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // xóa hdbct theo idsp
    public static boolean XoaHDBCTtheoIdSP(String idsp) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hdbchitiet WHERE IdSP= ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idsp);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanCTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
