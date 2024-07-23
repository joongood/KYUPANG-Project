package com.kyupang.controller;

import java.util.Collections;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.MemberMapper;
import com.kyupang.model.LoginDTO;
import com.kyupang.model.MemberVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/")
@AllArgsConstructor
public class MemberController {
   
   private MemberMapper mapper;
   
   @GetMapping("memberJoin")
   public void joinGET(MemberVO member) {
      log.info("==member join==");
   } 
      
   @PostMapping("memberJoin") //회원가입
   public String joinPost(MemberVO member, RedirectAttributes rttr) {
      log.info("==member joinPost==");
            
      mapper.create(member);   
      
      rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다.");            
      return "redirect:/";
   }
   @GetMapping("/emailCheck")
   public @ResponseBody int emailCheck(String memail) {
      log.info("==emailCheck.get==");
            
      return mapper.emailCheck(memail); //메일 존재 : 1, 없을 시 : 0
   }
      
   //로그인
   @GetMapping("/memberLogin")
   public void loginGET() {
      log.info("==member login==");
   }

   @PostMapping("/memberLogin")
   public String loginPOST(LoginDTO dto, HttpSession session, RedirectAttributes rttr) {
      log.info("login post ...........");
      log.info(dto.toString());

      MemberVO vo = mapper.login(dto);
      
      String uuid = UUID.randomUUID().toString();
      
      if (vo != null) {
           String memberStatus = vo.getMemberstatus();
           if (memberStatus != null) {
               if (memberStatus.equals("정지")) {
                   rttr.addFlashAttribute("msg", "정지된 아이디 입니다. 관리자에게 문의하세요.");
                   return "redirect:/member/memberLogin";
               } else if (memberStatus.equals("탈퇴")) {
                   rttr.addFlashAttribute("msg", "탈퇴처리된 아이디 입니다. 관리자에게 문의하세요.");
                   return "redirect:/member/memberLogin";
               }
           }

           session.setAttribute("id", vo.getMemail());
           session.setAttribute("name", vo.getMname());
           session.setAttribute("level", vo.getMlevel());
           session.setAttribute("loginstatus", vo.getLoginstatus());
           session.setAttribute("point", vo.getMpoint());
           session.setAttribute("cart", uuid);
           session.setAttribute("label", vo.getLabel());
           
           log.info(uuid);

           rttr.addFlashAttribute("msg", "로그인 되었습니다.");
           return "redirect:/";
       } else {
           rttr.addFlashAttribute("msg", "잘못된 로그인 정보 입니다.");
           return "redirect:/member/memberLogin";
       }
   }
   
   //카카오로그인
   @GetMapping("/kakao")
   public @ResponseBody int kakaoLogin(MemberVO vo,HttpSession session) {
      log.info("==카카오 로그인==");
      
      int result = mapper.emailCheck(vo.getMemail());
      String uuid = UUID.randomUUID().toString();
      if(result == 0) {
         vo.setLoginstatus("소셜");
         vo.setMname("카카오");
         vo.setIdentification("Y");
         mapper.kakaoLogin(vo);
      }
      
      vo = mapper.read(vo.getMemail());
      
      session.setAttribute("id", vo.getMemail());
        session.setAttribute("name", vo.getMname());
        session.setAttribute("level", vo.getMlevel());
        session.setAttribute("loginstatus", vo.getLoginstatus());
        session.setAttribute("cart", uuid);
        
        log.info(uuid);
        
        
      return result;      
   }
   
   //naver 로그인 콜백
   @GetMapping("/naverLogin")
   public void naverLogin() {
      log.info("== 네이버 콜백 ==");
   }
   
   //naver 로그인
   @GetMapping("/naver")
   public String naverLogin(MemberVO vo, HttpSession session) {
      log.info("네이버 세션 생성페이지 이동");
      
      int result = mapper.emailCheck(vo.getMemail()); // 아이디 존재 여부
      String uuid = UUID.randomUUID().toString();
      
      if(result == 0) {
         vo.setLoginstatus("소셜");
         vo.setMname("네이버");
         vo.setIdentification("Y");
         session.setAttribute("id", vo.getMemail());
         log.info(vo);
         mapper.naverLogin(vo);
         
         return "redirect:/member/s_memberJoinUp";
      }
      
      vo = mapper.read(vo.getMemail());
      
      session.setAttribute("id", vo.getMemail());
        session.setAttribute("name", vo.getMname());
        session.setAttribute("level", vo.getMlevel());
        session.setAttribute("loginstatus", vo.getLoginstatus());
        session.setAttribute("cart", uuid);
        
        log.info(uuid);
        
        
        return "redirect:/";
   }
   
   
   //회원수정
   @GetMapping("/memberJoinUp")
   public void joinupGET(HttpSession session, Model model) {
      log.info("joinup get ...........");

      String session_id = (String)session.getAttribute("id");

      MemberVO member = mapper.read(session_id);

      model.addAttribute("update", member);
   }

   @PostMapping("/memberJoinUp")
   public String joinupPOST(MemberVO vo, RedirectAttributes rttr) {
      log.info("joinup post ...........");
      log.info(vo.toString());

      mapper.update(vo);

      rttr.addFlashAttribute("msg","수정완료되었습니다.");

      return "redirect:/";
   }
   //소셜 회원수정
   @GetMapping("/s_memberJoinUp")
   public void sjoinupGET(HttpSession session, Model model) {
      log.info("joinup get ...........");

      String session_id = (String)session.getAttribute("id");

      MemberVO member = mapper.read(session_id);

      model.addAttribute("update", member);
   }
   
   //소셜 회원수정
   @PostMapping("/s_memberJoinUp")
   public String sjoinupPOST(MemberVO vo, HttpSession session, HttpServletRequest request, RedirectAttributes rttr) {
      log.info("joinup post ...........");
      log.info(vo.toString());

      mapper.supdate(vo);
      
        // 세션 무효화
      session = request.getSession(false);
        if (session != null) {
            session.invalidate();
            rttr.addFlashAttribute("msg","수정완료되었습니다. 다시 로그인 해주세요");
        }
      return "redirect:/";
   }
   
   //로그아웃
   @GetMapping("/logout") 
   public String logout(HttpSession session, RedirectAttributes rttr) {
      
      String session_cart = (String)session.getAttribute("cart");
      if(session_cart != null) {
    	  mapper.cartDelete(session_cart);
      }
      session.invalidate();
      
      rttr.addFlashAttribute("msg","로그아웃 되었습니다.");

      return "redirect:/";
   }
   
   //소셜 로그아웃
   @GetMapping("/slogout") 
   public String slogout(HttpSession session, RedirectAttributes rttr) {
      
      String session_cart = (String)session.getAttribute("cart");
      if(session_cart != null) {
    	  mapper.cartDelete(session_cart);
      }
      session.invalidate();
      
      rttr.addFlashAttribute("msg","로그아웃 되었습니다.");
      
      return "redirect:/";
   }
   
   @GetMapping("/getPoint")
   @ResponseBody
   public ResponseEntity<Object> getPoint(HttpSession session) {
       log.info("==getPoint==");

       String session_id = (String) session.getAttribute("id");
       try {
           int point = mapper.getPoint(session_id);
           return ResponseEntity.ok().body(Collections.singletonMap("point", point));
       } catch (Exception e) {
           log.error("Error while fetching point for session ID: " + session_id, e);
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                .body("Failed to fetch point: " + e.getMessage());
       }
   }
}
