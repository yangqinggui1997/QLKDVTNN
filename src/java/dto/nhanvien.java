/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.sql.Timestamp;

public class nhanvien {
    private String IdNV;
    private String TenNV;
    private Timestamp NgaySinh;
    private Short GioiTinh;
    private String SoCMND;
    private String SDT;
    private String DiaChi;
    private Short ChucVu;
    private Timestamp NgayVaoLam;

    public nhanvien() {
    }
    
    public nhanvien(String idnv, String tennv, Timestamp ngaysinh, Short gioitinh, String socmnd, String sdt, String diachi, Short chucvu, Timestamp ngayvaolam){
        this.IdNV=idnv;
        this.TenNV=tennv;        
        this.NgaySinh=ngaysinh;
        this.GioiTinh=gioitinh;
        this.SoCMND=socmnd;
        this.SDT=sdt;
        this.DiaChi=diachi;
        this.ChucVu=chucvu;
        this.NgayVaoLam=ngayvaolam;
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
     * @return the TenNV
     */
    public String getTenNV() {
        return TenNV;
    }

    /**
     * @param TenNV the TenNV to set
     */
    public void setTenNV(String TenNV) {
        this.TenNV = TenNV;
    }

    /**
     * @return the NgaySinh
     */
    public Timestamp getNgaySinh() {
        return NgaySinh;
    }

    /**
     * @param NgaySinh the NgaySinh to set
     */
    public void setNgaySinh(Timestamp NgaySinh) {
        this.NgaySinh = NgaySinh;
    }

    /**
     * @return the GioiTinh
     */
    public Short getGioiTinh() {
        return GioiTinh;
    }

    /**
     * @param GioiTinh the GioiTinh to set
     */
    public void setGioiTinh(Short GioiTinh) {
        this.GioiTinh = GioiTinh;
    }

    /**
     * @return the SoCMND
     */
    public String getSoCMND() {
        return SoCMND;
    }

    /**
     * @param SoCMND the SoCMND to set
     */
    public void setSoCMND(String SoCMND) {
        this.SoCMND = SoCMND;
    }

    /**
     * @return the SDT
     */
    public String getSDT() {
        return SDT;
    }

    /**
     * @param SDT the SDT to set
     */
    public void setSDT(String SDT) {
        this.SDT = SDT;
    }

    /**
     * @return the DiaChi
     */
    public String getDiaChi() {
        return DiaChi;
    }

    /**
     * @param DiaChi the DiaChi to set
     */
    public void setDiaChi(String DiaChi) {
        this.DiaChi = DiaChi;
    }

    /**
     * @return the ChucVu
     */
    public Short getChucVu() {
        return ChucVu;
    }

    /**
     * @param ChucVu the ChucVu to set
     */
    public void setChucVu(Short ChucVu) {
        this.ChucVu = ChucVu;
    }

    /**
     * @return the NgayVaoLam
     */
    public Timestamp getNgayVaoLam() {
        return NgayVaoLam;
    }

    /**
     * @param NgayVaoLam the NgayVaoLam to set
     */
    public void setNgayVaoLam(Timestamp NgayVaoLam) {
        this.NgayVaoLam = NgayVaoLam;
    }

}
