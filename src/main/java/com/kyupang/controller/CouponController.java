package com.kyupang.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.CouponMapper;
import com.kyupang.model.CouponVO;
import com.kyupang.model.CoupontempVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.PageMaker;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/coupon/")
@AllArgsConstructor
public class CouponController {
	
	private CouponMapper mapper;
	
	@GetMapping("/couponList") // 회원 리스트 출력
	public void listMembers(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		log.info("==listUser==");
		Criteria criteria = new Criteria();
		criteria.setPage(page);

		List<CoupontempVO> couponList = mapper.findCoupontempByCriteria(criteria);
		int totalCount = mapper.countAllCoupontemp();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(totalCount);

		model.addAttribute("couponList", couponList);
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@PostMapping("/downloadCoupon")
	public String downloadCoupon(@RequestParam("description") String description,
	                             @RequestParam("discount") Double discount,
	                             @RequestParam("expirydate") String expirydate,
	                             @RequestParam("minpurchase") int minpurchase,
	                             HttpSession session,
	                             RedirectAttributes rttr,
	                             Model model) {
	    
	    log.info("==== downloadCoupon ====");
	    String memail = (String) session.getAttribute("id");
    	
	    UUID uuid = UUID.randomUUID();
	    String code = uuid.toString().replace("-", "");
	    
	    CouponVO coupon = new CouponVO();
	    coupon.setCode(code);
	    coupon.setDescription(description);
	    coupon.setDiscount(discount);
	    coupon.setExpirydate(expirydate);
	    coupon.setMinpurchase(minpurchase);
	    coupon.setMemail(memail);
	    
	    log.info(coupon.toString());

	    boolean isAlreadyDownloaded = mapper.checkCouponDownloadStatus(description, memail); // 이 메서드는 쿠폰 다운로드 여부를 확인하는 메서드입니다.

	    if (isAlreadyDownloaded) {
	    	
	        rttr.addFlashAttribute("msg", "alr");
	        
	        return "redirect:/coupon/couponList";
	    }else {
	    	
		    mapper.downloadCoupon(coupon);
		
		    rttr.addFlashAttribute("msg", "down");
		    
		    return "redirect:/coupon/couponList";
	    }   
	}

}
