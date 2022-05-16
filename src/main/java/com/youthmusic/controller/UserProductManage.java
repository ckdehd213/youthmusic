package com.youthmusic.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youthmusic.domain.CategoryVO;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.PageDTO;
import com.youthmusic.domain.ProductVO;
import com.youthmusic.service.UserProductService;
import com.youthmusic.util.UploadFileUtils;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/product/*")
@Controller
public class UserProductManage {

	
	@Resource(name = "uploadFolder")
	String uploadFolder; // c:\\dev\\upload */
	
	@Inject
	private UserProductService service;
	
	// 2차카테고리 정보
		@ResponseBody
		@GetMapping(value = "/subCategory/{mainCategoryCode}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("mainCategoryCode") Integer cg_code){
			
			ResponseEntity<List<CategoryVO>> entity = null;
			
			entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cg_code), HttpStatus.OK);
			
			return entity;
			
		}
		
		// 2차 카테고리에 해당하는 상품리스트
		@GetMapping("/productList")
		public void productList(@ModelAttribute("cri") Criteria cri, @ModelAttribute("cg_code") Integer cg_code, Model model) {
			
			cri.setAmount(4);
			
			List<ProductVO> list = service.getListWithPaging(cg_code, cri);
			
			// 클라이언트에서 보내는 특수문자중에 역슬래시 데이터를 스프링에서 지원하지 않는다  떄문에  \\ -> /
			for(int i=0; i<list.size(); i++) {
				ProductVO vo = list.get(i);
				vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
			}
			
			
			int total = service.getTotalCount(cg_code);
			
			model.addAttribute("pageMaker", new PageDTO(cri, total));
			model.addAttribute("productList", list);
		}
		
		// 상품상세설명 페이지
		// 파라미터가 참조형일 경우에 값을 파라미터에 제공하지 않으면, 기본생성자 메서드가 자동으로 호출된다.
		// @RequestParam 사용시 파라미터값을 제공해야 한다. @RequestParam 사용하지않으면, 참조형일 경우에는 에러가 발생되지 않는다.
		@GetMapping("/productDetail")
		public void productDetail(@RequestParam(value = "type", defaultValue = "Y") String type, @ModelAttribute("cri") Criteria cri, Integer cg_code, @RequestParam("pro_num") Integer pro_num, Model model) {
			
			ProductVO vo = service.productDetail(pro_num);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
			
			model.addAttribute("productVO", vo);
			model.addAttribute("type", type);
		}
		
		
		// 상품리스트의 이미지 출력(썸네일)
		@RequestMapping
		@GetMapping("/displayFile")
		public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName) {
			
			ResponseEntity<byte[]> entity = null;
			
			entity = UploadFileUtils.getFileByte(uploadFolder, uploadPath, fileName );
			
			return entity;
		}
		
}
