package com.kyupang.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.CartMapper;
import com.kyupang.mapper.MemberMapper;
import com.kyupang.mapper.OrderMapper;
import com.kyupang.model.CartVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.MemberVO;
import com.kyupang.model.OrderVO;
import com.kyupang.model.OrdertranVO;
import com.kyupang.model.PageMaker;
import com.kyupang.model.ReadyResponse;
import com.kyupang.model.TossVO;
import com.kyupang.service.KakaoPayServiceImpl;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/payment/")
@AllArgsConstructor
public class PaymentController {
	
	private MemberMapper membermapper;
	private OrderMapper ordermapper;
	private CartMapper cartmapper;
	private KakaoPayServiceImpl kakaoPayServiceImpl;
	
	@GetMapping("paymentgate")
	public void getpaymentgate(HttpSession session, @RequestParam int totalAmount, Model model) {
		log.info("== get paymentgate ==");
		log.info(totalAmount);
		
		String session_id = (String)session.getAttribute("id");
		MemberVO member = membermapper.read(session_id);
		
		String uuid = UUID.randomUUID().toString();
		String uuid8 = uuid.substring(0,8);
		
		String session_cart = (String)session.getAttribute("cart");
		CartVO cart = ordermapper.read(session_cart);
		
		int productcount = cartmapper.countAllcart(session_cart);

		model.addAttribute("member", member);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("uuid", uuid8);
		model.addAttribute("cart", cart);
		model.addAttribute("productcount", productcount);
	}
	@PostMapping("paymentgate")
	public String postpaymentgate(String code1,@RequestParam Integer point, OrdertranVO vo, RedirectAttributes rttr,HttpSession session) {
		log.info("== post paymentgate ==");
		log.info(code1);
		
		String session_cart = (String)session.getAttribute("cart");
		Criteria criteria = new Criteria();
		
		Map<String, Object> map = new HashMap<>();
        map.put("session_id", (String)session.getAttribute("id"));
        map.put("point", point);
		
		ordermapper.create(vo);
		ordermapper.update((String)session.getAttribute("cart"));	//cartstaus 변경
		if(code1 != null && !code1.equals("")) {
			ordermapper.usedCoupon(code1);//코드 상태 Y로변경
		}
		if(point != null) {
			ordermapper.usedpoint(map);//사용 유저포인트 차감
		}
		
		Map<String, Object> map1 = new HashMap<>();
        map1.put("allpoint", ordermapper.pluspoint((String)session.getAttribute("cart")));
        map1.put("odid", vo.getOdid());
		
		ordermapper.depositcreate(map1);
		ordermapper.minusqty(session_cart);
		
		//카트 재생성
		session.removeAttribute("cart");
		String uuid = UUID.randomUUID().toString();
		session.setAttribute("cart", uuid);		
		
		rttr.addFlashAttribute("msg", "입금을 진행해주세요.");  
		
		int totalCount = cartmapper.countAllcart(uuid);
        // carttotalprice 메서드 수정으로 인해 반환 값을 Integer로 받고, null일 경우 0으로 처리
        Integer totalPrice = cartmapper.carttotalprice(uuid);
        if (totalPrice == null) {
            totalPrice = 0;
        }
        
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);
		
		// 세션에 카트의 상품 총합과 총 갯수 추가
        session.setAttribute("cartCount", totalCount);
        session.setAttribute("totalPrice", totalPrice);
        
