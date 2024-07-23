package com.kyupang.model;

import java.util.Date;

import lombok.Data;

@Data
public class WishlistVO {
   private Integer wid;//(Auto)
   private String mid;//구매자id (session_id) 
   private String mutual;//판매상점명
   private Integer pid;//상품코드(ProductVO참고)
   private String pname;//상품명
   private int price;//가격
   private int point;//포인트
   private int qty;//수량
   private String file1;//상품이미지1
   private String option_value1;//상품옵션값
   private String option_value2;//상품옵션값
   private String option_value3;//상품옵션값
   private String option_value4;//상품옵션값
   private String option_value5;//상품옵션값
}
