package com.kyupang.mapper;

import com.kyupang.model.LoginDTO;
import com.kyupang.model.MemberVO;

public interface MemberMapper {
	public int emailCheck(String memail); //아이디 중복확인
	public void create(MemberVO vo); //회원가입
	public MemberVO login(LoginDTO dto); //로그인
	public MemberVO read(String session_id); //수정페이지
	public void update(MemberVO vo); //회원수정
	
	public void kakaoLogin(MemberVO vo); //카카오 회원가입
	public void naverLogin(MemberVO vo); //네이버 회원가입
	public void supdate(MemberVO vo); //소셜 회원수정	
	
	public void cartDelete(String session_cart); //장바구니 초기화
	
	public int getPoint(String session_id);
}
