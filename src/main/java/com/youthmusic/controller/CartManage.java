package com.youthmusic.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youthmusic.domain.CartListVO;
import com.youthmusic.domain.CartVO;
import com.youthmusic.domain.MemberVO;
import com.youthmusic.service.CartService;
import com.youthmusic.util.UploadFileUtils;

@RequestMapping("/cart/*")
@Controller 
public class CartManage {

	@Resource(name = "uploadFolder")
	String uploadFolder;  // c:\\dev\\upload
	
	@Inject
	private CartService service;
	
	//로그인이 인증된 경우에만
	@ResponseBody
	@PostMapping("/cartAdd")
	public ResponseEntity<String> cart_add(Integer pro_num, int cart_amount, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		CartVO vo = new CartVO();
		vo.setPro_num(pro_num);
		vo.setCart_amount(cart_amount);
		
		//인증된 사용자 정보
		vo.setMem_id(((MemberVO) session.getAttribute("loginStatus")).getMem_id());
		
		try {
			
			service.cartAdd(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
		}catch(Exception e){
			
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	//인증된 상태에서 호출되는메서드의 파라미터는 HttpSession session 사용.
	@GetMapping("/cartList")
	public void cart_list(HttpSession session, Model model) {
		
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		List<CartListVO> list = service.cartList(mem_id);
		
		for(int i=0; i<list.size(); i++) {
			CartListVO vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		}
		
		model.addAttribute("cartList", list);
	}
	
	//상품리스트의 이미지출력(썸네일)
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName){
		
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFileUtils.getFileByte(uploadFolder, uploadPath, fileName);
		
		return entity;
	}
	
	//장바구니 물픔삭제
	@ResponseBody
	@PostMapping("/checkDelete")
	public ResponseEntity<String> checkDelete(@RequestParam("cart_codeArr[]") List<Integer> cart_codeArr){
		
		ResponseEntity<String> entity = null;
		
		try {
			for(int i=0; i<cart_codeArr.size(); i++) {
				
				service.cartDel(cart_codeArr.get(i));
			}
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//장바구니 모두 비우기
	@GetMapping("/cartAllDelete")
	public String cartAllDelete(HttpSession session) {
		
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		service.cartAllDel(mem_id);
		
		return "redirect:/cart/cartList";
	}
}
