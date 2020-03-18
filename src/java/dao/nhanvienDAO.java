/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
 
package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import dto.nhanvien;
import java.util.Random;
import Common.CommonCommand;
import java.sql.Timestamp;

public class nhanvienDAO {

    //lấy danh sách nhân viên
    public static ArrayList<nhanvien> getDSNV() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nhanvien ORDER BY DATE(NgayVaoLam) DESC, NgayVaoLam DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<nhanvien> list = new ArrayList<>();
    
        while (rs.next()) {
            nhanvien nv = new nhanvien();
            nv.setIdNV(rs.getString("IdNV"));
            nv.setTenNV(rs.getString("TenNV"));
            nv.setNgaySinh(Timestamp.valueOf(rs.getTimestamp("NgaySinh").toString())); 
            nv.setGioiTinh(rs.getShort("GioiTinh"));
            nv.setSoCMND(rs.getString("SoCMND"));
            nv.setSDT(rs.getString("SDT"));
            nv.setDiaChi(rs.getString("DiaChi"));
            nv.setChucVu(Short.valueOf(rs.getString("ChucVu")));
            nv.setNgayVaoLam(Timestamp.valueOf(rs.getTimestamp("NgayVaoLam").toString()));
            list.add(nv);
        }
        return list;
    }
    
     //lấy danh sách nhân viên bán hàng
    public static ArrayList<nhanvien> getDSNVBH() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nhanvien WHERE IdNV like N'%NVBH%'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<nhanvien> list = new ArrayList<>();
    
        while (rs.next()) {
            nhanvien nv = new nhanvien();
            nv.setIdNV(rs.getString("IdNV"));
            nv.setTenNV(rs.getString("TenNV"));
            list.add(nv);
        }
        return list;
    }
    
    //lấy danh sách nhân viên kế toán
    public static ArrayList<nhanvien> getDSNVKT() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nhanvien WHERE IdNV like N'%NVKT%'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<nhanvien> list = new ArrayList<>();
    
        while (rs.next()) {
            nhanvien nv = new nhanvien();
            nv.setIdNV(rs.getString("IdNV"));
            nv.setTenNV(rs.getString("TenNV"));
            list.add(nv);
        }
        return list;
    }
    
    //lấy danh sách nhân viên thủ kho
    public static ArrayList<nhanvien> getDSNVTK() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nhanvien WHERE IdNV like N'%NVTK%'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<nhanvien> list = new ArrayList<>();
    
        while (rs.next()) {
            nhanvien nv = new nhanvien();
            nv.setIdNV(rs.getString("IdNV"));
            nv.setTenNV(rs.getString("TenNV"));
            list.add(nv);
        }
        return list;
    }
    
    //lấy nhân viên theo mã
    public static nhanvien getNV(String idnv) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nhanvien WHERE IdNV = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idnv);
        ResultSet rs = ps.executeQuery();
        nhanvien nv = new nhanvien();
        while (rs.next()) {           
            nv.setIdNV(rs.getString("IdNV"));
            nv.setTenNV(rs.getString("TenNV"));
            nv.setNgaySinh(Timestamp.valueOf(rs.getTimestamp("NgaySinh").toString())); 
            nv.setGioiTinh(rs.getShort("GioiTinh"));
            nv.setSoCMND(rs.getString("SoCMND"));
            nv.setSDT(rs.getString("SDT"));
            nv.setDiaChi(rs.getString("DiaChi"));
            nv.setChucVu(Short.valueOf(rs.getString("ChucVu")));
            nv.setNgayVaoLam(Timestamp.valueOf(rs.getTimestamp("NgayVaoLam").toString()));            
        }
        return nv;
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemNV(nhanvien nv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "INSERT INTO nhanvien VALUES(?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, nv.getIdNV());
            ps.setString(2, nv.getTenNV());
            ps.setTimestamp(3, nv.getNgaySinh());
            ps.setShort(4, nv.getGioiTinh());
            ps.setString(5, nv.getSoCMND());
            ps.setString(6, nv.getSDT());
            ps.setString(7, nv.getDiaChi());
            ps.setShort(8, nv.getChucVu());  
            ps.setTimestamp(9, nv.getNgayVaoLam());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nhanvienDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatNV(nhanvien nv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE nhanvien SET TenNV = ? , NgaySinh = ?, GioiTinh = ?, SoCMND = ?, SDT = ?, DiaChi = ?, ChucVu= ?, NgayVaoLam = ? WHERE IdNV = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            
            ps.setString(1, nv.getTenNV());
            ps.setTimestamp(2, nv.getNgaySinh());
            ps.setShort(3, nv.getGioiTinh());
            ps.setString(4, nv.getSoCMND());
            ps.setString(5, nv.getSDT());
            ps.setString(6, nv.getDiaChi());
            ps.setShort(7, nv.getChucVu());  
            ps.setTimestamp(8, nv.getNgayVaoLam());
            ps.setString(9, nv.getIdNV());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nhanvienDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // xóa dữ liệu
    public static boolean XoaNV(String idnv) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        //xoá nhân viên trên thống kê hàng tồn
        String sql = "DELETE FROM nhanvien WHERE IdNV = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idnv);
            ps.executeUpdate();
            
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nhanvienDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // tìm kiếm
    public static ArrayList<nhanvien> TKNV(String key) throws Exception{
        Connection connection = CommonCommand.getConnection();
         
        String sql = "SELECT * FROM nhanvien WHERE (IdNV like N'%"+key+"%') or (TenNV like N'%"+key+"%') or (DATE_FORMAT(NgaySinh, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (GioiTinh like N'%"+key+"%') or (SoCMND like N'%"+key+"%') or (DiaChi like N'%"+key+"%') or (ChucVu like N'%"+key+"%') or (DATE_FORMAT(NgayVaoLam, '%d/%m/%Y %h:%i:%s %p') like N'%"+key+"%') or (SDT like N'%"+key+"%')";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<nhanvien> list = new ArrayList<>();
        while (rs.next()) {
            nhanvien nv = new nhanvien();
            nv.setIdNV(rs.getString("IdNV"));
            nv.setTenNV(rs.getString("TenNV"));
            nv.setNgaySinh(Timestamp.valueOf(rs.getTimestamp("NgaySinh").toString())); 
            nv.setGioiTinh(rs.getShort("GioiTinh"));
            nv.setSoCMND(rs.getString("SoCMND"));
            nv.setSDT(rs.getString("SDT"));
            nv.setDiaChi(rs.getString("DiaChi"));
            nv.setChucVu(Short.valueOf(rs.getString("ChucVu")));
            nv.setNgayVaoLam(Timestamp.valueOf(rs.getTimestamp("NgayVaoLam").toString()));
            list.add(nv);
        }
        return list;
    }
    
    public static String TaoMaNN(Short loainv) throws SQLException{
        Random ran=new Random();
        int ma=ran.nextInt(900000)+100000;
        String kq="";
        switch(loainv){
            case 1: 
                kq="NVQT"+ma;
                Boolean flag=true;
                if(!(getDSNV().isEmpty())){
                    while(flag){
                        try {
                            for (nhanvien nv : getDSNV()) {
                                if(nv.getIdNV().equals(kq)){
                                    ma=ran.nextInt(900000)+100000;
                                    kq="NVQT"+ma;
                                    flag=true;
                                    break;
                                }
                                else{
                                    flag=false;
                                } 
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(nhanvienDAO.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            break;
            case 2: 
                kq="NVKT"+ma;
                Boolean flag1=true;
                if(!(getDSNV().isEmpty())){
                    while(flag1){
                        try {
                            for (nhanvien nv : getDSNV()) {
                                if(nv.getIdNV().equals(kq)){
                                    ma=ran.nextInt(900000)+100000;
                                    kq="NVKT"+ma;
                                    flag1=true;
                                    break;
                                }
                                else{
                                    flag1=false;
                                } 
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(nhanvienDAO.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            break;
            case 3: 
                kq="NVBH"+ma; 
                Boolean flag2=true;
                if(!(getDSNV().isEmpty())){
                    while(flag2){
                        try {
                            for (nhanvien nv : getDSNV()) {
                                if(nv.getIdNV().equals(kq)){
                                    ma=ran.nextInt(900000)+100000;
                                    kq="NVBH"+ma;
                                    flag2=true;
                                    break;
                                }
                                else{
                                    flag2=false;
                                } 
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(nhanvienDAO.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            break;
            case 4: 
                kq="NVTK"+ma;
                Boolean flag3=true;
                if(!(getDSNV().isEmpty())){
                    while(flag3){
                        try {
                            for (nhanvien nv : getDSNV()) {
                                if(nv.getIdNV().equals(kq)){
                                    ma=ran.nextInt(900000)+100000;
                                    kq="NVTK"+ma;
                                    flag3=true;
                                    break;
                                }
                                else{
                                    flag3=false;
                                } 
                            }
                        } catch (SQLException ex) {
                            Logger.getLogger(nhanvienDAO.class.getName()).log(Level.SEVERE, null, ex);
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