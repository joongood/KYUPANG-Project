package com.kyupang.model;

import lombok.Data;

@Data
public class CategoryNameDTO {
	private String maincate;//카테고리(대분류 2자리)
	private String middlecate;//카테고리(중분류 4자리)
	private String categoryname; //대분류 카테고리 이름
	private String middlecatename; //중분류 카테고리 이름
	private String pname;//상품명
}
