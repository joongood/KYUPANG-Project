package com.kyupang.model;

import java.util.Date;

import lombok.Data;

@Data
public class OrdertranVO {
	private Integer tranid;//트랜젝션 고유번호(Auto)
	private String odid;//주문번호
	private String buyer;//구매자
	private Date dealdate;//거래날짜
	private Date trandate;//트랜젝션날짜(변경시 지속적으로 업데이트됨)
	private int payprice;//결제금액
	private String transtatus;//트랜젝션상태(주문완료, 주문취소, 거래완료)
	private String paymethod;//결제방법(카카오페이, 토스페이, 페이코, 무통장거래)
	private	String zipcode; //우편번호
	private	String address; //주소
	private	String addressdetail; //상세주소
	private String cart;//카트 고유id (session_cart)
}
