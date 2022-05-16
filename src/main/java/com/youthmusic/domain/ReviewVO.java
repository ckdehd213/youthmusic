package com.youthmusic.domain;

import java.util.Date;

import lombok.Data;


/*
작성일 : 22/03/22
*/

@Data
public class ReviewVO {

	//rev_num, mem_id, pro_num, rev_content, rev_score, rev_regdate
	private Integer rev_num;
	private String mem_id;
	private Integer pro_num;
	private String rev_content;
	private int rev_score;
	private Date rev_regdate;
	
}
