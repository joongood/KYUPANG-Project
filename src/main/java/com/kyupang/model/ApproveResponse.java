package com.kyupang.model;

import lombok.Data;

@Data
public class ApproveResponse { //결제 승인요청에 의해 응답받는 정보

	private String aid; //요청 고유번호
	private String tid; //결제 고유번호
	private String cid; //가맹점 코드
	private String sid; //정기결제용 ID , 정기결제 CID롤 간건 결제 요청시 발급
	private String partner_order_id; //가맹점 주문번호
	private String partner_user_id; //가맹점 회원 ID
	private String partner_method_type; //결제 수단 : card or money
	private int amount; //결제금액
	private String item_name; //상품명
	private String item_code; //상품 코드
	private int quantity; //상품 수량
	private String created_at; //결제 준비 요청 시각
	private String approved_at; //결제 승인 시각
	private String payload; //결제 승인 요청에 대해 저장한 값, 요청시 전달된 내용
}
//카카오페이 관련 model