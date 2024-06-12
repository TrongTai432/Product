package com.example.demo.security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import com.example.demo.constant.Constants;


public class PasswordGenerator {

    public static String encryptMD5(String inputStr) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update((inputStr + Constants.SALT_CONST).getBytes());
            byte[] digest = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        System.out.println(encryptMD5("123"));
    }
}
