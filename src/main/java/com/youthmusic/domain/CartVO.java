package com.youthmusic.domain;

import lombok.Data;


/*
   작성일 : 22/03/08
 */

@Data
public class CartVO {

	//cart_code, pro_num, mem_id, cart_amount
	private Long cart_code;
	private Integer pro_num;
	private String mem_id;
	private int cart_amount;
}
