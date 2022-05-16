package com.youthmusic.domain;

import lombok.Data;


/*
작성일 : 22/03/28
*/

@Data
public class OrderDetail {

	// ord_num, pro_num, ord_amount, ord_price
	private Integer ord_num;
	private Integer pro_num;
	private int ord_amount;
	private int ord_price;
}
