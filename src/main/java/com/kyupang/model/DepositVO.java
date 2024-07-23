package com.kyupang.model;
 
import lombok.Data;
 
@Data
public class DepositVO {
	private int did;
	private String odid;//주문번호
	private int allpoint;//적립포인트
}
