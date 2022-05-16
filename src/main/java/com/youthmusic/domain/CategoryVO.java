package com.youthmusic.domain;

import lombok.Data;

@Data
public class CategoryVO {

	
	private Integer cg_code; // 기본카테고리 코드
	private Integer cg_prt_code; // 부모카테고리 코드
	private String cg_name; 
}
