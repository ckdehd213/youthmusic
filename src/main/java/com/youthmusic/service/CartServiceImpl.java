package com.youthmusic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.youthmusic.domain.CartListVO;
import com.youthmusic.domain.CartVO;
import com.youthmusic.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	private CartMapper mapper;
	
	@Override
	public void cartAdd(CartVO vo) {
		// TODO Auto-generated method stub
		mapper.cartAdd(vo);
	}

	@Override
	public List<CartListVO> cartList(String mem_id) {
		// TODO Auto-generated method stub
		return mapper.cartList(mem_id) ;
	}

	@Override
	public void cartDel(Integer cart_code) {
		// TODO Auto-generated method stub
		mapper.cartDel(cart_code);
	}

	@Override
	public void cartAllDel(String mem_id) {
		// TODO Auto-generated method stub
		mapper.cartAllDel(mem_id);
	}

}
