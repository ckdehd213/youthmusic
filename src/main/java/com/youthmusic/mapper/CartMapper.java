package com.youthmusic.mapper;

import java.util.List;

import com.youthmusic.domain.CartListVO;
import com.youthmusic.domain.CartVO;

public interface CartMapper {

	public void cartAdd(CartVO vo);
	
	public List<CartListVO> cartList(String mem_id);
	
	public void cartDel(Integer cart_code);

	public void cartAllDel(String mem_id);
	
}
