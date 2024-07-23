package com.kyupang.model;

import lombok.Data;

@Data
public class ReadyResponse {

	private String tid;//결제 준비 단계에서 받은 결제 고유번호
	private String next_redirect_pc_url;
	private String partner_order_id; //가맹점 주문번호
}
//카카오페이 관련 model