package com.kyupang.service;

import org.springframework.stereotype.Service;

import com.warrenstrange.googleauth.GoogleAuthenticator;

@Service
public class OTPService {

    private final GoogleAuthenticator gAuth;

    public OTPService() {
        gAuth = new GoogleAuthenticator();
    }

    public String generateSecretKey() {
        return gAuth.createCredentials().getKey();
    }

    public boolean validateOTP(String secretKey, int otp) {
        return gAuth.authorize(secretKey, otp);
    }
}