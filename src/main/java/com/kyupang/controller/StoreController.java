package com.kyupang.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.StoreMapper;
import com.kyupang.model.StoreLoginDTO;
import com.kyupang.model.StoreVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/store/")
@AllArgsConstructor
public class StoreController {
	
	private StoreMapper mapper;
	
	@GetMapping("/storeJoin")
	public void joinGET(StoreVO store) {
		log.info("==store join==");
	}
	@PostMapping("/storeJoin") //회원가입
	   public String joinPost(StoreVO member, RedirectAttributes rttr) {
	      log.info("==member joinPost==");
	      
	      mapper.create(member);   
	      
	      rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다.");
	      return "redirect:/";
	   }
	   @GetMapping("/emailCheck")
	   public @ResponseBody int emailCheck(String semail) {
	      log.info("==emailCheck.get==");
	      
	      return mapper.emailCheck(semail); //메일 존재 : 1, 없을 시 : 0
	   }
	
	//로그인
	@GetMapping("/storeLogin") 
	public void loginGET() {
		log.info("login get ...........");
	}

	@PostMapping("/storeLogin")
	public String loginPOST(StoreLoginDTO dto, HttpSession session, RedirectAttributes rttr) {
		log.info("login post ...........");
		log.info(dto.toString());

		StoreVO vo = mapper.login(dto);

		if(vo != null) { //세션 생성
			session.setAttribute("id", vo.getSemail());
			session.setAttribute("label", vo.getMutual());
			session.setAttribute("storestatus", vo.getStorestatus());
			
			if (vo.getIdentification().equals("N")) {
				rttr.addFlashAttribute("msg", "OTP가입을 해주세요.");
	            return "redirect:/otp/nSecretKey";
	        } else {
	            return "redirect:/otp/storesecretkey";
	        }
		}else {
			rttr.addFlashAttribute("msg", "잘못된 로그인 정보 입니다.");

			return "redirect:/store/storeLogin";
		}
	}
		
	@GetMapping("/storelogout") 
	public String logout(HttpSession session, RedirectAttributes rttr) {

		session.invalidate();
		
		rttr.addFlashAttribute("msg", "로그아웃 되었습니다.");
		
		return "redirect:/";
	}
	@GetMapping("/bnumberCheck")
	   public @ResponseBody int bnumberCheck(String bnumber) {
	      log.info("==emailCheck.get==");
	      
	      return mapper.bnumberCheck(bnumber); //메일 존재 : 1, 없을 시 : 0
	   }
}
