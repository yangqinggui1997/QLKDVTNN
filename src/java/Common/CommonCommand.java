/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Common;


import java.sql.Connection;
import java.sql.DriverManager;
import java.security.MessageDigest;
import java.util.Arrays;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class CommonCommand {
    
    public static Connection getConnection(){
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vtnnjsp?useUnicode=true&characterEncoding=UTF-8", "root", "root");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
    
    //định dạng ngày giờ lưu trong csdl
    public static String endateformat (String str){
        String kq;
        String y=str.substring(6, 10);
        String m=str.substring(3, 5);
        String d=str.substring(0, 2);
        String h=str.substring(11, 13);
        String mn=str.substring(14, 16);
        String s=str.substring(17, 19);
        
        kq=y+"-"+m+"-"+d+" "+h+":"+mn+":"+s;       

        return kq;
    }
    
    //định dạng ngày giờ hiển thị lên web
    public static String dedateformat (String str){
        
        String y=str.substring(0, 4);
        String m=str.substring(5, 7);
        String d=str.substring(8, 10);
        String h=str.substring(11, 13);
        String mn=str.substring(14, 16);
        String s=str.substring(17, 19);
        Short hh=Short.parseShort(h);
        String apm;
        if(hh>12){
            hh = (short)(hh-12);
            apm="PM";
        }
        else{
            apm="AM";
        }
        String kq=d+"/"+m+"/"+y+" "+hh+":"+mn+":"+s+" "+apm;
        return kq;
    }
    
    //định dạng ngày giờ hiển thị lên form cập nhật
    public static String deDateFormatForUpdate (String str){
        
        String y=str.substring(0, 4);
        String m=str.substring(5, 7);
        String d=str.substring(8, 10);
        String h=str.substring(11, 13);
        String mn=str.substring(14, 16);
        String s=str.substring(17, 19);
        
        String kq=d+"/"+m+"/"+y+" "+h+":"+mn+":"+s;
        return kq;
    }
    
    //Mã hoá mật khẩu
    public static byte[] encrypt(String message) throws Exception {
        final MessageDigest md = MessageDigest.getInstance("md5");
        final byte[] digestOfPassword = md.digest("YANGGUI1997"
                .getBytes("utf-8"));
        final byte[] keyBytes = Arrays.copyOf(digestOfPassword, 24);
        for (int j = 0, k = 16; j < 8;) {
            keyBytes[k++] = keyBytes[j++];
        }

        final SecretKey key = new SecretKeySpec(keyBytes, "DESede");
        final IvParameterSpec iv = new IvParameterSpec(new byte[8]);
        final Cipher cipher = Cipher.getInstance("DESede/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, key, iv);

        final byte[] plainTextBytes = message.getBytes("utf-8");
        final byte[] cipherText = cipher.doFinal(plainTextBytes);
        // final String encodedCipherText = new sun.misc.BASE64Encoder()
        // .encode(cipherText);

        return cipherText;
    }
    
    //Giải mã mật khẩu
    public static String decrypt(byte[] message) throws Exception {
        final MessageDigest md = MessageDigest.getInstance("md5");
        final byte[] digestOfPassword = md.digest("YANGGUI1997"
                .getBytes("utf-8"));
        final byte[] keyBytes = Arrays.copyOf(digestOfPassword, 24);
        for (int j = 0, k = 16; j < 8;) {
            keyBytes[k++] = keyBytes[j++];
        }

        final SecretKey key = new SecretKeySpec(keyBytes, "DESede");
        final IvParameterSpec iv = new IvParameterSpec(new byte[8]);
        final Cipher decipher = Cipher.getInstance("DESede/CBC/PKCS5Padding");
        decipher.init(Cipher.DECRYPT_MODE, key, iv);

        // final byte[] encData = new
        // sun.misc.BASE64Decoder().decodeBuffer(message);
        final byte[] plainText = decipher.doFinal(message);

        return new String(plainText, "UTF-8");
    }
    
    public static void main(String[] args) throws Exception {
        System.out.println(getConnection());
        
    }
    
}
