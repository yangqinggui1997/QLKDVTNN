/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import Common.CommonCommand;
import dto.sanphambanct;
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
public class sanphambanCTDAO {
    
    //lấy danh sách spb chi tiết
    public static ArrayList<sanphambanct> getDSSPBCT() throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanphamct ORDER BY SLBan DESC";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<sanphambanct> list = new ArrayList<>();
    
        while (rs.next()) {
            sanphambanct spbct = new sanphambanct();
            spbct.setIdSPB(rs.getString("IdSPB"));
            spbct.setIdSP(rs.getString("IdSP"));
            spbct.setSLBan(rs.getLong("SLBan")); 
            list.add(spbct);
        }
        return list;
    }
    
    //lấy danh sách spb chi tiết theo mspb
    public static ArrayList<sanphambanct> getDSSPBCTtheoIdSPB(String mspb) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanphamct WHERE IdSPB = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, mspb);
        ResultSet rs = ps.executeQuery();
        ArrayList<sanphambanct> list = new ArrayList<>();
    
        while (rs.next()) {
            sanphambanct spbct = new sanphambanct();
            spbct.setIdSPB(rs.getString("IdSPB"));
            spbct.setIdSP(rs.getString("IdSP"));
            spbct.setSLBan(rs.getLong("SLBan")); 
            list.add(spbct);
        }
        return list;
    }
    
    //lấy spb chi tiết theo mã ht và mã sp
    public static sanphambanct getHTCT(String idspb, String idsp) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanphamct WHERE IdSPB = ? and IdSP = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, idspb);
        ps.setString(2, idsp);
        ResultSet rs = ps.executeQuery();
        sanphambanct spbct = new sanphambanct();
        while (rs.next()) {           
            spbct.setIdSPB(rs.getString("IdSPB"));
            spbct.setIdSP(rs.getString("IdSP"));
            spbct.setSLBan(rs.getLong("SLBan"));        
        }
        return spbct;
    }
    
    //lấy spb chi tiết theo mã spb
    public static sanphambanct getSPBCTtheoIdSPB(String ihspb) throws SQLException {
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT * FROM sanphamct WHERE IdSPB = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, ihspb);
        ResultSet rs = ps.executeQuery();
        sanphambanct spbct = new sanphambanct();
        while (rs.next()) {           
            spbct.setIdSPB(rs.getString("IdSPB"));
            spbct.setIdSP(rs.getString("IdSP"));
            spbct.setSLBan(rs.getLong("SLBan"));   
        }
        return spbct;
    }
    
    // thêm mới dữ liệu
    public static boolean ThemSPBCT(String month, String year, String mspb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "SELECT hdbct.`IdSP`, SUM(hdbct.SL) as SL FROM hdbchitiet hdbct INNER JOIN hoadonban hdb ON hdb.IdHDB=hdbct.IdHDB AND MONTH(hdb.`NgayLap`) = ? AND YEAR(hdb.`NgayLap`) = ? group by hdbct.`IdSP`";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, month);
            ps.setString(2, year);
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                sql = "INSERT INTO sanphamct VALUES(?,?,?)";
                ps = connection.prepareCall(sql);
                ps.setString(1, mspb);
                ps.setString(2, rs.getString("IdSP"));
                ps.setLong(3, rs.getLong("SL"));
                ps.executeUpdate();
            }
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    // thêm mới dữ liệu
    public static boolean CapnhatSPBCT(String month, String year, String mspb) throws SQLException{
        try {
            XoaSPBCTtheoIdSPB(mspb);
            ThemSPBCT(month, year, mspb);
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    // xóa dữ liệu
    public static boolean XoaSPBCT(String idspb, String idsp) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM sanphamct WHERE IdSPB = ? and IdSP = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idspb);
            ps.setString(2, idsp);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanCTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // xóa spbct thep idspb
    public static boolean XoaSPBCTtheoIdSPB(String idspb) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM sanphamct WHERE IdSPB = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idspb);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanCTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    // xóa spbct theo idsp
    public static boolean XoaSPBCTtheoIdSP(String idsp) throws SQLException{
        Connection connection = CommonCommand.getConnection();
        String sql = "DELETE FROM sanphamct WHERE IdSP = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idsp);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(sanphambanCTDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
