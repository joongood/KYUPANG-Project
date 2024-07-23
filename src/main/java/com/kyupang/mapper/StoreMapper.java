package com.kyupang.mapper;

import org.apache.ibatis.annotations.Param;

import com.kyupang.model.StoreLoginDTO;
import com.kyupang.model.StoreVO;

public interface StoreMapper {
	public int emailCheck(String semail); //아이디 중복확인
	public int bnumberCheck(String bnumber); //아이디 중복확인
	public void create(StoreVO vo); //회원가입
	public StoreVO login(StoreLoginDTO dto); //로그인
	public StoreVO read(String session_id);
	public void otpUpdate(@Param("secretKey") String secretKey,@Param("session_id") String session_id); //관리자 페이지에서 만든 회원용 OTP추가
}
