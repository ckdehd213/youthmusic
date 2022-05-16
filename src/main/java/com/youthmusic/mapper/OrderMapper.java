package com.youthmusic.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.youthmusic.domain.OrderDetail;
import com.youthmusic.domain.OrderInfoVO;
import com.youthmusic.domain.OrderVO;

public interface OrderMapper {

	public List<OrderInfoVO> orderInfo(String mem_id);

	public List<OrderInfoVO> directOrderInfo(@Param("pro_num") Integer pro_num, @Param("ord_amount") Integer ord_amount);
	
	public void orderInsert(OrderVO vo);
	
	public void orderDetailInsert(OrderDetail vo);
	
	
	
	
}
