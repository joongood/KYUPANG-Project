package com.kyupang.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.AdminMapper;
import com.kyupang.mapper.OrderMapper;
import com.kyupang.mapper.StatisticsMapper;
import com.kyupang.model.BannerVO;
import com.kyupang.model.CartTranDTO;
import com.kyupang.model.CategoryVO;
import com.kyupang.model.CommentsVO;
import com.kyupang.model.CoupontempVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.MemberVO;
import com.kyupang.model.PageMaker;
import com.kyupang.model.ProductVO;
import com.kyupang.model.StoreVO;
import com.kyupang.model.VisitorStats;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/")
@AllArgsConstructor
public class AdminController {

    private AdminMapper mapper;
    private OrderMapper orderMapper;
    private StatisticsMapper statisticsMapper;

    @GetMapping("/adminMain")
    public void mainGET(Model model) {
        log.info("== admin main ==");

        // 결제 수단별 통계 데이터 가져오기
        int countToss = statisticsMapper.getCountToss();
        int countKakao = statisticsMapper.getCountKakao();
        int countDeposit = statisticsMapper.getCountDeposit();

        // 최근 일주일 이내 가입자 비율 가져오기
        double recentSignupRate = statisticsMapper.getRecentSignupRate();

        // 최근 일주일 이내 탈퇴자 비율 가져오기
        double recentUnsubscribeRate = statisticsMapper.getRecentUnsubscribeRate();

        // 오늘 날짜 기준 전체 주문 수 가져오기
        int totalOrdersToday = statisticsMapper.getTotalOrdersToday();

        // 모델에 데이터 추가
        model.addAttribute("countToss", countToss);
        model.addAttribute("countKakao", countKakao);
        model.addAttribute("countDeposit", countDeposit);
        model.addAttribute("recentSignupRate", recentSignupRate);
        model.addAttribute("recentUnsubscribeRate", recentUnsubscribeRate);
        model.addAttribute("totalOrdersToday", totalOrdersToday);
    }
    
    @GetMapping("/visitor")
    @ResponseBody
    public List<VisitorStats> getVisitorStatsForLastWeek() {
        // 최근 일주일간의 기간 계산
        Date endDate = new Date();  // 현재 날짜
        long millisecondsPerDay = 24 * 60 * 60 * 1000;  // 1일을 밀리초로 계산
        Date startDate = new Date(endDate.getTime() - 7 * millisecondsPerDay);  // 7일 전

        // Mapper를 통해 방문자 통계 데이터 조회
        List<VisitorStats> visitorStats = statisticsMapper.getVisitorStatsForLastWeek(startDate, endDate);
        
        return visitorStats;
    }
    
    // 가맹점 매출 순위 리스트 조회
    @GetMapping("/franchise-rankings")
    @ResponseBody // JSON 형태의 데이터를 반환
    public List<CartTranDTO> getFranchiseRankings() {
        // 매출 기준으로 내림차순 정렬된 가맹점 리스트 조회
        List<CartTranDTO> franchiseRankings = statisticsMapper.getCartListOrderByTotalPayPriceDesc();
        
        return franchiseRankings;
    }

	@GetMapping("/calendar")
	public void calendarGET() {
		log.info("==calendar==");
	}

	// manageMember
	// ===========================================================================
	@GetMapping("/manageUser/listUser") // 회원 리스트 출력
	public void listMembers(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		log.info("==listUser==");
		Criteria criteria = new Criteria();
		criteria.setPage(page);

		List<MemberVO> memberList = mapper.findMembersByCriteria(criteria);
		int totalCount = mapper.countAllMembers();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(totalCount);

		model.addAttribute("memberList", memberList);
		model.addAttribute("pageMaker", pageMaker);
	}

	@GetMapping("/manageUser/detailUser") // 한건의 정보 조회
	public void readUserGet(@RequestParam("mid") Integer mid, Model model) {
		log.info("==readUser==");

		model.addAttribute("detail", mapper.read(mid));
	}

