/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.sanpham;
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
public class sanphamDAO {
    
    //lấy danh sách sản phẩm
    public static ArrayList<sanpham> getDSSP() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanpham ORDER BY DATE(NgayNhap) DESC, NgayNhap DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<sanpham> list = new ArrayList<>();
    
        while (rs.next()) {
            sanpham sp = new sanpham();
            sp.setIdSP(rs.getString("IdSP"));
            sp.setIdNCU(rs.getString("IdNCU"));
            sp.setTenSP(rs.getString("TenSP"));
            sp.setNgaySX(Timestamp.valueOf(rs.getTimestamp("NgaySX").toString()));
            sp.setNgayHH(Timestamp.valueOf(rs.getTimestamp("NgayHH").toString()));
            sp.setNhaSX(rs.getString("NhaSX"));
            sp.setNgayNhap(Timestamp.valueOf(rs.getTimestamp("NgayNhap").toString()));
            sp.setSLNhap(rs.getInt("SLNhap"));
            sp.setDonGiaNhap(rs.getLong("DonGiaNhap"));
            sp.setDonGiaTienMat(rs.getLong("DonGiaTienMat"));
            sp.setDonGiaThanhToanSau(rs.getLong("DonGiaThanhToanSau"));
            sp.setGiamGia(Short.valueOf(rs.getString("GiamGia")));
            sp.setAnhSP(rs.getString("AnhSP"));
            sp.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));
            list.add(sp);
        }
        return list;
    }
    
    //lấy sản phẩm theo mã
    public static sanpham getSP(String idsp) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanpham WHERE IdSP = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idsp);
        ResultSet rs = ps.executeQuery();
        sanpham sp = new sanpham();
        while (rs.next()) {           
            sp.setIdSP(rs.getString("IdSP"));
            sp.setIdNCU(rs.getString("IdNCU"));
            sp.setTenSP(rs.getString("TenSP"));
            sp.setNgaySX(Timestamp.valueOf(rs.getTimestamp("NgaySX").toString()));
            sp.setNgayHH(Timestamp.valueOf(rs.getTimestamp("NgayHH").toString()));
            sp.setNhaSX(rs.getString("NhaSX"));
            sp.setNgayNhap(Timestamp.valueOf(rs.getTimestamp("NgayNhap").toString()));
            sp.setSLNhap(rs.getInt("SLNhap"));
            
            sp.setDonGiaNhap(rs.getLong("DonGiaNhap"));
            
            sp.setDonGiaTienMat(rs.getLong("DonGiaTienMat"));

            sp.setDonGiaThanhToanSau(rs.getLong("DonGiaThanhToanSau"));
            
            sp.setGiamGia(Short.valueOf(rs.getString("GiamGia")));
            sp.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));          
        }
        return sp;
    }
    
    //lấy sản phẩm theo mã
    public static sanpham getSPtheoIdNCU(String idncu) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanpham WHERE IdNCU = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idncu);
        ResultSet rs = ps.executeQuery();
        sanpham sp = new sanpham();
        while (rs.next()) {           
            sp.setIdSP(rs.getString("IdSP"));
            sp.setIdNCU(rs.getString("IdNCU"));
            sp.setTenSP(rs.getString("TenSP"));
            sp.setNgaySX(Timestamp.valueOf(rs.getTimestamp("NgaySX").toString()));
            sp.setNgayHH(Timestamp.valueOf(rs.getTimestamp("NgayHH").toString()));
            sp.setNhaSX(rs.getString("NhaSX"));
            sp.setNgayNhap(Timestamp.valueOf(rs.getTimestamp("NgayNhap").toString()));
            sp.setSLNhap(rs.getInt("SLNhap"));
            
            sp.setDonGiaNhap(rs.getLong("DonGiaNhap"));
            
            sp.setDonGiaTienMat(rs.getLong("DonGiaTienMat"));

            sp.setDonGiaThanhToanSau(rs.getLong("DonGiaThanhToanSau"));
            
            sp.setGiamGia(Short.valueOf(rs.getString("GiamGia")));
            sp.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));          
        }
        return sp;
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemSP(sanpham sp) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "INSERT INTO sanpham VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, sp.getIdSP());
            ps.setString(2, sp.getIdNCU());
            ps.setString(3, sp.getTenSP());
            ps.setTimestamp(4, sp.getNgaySX());
            ps.setTimestamp(5, sp.getNgayHH());
            ps.setString(6, sp.getNhaSX());  
            ps.setTimestamp(7, sp.getNgayNhap());
            ps.setInt(8, sp.getSLNhap());
            ps.setLong(9, sp.getDonGiaNhap());
            ps.setLong(10, sp.getDonGiaTienMat());
            ps.setLong(11, sp.getDonGiaThanhToanSau());
            ps.setShort(12, sp.getGiamGia());
             ps.setString(13, sp.getAnhSP()); 
            ps.setTimestamp(14, sp.getNgayCN());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphamDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatSP(sanpham sp, Integer htd) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql;
        if(htd == 1){
            sql = "UPDATE sanpham SET IdNCU = ? , TenSP = ?, NgaySX = ?, NgayHH = ?, NhaSX = ?, NgayNhap = ?, SLNhap = ?, DonGiaNhap = ?, DonGiaTienMat = ?, DonGiaThanhToanSau = ?, GiamGia = ?, AnhSP= ?, NgayCN = ? WHERE IdSP = ?";
            try {
                PreparedStatement ps = connection.prepareCall(sql);

                ps.setString(1, sp.getIdNCU());
                ps.setString(2, sp.getTenSP());
                ps.setTimestamp(3, sp.getNgaySX());
                ps.setTimestamp(4, sp.getNgayHH());
                ps.setString(5, sp.getNhaSX()); 
                ps.setTimestamp(6, sp.getNgayNhap());
                ps.setInt(7, sp.getSLNhap());
                ps.setLong(8, sp.getDonGiaNhap());
                ps.setLong(9, sp.getDonGiaTienMat());
                ps.setLong(10, sp.getDonGiaThanhToanSau());
                ps.setShort(11, sp.getGiamGia());
                ps.setString(12, sp.getAnhSP());
                ps.setTimestamp(13, sp.getNgayCN());
                ps.setString(14, sp.getIdSP());

                ps.executeUpdate();
                return true;
            } catch (SQLException ex) {
                Logger.getLogger(sanphamDAO.class.getName()).log(Level.SEVERE, null, ex);
                return false;
            }
        }
        else{
            sql = "UPDATE sanpham SET IdNCU = ? , TenSP = ?, NgaySX = ?, NgayHH = ?, NhaSX = ?, NgayNhap = ?, SLNhap = ?, DonGiaNhap = ?, DonGiaTienMat = ?, DonGiaThanhToanSau = ?, GiamGia = ?, NgayCN = ? WHERE IdSP = ?";
            try {
                PreparedStatement ps = connection.prepareCall(sql);

                ps.setString(1, sp.getIdNCU());
                ps.setString(2, sp.getTenSP());
                ps.setTimestamp(3, sp.getNgaySX());
                ps.setTimestamp(4, sp.getNgayHH());
                ps.setString(5, sp.getNhaSX()); 
                ps.setTimestamp(6, sp.getNgayNhap());
                ps.setInt(7, sp.getSLNhap());
                ps.setLong(8, sp.getDonGiaNhap());
                ps.setLong(9, sp.getDonGiaTienMat());
                ps.setLong(10, sp.getDonGiaThanhToanSau());
                ps.setShort(11, sp.getGiamGia());
                ps.setTimestamp(12, sp.getNgayCN());
                ps.setString(13, sp.getIdSP());

                ps.executeUpdate();
                return true;
            } catch (SQLException ex) {
                Logger.getLogger(sanphamDAO.class.getName()).log(Level.SEVERE, null, ex);
                return false;
            }
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatSLSP(String masp, Integer sl) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql;
        sql = "UPDATE sanpham SET SLNhap = ? WHERE IdSP = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);

            ps.setInt(1, sl);
            ps.setString(2, masp);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphamDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    // xóa dữ liệu
    public static boolean XoaSP(String idsp) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM sanpham WHERE IdSP = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idsp);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphamDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // xóa sản phẩm theo idncu
    public static boolean XoaSPtheoIdNCU(String idncu) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM sanpham WHERE IdNCU = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idncu);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphamDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // tìm kiếm
    public static ArrayList<sanpham> TKSP(String key) throws Exception{
        Connection connection = CommonCommand.getConnection();
         
        String sql = "SELECT * FROM sanpham WHERE (IdSP like N'%"+key+"%') or (IdNCU like N'%"+key+"%') or (TenSP like N'%"+key+"%') or (DATE_FORMAT(NgaySX, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (DATE_FORMAT(NgayHH, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (NhaSX like N'%"+key+"%') or (DATE_FORMAT(NgayNhap, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (SLNhap like N'%"+key+"%') or (DonGiaNhap like N'%"+key+"%') or (DonGiaTienMat like N'%"+key+"%') or (DonGiaThanhToanSau like N'%"+key+"%') or (GiamGia like N'%"+key+"%') or (DATE_FORMAT(NgayCN, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%')";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<sanpham> list = new ArrayList<>();
        while (rs.next()) {
            sanpham sp = new sanpham();
            sp.setIdSP(rs.getString("IdSP"));
            sp.setIdNCU(rs.getString("IdNCU"));
            sp.setTenSP(rs.getString("TenSP"));
            sp.setNgaySX(Timestamp.valueOf(rs.getTimestamp("NgaySX").toString()));
            sp.setNgayHH(Timestamp.valueOf(rs.getTimestamp("NgayHH").toString()));
            sp.setNhaSX(rs.getString("NhaSX"));
            sp.setNgayNhap(Timestamp.valueOf(rs.getTimestamp("NgayNhap").toString()));
            sp.setSLNhap(rs.getInt("SLNhap"));
            sp.setDonGiaNhap(rs.getLong("DonGiaNhap"));
            sp.setDonGiaTienMat(rs.getLong("DonGiaTienMat"));
            sp.setDonGiaThanhToanSau(rs.getLong("DonGiaThanhToanSau"));
            sp.setGiamGia(Short.valueOf(rs.getString("GiamGia")));
            sp.setAnhSP(rs.getString("AnhSP"));
            sp.setNgayCN(Timestamp.valueOf(rs.getTimestamp("NgayCN").toString()));   
            list.add(sp);
        }
        return list;
    }
    
    public static String TaoMaNN() throws SQLException{
        Random ran=new Random();
        int ma=ran.nextInt(90000000)+10000000;
        String kq="SP"+ma;
        Boolean flag=true;
        if(!(getDSSP().isEmpty())){
            while(flag){
                try {
                    for (sanpham sp : getDSSP()) {
                        if(sp.getIdSP().equals(kq)){
                            ma=ran.nextInt(90000000)+10000000;
                            kq="SP"+ma;
                            flag=true;
                            break;
                        }
                        else{
                            flag=false;
                        } 
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(sanphamDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }      
        return kq;
    }
}
