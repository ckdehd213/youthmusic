package com.youthmusic.domain;

import lombok.Data;

@Data
public class CartListVO {

	private Long cart_code;
	private Integer pro_num;
	private String mem_id;
	private int cart_amount;
	private String pro_name;
	private String pro_img;
	private String pro_uploadpath;
	private int pro_price;
	private int pro_discount;
}
