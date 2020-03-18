/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.nhacungung;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class nhacungungDAO {
    
    //lấy danh sách nhà cung ứng
    public static ArrayList<nhacungung> getDSNCU() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nhacungung ORDER BY QuyMo DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<nhacungung> list = new ArrayList<>();
    
        while (rs.next()) {
            nhacungung ncu = new nhacungung();
            ncu.setIdNCU(rs.getString("IdNCU"));
            ncu.setTenNCU(rs.getString("TenNCU"));
            ncu.setEmail(rs.getString("Email"));
            ncu.setSDT(rs.getString("SDT"));
            ncu.setDiaChi(rs.getString("DiaChi"));
            ncu.setQuyMo(Short.valueOf(rs.getString("QuyMo")));
            ncu.setDanhGia(rs.getString("DanhGia"));
            list.add(ncu);
        }
        return list;
    }
    
    //lấy nhà cung ứng theo mã
    public static nhacungung getNCU(String idncu) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM nhacungung WHERE IdNCU = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idncu);
        ResultSet rs = ps.executeQuery();
        nhacungung ncu = new nhacungung();
        while (rs.next()) {           
            ncu.setIdNCU(rs.getString("IdNCU"));
            ncu.setTenNCU(rs.getString("TenNCU"));
            ncu.setEmail(rs.getString("Email"));
            ncu.setSDT(rs.getString("SDT"));
            ncu.setDiaChi(rs.getString("DiaChi"));
            ncu.setQuyMo(Short.valueOf(rs.getString("QuyMo")));
            ncu.setDanhGia(rs.getString("DanhGia"));          
        }
        return ncu;
    }
    
    // thêm mới dữ liệu
    public static Boolean ThemNCU(nhacungung ncu) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "INSERT INTO nhacungung VALUES(?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, ncu.getIdNCU());
            ps.setString(2, ncu.getTenNCU());
            ps.setString(3, ncu.getDiaChi());
            ps.setString(4, ncu.getSDT());
            ps.setString(5, ncu.getEmail());
            ps.setShort(6, ncu.getQuyMo());  
            ps.setString(7, ncu.getDanhGia());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nhacungungDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    // cập nhật dữ liệu
    public static boolean CapnhatNCU(nhacungung ncu) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "UPDATE nhacungung SET TenNCU = ? , DiaChi = ?, SDT = ?, Email = ?, QuyMo = ?, DanhGia = ? WHERE IdNCU = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            
            ps.setString(1, ncu.getTenNCU());
            ps.setString(2, ncu.getDiaChi());
            ps.setString(3, ncu.getSDT());
            ps.setString(4, ncu.getEmail());
            ps.setShort(5, ncu.getQuyMo());
            ps.setString(6, ncu.getDanhGia());
            ps.setString(7, ncu.getIdNCU());  
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nhacungungDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // xóa dữ liệu
    public static boolean XoaNCU(String idncu) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM nhacungung WHERE IdNCU = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idncu);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(nhanvienDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // tìm kiếm
    public static ArrayList<nhacungung> TKNCU(String key) throws Exception{
        Connection connection = CommonCommand.getConnection();
         
        String sql = "SELECT * FROM nhacungung WHERE (Email like N'%"+key+"%') or (TenNCU like N'%"+key+"%') or (IdNCU like N'%"+key+"%') or (DiaChi like N'%"+key+"%') or (QuyMo like N'%"+key+"%') or (DanhGia like N'%"+key+"%') or (SDT like N'%"+key+"%')";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<nhacungung> list = new ArrayList<>();
        while (rs.next()) {
            nhacungung ncu = new nhacungung();
            ncu.setIdNCU(rs.getString("IdNCU"));
            ncu.setTenNCU(rs.getString("TenNCU"));
            ncu.setEmail(rs.getString("Email"));
            ncu.setSDT(rs.getString("SDT"));
            ncu.setDiaChi(rs.getString("DiaChi"));
            ncu.setQuyMo(Short.valueOf(rs.getString("QuyMo")));
            ncu.setDanhGia(rs.getString("DanhGia"));       
            list.add(ncu);
        }
        return list;
    }
    
    public static String TaoMaNN() throws SQLException{
        Random ran=new Random();
        int ma=ran.nextInt(9000000)+1000000;
        String kq="NCU"+ma;
        Boolean flag=true;
        if(!(getDSNCU().isEmpty())){
            while(flag){
                try {
                    for (nhacungung ncu : getDSNCU()) {
                        if(ncu.getIdNCU().equals(kq)){
                            ma=ran.nextInt(9000000)+1000000;
                            kq="NCU"+ma;
                            flag=true;
                            break;
                        }
                        else{
                            flag=false;
                        } 
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(nhacungungDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }      
        return kq;
    }
}
