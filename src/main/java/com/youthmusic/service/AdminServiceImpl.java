package com.youthmusic.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youthmusic.domain.AdminVO;
import com.youthmusic.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {

	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;
	
	@Override
	public AdminVO adminLogin(String ad_id) {
		// TODO Auto-generated method stub
		return mapper.adminLogin(ad_id);
	}

	@Override
	public int adminRegister(AdminVO vo) {
		// TODO Auto-generated method stub
		return mapper.adminRegister(vo);
	}

}
