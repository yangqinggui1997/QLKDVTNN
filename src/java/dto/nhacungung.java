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
public class nhacungung {
    private String IdNCU;
    private String TenNCU;
    private Short QuyMo;
    private String SDT;
    private String Email;
    private String DiaChi;
    private String DanhGia;
    
    public nhacungung(){}
    
    public nhacungung(String idncu, String tenncu, String DiaChi, String sdt, String email, Short quymo, String danhgia){
        this.IdNCU=idncu;
        this.TenNCU=tenncu;
        this.QuyMo=quymo;
        
        this.SDT=sdt;
        this.Email=email;
        this.DiaChi=DiaChi;
        
        this.DanhGia=danhgia;
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
     * @return the TenNCU
     */
    public String getTenNCU() {
        return TenNCU;
    }

    /**
     * @param TenNCU the TenNCU to set
     */
    public void setTenNCU(String TenNCU) {
        this.TenNCU = TenNCU;
    }

    /**
     * @return the QuyMo
     */
    public Short getQuyMo() {
        return QuyMo;
    }

    /**
     * @param QuyMo the QuyMo to set
     */
    public void setQuyMo(Short QuyMo) {
        this.QuyMo = QuyMo;
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
}
