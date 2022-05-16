package com.youthmusic.service;

import java.util.List;

import com.youthmusic.domain.OrderDetailList;
import com.youthmusic.domain.OrderInfoVO;
import com.youthmusic.domain.OrderVO;



public interface OrderService {

	public List<OrderInfoVO> orderInfo(String mem_id);
	
	public List<OrderInfoVO> directOrderInfo(Integer pro_num, Integer ord_amount);
	
	public void orderInsert(OrderVO vo, OrderDetailList vo2);
		
}
