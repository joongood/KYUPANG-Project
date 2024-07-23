package com.kyupang.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kyupang.model.CartTranDTO;
import com.kyupang.model.VisitorStats;

public interface StatisticsMapper {
    // 결제수단별 통계 조회
    public int getCountToss();
    public int getCountKakao();
    public int getCountDeposit();
    public int getCountAll();
    
    // 방문자 수 집계 조회
    List<VisitorStats> getVisitorStatsForLastWeek(@Param("startDate") Date startDate, @Param("endDate") Date endDate);
    
    // 최근 일주일 이내 가입자 비율 조회
    public double getRecentSignupRate();
    
    // 최근 일주일 이내 탈퇴자 비율 조회
    public double getRecentUnsubscribeRate();
    
    // 오늘 날짜 기준 전체 주문 수 조회
    public int getTotalOrdersToday();
    
    // 결제가격 합계가 높은 순으로 장바구니 목록 조회
    List<CartTranDTO> getCartListOrderByTotalPayPriceDesc();
    
    // 월별 매출 조회
    List<Map<String, Object>> getMonthlySales(String session_label);

    // 가장 많이 팔리는 상품 리스트 조회
    List<Map<String, Object>> getTopSellingProducts(String session_label);
     
}
