package com.kyupang.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.StoreMapper;
import com.kyupang.service.OTPService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/otp/")
@AllArgsConstructor
public class OTPController {

    @Autowired
    private OTPService otpService;
    private StoreMapper mapper;

    @GetMapping("/generateSecretKey")
    public @ResponseBody Map<String, String> generateSecretKey() {
        String key = otpService.generateSecretKey();
        Map<String, String> response = new HashMap<>();
        response.put("key", key);
        return response;
    }

    @PostMapping("/validateOTP")
    public @ResponseBody String validateOTP(@RequestParam String secretKey, @RequestParam int otp) {
        if (otpService.validateOTP(secretKey, otp)) {
            return "true";
        } else {
            return "false";
        }
    }
    //관리자 페이지에서 만든 가맹점OTP용
    @GetMapping("/nSecretKey")
    public void generateSecretKey(Model model) {
        model.addAttribute("key", otpService.generateSecretKey());
    }

    @GetMapping("/nvalidateOTP")
    public String otpUpdate(@RequestParam("secretKey") String secretKey, @RequestParam String otp,Model model, HttpSession session, RedirectAttributes rttr) {
        String session_id = (String)session.getAttribute("id");
        
        
        // OTP가 숫자인지 확인
	    if(!otp.matches("\\d+")) {
	       rttr.addFlashAttribute("msg", "OTP 검증에 실패했습니다.");
	       return "redirect:/otp/nSecretKey";
	    }
	    int otpInt = Integer.parseInt(otp);
        boolean isValid = otpService.validateOTP(secretKey, otpInt);

        log.info("isValid:"+isValid);
        if (isValid) {       	
        	mapper.otpUpdate(secretKey, session_id); // secretKey를 바로 사용
        	rttr.addFlashAttribute("msg", "otp_ok");
            return "redirect:/";
        } else {
            rttr.addFlashAttribute("msg", "OTP 검증에 실패했습니다.");
            return "redirect:/otp/nSecretKey";
        }
    }  
}