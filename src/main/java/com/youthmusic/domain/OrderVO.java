package com.youthmusic.domain;

import java.util.Date;

import lombok.Data;


/*
작성일 : 22/03/28
*/

@Data
public class OrderVO {

	// ord_num, mem_id, ord_name, ord_post, ord_addr, ord_addr2, ord_phone, ord_total_price, ord_message, ord_depositor, ord_state, ord_date
	private Integer ord_num;
	private String mem_id;
	private String ord_name;
	private String ord_post;
	private String ord_addr;
	private String ord_addr2;
	private String ord_phone;
	private int ord_total_price;
	private String ord_message;
	private String ord_depositor;
	private String ord_state;
	private Date ord_date;
}
