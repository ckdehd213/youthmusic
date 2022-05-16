package com.youthmusic.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.MemberVO;
import com.youthmusic.domain.PageDTO;
import com.youthmusic.domain.ReviewVO;
import com.youthmusic.service.ReviewService;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/review/*")
@Controller
public class ReviewManage {
	
	@Inject
	private ReviewService service;

	// 상품후기목록  with paging
	@GetMapping("/productReview")
	public void product_review(@ModelAttribute("cri") Criteria cri, @RequestParam("pro_num") Integer pro_num, Model model) {
		
		log.info("productReview");
		
		cri.setAmount(3);
		
		int total = service.getTotalCount(pro_num);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("reviewListVO", service.reviewListWithPaging(cri, pro_num));
		
	}
	
	// 상품후기등록
	@ResponseBody
	@PostMapping("/productReviewWrite")
	public ResponseEntity<String> productReviewWrite(ReviewVO vo, HttpSession session){
		
		log.info("후기내용" + vo);
		
		vo.setMem_id(((MemberVO) session.getAttribute("loginStatus")).getMem_id());
		
		ResponseEntity<String> entity = null;
		
		try {
			service.reviewInsert(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}catch(Exception ex) {
			ex.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 상품후기 수정
	@ResponseBody
	@PostMapping("/productReviewEdit")
	public ResponseEntity<String> productReviewEdit(ReviewVO vo, HttpSession session){
		
		vo.setMem_id(((MemberVO) session.getAttribute("loginStatus")).getMem_id());
		
		ResponseEntity<String> entity = null;
		
		try {
			service.reviewEdit(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}catch(Exception ex) {
			ex.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	// 상품후기 삭제
	@ResponseBody
	@PostMapping("/productReviewDel")
	public ResponseEntity<String> productReviewDel(Integer rev_num){
		
		ResponseEntity<String> entity = null;
		
		try {
			service.reviewDel(rev_num);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		}catch(Exception ex) {
			ex.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
