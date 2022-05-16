package com.youthmusic.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.youthmusic.domain.OrderDetailInfo;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.OrderVO;

public interface AdminOrderMapper {

	/*일반 주문목록*/
	public List<OrderVO> getListWithPaging(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	
	public int getTotalCount(@Param("cri") Criteria cri, @Param("startDate") String startDate, @Param("endDate") String endDate);
	
	/*주문상태별 목록*/
	public List<OrderVO> getOrderStateListWithPaging(@Param("cri") Criteria cri, @Param("ord_state") String ord_state);
	
	public int getOrderStateTotalCount(@Param("cri") Criteria cri, @Param("ord_state") String ord_state);
	
	/*주문상태별 건수*/
	public int getOrderStateCount(String ord_state);
	
	
	public void orderStateChange(@Param("ord_num") Integer ord_num, @Param("ord_state") String ord_state);
	
	public void ordDelete(Integer ord_num);
	public void ordDetailDelete(Integer ord_num);
	
	public List<OrderDetailInfo> ordDetailInfo(Integer ord_num);
	
	public void ordDetailListDelete(@Param("ord_num") Integer ord_num, @Param("pro_num") Integer pro_num);
	
	
	
}
