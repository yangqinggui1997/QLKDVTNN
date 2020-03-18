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
public class nguoidung {
    private String IdND;
    private String IdNV;
    private String TenTK;
    private String MK;
    private Timestamp NgayTaoTK;
    private Timestamp SuaMKLanCuoi;
    private Short TrangThai;
    private Short LoaiND;
    
    public nguoidung(){}
    
    public nguoidung(String idnd, String idnv, String tentk, String mk, Timestamp ngaytaotk, Timestamp SuaMKLanCuoi, Short trangthai, Short loaind){
        this.IdND=idnd;
        this.IdNV=idnv;
        this.LoaiND=loaind;
        this.MK=mk;
        this.NgayTaoTK=ngaytaotk;
        this.SuaMKLanCuoi=SuaMKLanCuoi;
        this.TenTK=tentk;
        this.TrangThai=trangthai;
    }
    
    /**
     * @return the IdND
     */
    public String getIdND() {
        return IdND;
    }

    /**
     * @param IdND the IdND to set
     */
    public void setIdND(String IdND) {
        this.IdND = IdND;
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
     * @return the TenTK
     */
    public String getTenTK() {
        return TenTK;
    }

    /**
     * @param TenTK the TenTK to set
     */
    public void setTenTK(String TenTK) {
        this.TenTK = TenTK;
    }

    /**
     * @return the MK
     */
    public String getMK() {
        return MK;
    }

    /**
     * @param MK the MK to set
     */
    public void setMK(String MK) {
        this.MK = MK;
    }

    /**
     * @return the NgayTaoTK
     */
    public Timestamp getNgayTaoTK() {
        return NgayTaoTK;
    }

    /**
     * @param NgayTaoTK the NgayTaoTK to set
     */
    public void setNgayTaoTK(Timestamp NgayTaoTK) {
        this.NgayTaoTK = NgayTaoTK;
    }

    /**
     * @return the SuaMKLanCuoi
     */
    public Timestamp getSuaMKLanCuoi() {
        return SuaMKLanCuoi;
    }

    /**
     * @param SuaMKLanCuoi the SuaMKLanCuoi to set
     */
    public void setSuaMKLanCuoi(Timestamp SuaMKLanCuoi) {
        this.SuaMKLanCuoi = SuaMKLanCuoi;
    }

    /**
     * @return the TrangThai
     */
    public Short getTrangThai() {
        return TrangThai;
    }

    /**
     * @param TrangThai the TrangThai to set
     */
    public void setTrangThai(Short TrangThai) {
        this.TrangThai = TrangThai;
    }

    /**
     * @return the LoaiND
     */
    public Short getLoaiND() {
        return LoaiND;
    }

    /**
     * @param LoaiND the LoaiND to set
     */
    public void setLoaiND(Short LoaiND) {
        this.LoaiND = LoaiND;
    }
    
}
