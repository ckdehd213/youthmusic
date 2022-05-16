package com.youthmusic.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {

	/*
	 * 작성일 : 2022/02/08
	 
	회원아이디            MEM_ID
	회원이름               MEM_NAME
	회원비밀번호         MEM_PW
	우편번호               MEM_POST
	기본주소               MEM_ADDR
	상세주소               MEM_ADDR2
	전화번호               MEM_PHONE
	이메일 수신여부     MEM_ECHK
	적립금                  MEM_POINT
	가입일                  MEM_CREDATE
	수정일                  MEM_UPDATE
	최근 접속시간        MEM_LASTLOGIN

	 */
	
	private String mem_id;
	private String mem_pw;
	private String mem_name;
	private String mem_email;
	private String mem_post;
	private String mem_addr;
	private String mem_addr2;
	private String mem_phone;
	private String mem_echk;
	private int mem_point;
	private Date mem_credate;
	private Date mem_update;
	private Date mem_lastlogin;
	
	
	
	
	
}
