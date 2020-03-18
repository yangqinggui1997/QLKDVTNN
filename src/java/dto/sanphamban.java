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
public class sanphamban {
    private String IdSPB;
    private String IdNV;
    private Long TSLBanNgay;
    private Timestamp NgayTK;
    private Timestamp NgayCN;
    
    
    public sanphamban(){}
    
    public sanphamban(String idspb, String idnv, Long tslbanngay, Timestamp ngaytk, Timestamp ngaycn){
        this.IdSPB=idspb;
        this.IdNV=idnv;
        this.TSLBanNgay=tslbanngay;
        this.NgayTK=ngaytk;
        this.NgayCN=ngaycn;
    }

    /**
     * @return the IdSPB
     */
    public String getIdSPB() {
        return IdSPB;
    }

    /**
     * @param IdSPB the IdSPB to set
     */
    public void setIdSPB(String IdSPB) {
        this.IdSPB = IdSPB;
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
     * @return the TSLBanNgay
     */
    public Long getTSLBanNgay() {
        return TSLBanNgay;
    }

    /**
     * @param TSLBanNgay the TSLBanNgay to set
     */
    public void setTSLBanNgay(Long TSLBanNgay) {
        this.TSLBanNgay = TSLBanNgay;
    }

    /**
     * @return the NgayTK
     */
    public Timestamp getNgayTK() {
        return NgayTK;
    }

    /**
     * @param NgayTK the NgayTK to set
     */
    public void setNgayTK(Timestamp NgayTK) {
        this.NgayTK = NgayTK;
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
}
