package com.kyupang.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.CouponMapper;
import com.kyupang.mapper.MemberMapper;
import com.kyupang.mapper.MypageMapper;
import com.kyupang.mapper.WishlistMapper;
import com.kyupang.model.CartTranDTO;
import com.kyupang.model.CouponVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.MemberVO;
import com.kyupang.model.PageMaker;
import com.kyupang.model.WishlistVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mypage/")
@AllArgsConstructor
public class MypageController {
	
	private MypageMapper mapper;
	private MemberMapper membermapper;
	private WishlistMapper wishmapper;
	private CouponMapper couponmapper;

	@GetMapping("/mainMypage")
	public void mainGET() {
		log.info("==listMypage==");
	}
	
	//회원정보수정
	@GetMapping("/memberJoinUp")
	public void memberJoinUp(HttpSession session, Model model) {
		log.info("==회원정보수정==");

		String session_id = (String)session.getAttribute("id");

		MemberVO member = membermapper.read(session_id);
		
		model.addAttribute("update", member);
	}
	
	//위시리스트
	@GetMapping("/wishlist")
	public void wishlistget(Model model, HttpSession session) {
		log.info("== 위시리스트 ==");
		
		String session_id = (String)session.getAttribute("id");
		List<WishlistVO> wish = wishmapper.wishlist(session_id);
	    
	    model.addAttribute("wish", wish);
	}
	
	//찜 삭제
	@GetMapping("/wishdelete") 
	public String wishdelete(Integer wid, RedirectAttributes rttr) {
		log.info("==찜 삭제==");

		wishmapper.wishdelete(wid);

		rttr.addFlashAttribute("msg", "찜하기에서 삭제되었습니다.");
		
		return "redirect:/mypage/wishlist";
	}
	
	//쿠폰리스트
	@GetMapping("/couponlist")
	public void couponlistGet(@RequestParam(value = "page", defaultValue = "1") int page, Model model, HttpSession session) {
		log.info("==쿠폰리스트==");
		
		Criteria criteria = new Criteria();
		criteria.setPage(page);
		
		String session_id = (String)session.getAttribute("id");
		List<CouponVO> coupon = mapper.couponlist(session_id,criteria);		
		int totalCount = mapper.countAllCoupon(session_id);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(totalCount);		
		
		model.addAttribute("coupon", coupon);
		model.addAttribute("pageMaker", pageMaker);
	}
	
	//주문 상세 내역
	@GetMapping("/transactionlist")
	public void translistGet(String odid,@RequestParam(value = "page", defaultValue = "1") int page, Model model, HttpSession session) {
		log.info("==구매목록==");
		
		Criteria criteria = new Criteria();
		criteria.setPage(page);
		
		List<CartTranDTO> cart = mapper.cartlist(odid,criteria);
		
		int totalCount = mapper.countAllorder(odid);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(totalCount);
		
		model.addAttribute("cart", cart);
		model.addAttribute("pageMaker", pageMaker);
	}
	
	//주문내역
	@GetMapping("translist")
	public void Tlist(@RequestParam(value = "page", defaultValue = "1") int page,
	                  Model model, HttpSession session) {
	    log.info("==구매목록==");

	    Criteria criteria = new Criteria();
	    criteria.setPage(page);

	    String session_id = (String) session.getAttribute("id");
	    if (session_id == null) {
	        throw new IllegalArgumentException("Session ID is null");
	    }

	    List<CartTranDTO> cartList = mapper.orderlist(session_id, criteria);
	    if (cartList == null) {
	        cartList = new ArrayList<>();  // 빈 리스트로 초기화
	    }

	    int totalCount = mapper.countAllcart(session_id);

	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCriteria(criteria);
	    pageMaker.setTotalCount(totalCount);

	    // 각 주문의 상품 수 계산
	    Map<String, Integer> orderCountMap = new HashMap<>();
	    for (CartTranDTO cart : cartList) {
	        String currentOdid = cart.getOdid();
	        if (!orderCountMap.containsKey(currentOdid)) {
	            int orderCount = mapper.countoneorder(currentOdid);
	            orderCountMap.put(currentOdid, orderCount);
	        }
	    }

	    // Model 객체에 추가
	    model.addAttribute("cartList", cartList);
	    model.addAttribute("pageMaker", pageMaker);
	    model.addAttribute("orderCountMap", orderCountMap);
	}

	
	//구매취소
	@PostMapping("/cancel")
	public String cancel(HttpSession session, String cart, Integer pid, String odid) {
		log.info("==구매취소==");
		
		Map<String, Object> map = new HashMap<>();
		map.put("cart", cart);
		map.put("pid", pid);
		map.put("odid", odid);
		
		Map<String, Object> map1 = new HashMap<>();
        map1.put("point", mapper.pluspoint(map));
        map1.put("session_id", (String)session.getAttribute("id"));
        
        mapper.minuspoint(map1);
        mapper.cancel(map);
		
        return "redirect:/mypage/transactionlist";
	}
}
