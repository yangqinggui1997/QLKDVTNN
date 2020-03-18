/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.nguoidung;
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
public class nguoidungDAO {
    //lấy danh sách người dùng
    public static ArrayList<nguoidung> getDSND() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nguoi_dung ORDER BY DATE(NgayTaoTK) DESC, NgayTaoTK DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<nguoidung> list = new ArrayList<>();
        while (rs.next()) {
            nguoidung nd = new nguoidung();
            nd.setIdND(rs.getString("IdND"));
            nd.setIdNV(rs.getString("IdNV"));
            nd.setTenTK(rs.getString("TenTK")); 
            nd.setMK(rs.getString("MK"));
            nd.setNgayTaoTK(Timestamp.valueOf(rs.getTimestamp("NgayTaoTK").toString()));
            nd.setSuaMKLanCuoi(Timestamp.valueOf(rs.getTimestamp("SuaMKLanCuoi").toString()));
            nd.setTrangThai(rs.getShort("TrangThai"));
            nd.setLoaiND(rs.getShort("LoaiND"));
            
            list.add(nd);
        }
        return list;
    }
    
    //Kiểm tra đăng nhập
    public static nguoidung KTTKDN(String username, String PassWord) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nguoi_dung WHERE TenTK = ? and MK = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, username);
        ps.setString(2, PassWord);
        ResultSet rs = ps.executeQuery();
        nguoidung nd = new nguoidung();
        while (rs.next()) {           
            nd.setIdND(rs.getString("IdND"));
            nd.setTenTK(rs.getString("TenTK"));
            nd.setTrangThai(rs.getShort("TrangThai"));
        }
        return nd;
    }
    
    //lấy người dùng theo mã
    public static nguoidung getND(String idnd) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nguoi_dung WHERE IdND = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idnd);
        ResultSet rs = ps.executeQuery();
        nguoidung nd = new nguoidung();
        while (rs.next()) {           
            nd.setIdND(rs.getString("IdND"));
            nd.setIdNV(rs.getString("IdNV"));
            nd.setTenTK(rs.getString("TenTK")); 
            nd.setMK(rs.getString("MK"));
            nd.setNgayTaoTK(Timestamp.valueOf(rs.getTimestamp("NgayTaoTK").toString()));
            nd.setSuaMKLanCuoi(Timestamp.valueOf(rs.getTimestamp("SuaMKLanCuoi").toString()));
            nd.setTrangThai(rs.getShort("TrangThai"));
            nd.setLoaiND(rs.getShort("LoaiND"));
        }
        return nd;
    }
    
    //lấy người dùng theo mã nhân viên
    public static nguoidung getNDtheoIdNV(String idnv) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nguoi_dung WHERE IdNV = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idnv);
        ResultSet rs = ps.executeQuery();
        nguoidung nd = new nguoidung();
        while (rs.next()) {           
            nd.setIdND(rs.getString("IdND"));
            nd.setIdNV(rs.getString("IdNV"));
            nd.setTenTK(rs.getString("TenTK")); 
            nd.setMK(rs.getString("MK"));
            nd.setNgayTaoTK(Timestamp.valueOf(rs.getTimestamp("NgayTaoTK").toString()));
            nd.setSuaMKLanCuoi(Timestamp.valueOf(rs.getTimestamp("SuaMKLanCuoi").toString()));
            nd.setTrangThai(rs.getShort("TrangThai"));
            nd.setLoaiND(rs.getShort("LoaiND"));
        }
        return nd;
    }
    
    //lấy người dùng theo tk
    public static nguoidung getNDtheoTenTK(String tentk) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nguoi_dung WHERE TenTK = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, tentk);
        ResultSet rs = ps.executeQuery();
        nguoidung nd = new nguoidung();
        while (rs.next()) {           
            nd.setIdND(rs.getString("IdND"));           
        }
        return nd;
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemND(nguoidung nd) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "INSERT INTO nguoi_dung VALUES(?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, nd.getIdND());
            ps.setString(2, nd.getIdNV());
            ps.setString(3, nd.getTenTK());
            ps.setString(4, nd.getMK());
            ps.setTimestamp(5, nd.getNgayTaoTK());
            ps.setTimestamp(6, nd.getSuaMKLanCuoi());
            ps.setShort(7, nd.getTrangThai());
            ps.setShort(8, nd.getLoaiND());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    //kiểm tra mật khẩu trước khi đổi
    public static Boolean KTMK(String idnd, String mk) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nguoi_dung WHERE IdND = ? and MK = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idnd);
        ps.setString(2, mk);
        ResultSet rs = ps.executeQuery();
        nguoidung nd = new nguoidung();
        while (rs.next()) {           
            nd.setIdND(rs.getString("IdND"));
        }
        Boolean kq=false;
        if(nd.getIdND() != null){
            kq=true;
        }
        return kq;
    }
    
    // cập nhật mật khẩu
    public static boolean CapnhatMK(String idnd, String mkmoi) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE nguoi_dung SET MK = ?, SuaMKLanCuoi = ? WHERE IdND = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(3, idnd);
            ps.setString(1, mkmoi);
            Timestamp suamklancuoi = new Timestamp(System.currentTimeMillis());
            ps.setTimestamp(2, suamklancuoi);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // cập nhật khoá tài khoản
    public static boolean CapnhatKhoaTK(String idnd, Short khoa) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE nguoi_dung SET TrangThai = ? WHERE IdND = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(2, idnd);
            ps.setShort(1, khoa);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // cập nhật loại ND
    public static boolean CapnhatNhomND(String idnd, Short nnd) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE nguoi_dung SET LoaiND = ?, IdND= ? WHERE IdND = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setShort(1, nnd);
           
            
            Short idmoi;
            switch (nnd) {
                case 1:
                    idmoi=1;
                    break;
                case 2:
                    idmoi=2;
                    break;
                case 3:
                    idmoi=3;
                    break;
                default:
                    idmoi=4;
                    break;
            }
            String mamoi=TaoMaNN(idmoi);
            ps.setString(2, mamoi);
            ps.setString(3, idnd);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // cập nhật mnv
    public static boolean CapnhatIdNV(String idnd, String idnv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE nguoi_dung SET IdNV = ? WHERE IdND = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idnv);
            ps.setString(2, idnd);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // cập nhật mnd khi mnv thay doi
    public static boolean CapnhatIdND(String idndmoi, String idndcu) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE nguoi_dung SET IdND = ? WHERE IdND = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idndmoi);
            ps.setString(2, idndcu);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // xóa dữ liệu
    public static boolean XoaND(String idnd) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM nguoi_dung WHERE IdND = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idnd);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // xóa người dùng theo mã nv
    public static boolean XoaNDtheoIdNV(String idnv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM nguoi_dung WHERE IdNV = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idnv);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    // tìm kiếm
    public static ArrayList<nguoidung> TKND(String key) throws Exception{
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nguoi_dung WHERE (IdND like N'%"+key+"%') or (IdNV like N'%"+key+"%') or (TenTK like N'%"+key+"%') or (DATE_FORMAT(NgayTaoTK, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (DATE_FORMAT(SuaMKLanCuoi, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%')";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<nguoidung> list = new ArrayList<>();
        while (rs.next()) {
            nguoidung nd = new nguoidung();
            nd.setIdND(rs.getString("IdND"));
            nd.setIdNV(rs.getString("IdNV"));
            nd.setTenTK(rs.getString("TenTK")); 
            nd.setMK(rs.getString("MK"));
            nd.setNgayTaoTK(Timestamp.valueOf(rs.getTimestamp("NgayTaoTK").toString()));
            nd.setSuaMKLanCuoi(Timestamp.valueOf(rs.getTimestamp("SuaMKLanCuoi").toString()));
            nd.setTrangThai(rs.getShort("TrangThai"));
            nd.setLoaiND(rs.getShort("LoaiND"));
            list.add(nd);
        }
        return list;
    }
    
    public static String TaoMaNN(Short loaind) throws SQLException{
        Random ran=new Random();
        int ma=ran.nextInt(900000)+100000;
        String kq="";
        switch(loaind){
            case 1: 
                kq="NDQT"+ma;
                Boolean flag=true;
                if(!(getDSND().isEmpty())){
                    while(flag){
                        try {
                            for (nguoidung nd : getDSND()) {
                                if(nd.getIdND().equals(kq)){
                                    ma=ran.nextInt(900000)+100000;
                                    kq="NDQT"+ma;
                                    flag=true;
                                    break;
                                }
                                else{
                                    flag=false;
                                } 
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            break;
            case 2: 
                kq="NDKT"+ma;
                Boolean flag1=true;
                if(!(getDSND().isEmpty())){
                    while(flag1){
                        try {
                            for (nguoidung nd : getDSND()) {
                                if(nd.getIdND().equals(kq)){
                                    ma=ran.nextInt(900000)+100000;
                                    kq="NDKT"+ma;
                                    flag1=true;
                                    break;
                                }
                                else{
                                    flag1=false;
                                } 
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            break;
            case 3: 
                kq="NDBH"+ma; 
                Boolean flag2=true;
                if(!(getDSND().isEmpty())){
                    while(flag2){
                        try {
                            for (nguoidung nd : getDSND()) {
                                if(nd.getIdND().equals(kq)){
                                    ma=ran.nextInt(900000)+100000;
                                    kq="NDBH"+ma;
                                    flag2=true;
                                    break;
                                }
                                else{
                                    flag2=false;
                                } 
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            break;
            case 4: 
                kq="NDTK"+ma;
                Boolean flag3=true;
                if(!(getDSND().isEmpty())){
                    while(flag3){
                        try {
                            for (nguoidung nd : getDSND()) {
                                if(nd.getIdND().equals(kq)){
                                    ma=ran.nextInt(900000)+100000;
                                    kq="NDTK"+ma;
                                    flag3=true;
                                    break;
                                }
                                else{
                                    flag3=false;
                                } 
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(nguoidungDAO.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            break;
            default:
                break;
        }       
        return kq;
    }
}
