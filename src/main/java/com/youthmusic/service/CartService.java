package com.youthmusic.service;

import java.util.List;

import com.youthmusic.domain.CartListVO;
import com.youthmusic.domain.CartVO;

public interface CartService {

	public void cartAdd(CartVO vo);
	
	public List<CartListVO> cartList(String mem_id);
	
	public void cartDel(Integer cart_code);

	public void cartAllDel(String mem_id);
}
