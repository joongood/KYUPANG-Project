package com.kyupang.model;

import lombok.Data;

@Data
public class CartTranDTO {
	private Integer ctid;
	private Integer tranid;
	private String cart;
	private String mid;
	private String mutual;
	private Integer pid;
	private String pname;
	private int price;
	private int point;
	private int qty;
	private int payprice;
	private String cartstatus;
	private String file1;
	private String odid;
	private String buyer;
	private String dealdate;
	private String trandate;
	private String transtatus;
	private String paymethod;
	private int ordercount; //get, set 쓰기위한 임시
	private String cal; //정산 상태
	private int total_payprice;
}
