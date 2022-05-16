package com.youthmusic.domain;

import java.util.List;

import lombok.Data;

@Data
public class OrderDetailList {

	// 주문페이지에서 주문상품정보를 여러개 입력받고자 할때 사용목적
	// ex) name파라미터 : orderDetailList[0].속성명, orderDetailList[1].속성명, orderDetailList[2].속성명 
	private List<OrderDetail> orderDetailList;
}
