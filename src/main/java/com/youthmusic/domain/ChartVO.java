package com.youthmusic.domain;

import lombok.Data;

@Data
public class ChartVO {

	private String cg_name;
	private int sales;
	
	private String year;
	private int totalprice;
}
