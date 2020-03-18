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
public class sanphambanct {
    private String IdSPB;
    private String IdSP;
    private Long SLBan;
   
    
    
    public sanphambanct(){}
    
    public sanphambanct(String idspb, String idsp, Long slban){
        this.IdSPB=idspb;
        this.IdSP=idsp;
        this.SLBan=slban;
        
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
     * @return the SLBan
     */
    public Long getSLBan() {
        return SLBan;
    }

    /**
     * @param SLBan the SLBan to set
     */
    public void setSLBan(Long SLBan) {
        this.SLBan = SLBan;
    }
}
