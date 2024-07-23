package com.kyupang.model;

import lombok.Data;

@Data
public class TossVO {
	private String cart;//카트 고유id (session_cart)   
	private String buyer;
	private String zipcode; //받는 사람 이름
	private String address; //받는 사람 주소	
	private String addressdetail; //받는 사람 연락처
	private String code; //쿠폰코드
	private Integer point; //사용포인트
}
