package com.kyupang.model;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private Integer bid;//(auto increment)
	private String title;//제목
	private String contenttext;//내용
	private Date date;//제목
	private String file1;//파일명
}
