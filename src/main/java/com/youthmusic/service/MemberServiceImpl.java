package com.youthmusic.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.youthmusic.domain.MemberVO;
import com.youthmusic.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Override
	public int join(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.join(vo);
	}

	@Override
	public String checkID(String mem_id) {
		// TODO Auto-generated method stub
		return mapper.checkID(mem_id);
	}

	@Override
	public MemberVO login(String mem_id) {
		// TODO Auto-generated method stub
		return mapper.login(mem_id);
	}

	@Override
	public int edit(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.edit(vo);
	}

	@Override
	public String searchPwByEmail(String mem_email) {
		// TODO Auto-generated method stub
		return mapper.searchPwByEmail(mem_email);
	}

	@Override
	public int changePw(String mem_email, String mem_pw) {
		// TODO Auto-generated method stub
		return mapper.changePw(mem_email, mem_pw);
	}

	@Override
	public String currentPw(String mem_id, PasswordEncoder cryptPassEnc, String current_mem_pw, String changed_mem_pw) {
		// TODO Auto-generated method stub
		
		String result = "noPw";
		
		// 디비의 암호화된 비밀번호가 사용자가 입력한 비밀번호로 생성된 것인지의 여부
		if(cryptPassEnc.matches(current_mem_pw, mapper.currentPw(mem_id))) {
			mapper.changeNewPw(mem_id, changed_mem_pw);
			result = "success";
		}
		return result;
	}

	@Override
	public int memDelete(String mem_id, PasswordEncoder cryptPassEnc, String mem_pw) {
		// TODO Auto-generated method stub
		
		int count = 0;
		
		if(cryptPassEnc.matches(mem_pw, mapper.currentPw(mem_id))) {
			count = mapper.memDelete(mem_id);
		}
		
		return count;
	}

	
}
