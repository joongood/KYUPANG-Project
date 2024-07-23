package com.kyupang.model;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	//OrderMapper 등 관련없이 카카오페이 때문에 만들었음
	private String odid; //주문번호
	private String buyer; //주문번호
	private int qty; //상품 수
	private int payprice; //총 주문금액
	private String zipcode; //받는 사람 이름
	private String address; //받는 사람 주소	
	private String addressdetail; //받는 사람 연락처
	private String orderName; //상품명
	private String code; //쿠폰코드
	private Integer point; //사용포인트
	
	
	
	private String odr_addr; //주문자 주소
	private String odr_phone; //주문자 연락처



	private String odr_memo; //요청사항 메모

	
	private Date pay_date; //결제일

	private String pay_method; //결제방식(무통장, 카카오페이)
	private String tid; //카카오 결제고유번호
	private String pay_type; //결제 성공여부

	private String pay_bank_user; //입금자명(무통장)
	private String pay_bank_name; //은행명
	private int pay_rest_price; //미지급금
}