package com.youthmusic.service;

import org.springframework.security.crypto.password.PasswordEncoder;

import com.youthmusic.domain.MemberVO;

public interface MemberService {

	public int join(MemberVO vo);
	
	public String checkID(String mem_id);
	
	public MemberVO login(String mem_id);
	
	public int edit(MemberVO vo);
	
	public String searchPwByEmail(String mem_email);
	
	public int changePw(String mem_email, String mem_pw);
	
	public String currentPw(String mem_id, PasswordEncoder cryptPassEnc, String current_mem_pw, String changed_mem_pw);
	
	public int memDelete(String mem_id, PasswordEncoder cryptPassEnc, String mem_pw);
}
