package com.kyupang.mapper;

import java.util.List;
import java.util.Map;

import com.kyupang.model.WishlistVO;

public interface WishlistMapper {
	public void wishCreate(WishlistVO vo); //찜하기
	List<WishlistVO> wishlist(String session_id);//찜하기 list
	public void wishdelete(Integer wid);//찜하기 삭제
	public void sendcart(Map<String, Object> map); //장바구니로 전송
}
