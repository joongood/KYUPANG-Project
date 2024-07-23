package com.kyupang.model;

import lombok.Data;

@Data
public class StoreVO {
	private Integer sid;//가맹점 코드(Auto)
	private String semail;//가맹점 이메일
	private String mutual;// 상호명
	private String ownername;// 대표자명
	private String bnumber; //사업자 등록번호
	private	String bnumberok; //사업자 등록번호 확인 여부(Y, N)
	private	String identification;//본인인증여부(Y, N)
	private String authok;//OTP인증여부(Y, N)
	private	String spassword;//비밀번호
	private String sphone;//대표번호
	private String zipcode;//우편번호
	private String address;//주소
	private String addressdetail;//상세주소
	private String joindate;//가입날짜
	private String slevel;//가맹점레벨
	private String storestatus;//가맹점상태(정상, 정지, 탈퇴)
	private String loginstatus;//로그인분류(가맹점)
	private String secretkey;//otp고유번호
	private String ok; //가맹점 정보 수정용 임시 
}
