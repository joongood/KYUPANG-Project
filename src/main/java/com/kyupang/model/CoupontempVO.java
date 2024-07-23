package com.kyupang.model;

import lombok.Data;

@Data
public class CoupontempVO {
		private Integer couponid;
		private String description;
		private Double discount;
		private String expirydate;
		private int minpurchase;
}
