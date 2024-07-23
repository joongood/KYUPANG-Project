package com.kyupang.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponentsBuilder;

import com.kyupang.mapper.CartMapper;
import com.kyupang.model.CartVO;
import com.kyupang.model.CouponVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.PageMaker;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/cart/")
@AllArgsConstructor
public class CartController {

	private CartMapper mapper;
	
	@GetMapping("cartlist")
	public void GetcartList(@RequestParam(value = "page", defaultValue = "1") int page, Model model, HttpSession session){
		log.info("==get cart list==");
		
		String session_cart = (String)session.getAttribute("cart");
		String session_id = (String)session.getAttribute("id");
		
		Criteria criteria = new Criteria();
        criteria.setPage(page);
        
        List<CartVO> cartlist = mapper.cartlist(session_cart, criteria);
        int totalCount = mapper.countAllcart(session_cart);
        // carttotalprice 메서드 수정으로 인해 반환 값을 Integer로 받고, null일 경우 0으로 처리
        Integer totalPrice = mapper.carttotalprice(session_cart);
        if (totalPrice == null) {
            totalPrice = 0;
        }
        
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);         
        
        List<CouponVO>couponList = mapper.couponList(session_id);
        
        model.addAttribute("cartlist", cartlist);
        model.addAttribute("couponList", couponList);
        model.addAttribute("pageMaker", pageMaker);
        
        // 세션에 카트의 상품 총합과 총 갯수 추가
        session.setAttribute("cartCount", totalCount);
        session.setAttribute("totalPrice", totalPrice);
	}
	
	@PostMapping("addcart")
	public String addcart(@RequestParam(value = "cid", defaultValue = "") String cid,@RequestParam(value = "page", defaultValue = "1") int page, @ModelAttribute CartVO vo, RedirectAttributes rttr, HttpSession session) {
		log.info("==post cart list==");
		
		String session_cart = (String)session.getAttribute("cart");		
		
		// 현재 재고 수량 확인
	    Integer maxQty = mapper.getMaxQty(vo.getPid());
	    if (maxQty == null) {
	        maxQty = 0;
	    }

	    // 요청한 수량이 재고 수량을 초과하는지 확인
	    if (vo.getQty() > maxQty) {
	        rttr.addFlashAttribute("msg", "재고보다 많은 수량을 선택하셨습니다.\n수량을 줄여주세요.");
	        return "redirect:/product/itemlist?cid=" + cid + "&page=" + page;
	    }
	    mapper.addcart(vo);
	    log.info(vo.toString());
	    log.info("==담기 성공==");
	    
	    rttr.addFlashAttribute("msg" , "장바구니에 담았습니다.");
	    
	    int totalCount = mapper.countAllcart(session_cart);
        // carttotalprice 메서드 수정으로 인해 반환 값을 Integer로 받고, null일 경우 0으로 처리
        Integer totalPrice = mapper.carttotalprice(session_cart);
        if (totalPrice == null) {
            totalPrice = 0;
        }
        
        // 세션에 카트의 상품 총합과 총 갯수 추가
        session.setAttribute("cartCount", totalCount);
        session.setAttribute("totalPrice", totalPrice);
        
        return "redirect:/product/itemlist?cid=" + cid + "&page=" + page;
	}
	
	@PostMapping("brandaddcart")
	public String brandaddcart(@RequestParam(value = "mutual", defaultValue = "") String mutual,@RequestParam(value = "page", defaultValue = "1") int page, @ModelAttribute CartVO vo, RedirectAttributes rttr, HttpSession session) {
		log.info("==post cart list==");
		
		String session_cart = (String)session.getAttribute("cart");		
		
		// 현재 재고 수량 확인
	    Integer maxQty = mapper.getMaxQty(vo.getPid());
	    if (maxQty == null) {
	        maxQty = 0;
	    }

	    // 요청한 수량이 재고 수량을 초과하는지 확인
	    if (vo.getQty() > maxQty) {
	        rttr.addFlashAttribute("msg", "재고보다 많은 수량을 선택하셨습니다.\n수량을 줄여주세요.");
	        String redirectUrl = UriComponentsBuilder.fromPath("/product/itemlistm")
			                    .queryParam("mutual", mutual)
			                    .queryParam("page", page)
			                    .build()
			                    .encode()
			                    .toUriString();
			return "redirect:" + redirectUrl;
	    }
	    mapper.addcart(vo);
	    log.info(vo.toString());
	    log.info("==담기 성공==");
	    
	    rttr.addFlashAttribute("msg" , "장바구니에 담았습니다.");
	    
	    int totalCount = mapper.countAllcart(session_cart);
        // carttotalprice 메서드 수정으로 인해 반환 값을 Integer로 받고, null일 경우 0으로 처리
        Integer totalPrice = mapper.carttotalprice(session_cart);
        if (totalPrice == null) {
            totalPrice = 0;
        }
        
        // 세션에 카트의 상품 총합과 총 갯수 추가
        session.setAttribute("cartCount", totalCount);
        session.setAttribute("totalPrice", totalPrice);
        
        String redirectUrl = UriComponentsBuilder.fromPath("/product/itemlistm")
		                .queryParam("mutual", mutual)
		                .queryParam("page", page)
		                .build()
		                .encode()
		                .toUriString();
		
		return "redirect:" + redirectUrl;
	}
	
	@GetMapping("cartdelete")
	public String delete(RedirectAttributes rttr, String ctid) {
		log.info("==카트 삭제==");
		
		mapper.cartdelete(ctid);
		
		rttr.addFlashAttribute("msg", "장바구니 제거완료");
		
		return "redirect:/cart/cartlist";
	}
	
	@PostMapping("qtychange")
	public void qtychange(int pid, int qty,HttpSession session, HttpServletResponse response) throws IOException {
		log.info("==qtychange==");
		Map<String, Object> map = new HashMap<>();
        map.put("qty", qty);
        map.put("pid", pid);
        map.put("session_cart", (String)session.getAttribute("cart"));
        
        //현재 재고 수량 확인
        Integer maxQty = mapper.getMaxQty(pid);
        if (maxQty == null) {
            maxQty = 0;
        }

        // 요청한 수량이 재고 수량을 초과하는지 확인
        if (qty > maxQty) {
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("재고보다 많은 수량을 선택하셨습니다.\n수량을 줄여주세요.");
            return;
        }
        
        //수량업데이트
		mapper.qtyupdate(map);
	}
}
