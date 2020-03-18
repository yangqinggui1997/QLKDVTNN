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
public class hangton {
    private String IdHT;
    private String IdNV;
    private Long TongSLTNgay;
    private Timestamp NgayTK;
    private Timestamp NgayCN;
    
    
    public hangton(){}
    
    public hangton(String idht, String idnv, Long tongsltngay, Timestamp ngaytk, Timestamp ngaycn){
        this.IdHT=idht;
        this.IdNV=idnv;
        this.TongSLTNgay=tongsltngay;
        this.NgayTK=ngaytk;
        this.NgayCN=ngaycn;
    }

    /**
     * @return the IdHT
     */
    public String getIdHT() {
        return IdHT;
    }

    /**
     * @param IdHT the IdHT to set
     */
    public void setIdHT(String IdHT) {
        this.IdHT = IdHT;
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
     * @return the TongSLTNgay
     */
    public Long getTongSLTNgay() {
        return TongSLTNgay;
    }

    /**
     * @param TongSLTNgay the TongSLTNgay to set
     */
    public void setTongSLTNgay(Long TongSLTNgay) {
        this.TongSLTNgay = TongSLTNgay;
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
