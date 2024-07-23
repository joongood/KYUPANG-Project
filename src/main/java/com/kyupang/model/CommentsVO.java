package com.kyupang.model;

import java.util.Date;

import lombok.Data;

@Data
public class CommentsVO {
	private Integer cmid; //댓글 고유번호(Auto)
	private Integer pid; //상품코드(ProductVO참고)
	private String comment_text; //댓글 내용
	private String writer; //작성자
	private Date writedate; //작성일
}
