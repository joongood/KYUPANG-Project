package com.kyupang.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kyupang.mapper.MutualMapper;
import com.kyupang.mapper.StatisticsMapper;
import com.kyupang.model.BannerVO;
import com.kyupang.model.CartTranDTO;
import com.kyupang.model.CategoryVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.MemberVO;
import com.kyupang.model.PageMaker;
import com.kyupang.model.ProductVO;
import com.kyupang.model.StoreVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mutual/")
@AllArgsConstructor
public class MutualController {
	
	private MutualMapper mapper;
	private StatisticsMapper statisticsMapper;
	
    @GetMapping("/mutualMain")
    public void mainGET(Model model, HttpSession session) {
        log.info("== mutual main ==");
        
        String session_label = (String)session.getAttribute("label");
        
        // 월별 매출 조회
        List<Map<String, Object>> monthlySales = statisticsMapper.getMonthlySales(session_label);

        // 가장 많이 팔리는 상품 리스트 조회
        List<Map<String, Object>> topSellingProducts = statisticsMapper.getTopSellingProducts(session_label); // 가맹점 이름을 넣어주세요

        // 모델에 데이터 추가
        model.addAttribute("monthlySales", monthlySales);
        model.addAttribute("topSellingProducts", topSellingProducts);
    }
	
	@GetMapping("/calendar")
	public void calendarGET() {
		log.info("==calendar==");
	}
	
	//manageProduct ===========================================================================
	@GetMapping("/manageProduct/listProduct") //회원 리스트 출력
	public void listProduct(@RequestParam(value = "page", defaultValue = "1") int page, HttpSession session, Model model) {
        
		String session_id = (String)session.getAttribute("name");
		String session_label = (String)session.getAttribute("label");
		
		log.info("==list Product==");
		Criteria criteria = new Criteria();
        criteria.setPage(page);

        List<ProductVO> productList = mapper.findProductsByCriteria(session_id, session_label, criteria);
        int totalCount = mapper.countAllProducts(session_id, session_label);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);

