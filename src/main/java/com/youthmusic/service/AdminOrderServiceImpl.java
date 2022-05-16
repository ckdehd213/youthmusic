package com.youthmusic.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.youthmusic.mapper.AdminOrderMapper;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.OrderDetailInfo;
import com.youthmusic.domain.OrderVO;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {

	@Inject
	private AdminOrderMapper oMapper;
	
	@Override
	public List<OrderVO> getListWithPaging(Criteria cri, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return oMapper.getListWithPaging(cri, startDate, endDate);
	}

	@Override
	public int getTotalCount(Criteria cri, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return oMapper.getTotalCount(cri, startDate, endDate);
	}

	@Override
	public List<OrderVO> getOrderStateListWithPaging(Criteria cri, String ord_state) {
		// TODO Auto-generated method stub
		return oMapper.getOrderStateListWithPaging(cri, ord_state);
	}

	@Override
	public int getOrderStateTotalCount(Criteria cri, String ord_state) {
		// TODO Auto-generated method stub
		return oMapper.getOrderStateTotalCount(cri, ord_state);
	}

	@Override
	public int getOrderStateCount(String ord_state) {
		// TODO Auto-generated method stub
		return oMapper.getOrderStateCount(ord_state);
	}

	@Override
	public void orderStateChange(Integer ord_num, String ord_state) {
		// TODO Auto-generated method stub
		oMapper.orderStateChange(ord_num, ord_state);
	}

	@Transactional
	@Override
	public void ordDelete(Integer ord_num) {
		// TODO Auto-generated method stub
		//주문상세테이블에서 삭제
		oMapper.ordDetailDelete(ord_num);
		//주문삭제
		oMapper.ordDelete(ord_num);
	}

	@Override
	public List<OrderDetailInfo> ordDetailInfo(Integer ord_num) {
		// TODO Auto-generated method stub
		return oMapper.ordDetailInfo(ord_num);
	}

	@Override
	public void ordDetailDelete(Integer ord_num, Integer pro_num) {
		// TODO Auto-generated method stub
		oMapper.ordDetailListDelete(ord_num, pro_num);
	}

}
