package com.kyupang.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kyupang.mapper.AdminMapper;
import com.kyupang.mapper.ProductMapper;
import com.kyupang.mapper.VisitorStatsMapper;
import com.kyupang.model.BannerVO;
import com.kyupang.model.ProductVO;
import com.kyupang.model.VisitorStats;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@AllArgsConstructor
public class HomeController {

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    private AdminMapper mapper;
    private ProductMapper pmapper;
    private VisitorStatsMapper visitorStatsMapper;

    
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Model model, HttpServletRequest request) {
        logger.info("==info==");
        
        List<BannerVO> banners = mapper.getApprovedBanners();
        model.addAttribute("banners", banners);
        
        List<ProductVO> productList = pmapper.productlistIndex();
        model.addAttribute("productList", productList);
        
        String ipAddress = request.getRemoteAddr(); // 클라이언트의 IP 주소 가져오기

        VisitorStats visitorStats = new VisitorStats();
        visitorStats.setVisitDate(new Date());
        visitorStats.setIpAddress(ipAddress);

        visitorStatsMapper.insertVisitorStats(visitorStats);

        return "index";
    }
}
