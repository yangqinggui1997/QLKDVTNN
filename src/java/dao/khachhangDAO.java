/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.khachhang;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class khachhangDAO {
    
    //lấy danh sách khách hàng
    public static ArrayList<khachhang> getDSKH() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM khachhang ORDER BY DATE(NgaySinh) DESC, NgaySinh DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<khachhang> list = new ArrayList<>();
    
        while (rs.next()) {
            khachhang kh = new khachhang();
            kh.setTenKH(rs.getString("TenKH"));
            kh.setEmail(rs.getString("Email"));
            kh.setNgaySinh(Timestamp.valueOf(rs.getTimestamp("NgaySinh").toString())); 
            kh.setGioiTinh(rs.getShort("GioiTinh"));
            kh.setSoCMND(rs.getString("SoCMND"));
            kh.setSDT(rs.getString("SDT"));
            kh.setDiaChi(rs.getString("DiaChi"));
            kh.setLoaiKH(Short.valueOf(rs.getString("LoaiKH")));
            kh.setDanhGia(rs.getString("DanhGia"));
            list.add(kh);
        }
        return list;
    }
    
    //lấy khách hàng theo mã
    public static khachhang getKH(String idkh) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM khachhang WHERE SoCMND = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idkh);
        ResultSet rs = ps.executeQuery();
        khachhang kh = new khachhang();
        while (rs.next()) {           
            kh.setTenKH(rs.getString("TenKH"));
            kh.setEmail(rs.getString("Email"));
            kh.setNgaySinh(Timestamp.valueOf(rs.getTimestamp("NgaySinh").toString())); 
            kh.setGioiTinh(rs.getShort("GioiTinh"));
            kh.setSoCMND(rs.getString("SoCMND"));
            kh.setSDT(rs.getString("SDT"));
            kh.setDiaChi(rs.getString("DiaChi"));
            kh.setLoaiKH(Short.valueOf(rs.getString("LoaiKH")));
            kh.setDanhGia(rs.getString("DanhGia"));          
        }
        return kh;
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemKH(khachhang kh) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "INSERT INTO khachhang VALUES(?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, kh.getTenKH());
            ps.setTimestamp(2, kh.getNgaySinh());
            ps.setShort(3, kh.getGioiTinh());
            ps.setString(4, kh.getSoCMND());
            ps.setString(5, kh.getSDT());
            ps.setString(6, kh.getEmail());
            ps.setString(7, kh.getDiaChi());
            ps.setShort(8, kh.getLoaiKH());  
            ps.setString(9, kh.getDanhGia());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(khachhangDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatKH(khachhang kh) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE khachhang SET TenKH = ? , NgaySinh = ?, GioiTinh = ?, Email = ?, SDT = ?, DiaChi = ?, LoaiKH= ?, DanhGia = ? WHERE SoCMND = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            
            ps.setString(1, kh.getTenKH());
            ps.setTimestamp(2, kh.getNgaySinh());
            ps.setShort(3, kh.getGioiTinh());
            ps.setString(4, kh.getEmail());
            ps.setString(5, kh.getSDT());
            ps.setString(6, kh.getDiaChi());
            ps.setShort(7, kh.getLoaiKH());  
            ps.setString(8, kh.getDanhGia());
            ps.setString(9, kh.getSoCMND());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(khachhangDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // xóa dữ liệu
    public static boolean XoaKH(String idkh) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM khachhang WHERE SoCMND = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idkh);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(khachhangDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // tìm kiếm
    public static ArrayList<khachhang> TKKH(String key) throws Exception{
        Connection connection = CommonCommand.getConnection();
         
        String sql = "SELECT * FROM khachhang WHERE (Email like N'%"+key+"%') or (TenKH like N'%"+key+"%') or (DATE_FORMAT(NgaySinh, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (GioiTinh like N'%"+key+"%') or (SoCMND like N'%"+key+"%') or (DiaChi like N'%"+key+"%') or (LoaiKH like N'%"+key+"%') or (DanhGia like N'%"+key+"%') or (SDT like N'%"+key+"%')";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<khachhang> list = new ArrayList<>();
        while (rs.next()) {
            khachhang kh = new khachhang();
            kh.setTenKH(rs.getString("TenKH"));
            kh.setEmail(rs.getString("Email"));
            kh.setNgaySinh(Timestamp.valueOf(rs.getTimestamp("NgaySinh").toString())); 
            kh.setGioiTinh(rs.getShort("GioiTinh"));
            kh.setSoCMND(rs.getString("SoCMND"));
            kh.setSDT(rs.getString("SDT"));
            kh.setDiaChi(rs.getString("DiaChi"));
            kh.setLoaiKH(Short.valueOf(rs.getString("LoaiKH")));
            kh.setDanhGia(rs.getString("DanhGia"));       
            list.add(kh);
        }
        return list;
    }
    
}