	@GetMapping("/manageUser/addUser")
	public void addUserGet() {
		log.info("==addSUer==");
	}

	@PostMapping("/manageUser/addUser") // 회원가입
	public String addUserPost(MemberVO member, RedirectAttributes rttr) {
		log.info("==memberAdd Post==");

		mapper.create(member);

		rttr.addFlashAttribute("msg", "add");

		return "redirect:/admin/manageUser/addUser";
	}

	@GetMapping("/manageUser/modifyUser")
	public void modifyUserGet(Integer mid, Model model) {
		log.info("==modifySUer==");

		model.addAttribute("modify", mapper.read(mid));
	}

	@PostMapping("/manageUser/modifyUser")
	public String modifyUserPost(MemberVO member, RedirectAttributes rttr) {
		log.info("==modifySUer Post==");
		log.info(member.toString());

		mapper.update(member);

		rttr.addFlashAttribute("msg", "modify");

		return "redirect:/admin/manageUser/modifyUser";
	}

	@GetMapping("/manageUser/delUser")
	public String deleteUserGet(Integer mid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.delete(mid);

		rttr.addFlashAttribute("msg", "del");

		return "redirect:/admin/manageUser/listUser";
	}

	// manageStore
	// ===========================================================================
	@GetMapping("/manageStore/listStore") // 가맹점 리스트 출력
	public void listStores(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		log.info("==liststore==");
		Criteria criteria = new Criteria();
		criteria.setPage(page);

		List<StoreVO> storeList = mapper.findStoresByCriteria(criteria);
		int totalCount = mapper.countAllStores();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(totalCount);

		model.addAttribute("storeList", storeList);
		model.addAttribute("pageMaker", pageMaker);
	}

	@GetMapping("/manageStore/detailStore") // 한건의 정보 조회
	public void readStoreGet(@RequestParam("sid") Integer sid, Model model) {
		log.info("==readStore==");

		model.addAttribute("detail", mapper.read_s(sid));
	}

	@GetMapping("/manageStore/addStore")
	public void addStoreGet() {
		log.info("==addSStore==");
	}

	@PostMapping("/manageStore/addStore") // 회원가입
	public String addStorePost(StoreVO store, RedirectAttributes rttr) {
		log.info("==storeAdd Post==");
		log.info(store.toString());

		mapper.create_s(store);

		rttr.addFlashAttribute("msg", "add");

		return "redirect:/admin/manageStore/addStore";
	}

	@GetMapping("/manageStore/modifyStore")
	public void modifyStoreGet(Integer sid, Model model) {
		log.info("==modifyStore==");

		model.addAttribute("modify", mapper.read_s(sid));
	}

	@PostMapping("/manageStore/modifyStore")
	public String modifyStorePost(StoreVO store, RedirectAttributes rttr) {
		log.info("==modifyStore Post==");
		log.info(store.toString());

		mapper.update_s(store);

		rttr.addFlashAttribute("msg", "modify");

		return "redirect:/admin/manageStore/modifyStore";
	}

	@GetMapping("/manageStore/delStore")
	public String deleteStoreGet(Integer sid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.delete_s(sid);

		rttr.addFlashAttribute("msg", "del");

		return "redirect:/admin/manageStore/listStore";
	}

	// manageCategory
	// ===========================================================================
	@GetMapping("/manageCategory/listCategory")
	public void listCategories(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		log.info("==list category==");
		Criteria criteria = new Criteria();
		criteria.setPage(page);

		List<CategoryVO> cateList = mapper.findCategoriesByCriteria(criteria);
		int totalCount = mapper.countAllCategories();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(totalCount);

		model.addAttribute("cateList", cateList);
		model.addAttribute("pageMaker", pageMaker);
	}

	@GetMapping("/manageCategory/addCategory")
	public void addCategoryGet() {
		log.info("==addCategory==");

	}

