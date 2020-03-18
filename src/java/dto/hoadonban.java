/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.sql.Timestamp;


/**
 *
 * @author DELL
 */
public class hoadonban {
    private String IdHDB;
    private String IdNV;
    private String IdKH;
    private Timestamp NgayLap;
    private Short HinhThucTT;
    private Long DaThanhToan;
    private Long TongSL;
    private Long TongTien;
    private Short TinhTrang;
    private Short DaNhan;
    private Timestamp NgayCN;
    
    public hoadonban(){}
    
    public hoadonban(String idhdb, String idnv, String idkh, Timestamp ngaylap, Short hinhthuctt, Long dathanhtoan, Long tongsl, Long tongtien, Short tinhtrang, Short danhan, Timestamp ngaycn){
        this.IdHDB=idhdb;
        this.IdNV=idnv;
        this.IdKH=idkh;
        this.NgayLap=ngaylap;
        this.HinhThucTT=hinhthuctt;
        this.TongSL=tongsl;
        this.DaThanhToan=dathanhtoan;
        this.TongTien=tongtien;
        this.TinhTrang=tinhtrang;
        this.DaNhan=danhan;
        this.NgayCN=ngaycn;
    }

    /**
     * @return the IdHDB
     */
    public String getIdHDB() {
        return IdHDB;
    }

    /**
     * @param IdHDB the IdHDB to set
     */
    public final void setIdHDB(String IdHDB) {
        this.IdHDB = IdHDB;
    }

    /**
     * @return the IdNV
     */
    public String getIdNV() {
        return IdNV;
    }

    /**
     * @param IdNV the IdNV to set
     */
    public void setIdNV(String IdNV) {
        this.IdNV = IdNV;
    }

    /**
     * @return the IdKH
     */
    public String getIdKH() {
        return IdKH;
    }

    /**
     * @param IdKH the IdKH to set
     */
    public void setIdKH(String IdKH) {
        this.IdKH = IdKH;
    }

    /**
     * @return the NgayLap
     */
    public Timestamp getNgayLap() {
        return NgayLap;
    }

    /**
     * @param NgayLap the NgayLap to set
     */
    public void setNgayLap(Timestamp NgayLap) {
        this.NgayLap = NgayLap;
    }

    /**
     * @return the HinhThucTT
     */
    public Short getHinhThucTT() {
        return HinhThucTT;
    }

    /**
     * @param HinhThucTT the HinhThucTT to set
     */
    public void setHinhThucTT(Short HinhThucTT) {
        this.HinhThucTT = HinhThucTT;
    }

    /**
     * @return the DaThanhToan
     */
    public Long getDaThanhToan() {
        return DaThanhToan;
    }

    /**
     * @param DaThanhToan the DaThanhToan to set
     */
    public void setDaThanhToan(Long DaThanhToan) {
        this.DaThanhToan = DaThanhToan;
    }

    /**
     * @return the TongSL
     */
    public Long getTongSL() {
        return TongSL;
    }

    /**
     * @param TongSL the TongSL to set
     */
    public void setTongSL(Long TongSL) {
        this.TongSL = TongSL;
    }

    /**
     * @return the TongTien
     */
    public Long getTongTien() {
        return TongTien;
    }

    /**
     * @param TongTien the TongTien to set
     */
    public void setTongTien(Long TongTien) {
        this.TongTien = TongTien;
    }

    /**
     * @return the TinhTrang
     */
    public Short getTinhTrang() {
        return TinhTrang;
    }

    /**
     * @param TinhTrang the TinhTrang to set
     */
    public void setTinhTrang(Short TinhTrang) {
        this.TinhTrang = TinhTrang;
    }

    /**
     * @return the NgayCN
     */
    public Timestamp getNgayCN() {
        return NgayCN;
    }

    /**
     * @param NgayCN the NgayCN to set
     */
    public void setNgayCN(Timestamp NgayCN) {
        this.NgayCN = NgayCN;
    }

    /**
     * @return the DaNhan
     */
    public Short getDaNhan() {
        return DaNhan;
    }

    /**
     * @param DaNhan the DaNhan to set
     */
    public void setDaNhan(Short DaNhan) {
        this.DaNhan = DaNhan;
    }
}
