package com.kyupang.model;

import lombok.Data;

@Data
public class BannerVO {
	private Integer bid; //배너신청고유ID
	private String title; //배너신청제목
	private int bprice; //배너신청제안가격
	private String imageurl; //이미지URL
	private String mutual; //신청가맹점명
	private String requestdate; //요청일
	private String approvalDate; //승인일
	private String startdate; //게시시작일
	private String enddate; //게시종료일
	private String approved; //승인상태
	private String status; //활성여부
}
