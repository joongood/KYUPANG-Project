package com.kyupang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kyupang.model.CommentsCriteria;
import com.kyupang.model.CommentsVO;

public interface CommentsMapper {

	public List<CommentsVO> CommentsList(Integer pid); // 리뷰목록
	public void addComments(CommentsVO vo); // 리뷰등록
	public void modifyComments(CommentsVO vo); //리뷰수정
	public void deleteComments(Integer cmid); //리뷰삭제
	
	public List<CommentsVO> commentsPage(@Param("pid") Integer pid,@Param("criteria") CommentsCriteria criteria);
	public int count(@Param("pid") Integer pid);
}