	@PostMapping("/manageCategory/addCategory")
	public String addCategoryPost(CategoryVO cate, RedirectAttributes rttr) {
		log.info("==storeAdd Post==");
		log.info(cate.toString());

		mapper.create_c(cate);

		rttr.addFlashAttribute("msg", "suc");

		return "redirect:/admin/manageCategory/listCategory";
	}

	@GetMapping("/manageCategory/modifyCategory")
	public void modifyCategoryGet(String cid, Model model) {
		log.info("==modifyCategory==");

		model.addAttribute("modify", mapper.read_c(cid));
	}

	@PostMapping("/manageCategory/modifyCategory")
	public String modifyCategoryPost(CategoryVO cate, RedirectAttributes rttr) {
		log.info("==modifyCategory Post==");
		log.info(cate.toString());

		mapper.update_c(cate);

		rttr.addFlashAttribute("msg", "modify");

		return "redirect:/admin/manageCategory/listCategory";
	}

	@GetMapping("/manageCategory/delCategory")
	public String deleteCategoryGet(String cid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.delete_c(cid);

		rttr.addFlashAttribute("msg", "del");

		return "redirect:/admin/manageCategory/listCategory";
	}

	// manageBanner
	// ===========================================================================
	@GetMapping("/manageBanner/listBanner")
	public void listBannerGET(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		log.info("== list banner ==");
		Criteria criteria = new Criteria();
		criteria.setPage(page);

		List<BannerVO> bannerList = mapper.findBannersByCriteria(criteria);
		int totalCount = mapper.countAllBanners();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(totalCount);

		model.addAttribute("bannerList", bannerList);
		model.addAttribute("pageMaker", pageMaker);

	}

	@GetMapping("/manageBanner/delBanner")
	public String deleteBannerGet(Integer bid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.delBanner(bid);

		rttr.addFlashAttribute("msg", "del");

		return "redirect:/admin/manageBanner/listBanner";
	}

	@GetMapping("/manageBanner/okBanner")
	public String okBannerGet(Integer bid, RedirectAttributes rttr) {
		log.info("==ok get==");

		mapper.okBanner(bid);

		rttr.addFlashAttribute("msg", "ok");

		return "redirect:/admin/manageBanner/listBanner";
	}
	
	@PostMapping("/manageBanner/toggleStatus")
	public ResponseEntity<Map<String, Object>> toggleStatus(@RequestParam Integer bid, @RequestParam String status) {
		log.info("=== update_status ===");
		
		Map<String, Object> response = new HashMap<>();
		try {
		    log.info(bid);
		    log.info(status);
		    mapper.updateBannerStatus(bid, status);
		    response.put("success", true);
		} catch (Exception e) {
		    response.put("success", false);
		    response.put("message", "상태 변경 중 오류 발생: " + e.getMessage());
		    log.error("상태 변경 중 오류 발생: " + e.getMessage(), e); // 더 자세한 오류 로그를 출력합니다.
		}
		return ResponseEntity.ok(response);
	}
	
	
	// manageProduct
	// ===========================================================================
	@GetMapping("/manageProduct/listProduct")
	public void listProduct(@RequestParam(value = "page", defaultValue = "1") int page, HttpSession session, Model model) {
		
		log.info("==list Product==");
		Criteria criteria = new Criteria();
        criteria.setPage(page);

        List<ProductVO> productList = mapper.findProductsByCriteria(criteria);
        int totalCount = mapper.countAllProducts();

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);

