package com.youthmusic.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.youthmusic.domain.MemberVO;
import com.youthmusic.domain.OrderDetailList;
import com.youthmusic.domain.OrderInfoVO;
import com.youthmusic.domain.OrderVO;
import com.youthmusic.service.KakaoPayServiceImpl;
import com.youthmusic.service.OrderService;
import com.youthmusic.util.UploadFileUtils;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/order/*")
@Controller
public class OrderManage {

	@Resource(name = "uploadFolder")
	String uploadFolder; // c:\\dev\\upload */
	
	@Inject
	private OrderService oService;
	
	@Inject
	private KakaoPayServiceImpl kakaopayService;
	
	//orderInfo
	@RequestMapping("/orderInfo")
	public void orderInfo(@RequestParam(value = "pro_num", required = false) Integer pro_num, @RequestParam(value = "pro_stock", required = false) Integer pro_stock, HttpSession session, Model model) {
		
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		List<OrderInfoVO> list = null;
		/* 바로구매 추가시 String type 추가후 아래 코드추가
		 * 
		if(type.equals("direct")) {
			// 상품1개
			list = oService.directOrderInfo(pro_num, pro_stock);  // 1)메인에서 바로구매 2)상품상세 바로구매
			(list.get(0)).setCart_amount(pro_stock); // 수량변경.
		}else if(type.equals("cart_order")) {
			list = oService.orderInfo(mem_id);      // 장바구니에서 구매
		}
		*/
		list = oService.orderInfo(mem_id); //  장바구니에서 구매
		
		// 슬래시를 역슬래시로 바꾸는 구문.
		for(int i=0; i<list.size(); i++) {
			OrderInfoVO vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		} 
		
		//주문내역정보
		model.addAttribute("orderInfo", list);
	}
	
	//상품리스트의 이미지출력(썸네일)
		@ResponseBody
		@GetMapping("/displayFile")  // 클라이언트에서 보내는 특수문자중에 역슬래시 데이타를 스프링에서 지원하지 않는다. 
		public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName) {
			
			ResponseEntity<byte[]> entity = null;
			
			entity = UploadFileUtils.getFileByte(uploadPath, uploadPath, fileName);
			
			return entity;
		}
		
	//orderAction	
		@PostMapping("/orderAction")
		public String orderAction(OrderVO order, OrderDetailList orderDetail, HttpSession session, RedirectAttributes rttr) {
			
			order.setMem_id(((MemberVO) session.getAttribute("loginStatus")).getMem_id());
			
			log.info("주문정보: " + order);
			log.info("주문상세정보: " + orderDetail);
			
			
			oService.orderInsert(order, orderDetail);
			
			// 예> 주문번호:100 [상품 5 건]
			String pro_name = String.format("주문번호:%d [상품 %d 건]", order.getOrd_num(), orderDetail.getOrderDetailList().size());
			
			
			// 카카오페이 결제시 필요한 정보.
			rttr.addAttribute("ord_name", order.getOrd_name()); // 주문자
			rttr.addAttribute("ord_total_price", order.getOrd_total_price()); // 주문가격
			rttr.addAttribute("ord_zipcode", order.getOrd_post()); // 주문자 우편번호
			rttr.addAttribute("pro_name", pro_name ); // 상품명
			
			return "redirect:/order/orderPayView";
		}
		
		@GetMapping("/orderPayView")
		public void orderPayView(@ModelAttribute("order") OrderVO order, @ModelAttribute("pro_name") String pro_name) {
			
		}
		
		// 카카오페이결제 요청
		/*
		@GetMapping("/pay")
		public @ResponseBody ReadyResponse payReady(@RequestParam(name = "total_amount") int totalAmount) {
			
			//log.info("주문정보:"+order);
			log.info("주문가격:"+totalAmount);
			// 카카오 결제 준비하기	- 결제요청 service 실행.
			ReadyResponse readyResponse = kakaopayService.payReady(totalAmount);
			// 요청처리후 받아온 결재고유 번호(tid)를 모델에 저장
//			model.addAttribute("tid", readyResponse.getTid());
			log.info("결재고유 번호: " + readyResponse.getTid());		
			// Order정보를 모델에 저장
//			model.addAttribute("order",order);
			
			return readyResponse; // 클라이언트에 보냄.(tid,next_redirect_pc_url이 담겨있음.)
		}
		*/
			
	    // 결제승인요청
		/*
		@GetMapping("/order/pay/completed")
		public String payCompleted(@RequestParam("pg_token") String pgToken, @ModelAttribute("tid") String tid, @ModelAttribute("order") Order order,  Model model) {
			
			log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
			log.info("주문정보: " + order);		
			log.info("결재고유 번호: " + tid);
			
			// 카카오 결재 요청하기
			ApproveResponse approveResponse = kakaopayService.payApprove(tid, pgToken);	
			
			// 5. payment 저장
			//	orderNo, payMathod, 주문명.
			// - 카카오 페이로 넘겨받은 결재정보값을 저장.
			Payment payment = Payment.builder() 
					.paymentClassName(approveResponse.getItem_name())
					.payMathod(approveResponse.getPayment_method_type())
					.payCode(tid)
					.build();
			
			orderService.saveOrder(order,payment);
			
			return "redirect:/orders";
		}
		*/
		/*
		// 결제 취소시 실행 url
		@GetMapping("/order/pay/cancel")
		public String payCancel() {
			return "redirect:/carts";
		}
	    
		// 결제 실패시 실행 url    	
		@GetMapping("/order/pay/fail")
		public String payFail() {
			return "redirect:/carts";
		}
		*/
		
}
