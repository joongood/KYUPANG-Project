package com.kyupang.model;

import lombok.Data;

@Data
public class MemberVO {
	private Integer mid; //회원 고유번호(Auto)
	private	String memail; //회원 이메일
	private String mname; //회원 이름
	private String identification;//본인인증여부(Y, N)
	private	String mage; //생년월일
	private String mgender; //성별(남자, 여자)
	private String mpassword; //회원 비밀번호
	private	String mphone; //회원전화번호
	private	String zipcode; //우편번호
	private	String address; //주소
	private	String addressdetail; //상세주소
	private	String joindate; //가입날짜
	private	String mlevel; // 레벨
	private	String memberstatus; //회원상태(정상, 정지, 탈퇴)
	private	String loginstatus; //로그인분류(일반, 소셜, 가맹점회원)
	private int mpoint;// 회원보유포인트
	private String label; //소속
}
