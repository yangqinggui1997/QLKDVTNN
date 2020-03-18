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
public class hangtonct {
    private String IdHT;
    private String IdSP;
    private Long SLTon;
   
    
    
    public hangtonct(){}
    
    public hangtonct(String idht, String idsp, Long slton){
        this.IdHT=idht;
        this.IdSP=idsp;
        this.SLTon=slton;
        
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
     * @return the SLTon
     */
    public Long getSLTon() {
        return SLTon;
    }

    /**
     * @param SLTon the SLTon to set
     */
    public void setSLTon(Long SLTon) {
        this.SLTon = SLTon;
    }
}
