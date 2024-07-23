package com.kyupang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.WishlistMapper;
import com.kyupang.model.WishlistVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/wish/")
@AllArgsConstructor
public class WishController {
	
	private WishlistMapper mapper;
	
	@GetMapping("/wishlist")
	public void wishlistget(Model model, HttpSession session) {
		log.info("=== wishlist_get ===");
		
		String session_id = (String)session.getAttribute("id");
		List<WishlistVO> wish = mapper.wishlist(session_id);
	    
	    model.addAttribute("wish", wish);
	}
	
	@PostMapping("/wishCreate") //찜하기
	public ResponseEntity<String> wishCreate(@ModelAttribute WishlistVO vo) {
		log.info("==wishCreate==");
		log.info(vo.toString());
		
		ResponseEntity<String> entity = null;
           
		mapper.wishCreate(vo); 
		
		return entity;
	}
	@GetMapping("/wishdelete") //찜 삭제
	public String wishdelete(Integer wid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.wishdelete(wid);

		rttr.addFlashAttribute("msg", "찜하기에서 삭제되었습니다.");
		
		return "redirect:/wish/wishlist";
	}
	@PostMapping("/sendcart") //카트로 보내기
	public String sendcart(WishlistVO vo, HttpSession session, RedirectAttributes rttr) {
		log.info("==sendcart==");		
        
		String cart = (String)session.getAttribute("cart");
		
		Map<String, Object> map = new HashMap<>();
        map.put("vo", vo);
        map.put("cart", cart);
				
		mapper.sendcart(map);
		rttr.addFlashAttribute("msg", "장바구니에 담았습니다.");
		return "redirect:/cart/cartlist";
	}
}

