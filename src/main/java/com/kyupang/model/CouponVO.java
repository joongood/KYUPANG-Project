package com.kyupang.model;

import lombok.Data;

@Data
public class CouponVO {
	private Integer couponid;
	private String code;
	private String description;
	private Double discount;
	private String expirydate;
	private int minpurchase;
	private String memail;
	private String used;
}

