package com.kyupang.model;

import lombok.Data;

@Data
public class CategoryVO {
	private String cid; //카테고리 고유번호
	private String cname; //카테고리 이름
	private String cuse; //사용여부(Y, N)
}
