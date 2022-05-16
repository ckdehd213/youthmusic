package com.youthmusic.domain;

import lombok.Data;

@Data
public class OrderDetailInfo {

	/*
	  od.ord_num, od.pro_num, p.pro_name, od.ord_amount, od.ord_price, p.pro_uploadpath, p.pro_img
	 */
	
	private Integer ord_num;
	private String pro_name;
	private Integer pro_num;
	private int ord_amount;
	private int ord_price;
	private String pro_uploadpath;
	private String pro_img;
}