	    return "redirect:/";
	}
	@PostMapping("tosssave")
	public void tosssave(@ModelAttribute TossVO vo) {
		log.info("==post cart list==");
		
		ordermapper.save(vo);
		log.info(vo.toString());
		log.info("배송정보 일시적 저장");
	}
	@GetMapping("toss") //toss 결제
	public void gettoss(@RequestParam String orderId,@RequestParam String paymentKey,@RequestParam int amount,Model model) {
		log.info(orderId);
		log.info(paymentKey);
		log.info(amount);
		
		model.addAttribute("orderId", orderId);
		model.addAttribute("paymentKey", paymentKey);
		model.addAttribute("amount", amount);
	}
	
	@PostMapping("toss") //toss 결제
	public String posttoss(@RequestParam String orderId, @RequestParam int amount, RedirectAttributes rttr, HttpSession session) {
		log.info(orderId);		
		
		TossVO toss = ordermapper.saveread((String)session.getAttribute("cart"));
		Criteria criteria = new Criteria();
		
		Map<String, Object> map = new HashMap<>();
        map.put("session_id", (String)session.getAttribute("id"));
        map.put("point", toss.getPoint());
		
		ordermapper.tosscreate(orderId, toss.getBuyer(), amount, toss.getZipcode(), toss.getAddress(), toss.getAddressdetail(),toss.getCart());
		ordermapper.update((String)session.getAttribute("cart"));//cartstaus 변경
		
		if(toss.getCode() != null) {
			ordermapper.usedCoupon(toss.getCode());//코드 상태 Y로변경
		}
		
		if(toss.getPoint() != null) {
			ordermapper.usedpoint(map);//사용 유저포인트 차감
		}
		
        String session_cart = (String)session.getAttribute("cart");
        int point =  ordermapper.pluspoint(session_cart);
        
        log.info(point);
        
        Map<String, Object> map1 = new HashMap<>();
        map1.put("session_id", (String)session.getAttribute("id"));
        map1.put("point", point);
        
        ordermapper.addpoint(map1);
        
        ordermapper.minusqty(session_cart);
		
		
		//카트 재생성
		session.removeAttribute("cart");
		String uuid = UUID.randomUUID().toString();
		session.setAttribute("cart", uuid);
		
		rttr.addFlashAttribute("msg", "결제를 완료하였습니다.");
		
		int totalCount = cartmapper.countAllcart(uuid);
        // carttotalprice 메서드 수정으로 인해 반환 값을 Integer로 받고, null일 경우 0으로 처리
        Integer totalPrice = cartmapper.carttotalprice(uuid);
        if (totalPrice == null) {
            totalPrice = 0;
        }
        
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);
		
		// 세션에 카트의 상품 총합과 총 갯수 추가
        session.setAttribute("cartCount", totalCount);
        session.setAttribute("totalPrice", totalPrice);
		
		return "redirect:/";
	}
	@PostMapping("kakaopay") //카카오페이 결제
	public @ResponseBody ReadyResponse payReady(@RequestBody OrderVO vo, HttpSession session) {
		log.info("카카오페이 결제 ...........................");

		vo.setPay_method("카카오페이"); //결제방식
		int totalAmount = vo.getPayprice(); //총 주문금액
		String itemName = vo.getOrderName(); //상품명
		int quantity = vo.getQty();
		String mem_id = (String)session.getAttribute("id"); //가맹점 회원 아이디

		// 카카오페이 서버에 1차 준비요청
		ReadyResponse readyResponse = kakaoPayServiceImpl.payReady(itemName, quantity, mem_id, totalAmount);

		log.info("결제고유번호:"+readyResponse.getTid());
		log.info("결제요청URL:"+readyResponse.getNext_redirect_pc_url());

		vo.setTid(readyResponse.getTid()); //결제 고유번호 입력
		vo.setPay_type(""); //결제 성공여부 null 처리

		log.info(vo);

		session.setAttribute("tid", readyResponse.getTid()); //결제 성공,실패,취소 시 변경처리 필요
		session.setAttribute("payprice", totalAmount); //가격 세션에 만들기
		session.setAttribute("odid", vo.getOdid());
		session.setAttribute("buyer", vo.getBuyer());
		session.setAttribute("zipcode", vo.getZipcode());
		session.setAttribute("address", vo.getAddress());
		session.setAttribute("addressdetail", vo.getAddressdetail());
		session.setAttribute("code", vo.getCode());
		session.setAttribute("usepoint", vo.getPoint());
		

		//// mapper 관련 생성 후 insert 처리 구현 ////

		return readyResponse;
	}

	@GetMapping("orderApp")
	public void orderApp(HttpSession session,RedirectAttributes rttr) {
		log.info("결제 성공.................");

		String session_tid = (String)session.getAttribute("tid");
		int session_totalAmount = (Integer)session.getAttribute("payprice");
		String session_id = (String)session.getAttribute("id");
		String session_code = (String)session.getAttribute("code");
		Integer session_point = (Integer)session.getAttribute("usepoint");
		Criteria criteria = new Criteria();
		
		log.info("tid : "+session_tid);
		log.info("totalAmount : "+session_totalAmount);
		
		Map<String, Object> map = new HashMap<>();
        map.put("odid", (String)session.getAttribute("odid"));
        map.put("buyer", (String)session.getAttribute("buyer"));
        map.put("payprice", (Integer)session.getAttribute("payprice"));
        map.put("zipcode", (String)session.getAttribute("zipcode"));
        map.put("address", (String)session.getAttribute("address"));
        map.put("addressdetail", (String)session.getAttribute("addressdetail"));
        map.put("cart", (String)session.getAttribute("cart"));
        
        Map<String, Object> map1 = new HashMap<>();
        map1.put("session_id", session_id);
        map1.put("point", session_point);
        
        ordermapper.kakaocreate(map);
        ordermapper.update((String)session.getAttribute("cart"));	//cartstaus 변경
        if(session_code != null) {
			ordermapper.usedCoupon(session_code);//코드 상태 Y로변경
		}
		
		if(session_point != null) {
			ordermapper.usedpoint(map1);//사용 유저포인트 차감
		}
		
		String session_cart = (String)session.getAttribute("cart");
        int point =  ordermapper.pluspoint(session_cart);
        
        log.info(point);
        
        Map<String, Object> map2 = new HashMap<>();
        map2.put("session_id", session_id);
        map2.put("point", point);
        
        ordermapper.addpoint(map2);
        ordermapper.minusqty(session_cart);
        
        session.removeAttribute("tid");
		session.removeAttribute("odid"); 
		session.removeAttribute("buyer");
		session.removeAttribute("payprice");
		session.removeAttribute("zipcode");
		session.removeAttribute("address");
		session.removeAttribute("addressdetail");
		session.removeAttribute("code");
		session.removeAttribute("usepoint");
		//카트 재생성
		session.removeAttribute("cart");
		String uuid = UUID.randomUUID().toString();
		session.setAttribute("cart", uuid);
		
		int totalCount = cartmapper.countAllcart(uuid);
        // carttotalprice 메서드 수정으로 인해 반환 값을 Integer로 받고, null일 경우 0으로 처리
        Integer totalPrice = cartmapper.carttotalprice(uuid);
        if (totalPrice == null) {
            totalPrice = 0;
        }
        
        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);
		
		// 세션에 카트의 상품 총합과 총 갯수 추가
        session.setAttribute("cartCount", totalCount);
        session.setAttribute("totalPrice", totalPrice);

		//// insert 처리된 데이터 중 mapper 이용 - 결제 성공 업데이트 처리 ////
	}

	@GetMapping("orderCancel")
	public void orderCancel(HttpSession session,HttpServletResponse response)throws IOException {
		log.info("결제 취소.................");
		session.removeAttribute("tid");
		session.removeAttribute("odid"); 
		session.removeAttribute("buyer");
		session.removeAttribute("payprice");
		session.removeAttribute("zipcode");
		session.removeAttribute("address");
		session.removeAttribute("addressdetail");
		
		// 팝업창을 닫는 스크립트를 응답으로 작성
	    response.setContentType("text/html;charset=UTF-8");
	    PrintWriter out = response.getWriter();
	    out.println("<script>");
	    out.println("window.close();");
	    out.println("</script>");
	    out.flush();
		
	}

	@GetMapping("orderFail")
	public String orderFail(HttpSession session,RedirectAttributes rttr) {
		log.info("결제 실패.................");
		session.removeAttribute("tid");
		session.removeAttribute("odid"); 
		session.removeAttribute("buyer");
		session.removeAttribute("payprice");
		session.removeAttribute("zipcode");
		session.removeAttribute("address");
		session.removeAttribute("addressdetail");
		return "redirect:/";		
	}

}
