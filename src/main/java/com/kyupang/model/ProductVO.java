package com.kyupang.model;

import lombok.Data;

@Data
public class ProductVO {
	private Integer pid;//상품코드(Auto)
	private String maincate;//카테고리(대분류 2자리)
	private String middlecate;//카테고리(중분류 4자리)
	private String mutual;//판매상점명
	private String pname;//상품명
	private	int price;//가격
	private int point;//적립포인트
	private int qty;//수량
	private String description; //상품설명
	private	String product_option;//상품옵션추가여부(Y, N)
	private	String option_value1;//상품옵션값
	private	String option_value2;//상품옵션값
	private	String option_value3;//상품옵션값
	private	String option_value4;//상품옵션값
	private	String option_value5;//상품옵션값
	private String productuse;//상품활성여부(Y, N)
	private	String hit;//히트상품(Y, N)
	private String suggest;//추천상품(Y, N)
	private	String newproduct;//신규상품(Y, N)
	private String popular;//인기상품(Y, N)
	private String salecheck;//할인여부(Y, N)
	private int saleprice;//할인가격
	private String file1;//상품이미지1
	private String file2;//상품이미지2
	private String file3;//상품이미지3
	private String file4;//상품이미지4
	private String file5;//상품이미지5
	private String listingdate;//상품게시일
	private int readcount;//상품조회수
}
