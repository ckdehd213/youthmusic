package com.youthmusic.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youthmusic.util.UploadFileUtils;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.OrderDetailInfo;
import com.youthmusic.domain.OrderVO;
import com.youthmusic.domain.PageDTO;
import com.youthmusic.service.AdminOrderService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/admin/order/*")
@Controller
public class AdOrderManage {

	@Resource(name = "uploadFolder")
	String uploadFolder; // c:\\dev\\upload */
	
	@Inject
	private AdminOrderService oService;
	
	@GetMapping("/orderList")
	public void orderList(Criteria cri, @RequestParam(value = "startDate", required = false) String startDate, @RequestParam(value = "endDate", required = false) String endDate, Model model) {
		
		//log.info("시작날짜: " + startDate);
		//log.info("종료날짜: " + endDate);
		
		cri.setAmount(2);
		List<OrderVO> list = oService.getListWithPaging(cri, startDate, endDate);
		
		int total = oService.getTotalCount(cri, startDate, endDate);
		model.addAttribute("ord_total", total);
		
		//주문상태별 건수(getOrderStateCount)
		model.addAttribute("ord_count", oService.getOrderStateCount("주문접수"));
		model.addAttribute("ord_pay", oService.getOrderStateCount("결제완료"));
		model.addAttribute("ord_delivery", oService.getOrderStateCount("배송준비중"));
		model.addAttribute("ord_cancel", oService.getOrderStateCount("취소요청"));
		model.addAttribute("ord_change", oService.getOrderStateCount("교환요청"));
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("orderList", list);
	}
	
	//주문 상태별 목록보기
	@GetMapping("/orderStateList")
	public String orderStateList(@ModelAttribute("ord_state") String ord_state, Criteria cri, Model model) {
		
		cri.setAmount(2);
		List<OrderVO> list = oService.getOrderStateListWithPaging(cri, ord_state);
		
		int total = oService.getOrderStateTotalCount(cri, ord_state);
		model.addAttribute("ord_total", total);
		
		//주문상태별 건수
		model.addAttribute("ord_count", oService.getOrderStateCount("주문접수"));
		model.addAttribute("ord_pay", oService.getOrderStateCount("결제완료"));
		model.addAttribute("ord_delivery", oService.getOrderStateCount("배송준비중"));
		model.addAttribute("ord_cancel", oService.getOrderStateCount("취소요청"));
		model.addAttribute("ord_change", oService.getOrderStateCount("교환요청"));
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("orderList", list);
		
		return "/admin/order/orderList";
	}
	
	// 주문상태 (일괄, 개별) 변경
	@ResponseBody
	@PostMapping("/orderStateAll")
	public ResponseEntity<String> stateEdit(@RequestParam("ord_numArr[]") List<Integer> ord_numArr, @RequestParam("ord_stateArr[]") List<String> ord_stateArr){
		
		ResponseEntity<String> entity = null;
		
		//log.info(ord_numArr);
		//log.info(ord_StateArr);
		
		try {
			
			for(int i=0; i < ord_numArr.size(); i++) {
				oService.orderStateChange(ord_numArr.get(i), ord_stateArr.get(i));
			}
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
			
		}
		
		return entity;
	}
	
	@ResponseBody
	//@GetMapping("/checkDelete")
	@PostMapping("/checkDelete")
	//@RequestMapping(value = "/checkDelete", method = {RequestMethod.GET, RequestMethod.POST}  ) 둘다 지원
	public ResponseEntity<String> checkDelete(@RequestParam("ord_numArr[]") List<Integer> ord_numArr){
		
		ResponseEntity<String> entity = null;
		
		try {
			for(int i=0; i<ord_numArr.size(); i++) {
								
				//주문, 주문삭제테이블 삭제작업
				oService.ordDelete(ord_numArr.get(i));
				
			}
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity; 
	}
	
	@GetMapping("/detailInfo")
	public void detailInfo(Integer ord_num, Model model) {
		
		List<OrderDetailInfo> list = oService.ordDetailInfo(ord_num);
		
		// 슬래시를 역슬래시로 바꾸는 구문.
		for(int i=0; i<list.size(); i++) {
			OrderDetailInfo vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		}
		
		//주문번호를 이용한 주문상세정보
		model.addAttribute("oDetailList", list);
	}
	
	@ResponseBody
	@PostMapping("/detailListDelete")
	public ResponseEntity<String> detailListDelete(Integer ord_num, Integer pro_num) {
		ResponseEntity<String> entity = null;
		
		
		try {
			oService.ordDetailDelete(ord_num, pro_num);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}catch(Exception ex) {
			ex.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//상품리스트의 이미지출력(썸네일)
		@ResponseBody
		@GetMapping("/displayFile")  // 클라이언트에서 보내는 특수문자중에 역슬래시 데이타를 스프링에서 지원하지 않는다. 
		public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName) {
			
			ResponseEntity<byte[]> entity = null;
			
			entity = UploadFileUtils.getFileByte(uploadFolder, uploadPath, fileName );
			
			return entity;
		}
}
