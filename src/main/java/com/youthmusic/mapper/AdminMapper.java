package com.youthmusic.mapper;

import com.youthmusic.domain.AdminVO;

public interface AdminMapper {
	
	public AdminVO adminLogin(String ad_id);

	public int adminRegister(AdminVO vo);
}
