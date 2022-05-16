package com.youthmusic.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AdminVO {

	// ad_id, ad_pw, ad_name, ad_lastlogin
	private String ad_id;
	private String ad_pw;
	private String ad_name;
	private Date ad_lastlogin;
}
