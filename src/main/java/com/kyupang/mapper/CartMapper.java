package com.kyupang.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kyupang.model.CartVO;
import com.kyupang.model.CouponVO;
import com.kyupang.model.Criteria;

public interface CartMapper {	
	
	List<CartVO> cartlist(@Param("session_cart") String session_cart, @Param("criteria") Criteria criteria); // 장바구리 리스트
	public void addcart(CartVO vo); // 장바구니 추가
	public void cartdelete(String ctid); //장바구니 삭제
	Integer carttotalprice(String session_cart); // 장바구니 속 총 상품의 가격
	int countAllcart(String session_cart); // 장바구니 갯수
	List<CouponVO> couponList(String session_id); //쿠폰리스트 불러오기
	public void qtyupdate(Map<String, Object> map);	
    Integer getMaxQty(int pid); // 상품의 최대 수량을 조회하는 메서드
}
