package com.youthmusic.service;

import java.util.List;

import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.OrderDetailInfo;
import com.youthmusic.domain.OrderVO;

public interface AdminOrderService {

	public List<OrderVO> getListWithPaging(Criteria cri, String startDate, String endDate);
	
	public int getTotalCount(Criteria cri, String startDate, String endDate);
	
	public List<OrderVO> getOrderStateListWithPaging(Criteria cri, String ord_state);
	
	public int getOrderStateTotalCount(Criteria cri, String ord_state);
	
	public int getOrderStateCount(String ord_state);
	
	public void orderStateChange(Integer ord_num, String ord_state);
	
	public void ordDelete(Integer ord_num);
	
	public List<OrderDetailInfo> ordDetailInfo(Integer ord_num);
	
	public void ordDetailDelete(Integer ord_num, Integer pro_num);
}
