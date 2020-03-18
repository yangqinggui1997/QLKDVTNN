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
public class sanpham {
    private String IdSP;
    private String IdNCU;
    private String TenSP;
    private Timestamp NgaySX;
    private Timestamp NgayHH;
    private String NhaSX;
    private Timestamp NgayNhap;
    private Integer SLNhap;
    private Long DonGiaNhap;
    private Long DonGiaTienMat;
    private Long DonGiaThanhToanSau;
    private Short GiamGia;
    private String AnhSP;
    private Timestamp NgayCN;
    
    public sanpham(){}
    
    public sanpham(String idsp, String idncu, String tensp, Timestamp ngaysx, Timestamp NgayHH, String nhasx, Timestamp ngaynhap, Integer slnhap, Long dongianhap, Long dongiatienmat, Long dongiathanhtoansau, Short giamgia, String anhsp, Timestamp ngaycn){
        this.IdSP=idsp;
        this.IdNCU=idncu;
        this.TenSP=tensp;
        this.NgaySX=ngaysx;
        this.NgayHH=NgayHH;
        this.NhaSX=nhasx;
        this.NgayNhap=ngaynhap;
        this.SLNhap=slnhap;
        this.DonGiaNhap=dongianhap;
        this.DonGiaTienMat=dongiatienmat;
        this.DonGiaThanhToanSau=dongiathanhtoansau;
        this.GiamGia=giamgia;
        this.AnhSP=anhsp;
        this.NgayCN=ngaycn;
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
     * @return the IdNCU
     */
    public String getIdNCU() {
        return IdNCU;
    }

    /**
     * @param IdNCU the IdNCU to set
     */
    public void setIdNCU(String IdNCU) {
        this.IdNCU = IdNCU;
    }

    /**
     * @return the TenSP
     */
    public String getTenSP() {
        return TenSP;
    }

    /**
     * @param TenSP the TenSP to set
     */
    public void setTenSP(String TenSP) {
        this.TenSP = TenSP;
    }

    /**
     * @return the NgaySX
     */
    public Timestamp getNgaySX() {
        return NgaySX;
    }

    /**
     * @param NgaySX the NgaySX to set
     */
    public void setNgaySX(Timestamp NgaySX) {
        this.NgaySX = NgaySX;
    }

    /**
     * @return the NgayHH
     */
    public Timestamp getNgayHH() {
        return NgayHH;
    }

    /**
     * @param NgayHH the NgayHH to set
     */
    public void setNgayHH(Timestamp NgayHH) {
        this.NgayHH = NgayHH;
    }

    /**
     * @return the NhaSX
     */
    public String getNhaSX() {
        return NhaSX;
    }

    /**
     * @param NhaSX the NhaSX to set
     */
    public void setNhaSX(String NhaSX) {
        this.NhaSX = NhaSX;
    }

    /**
     * @return the NgayNhap
     */
    public Timestamp getNgayNhap() {
        return NgayNhap;
    }

    /**
     * @param NgayNhap the NgayNhap to set
     */
    public void setNgayNhap(Timestamp NgayNhap) {
        this.NgayNhap = NgayNhap;
    }

    /**
     * @return the SLNhap
     */
    public Integer getSLNhap() {
        return SLNhap;
    }

    /**
     * @param SLNhap the SLNhap to set
     */
    public void setSLNhap(Integer SLNhap) {
        this.SLNhap = SLNhap;
    }

    /**
     * @return the DonGiaNhap
     */
    public Long getDonGiaNhap() {
        return DonGiaNhap;
    }

    /**
     * @param DonGiaNhap the DonGiaNhap to set
     */
    public void setDonGiaNhap(Long DonGiaNhap) {
        this.DonGiaNhap = DonGiaNhap;
    }

    /**
     * @return the DonGiaTienMat
     */
    public Long getDonGiaTienMat() {
        return DonGiaTienMat;
    }

    /**
     * @param DonGiaTienMat the DonGiaTienMat to set
     */
    public void setDonGiaTienMat(Long DonGiaTienMat) {
        this.DonGiaTienMat = DonGiaTienMat;
    }

    /**
     * @return the DonGiaThanhToanSau
     */
    public Long getDonGiaThanhToanSau() {
        return DonGiaThanhToanSau;
    }

    /**
     * @param DonGiaThanhToanSau the DonGiaThanhToanSau to set
     */
    public void setDonGiaThanhToanSau(Long DonGiaThanhToanSau) {
        this.DonGiaThanhToanSau = DonGiaThanhToanSau;
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
     * @return the AnhSP
     */
    public String getAnhSP() {
        return AnhSP;
    }

    /**
     * @param AnhSP the AnhSP to set
     */
    public void setAnhSP(String AnhSP) {
        this.AnhSP = AnhSP;
    }
}
