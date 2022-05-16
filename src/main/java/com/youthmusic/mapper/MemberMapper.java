package com.youthmusic.mapper;

import org.apache.ibatis.annotations.Param;

import com.youthmusic.domain.MemberVO;

public interface MemberMapper {

	public int join(MemberVO vo);
	
	public String checkID(String mem_id);
	
	public MemberVO login(String mem_id);
	
	public int edit(MemberVO vo);
	
	public String searchPwByEmail(String mem_email);
	
	public int changePw(@Param("mem_email") String mem_email, @Param("mem_pw") String mem_pw);
	
	public String currentPw(String mem_id);
	
	public int changeNewPw(@Param("mem_id") String mem_id, @Param("changed_mem_pw") String changed_mem_pw);
	
	public int memDelete(String mem_id);
}
