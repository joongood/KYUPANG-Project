package com.kyupang.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.kyupang.model.CartTranDTO;
import com.kyupang.model.CouponVO;
import com.kyupang.model.Criteria;
import com.kyupang.model.OrdertranVO;

public interface MypageMapper {

	
	//쿠폰목록
	List<CouponVO> couponlist(@Param("session_id") String session_id,@Param("criteria") Criteria criteria); // 쿠폰리스트
	int countAllCoupon(String session_id); // 쿠폰 수
	
	//구매내역 및 환불
	List<CartTranDTO> cartlist(@Param("odid") String odid,@Param("criteria") Criteria criteria); // 거래리스트
	List<CartTranDTO> orderlist(@Param("session_id") String session_id,@Param("criteria") Criteria criteria);//결제리스트
	public int countAllcart(String session_id); // 거래 수
	public int countAllorder(String odid); // 거래 수
    public int countoneorder(String odid); //주문 번호(odid)를 기반으로 상품 수를 조회하는 메서드
	void transOk(int ctid); // 구매확정
	public int pluspoint(Map<String, Object> map);//카트 상품 포인트 더하기
	public void minuspoint(Map<String, Object> map);//구매상품 포인트 적립하기
	public void cancel(Map<String, Object> map);//구매상품 포인트 적립하기
	public void ocancel(Map<String, Object> map);//구매상품 포인트 적립하기
}
