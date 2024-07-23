package com.kyupang.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.StoreMapper;
import com.kyupang.model.StoreVO;
import com.kyupang.service.OTPService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/otp/")
@AllArgsConstructor
public class StoreOTPController {

    @Autowired
    private OTPService otpService;
    private StoreMapper mapper;

    @GetMapping("/storesecretkey")
    public void generateSecretKey(Model model, HttpSession session) {
    	
    	String session_id = (String)session.getAttribute("id");
    	StoreVO store = mapper.read(session_id);
    	
        model.addAttribute("key",store.getSecretkey());
    }

    @PostMapping("/StoreValidateOTP")
    public String validateOTP(@RequestParam String secretKey, @RequestParam String otp, Model model, HttpSession session, RedirectAttributes rttr) {
    	
    	 String session_id = (String)session.getAttribute("id");
    	 StoreVO store = mapper.read(session_id);
    	
    	 // OTP가 숫자인지 확인
	     if(!otp.matches("\\d+")) {
	        rttr.addFlashAttribute("msg", "OTP 검증에 실패했습니다.");
	        return "redirect:/otp/storesecretkey";
	     }
    	 
    	 int otpInt = Integer.parseInt(otp);
    	 boolean isValid = otpService.validateOTP(secretKey, otpInt);
         model.addAttribute("result", isValid);
        
         
         if(isValid) {
    		session.setAttribute("level", store.getSlevel());
    		log.info("=========2===========");
            rttr.addFlashAttribute("msg", "로그인이 완료되었습니다.");
            return "redirect:/";
         }else {
            rttr.addFlashAttribute("msg", "OTP 검증에 실패했습니다.");
            return "redirect:/otp/storesecretkey";
         }
    }
    
}