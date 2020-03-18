/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;


/**
 *
 * @author DELL
 */
public class hoadonbanct {
    private String IdHDB;
    private String IdSP;
    private Integer SL;
    private Long DonGia;
    private Short GiamGia;
    private Long ThanhTien;
    
    
    public hoadonbanct(){}
    
    public hoadonbanct(String idhdb, String idsp, Integer sl, Long DonGia, Short giamgia, Long thanhtien){
        this.IdHDB=idhdb;
        this.IdSP=idsp;
        this.SL=sl;
        this.DonGia=DonGia;
        this.GiamGia=giamgia;
        this.ThanhTien=thanhtien;
        
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
    public void setIdHDB(String IdHDB) {
        this.IdHDB = IdHDB;
    }

    /**
     * @return the IdSP
     */
    public String getIdSP() {
        return IdSP;
    }

    /**
     * @param IdSP the IdSP to set
     */
    public void setIdSP(String IdSP) {
        this.IdSP = IdSP;
    }

    /**
     * @return the SL
     */
    public Integer getSL() {
        return SL;
    }

    /**
     * @param SL the SL to set
     */
    public void setSL(Integer SL) {
        this.SL = SL;
    }

    /**
     * @return the DonGia
     */
    public Long getDonGia() {
        return DonGia;
    }

    /**
     * @param DonGia the DonGia to set
     */
    public void setDonGia(Long DonGia) {
        this.DonGia = DonGia;
    }

    /**
     * @return the GiamGia
     */
    public Short getGiamGia() {
        return GiamGia;
    }

    /**
     * @param GiamGia the GiamGia to set
     */
    public void setGiamGia(Short GiamGia) {
        this.GiamGia = GiamGia;
    }

    /**
     * @return the ThanhTien
     */
    public Long getThanhTien() {
        return ThanhTien;
    }

    /**
     * @param ThanhTien the ThanhTien to set
     */
    public void setThanhTien(Long ThanhTien) {
        this.ThanhTien = ThanhTien;
    }
}
