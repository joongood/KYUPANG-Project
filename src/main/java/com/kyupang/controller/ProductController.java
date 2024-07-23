package com.kyupang.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kyupang.mapper.ProductMapper;
import com.kyupang.model.CategoryNameDTO;
import com.kyupang.model.CategoryVO;
import com.kyupang.model.ProductCriteria;
import com.kyupang.model.ProductPageMaker;
import com.kyupang.model.ProductVO;
import com.kyupang.model.StoreVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/product/")
@AllArgsConstructor
public class ProductController {
	
	private ProductMapper mapper;
	//전체상품list
	@GetMapping("itemlist")
	public String itemlist(@RequestParam(value = "page", defaultValue = "1") int page,Model model,@RequestParam(value = "cid", required = false) Integer cid) {
		ProductCriteria criteria = new ProductCriteria();
        criteria.setPage(page);
		
        Map<String, Object> map = new HashMap<>();
        map.put("criteria", criteria);
        map.put("cid", cid);
        
		List<ProductVO> productList = mapper.productlist(map);
		List<CategoryVO> cateList = mapper.catelist();
		int totalCount = mapper.countAllProduct(map);

        ProductPageMaker pageMaker = new ProductPageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);
        
        model.addAttribute("productList", productList);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("cateList", cateList);
        model.addAttribute("cid", cid);
        
        return "/product/itemlist";
	}
	
	//인기상품list
	@GetMapping("itemlistp")
	public String itemlistp(@RequestParam(value = "page", defaultValue = "1") int page,Model model,@RequestParam(value = "cid", required = false) Integer cid) {
		ProductCriteria criteria = new ProductCriteria();
        criteria.setPage(page);
        
        Map<String, Object> map = new HashMap<>();
        map.put("criteria", criteria);
        map.put("cid", cid);
		
		List<ProductVO> productList = mapper.productlistp(map);
		List<CategoryVO> cateList = mapper.catelist();
		int totalCount = mapper.countAllProductp(map);

        ProductPageMaker pageMaker = new ProductPageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);
        model.addAttribute("productList", productList);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("cateList", cateList);
        model.addAttribute("cid", cid);
        
        return "/product/itemlist";
	}
	
	//세일상품(할인율 20% 이상 상품)list
	@GetMapping("itemlists")
	public String itemlists(@RequestParam(value = "page", defaultValue = "1") int page,Model model,@RequestParam(value = "cid", required = false) Integer cid) {
		ProductCriteria criteria = new ProductCriteria();
        criteria.setPage(page);
        
        Map<String, Object> map = new HashMap<>();
        map.put("criteria", criteria);
        map.put("cid", cid);
		
		List<ProductVO> productList = mapper.productlists(map);
		List<CategoryVO> cateList = mapper.catelist();
		int totalCount = mapper.countAllProducts(map);

        ProductPageMaker pageMaker = new ProductPageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);
        model.addAttribute("productList", productList);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("cateList", cateList);
        model.addAttribute("cid", cid);       
        
        return "/product/itemlist";
	}
	
	@GetMapping("itemview")
	public void itemview(@RequestParam("pid") int pid, Model model,ProductVO vo) {
		ProductVO product = mapper.read(pid);
		CategoryNameDTO cate = mapper.cateview(pid);
		
		log.info("==상품 조회수 증가!==");
		mapper.update(vo); // 상품 클릭시 조회수 1 증가
		
		model.addAttribute("product", product);
		model.addAttribute("cate", cate);
	}
	
	//추천상품list
	@GetMapping("itemlists2")
	public String itemlists2(@RequestParam(value = "page", defaultValue = "1") int page,Model model,@RequestParam(value = "cid", required = false) Integer cid) {
		ProductCriteria criteria = new ProductCriteria();
        criteria.setPage(page);
        
        Map<String, Object> map = new HashMap<>();
        map.put("criteria", criteria);
        map.put("cid", cid);
		
		List<ProductVO> productList = mapper.productlists2(map);
		List<CategoryVO> cateList = mapper.catelist();
		int totalCount = mapper.countAllProducts2(map);

        ProductPageMaker pageMaker = new ProductPageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);
        model.addAttribute("productList", productList);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("cateList", cateList);
        model.addAttribute("cid", cid);
        
        return "/product/itemlist";
	}
	//브랜드관list
	@GetMapping("itemlistm")
	public String itemlistm(@RequestParam(value = "page", defaultValue = "1") int page,Model model,@RequestParam(value = "mutual", required = false) String mutual,@RequestParam(value = "cid", required = false) String cid) {
		ProductCriteria criteria = new ProductCriteria();
        criteria.setPage(page);
		
        Map<String, Object> map = new HashMap<>();
        map.put("criteria", criteria);
        map.put("mutual", mutual);
        map.put("cid", cid);
        
		List<ProductVO> productList = mapper.productlistb(map);
		List<CategoryVO> cateList = mapper.catelist();
		List<StoreVO> brandList = mapper.brandlist();
		int totalCount = mapper.countAllProductb(map);

        ProductPageMaker pageMaker = new ProductPageMaker();
        pageMaker.setCriteria(criteria);
        pageMaker.setTotalCount(totalCount);
        model.addAttribute("productList", productList);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("brandList", brandList);
        model.addAttribute("cateList", cateList);
        model.addAttribute("mutual", mutual);
        model.addAttribute("cid", cid);
        
        log.info(cid);
        log.info(mutual);
        
        return "/product/itemlistb";
	}
	
	@GetMapping("search")
	public String searchItme(@RequestParam(value = "page", defaultValue = "1") int page, Model model,@RequestParam(value = "cid", required = false) String cid,@RequestParam(value = "search", required = false) String search, @RequestParam(value = "searchType", required = false) String searchType) {
		ProductCriteria criteria = new ProductCriteria();
        criteria.setPage(page);
        criteria.setSearch(search);
        criteria.setSearchType(searchType);
		
		Map<String, Object> map = new HashMap<>();
        map.put("criteria", criteria);
        map.put("cid", cid);
        map.put("search", search);
        map.put("searchType", searchType);
		
		List<ProductVO> productList = mapper.SearchProductList(map);
		int totalCount = mapper.countSearchProduct(map);
		List<CategoryVO> cateList = mapper.catelist();
		
		ProductPageMaker pageMaker = new ProductPageMaker();
		
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(totalCount);
		
		model.addAttribute("productList", productList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("criteria", criteria);
		model.addAttribute("cateList", cateList);
		model.addAttribute("cid", cid);
		
		return "/product/itemlist";
	}
	
	@PostMapping("option")
	public void option(Integer pid, Model model) {
		log.info("==product option==");  
		
		List<ProductVO> option = mapper.option(pid);
		
		model.addAttribute("optionList", option);
	}
}
