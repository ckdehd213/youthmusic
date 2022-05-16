package com.youthmusic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.youthmusic.domain.OrderDetailList;
import com.youthmusic.domain.OrderInfoVO;
import com.youthmusic.domain.OrderVO;
import com.youthmusic.mapper.CartMapper;
import com.youthmusic.mapper.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	private OrderMapper mapper;
	
	@Inject
	private CartMapper cartMapper;
	
	@Override
	public List<OrderInfoVO> orderInfo(String mem_id) {
		// TODO Auto-generated method stub
		return mapper.orderInfo(mem_id);
	}

	@Override
	public List<OrderInfoVO> directOrderInfo(Integer pro_num, Integer ord_amount) {
		// TODO Auto-generated method stub
		return mapper.directOrderInfo(pro_num, ord_amount);
	}

	@Transactional
	@Override
	public void orderInsert(OrderVO order, OrderDetailList orderDetail) {
		// TODO Auto-generated method stub
		//1) 주문작업
		mapper.orderInsert(order); // vo안에 ord_num 변수값을 이용하여, 시퀀스값을 참조할수가 있다.
		
		Integer ord_num = order.getOrd_num();
		String mem_id = order.getMem_id();
		
		//2) 주문상세 작업
		orderDetail.getOrderDetailList().forEach(oDetail -> {
			oDetail.setOrd_num(ord_num);
			mapper.orderDetailInsert(oDetail);
		});
		
		//3) 장바구니 삭제 (직접구매 또는 장바구니 목록에서 구매 공통으로 실행)
		cartMapper.cartAllDel(mem_id);
	}

}
