package com.kyupang.mapper;

import java.util.List;

import com.kyupang.model.BoardVO;
import com.kyupang.model.Criteria;

public interface BoardMapper {
	List<BoardVO> boardlist(Criteria criteria);
	public void boardcreate(BoardVO vo); //회원가입
	public BoardVO boardread(int bid); //상세페이지
	public void boardupdate(BoardVO vo); //회원수정
	int countBoard();
	public void deleteBoard(int bid);
}
