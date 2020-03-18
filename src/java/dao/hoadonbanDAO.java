/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.hoadonban;
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
public class hoadonbanDAO {
    
    //lấy danh sách hoá đơn bán
    public static ArrayList<hoadonban> getDSHDB() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hoadonban ORDER BY DATE(NgayLap) DESC, NgayLap DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<hoadonban> list = new ArrayList<>();
    
        while (rs.next()) {
            hoadonban hdb = new hoadonban();
            hdb.setIdHDB(rs.getString("IdHDB"));
            hdb.setIdNV(rs.getString("IdNV"));
            hdb.setNgayLap(Timestamp.valueOf(rs.getTimestamp("NgayLap").toString()));
            hdb.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            hdb.setDaThanhToan(rs.getLong("DaThanhToan"));
            hdb.setTongSL(rs.getLong("TongSL"));
            hdb.setTongTien(rs.getLong("TongTien"));
            hdb.setHinhThucTT(Short.valueOf(rs.getString("HinhThucTT")));
            hdb.setTinhTrang(Short.valueOf(rs.getString("TinhTrang")));
            hdb.setDaNhan(Short.valueOf(rs.getString("DaNhan")));
            hdb.setIdKH(rs.getString("IdKH"));
            list.add(hdb);
        }
        return list;
    }
    
    //lấy hoá đơn bán theo mã
    public static hoadonban getHDB(String idhdb) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hoadonban WHERE IdHDB = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idhdb);
        ResultSet rs = ps.executeQuery();
        hoadonban hdb = new hoadonban();
        while (rs.next()) {           
            hdb.setIdHDB(rs.getString("IdHDB"));
            hdb.setIdNV(rs.getString("IdNV"));
            hdb.setNgayLap(Timestamp.valueOf(rs.getTimestamp("NgayLap").toString()));
            hdb.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            hdb.setDaThanhToan(rs.getLong("DaThanhToan"));
            hdb.setTongSL(rs.getLong("TongSL"));
            hdb.setTongTien(rs.getLong("TongTien"));
            hdb.setHinhThucTT(Short.valueOf(rs.getString("HinhThucTT")));
            hdb.setTinhTrang(Short.valueOf(rs.getString("TinhTrang")));
            hdb.setDaNhan(Short.valueOf(rs.getString("DaNhan")));
            hdb.setIdKH(rs.getString("IdKH"));          
        }
        return hdb;
    }
    
    //lấy mã hoá đơn theo mã nhân viên
    public static hoadonban getHDBtheoIdNV(String idnv) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hoadonban WHERE IdNV = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idnv);
        ResultSet rs = ps.executeQuery();
        hoadonban hdb = new hoadonban();
        while (rs.next()) {           
            hdb.setIdHDB(rs.getString("IdHDB"));
            hdb.setIdNV(rs.getString("IdNV"));
            hdb.setNgayLap(Timestamp.valueOf(rs.getTimestamp("NgayLap").toString()));
            hdb.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            hdb.setDaThanhToan(rs.getLong("DaThanhToan"));
            hdb.setTongSL(rs.getLong("TongSL"));
            hdb.setTongTien(rs.getLong("TongTien"));
            hdb.setHinhThucTT(Short.valueOf(rs.getString("HinhThucTT")));
            hdb.setTinhTrang(Short.valueOf(rs.getString("TinhTrang")));
            hdb.setDaNhan(Short.valueOf(rs.getString("DaNhan")));
            hdb.setIdKH(rs.getString("IdKH"));          
        }
        return hdb;
    }
    
    //lấy hoá đơn bán theo mã khách hàng
    public static hoadonban getHDBtheoIdKH(String idkh) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM hoadonban WHERE IdKH = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idkh);
        ResultSet rs = ps.executeQuery();
        hoadonban hdb = new hoadonban();
        while (rs.next()) {           
            hdb.setIdHDB(rs.getString("IdHDB"));
            hdb.setIdNV(rs.getString("IdNV"));
            hdb.setNgayLap(Timestamp.valueOf(rs.getTimestamp("NgayLap").toString()));
            hdb.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            hdb.setDaThanhToan(rs.getLong("DaThanhToan"));
            hdb.setTongSL(rs.getLong("TongSL"));
            hdb.setTongTien(rs.getLong("TongTien"));
            hdb.setHinhThucTT(Short.valueOf(rs.getString("HinhThucTT")));
            hdb.setTinhTrang(Short.valueOf(rs.getString("TinhTrang")));
            hdb.setDaNhan(Short.valueOf(rs.getString("DaNhan")));
            hdb.setIdKH(rs.getString("IdKH"));          
        }
        return hdb;
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemHDB(hoadonban hdb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "INSERT INTO hoadonban VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, hdb.getIdHDB());
            ps.setString(2, hdb.getIdNV());
            ps.setString(3, hdb.getIdKH());
            ps.setTimestamp(4, hdb.getNgayLap());
            ps.setShort(5, hdb.getHinhThucTT());
            ps.setLong(6, hdb.getDaThanhToan());
            ps.setLong(7, hdb.getTongSL());
            ps.setLong(8, hdb.getTongTien());
            ps.setShort(9, hdb.getTinhTrang());
            ps.setShort(10, hdb.getDaNhan());
            ps.setTimestamp(11, hdb.getNgayCN());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatHDB(hoadonban hdb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE hoadonban SET IdNV = ?, IdKH = ?, HinhThucTT = ?, DaThanhToan = ?, TongSL = ?, TongTien= ?, TinhTrang = ?, NgayCN = ?, DaNhan= ? WHERE IdHDB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, hdb.getIdNV());
            ps.setString(2, hdb.getIdKH());
            ps.setShort(3, hdb.getHinhThucTT());
            ps.setLong(4, hdb.getDaThanhToan());
            ps.setLong(5, hdb.getTongSL());
            ps.setLong(6, hdb.getTongTien());
            ps.setShort(7, hdb.getTinhTrang());
            ps.setTimestamp(8, hdb.getNgayCN());
            ps.setShort(9, hdb.getDaNhan());
            ps.setString(10, hdb.getIdHDB());
            
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // cập nhật dữ liệu khi idnv thay doi
    public static boolean CapnhatIdNV(String idhdb, String idnv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE hoadonban SET IdNV = ? WHERE IdHDB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setString(1, idnv);
            ps.setString(2, idhdb);

            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // cập nhật dữ liệu khi idkh thay doi
    public static boolean CapnhatIdKH(String idhdb, String idkh) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE hoadonban SET IdKH = ? WHERE IdHDB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setString(1, idkh);
            ps.setString(2, idhdb);

            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // xóa dữ liệu
    public static boolean XoaHDB(String idhdb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hoadonban WHERE IdHDB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idhdb);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // xóa hdb theo idnv
    public static boolean XoaHDBtheoIdNV(String idnv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hoadonban WHERE IdNV = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idnv);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // xóa hdb theo idkh
    public static boolean XoaHDBtheoIdKH(String idkh) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM hoadonban WHERE IdKH = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idkh);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // tính tổng số lượng
    public static Boolean TongSLUpdate(String idhdb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT SUM(SL) AS SL FROM hdbchitiet WHERE IdHDB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idhdb);
            ResultSet rs = ps.executeQuery();
             Long sl=0L;
            while (rs.next()) {
               sl=rs.getLong("SL");
            }
            sql = "UPDATE hoadonban SET TongSL = ? WHERE IdHDB = ?";
            ps = connection.prepareCall(sql);
            ps.setLong(1, sl);
            ps.setString(2, idhdb);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    // tính tổng tiền
    public static Boolean TongTienUpdate(String idhdb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT SUM(ThanhTien) AS TT FROM hdbchitiet WHERE IdHDB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idhdb);
            ResultSet rs = ps.executeQuery();
             Long tt=0L;
            while (rs.next()) {
               tt=rs.getLong("TT");
            }
            sql = "UPDATE hoadonban SET TongTien = ? WHERE IdHDB = ?";
            ps = connection.prepareCall(sql);
            ps.setLong(1, tt);
            ps.setString(2, idhdb);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    // tìm kiếm
    public static ArrayList<hoadonban> TKHDB(String key) throws Exception{
        Connection connection = CommonCommand.getConnection();
         
        String sql = "SELECT * FROM hoadonban WHERE (IdHDB like N'%"+key+"%') or (IdNV like N'%"+key+"%') or (IdKH like N'%"+key+"%') or (DATE_FORMAT(NgayLap, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (HinhThucTT like N'%"+key+"%') or (DaThanhToan like N'%"+key+"%') or (TongSL like N'%"+key+"%') or (TongTien like N'%"+key+"%') or (TinhTrang like N'%"+key+"%') or (DATE_FORMAT(NgayCN, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%')";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<hoadonban> list = new ArrayList<>();
        while (rs.next()) {
            hoadonban hdb = new hoadonban();
            hdb.setIdHDB(rs.getString("IdHDB"));
            hdb.setIdNV(rs.getString("IdNV"));
            hdb.setNgayLap(Timestamp.valueOf(rs.getTimestamp("NgayLap").toString()));
            hdb.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            hdb.setDaThanhToan(rs.getLong("DaThanhToan"));
            hdb.setTongSL(rs.getLong("TongSL"));
            hdb.setTongTien(rs.getLong("TongTien"));
            hdb.setHinhThucTT(Short.valueOf(rs.getString("HinhThucTT")));
            hdb.setTinhTrang(Short.valueOf(rs.getString("TinhTrang")));
            hdb.setIdKH(rs.getString("IdKH"));        
            list.add(hdb);
        }
        return list;
    }
    
    public static String TaoMaNN() throws SQLException{
        Random ran=new Random();
        int ma=ran.nextInt(9000000)+1000000;
        String kq="HDB"+ma;
        Boolean flag=true;
        if(!(getDSHDB().isEmpty())){
            while(flag){
                try {
                    for (hoadonban hdb : getDSHDB()) {
                        if(hdb.getIdHDB().equals(kq)){
                            ma=ran.nextInt(9000000)+1000000;
                            kq="HDB"+ma;
                            flag=true;
                            break;
                        }
                        else{
                            flag=false;
                        } 
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(hoadonbanDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }      
        return kq;
    }
}
