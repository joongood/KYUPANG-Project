package com.kyupang.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.kyupang.model.ApproveResponse;
import com.kyupang.model.ReadyResponse;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class KakaoPayServiceImpl {

	public ReadyResponse payReady(String itemName, int quantity, String mem_id, int totalAmount) {

		String order_id = "100"; //가맹점 주문번호

		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();

		//테스트 가맹점 코드 : TC0ONETIME
		parameters.add("cid", "TC0ONETIME"); //가맹점 코드 10자리(테스트 코드 적용)
		parameters.add("partner_order_id", order_id); //가맹점 주문번호
		parameters.add("partner_user_id", mem_id); //가맹점 회원 아이디
		parameters.add("item_name", itemName); //상품명
		parameters.add("quantity", String.valueOf(quantity)); //수량
		parameters.add("total_amount", String.valueOf(totalAmount)); //총 주문금액
		parameters.add("tax_free_amount", "0"); //비과세
		parameters.add("approval_url", "http://localhost:8080/payment/orderApp"); //결제 성공시
		parameters.add("cancel_url", "http://localhost:8080/payment/orderCancel"); //결제 취소시
		parameters.add("fail_url", "http://localhost:8080/payment/orderFail"); //결제 실패시

		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

		//외부 API 통신
		RestTemplate template = new RestTemplate();

		String url = "https://kapi.kakao.com/v1/payment/ready";

		ReadyResponse readyResponse = template.postForObject(url, requestEntity, ReadyResponse.class);

		return readyResponse;
	}

	public ApproveResponse payApprove(String tid, String pgToken, String mem_id) {

		String order_id = "100"; //가맹점 주문번호

		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();

		parameters.add("cid", "TC0ONETIME"); //가맹점 코드 10자리(테스트 코드 적용)
		parameters.add("tid", tid); //결제 고유번호
		log.info(tid);
		parameters.add("partner_order_id", order_id); //가맹점 주문번호
		parameters.add("partner_user_id", mem_id); //가맹점 회원 아이디
		parameters.add("pg_token", pgToken);//gpt왈 : 결제 준비 단계에서 결제가 성공적으로 이루어졌을데 카페에서 반환하는 토큰

		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

		//외부 API 통신
		RestTemplate template = new RestTemplate();

		String url = "https://kapi.kakao.com/v1/payment/approve";

		ApproveResponse approveResponse = template.postForObject(url, requestEntity, ApproveResponse.class);


		return approveResponse;
	}


	private HttpHeaders getHeaders() {

		HttpHeaders headers = new HttpHeaders();

		headers.set("Authorization", "KakaoAK 3823965aacb970a9fe6447c6715558c2"); //카카오 앱 : Admin Key 값
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		return headers;
	}
}