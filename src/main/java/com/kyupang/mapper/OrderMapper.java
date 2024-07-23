package com.kyupang.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kyupang.model.CartVO;
import com.kyupang.model.OrdertranVO;
import com.kyupang.model.TossVO;

public interface OrderMapper {
	public CartVO read(String session_cart);
	public void create(OrdertranVO vo); //무통장
	public void save(TossVO vo); //toss
	public TossVO saveread(String session_cart);//토스 구매자 정보 불러오기
	public void tosscreate(@Param("odid") String odid,
					       @Param("buyer") String buyer,
					       @Param("payprice") int payprice,
					       @Param("zipcode") String zipcode,
					       @Param("address") String address,
					       @Param("addressdetail") String addressdetail,
					       @Param("cart") String cart); //toss페이
	public void kakaocreate(Map<String, Object> map); //카카오페이
	public void update(String cart);
	public void usedCoupon(String code);
	public void usedpoint(Map<String, Object> map);
	public int pluspoint(String session_cart);//카트 상품 포인트 더하기
	public void addpoint(Map<String, Object> map);//구매상품 포인트 적립하기
	public void depositcreate(Map<String, Object> map); //무통장 관리자용
	public void minusqty(String session_cart);
}