        model.addAttribute("productList", productList);
        model.addAttribute("pageMaker", pageMaker);
    }
	
	@GetMapping("/manageProduct/detailProduct")
	public void detailProductGET(@RequestParam("pid") Integer pid, Model model) {
		log.info("== detailProductGET ==");
		
		List<CategoryVO>maincate = mapper.cateMain();
		
		model.addAttribute("maincate", maincate);
		model.addAttribute("detail", mapper.read_p(pid));
		model.addAttribute("cate", mapper.categoryJoin(pid));
		
	}
	
	@GetMapping("/manageProduct/delProduct")
	public String deleteProductGet(Integer pid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.delete_p(pid);

		rttr.addFlashAttribute("msg", "del");
		
		return "redirect:/admin/manageProduct/listProduct";
	}
	
	
	// manageCoupon
	// ===========================================================================
	@GetMapping("/manageCoupon/listCoupon")
	public void listCoupon(@RequestParam(value = "page", defaultValue = "1") int page, HttpSession session, Model model) {
		
		log.info("==list Product==");
		Criteria criteria = new Criteria();
        criteria.setPage(page);

        List<CoupontempVO> couponList = mapper.findCouponByCriteria(criteria);
        int totalCount = mapper.countAllCoupon();

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);

        model.addAttribute("couponList", couponList);
        model.addAttribute("pageMaker", pageMaker);
    }
	
	@GetMapping("/manageCoupon/addCoupon")
	public void addcoupon_get() {
		log.info("==addcoupon_get==");	
	}
	
	@PostMapping("/manageCoupon/addCoupon")
	public String addcoupon_post(CoupontempVO temp, RedirectAttributes rttr) {
		log.info("==addcoupon_post==");	
		
		log.info(temp.toString());

		mapper.insertCoupon(temp);

		rttr.addFlashAttribute("msg", "suc");

		return "redirect:/admin/manageCoupon/listCoupon";
	}
	
	
	// manageComment
	// ===========================================================================
	@GetMapping("/manageComments/listComments")
	public void listComments(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		log.info("==list Comments==");
		Criteria criteria = new Criteria();
        criteria.setPage(page);

        List<CommentsVO> commentsList = mapper.findCommentsByCriteria(criteria);
        int totalCount = mapper.countAllComments();

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);

        model.addAttribute("commentsList", commentsList);
        model.addAttribute("pageMaker", pageMaker);
    }
	
	@GetMapping("/manageComments/deleteComments")
	public String deleteCommnets(Integer cmid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.deleteComments(cmid);

		rttr.addFlashAttribute("msg", "del");
		
		return "redirect:/admin/manageComments/listComments";
	}
	
	
	// manageTran
	// ===========================================================================
	@GetMapping("/manageTran/listTran")
	public void listTran(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		log.info("==list Tran==");
		Criteria criteria = new Criteria();
        criteria.setPage(page);

        List<CartTranDTO> tranList = mapper.findTranByCriteria(criteria);
        int totalCount = mapper.countAllTran();

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);

        model.addAttribute("tranList", tranList);
        model.addAttribute("pageMaker", pageMaker);
    }
	
	@GetMapping("/manageTran/updateTran")
	public String updateTran(@RequestParam Integer tranid, @RequestParam String session_cart, @RequestParam String session_id, RedirectAttributes rttr) {
		log.info("==updateTran Post==");

		mapper.updateTranStatus(tranid);
		
		int point = orderMapper.pluspoint(session_cart);
		
		Map<String, Object> map = new HashMap<>();
        map.put("session_id", session_id);
        map.put("point", point);

		orderMapper.addpoint(map);
		
		rttr.addFlashAttribute("msg", "mod");

		return "redirect:/admin/manageTran/listTran";
	}
	
	
	//manageCal===========================================================================
	@GetMapping("/manageCal/listCal") //회원 리스트 출력
	 public void listCal(@RequestParam(value = "page", defaultValue = "1") int page, Model model, HttpSession session) {
       
		log.info("==listCal==");
				
		Criteria criteria = new Criteria();
		criteria.setPage(page);

		List<CartTranDTO> calList = mapper.findCalByCriteria(criteria);
		int totalCount = mapper.countAllCal();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(totalCount);

		model.addAttribute("calList", calList);
		model.addAttribute("pageMaker", pageMaker);
   }
	
	@GetMapping("/manageCal/updateCal")
	public String updateCal(Integer ctid, RedirectAttributes rttr) {
		log.info("==updateCal==");

		mapper.updateCal(ctid);

		rttr.addFlashAttribute("msg", "cal");
		
		return "redirect:/admin/manageCal/listCal";
	}
}
