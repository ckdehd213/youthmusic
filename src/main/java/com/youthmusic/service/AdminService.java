package com.youthmusic.service;

import com.youthmusic.domain.AdminVO;

public interface AdminService {

	public AdminVO adminLogin(String ad_id);
	
	public int adminRegister(AdminVO vo);
}