        model.addAttribute("productList", productList);
        model.addAttribute("pageMaker", pageMaker);
    }
	
	@PostMapping("/manageProduct/cate2") //회원가입
	public void cate2Post(String cid, Model model) {
		log.info("==mutual cate2==");  
		
		List<CategoryVO> middlecate = mapper.cateMiddle(cid);
		
		model.addAttribute("middlecate", middlecate);
	}
	
	@Resource(name = "productPath")
	private String productPath;
	
	@GetMapping("/manageProduct/addProduct")
	public void addProductsGET(HttpSession session, Model model) {
		log.info("== addProduct_Get ==");
		String session_label = (String)session.getAttribute("label");
		
		List<CategoryVO>maincate = mapper.cateMain();
		
		model.addAttribute("maincate", maincate);	
		model.addAttribute("label", session_label);
	}

	@PostMapping("/manageProduct/addProduct")
	public String addProductPost(@RequestParam("maincate") String maincate,
	                             @RequestParam("middlecate") String middlecate,
	                             @RequestParam("mutual") String mutual,
	                             @RequestParam("pname") String pname,
	                             @RequestParam("price") String price,
	                             @RequestParam("point") String point,
	                             @RequestParam("qty") String qty,
	                             @RequestParam("description") String description,
	                             @RequestParam("product_option") String product_option,
	                             @RequestParam("option_value1") String option_value1,
	                             @RequestParam("option_value2") String option_value2,
	                             @RequestParam("option_value3") String option_value3,
	                             @RequestParam("option_value4") String option_value4,
	                             @RequestParam("option_value5") String option_value5,
	                             @RequestParam("productuse") String productuse,
	                             @RequestParam("hit") String hit,
	                             @RequestParam("suggest") String suggest,
	                             @RequestParam("newproduct") String newproduct,
	                             @RequestParam("popular") String popular,
	                             @RequestParam("salecheck") String salecheck,
	                             @RequestParam("saleprice") String saleprice,
	                             @RequestParam("file1") MultipartFile file1,
	                             @RequestParam("file2") MultipartFile file2,
	                             @RequestParam("file3") MultipartFile file3,
	                             @RequestParam("file4") MultipartFile file4,
	                             @RequestParam("file5") MultipartFile file5,
	                             RedirectAttributes rttr) {
	    
	    log.info("==== addProduct_Post ====");
	    ProductVO product = new ProductVO();
	    product.setMaincate(maincate);
	    product.setMiddlecate(middlecate);
	    product.setMutual(mutual);
	    product.setPname(pname);
	    product.setPrice(Integer.parseInt(price));
	    product.setPoint(Integer.parseInt(point));
	    product.setQty(Integer.parseInt(qty));
	    product.setDescription(description);
	    product.setProduct_option(product_option);
	    if (product_option.equals("Y")) {
	        product.setOption_value1(option_value1);
	        product.setOption_value2(option_value2);
	        product.setOption_value3(option_value3);
	        product.setOption_value4(option_value4);
	        product.setOption_value5(option_value5);
	    }
	    product.setProductuse(productuse);
	    product.setHit(hit);
	    product.setSuggest(suggest);
	    product.setNewproduct(newproduct);
	    product.setPopular(popular);
	    product.setSalecheck(salecheck);
	    if (salecheck.equals("Y")) {
	        product.setSaleprice(Integer.parseInt(saleprice));
	    }
	    
	    // 파일 업로드 처리
	    try {
	        if (!file1.isEmpty()) {
	            String fileName1 = saveFile(file1);
	            product.setFile1(fileName1);
	        }
	        if (!file2.isEmpty()) {
	            String fileName2 = saveFile(file2);
	            product.setFile2(fileName2);
	        }
	        if (!file3.isEmpty()) {
	            String fileName3 = saveFile(file3);
	            product.setFile3(fileName3);
	        }
	        if (!file4.isEmpty()) {
	            String fileName4 = saveFile(file4);
	            product.setFile4(fileName4);
	        }
	        if (!file5.isEmpty()) {
	            String fileName5 = saveFile(file5);
	            product.setFile5(fileName5);
	        }
	    } catch (Exception e) {
	        rttr.addFlashAttribute("msg", "err");
	        return "error";
	    }

	    mapper.create(product);
	    
	    rttr.addFlashAttribute("msg", "add");

	    return "redirect:/mutual/manageProduct/addProduct";
	}
	
	@GetMapping("/manageProduct/detailProduct")
	public void detailProductGET(@RequestParam("pid") Integer pid, Model model) {
		log.info("== detailProductGET ==");
		
		List<CategoryVO>maincate = mapper.cateMain();
		
		model.addAttribute("maincate", maincate);
		model.addAttribute("detail", mapper.read(pid));
		model.addAttribute("cate", mapper.categoryJoin(pid));
		
	}
	
	@GetMapping("/manageProduct/modifyProduct")
	public void modifyProductGET(@RequestParam("pid") Integer pid, Model model) {
		log.info("== detailProductGET ==");
		
		List<CategoryVO>maincate = mapper.cateMain();
		
		model.addAttribute("maincate", maincate);
		model.addAttribute("modify", mapper.read(pid));		
	}
	
	@PostMapping("/manageProduct/modifyProduct")
	public String modifyProductPost(@RequestParam("pid") String pid,
									@RequestParam("maincate") String maincate,
								 	@RequestParam("middlecate") String middlecate,
								 	@RequestParam("mutual") String mutual,
								 	@RequestParam("pname") String pname,
								 	@RequestParam("price") String price,
								 	@RequestParam("point") String point,
								 	@RequestParam("qty") String qty,
								 	@RequestParam("description") String description,
								 	@RequestParam("product_option") String product_option,
								 	@RequestParam("option_value1") String option_value1,
								 	@RequestParam("option_value2") String option_value2,
								 	@RequestParam("option_value3") String option_value3,
								 	@RequestParam("option_value4") String option_value4,
								 	@RequestParam("option_value5") String option_value5,
								 	@RequestParam("productuse") String productuse,
								 	@RequestParam("hit") String hit,
								 	@RequestParam("suggest") String suggest,
								 	@RequestParam("newproduct") String newproduct,
								 	@RequestParam("popular") String popular,
								 	@RequestParam("salecheck") String salecheck,
								 	@RequestParam("saleprice") String saleprice,
								 	@RequestParam("file1") MultipartFile file1,
								 	@RequestParam("file2") MultipartFile file2,
								 	@RequestParam("file3") MultipartFile file3,
								 	@RequestParam("file4") MultipartFile file4,
								 	@RequestParam("file5") MultipartFile file5,
								 	RedirectAttributes rttr) {
	    
	    log.info("==== modifyProduct_Post ====");
	    log.info("pid: " + pid);
	    
	    ProductVO product = new ProductVO();
	    product.setPid(Integer.parseInt(pid));
	    product.setMaincate(maincate);
	    product.setMiddlecate(middlecate);
	    product.setMutual(mutual);
	    product.setPname(pname);
	    product.setPrice(Integer.parseInt(price));
	    product.setPoint(Integer.parseInt(point));
	    product.setQty(Integer.parseInt(qty));
	    product.setDescription(description);
	    product.setProduct_option(product_option);
	    if (product_option.equals("Y")) {
	        product.setOption_value1(option_value1);
	        product.setOption_value2(option_value2);
	        product.setOption_value3(option_value3);
	        product.setOption_value4(option_value4);
	        product.setOption_value5(option_value5);
	    }
	    product.setProductuse(productuse);
	    product.setHit(hit);
	    product.setSuggest(suggest);
	    product.setNewproduct(newproduct);
	    product.setPopular(popular);
	    product.setSalecheck(salecheck);
	    if (salecheck.equals("Y")) {
	        product.setSaleprice(Integer.parseInt(saleprice));
	    }
	    
	    // 파일 업로드 처리
	    try {
	        if (!file1.isEmpty()) {
	            String fileName1 = saveFile(file1);
	            product.setFile1(fileName1);
	        }
	        if (!file2.isEmpty()) {
	            String fileName2 = saveFile(file2);
	            product.setFile2(fileName2);
	        }
	        if (!file3.isEmpty()) {
	            String fileName3 = saveFile(file3);
	            product.setFile3(fileName3);
	        }
	        if (!file4.isEmpty()) {
	            String fileName4 = saveFile(file4);
	            product.setFile4(fileName4);
	        }
	        if (!file5.isEmpty()) {
	            String fileName5 = saveFile(file5);
	            product.setFile5(fileName5);
	        }
	    } catch (Exception e) {
	        rttr.addFlashAttribute("msg", "err");
	        return "error";
	    }
	 
	    log.info(product);

	    mapper.update(product);
	    
	    rttr.addFlashAttribute("msg", "mod");

	    return "redirect:/mutual/manageProduct/listProduct";
	}
	
	@GetMapping("/manageProduct/delProduct")
	public String deleteProductGet(Integer pid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.delete(pid);

		rttr.addFlashAttribute("msg", "del");
		
		return "redirect:/mutual/manageProduct/listProduct";
	}
	
	private String saveFile(MultipartFile file) throws IOException {
	    // 파일 저장 로직 구현 (예: 파일을 특정 경로에 저장하고, 파일명을 반환)
	    String fileName = file.getOriginalFilename();
	    String savePath = "D:\\Dev\\Project_KTE\\KYUPANG_Project\\src\\main\\webapp\\resources\\product_upload\\" + fileName; // 슬래시 추가
	    File saveDir = new File("D:\\Dev\\Project_KTE\\KYUPANG_Project\\src\\main\\webapp\\resources\\product_upload");
	    if (!saveDir.exists()) {
	        saveDir.mkdirs(); // 폴더가 존재하지 않으면 생성
	    }
	    file.transferTo(new File(savePath));
	    return fileName;
	}
	
	//manageMutual ===========================================================================
	@GetMapping("/manageMutual/modifyMutual")
	public void modifyMutualGET(HttpSession session, Model model) {
		log.info("== detailProductGET ==");
		
		String session_id = (String)session.getAttribute("id");
		
		StoreVO store = mapper.readStore(session_id);
		
		model.addAttribute("modify", store);
		
	}
	
	@PostMapping("/manageMutual/modifyMutual")
	public String modifyMutualPOST(StoreVO vo, RedirectAttributes rttr) {
		log.info("== modifyMutualPOST ==");
		log.info(vo.toString());
		
		mapper.updateStore(vo);
		
		rttr.addFlashAttribute("msg","mod");
		
		return "redirect:/mutual/mutualMain";
	}
	
	//manageBanner ===========================================================================
	@GetMapping("/manageBanner/listBanner")
	public void listBannerGET(@RequestParam(value = "page", defaultValue = "1") int page, HttpSession session, Model model) {
		
		String session_id = (String)session.getAttribute("name");
		String session_label = (String)session.getAttribute("label");
		
		log.info("== list banner ==");
		Criteria criteria = new Criteria();
        criteria.setPage(page);

        List<BannerVO> bannerList = mapper.findBannersByCriteria(session_id, session_label, criteria);
        int totalCount = mapper.countAllBanners(session_id, session_label);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);

        model.addAttribute("bannerList", bannerList);
        model.addAttribute("pageMaker", pageMaker);
		
	}
	
	@GetMapping("/manageBanner/addBanner")
	public void addBannerGET(HttpSession session, Model model) {
		log.info("== addBanner_Get ==");
		String session_label = (String)session.getAttribute("label");
	
		model.addAttribute("label", session_label);
	}
		
	@PostMapping("/manageBanner/addBanner")
	public String addBannerPOST(@RequestParam("title") String title,
								@RequestParam("bprice") String bprice,
								@RequestParam("imageurl") MultipartFile imageurl,
								@RequestParam("mutual") String mutual,
								@RequestParam("startdate") String startdate,
								@RequestParam("enddate") String enddate,
								RedirectAttributes rttr) {
		log.info("== addBanner_POST ==");
		
		BannerVO banner = new BannerVO();
		banner.setTitle(title);
		banner.setBprice(Integer.parseInt(bprice));
		
		try {
	        if (!imageurl.isEmpty()) {
	            String fileName = saveFile2(imageurl);
	            banner.setImageurl(fileName);
	        }
		} catch (Exception e) {
	        rttr.addFlashAttribute("msg", "err");
	        return "error";
	    }
		
		banner.setMutual(mutual);
		banner.setStartdate(startdate);
		banner.setEnddate(enddate);
		
        mapper.create_b(banner);
        
        rttr.addFlashAttribute("msg", "add");
        
        return "redirect:/mutual/manageBanner/listBanner";
		
	}
	
	@GetMapping("/manageBanner/detailBanner")
	public void detailBannerGET(Integer bid, Model model) {
		log.info("== detailBanner_Get ==");
	
		model.addAttribute("detail", mapper.readBanner(bid));
	}
	
	@GetMapping("/manageBanner/modifyBanner")
	public void modifyBannerGET(Integer bid, Model model) {
		log.info("== modifyBanner_Get ==");
	
		model.addAttribute("modify", mapper.readBanner(bid));
	}
	
	@PostMapping("/manageBanner/modifyBanner")
	public String modifyBannerPOST(@RequestParam("bid") String bid,
								   @RequestParam("title") String title,
								   @RequestParam("bprice") String bprice,
								   @RequestParam("imageurl") MultipartFile imageurl,
								   @RequestParam("mutual") String mutual,
								   @RequestParam("startdate") String startdate,
								   @RequestParam("enddate") String enddate,
								   RedirectAttributes rttr) {
		
		log.info("== modifyBanner_POST ==");
		
		BannerVO banner = new BannerVO();
		banner.setBid(Integer.parseInt(bid));
		banner.setTitle(title);
		banner.setBprice(Integer.parseInt(bprice));
		
		try {
	        if (!imageurl.isEmpty()) {
	            String fileName = saveFile2(imageurl);
	            banner.setImageurl(fileName);
	        }
		} catch (Exception e) {
	        rttr.addFlashAttribute("msg", "err");
	        return "error";
	    }
		
		banner.setMutual(mutual);
		banner.setStartdate(startdate);
		banner.setEnddate(enddate);
		
        mapper.updateBanner(banner);
        
        rttr.addFlashAttribute("msg", "mod");
        
        return "redirect:/mutual/manageBanner/listBanner";
	
	}
	
	@GetMapping("/manageBanner/delBanner")
	public String deleteBannerGet(Integer bid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.delBanner(bid);

		rttr.addFlashAttribute("msg", "del");
		
		return "redirect:/mutual/manageBanner/listBanner";
	}
	
	private String saveFile2(MultipartFile file) throws IOException {
	    // 파일 저장 로직 구현 (예: 파일을 특정 경로에 저장하고, 파일명을 반환)
	    String fileName = file.getOriginalFilename();
	    String savePath = "D:\\Dev\\Project_KTE\\KYUPANG_Project\\src\\main\\webapp\\resources\\banner_submit\\" + fileName; // 슬래시 추가
	    File saveDir = new File("D:\\Dev\\Project_KTE\\KYUPANG_Project\\src\\main\\webapp\\resources\\banner_submit");
	    if (!saveDir.exists()) {
	        saveDir.mkdirs(); // 폴더가 존재하지 않으면 생성
	    }
	    file.transferTo(new File(savePath));
	    return fileName;
	}
	
	
	//manageMember ===========================================================================
	 @GetMapping("/manageUser/listUser") //회원 리스트 출력
	 public void listMembers(@RequestParam(value = "page", defaultValue = "1") int page, Model model, HttpSession session) {
        
		log.info("==listUser==");
		
		String session_label = (String)session.getAttribute("label");
		
		Criteria criteria = new Criteria();
        criteria.setPage(page);

        List<MemberVO> memberList = mapper.findMembersByCriteria(session_label, criteria);
        int totalCount = mapper.countAllMembers(session_label);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);

        model.addAttribute("memberList", memberList);
        model.addAttribute("pageMaker", pageMaker);
    }
	
	@GetMapping("/manageUser/detailUser") // 한건의 정보 조회
	public void readUserGet(@RequestParam("mid") Integer mid, Model model) {
		log.info("==readUser==");

		model.addAttribute("detail", mapper.read_m(mid));	
	}
	
	@GetMapping("/manageUser/addUser")
	public void addUserGet(HttpSession session, Model model) {
		log.info("==addSUer==");
		
		String session_label = (String)session.getAttribute("label");
		
		model.addAttribute("mutual" ,session_label);
	}
	
	@PostMapping("/manageUser/addUser") // 회원가입
	public String addUserPost(MemberVO member, RedirectAttributes rttr) {
	    log.info("==memberAdd Post==");

	    mapper.create_m(member);
	    
	    rttr.addFlashAttribute("msg", "add");
	    
	    return "redirect:/mutual/manageUser/addUser";
	}


	@GetMapping("/manageUser/modifyUser")
	public void modifyUserGet(Integer mid, Model model) {
		log.info("==modifySUer==");
		
		model.addAttribute("modify", mapper.read_m(mid));	
	}
	
	@PostMapping("/manageUser/modifyUser")
	public String modifyUserPost(MemberVO member, RedirectAttributes rttr) {
		log.info("==modifySUer Post==");
		log.info(member.toString());
		
		mapper.update_m(member);
		
		rttr.addFlashAttribute("msg", "modify");
		
		return "redirect:/mutual/manageUser/modifyUser";
	}
	
	@GetMapping("/manageUser/delUser")
	public String deleteUserGet(Integer mid, RedirectAttributes rttr) {
		log.info("==remove get==");

		mapper.delete_m(mid);

		rttr.addFlashAttribute("msg", "del");
		
		return "redirect:/mutual/manageUser/listUser";
	}
	
	
	//manageCal===========================================================================
	@GetMapping("/manageCal/listCal") //회원 리스트 출력
	 public void listCal(@RequestParam(value = "page", defaultValue = "1") int page, Model model, HttpSession session) {
       
		log.info("==listCal==");
		
		String session_label = (String)session.getAttribute("label");
				
		Criteria criteria = new Criteria();
		criteria.setPage(page);

		List<CartTranDTO> calList = mapper.findCalByCriteria(session_label, criteria);
		int totalCount = mapper.countAllCal(session_label);

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
		
		return "redirect:/mutual/manageCal/listCal";
	}
}
