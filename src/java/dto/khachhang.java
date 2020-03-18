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
public class khachhang {
    private String TenKH;
    private Timestamp NgaySinh;
    private Short GioiTinh;
    private String SoCMND;
    private String SDT;
    private String Email;
    private String DiaChi;
    private Short LoaiKH;
    private String DanhGia;
    
    public khachhang(){}
    
    public khachhang(String tenkh, Timestamp ngaysinh, Short gioitinh, String socmnd, String sdt, String email, String diachi, Short loaikh, String danhgia){
        this.TenKH=tenkh;
        this.NgaySinh=ngaysinh;
        this.LoaiKH=loaikh;
        this.SoCMND=socmnd;
        this.SDT=sdt;
        this.Email=email;
        this.GioiTinh=gioitinh;
        this.DiaChi=diachi;
        this.DanhGia=danhgia;
    }

    /**
     * @return the DanhGia
     */
    public String getDanhGia() {
        return DanhGia;
    }

    /**
     * @param DanhGia the DanhGia to set
     */
    public void setDanhGia(String DanhGia) {
        this.DanhGia = DanhGia;
    }

    /**
     * @return the TenKH
     */
    public String getTenKH() {
        return TenKH;
    }

    /**
     * @param TenKH the TenKH to set
     */
    public void setTenKH(String TenKH) {
        this.TenKH = TenKH;
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
     * @return the Email
     */
    public String getEmail() {
        return Email;
    }

    /**
     * @param Email the Email to set
     */
    public void setEmail(String Email) {
        this.Email = Email;
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
     * @return the LoaiKH
     */
    public Short getLoaiKH() {
        return LoaiKH;
    }

    /**
     * @param LoaiKH the LoaiKH to set
     */
    public void setLoaiKH(Short LoaiKH) {
        this.LoaiKH = LoaiKH;
    }
}
