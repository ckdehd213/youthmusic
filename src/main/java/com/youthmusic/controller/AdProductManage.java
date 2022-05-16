package com.youthmusic.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.youthmusic.domain.CategoryVO;
import com.youthmusic.domain.Criteria;
import com.youthmusic.domain.PageDTO;
import com.youthmusic.domain.ProductVO;
import com.youthmusic.service.AdminProductService;
import com.youthmusic.util.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/admin/product/*")
@Controller
public class AdProductManage {
	
	@Resource(name = "uploadFolder")
	String uploadFolder;  // context에 설정되어 있음  // c:\\dev\\upload

	
	private AdminProductService service;
	
	// 상품등록 폼
	@GetMapping("/productInsert")
	public void product_insert(Model model) {
		
		// 1차 카테고리 정보
		model.addAttribute("mainCategory", service.mainCategory());
	}
	
	// 2차카테고리 정보
	@ResponseBody
	@GetMapping(value = "/subCategory/{mainCategoryCode}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("mainCategoryCode") Integer cg_code){
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cg_code), HttpStatus.OK);
		
		return entity;
		
	}
	
	//CKEditor 상품설명 이미지.
	@PostMapping("/editor/imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) {
		
		
		
		/*
		 CKEditor 파일 업로드 1) 파일업로드 작업  2) 업로드된 파일정보를 브라우저에게 보내야 한다.
		 */
		

	
		// 클라이언트로부터 전송되어 온 파일을 업로드폴더에 복사(생성)
		OutputStream out = null;
		
		// 업로드된 파일정보를 브라우저에게 보내야 한다.
		PrintWriter printWriter = null;
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		try {
		String fileName= upload.getOriginalFilename();
		byte[] bytes = upload.getBytes();
		// 클라이언트에서 전송해온 파일명을 포함하여, 실제 업로드되는 경로생성
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName;
		
		log.info("업로드폴더 물리적 경로: " + uploadPath);
		
		out = new FileOutputStream(new File(uploadPath)); // 0byte의  빈 파일 생성
		
		// 파일에 내용이 채워짐.
		out.write(bytes);
		out.flush();
		
		//여기까지 1)
		/*======================================================================*/
		
		
		String callback = request.getParameter("CKEditorFuncNum");
		
		log.info(callback);
		
		printWriter = response.getWriter();
		
		// <resources mapping="/upload/**" location="/resources/upload/" />
		String fileUrl = "/upload/" + fileName;
		
		printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction("
							+ callback
							+ ",'"
							+ fileUrl
							+ "','이미지를 업로드 하였습니다.'"
							+ ")</script>");
		printWriter.flush();
		
	// <script>window.parent.CKEDITOR.tools.callFunction("callback", fileUrl, '이미지를 업로드 하였습니다.')</script>
	
	}catch(Exception ex) {
		ex.printStackTrace();
	}finally {
		try {
		if(out != null) out.close();
		if(printWriter != null) printWriter.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
	}
	
	//return;
	
}
	
	
	
	
	// 상품등록 저장
	@PostMapping("/productInsert")
	public String product_insert(ProductVO vo, RedirectAttributes rttr) {
		
		log.info("상품정보" + vo);
		
		
		//1) 파일업로드 작업
		vo.setPro_img(UploadFileUtils.uploadFile(uploadFolder, vo.getUpload()));
		vo.setPro_uploadpath(UploadFileUtils.getFolder());  // 날짜폴더명
			
		
		//2) 상품정보를 저장
		service.product_insert(vo);
		
		rttr.addFlashAttribute("msg", "insertOk");
		
		return "redirect:/admin/product/productList";  		
	}
	
	
	// 상품리스트
	@GetMapping("/productList")
	public void product_list(Criteria cri, Model model) {
		
		cri.setAmount(2); // 한 페이지 마다 나타낼 리스트의 개수 2로 설정  (임시)
		List<ProductVO> list = service.getListWithPaging(cri);
		
		// 클라이언트에서 보내는 특수문자중에 역슬래시 데이터를 스프링에서 지원하지 않는다  떄문에  \\ -> /
		for(int i=0; i<list.size(); i++) {
			ProductVO vo = list.get(i);
			vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		}
		
		
		int total = service.getTotalCount(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("productList", list);
	}
	
	// 상품수정 폼
	@GetMapping("/productEdit")
	public void product_Edit(@RequestParam("pro_num") Integer pro_num, @ModelAttribute("cri") Criteria cri, Model model) {
		
		
		// 1) 상품정보.
		ProductVO vo = service.product_edit(pro_num);
		vo.setPro_uploadpath(vo.getPro_uploadpath().replace("\\", "/"));
		model.addAttribute("productVO", vo); // productVO - jsp에서 참조     	*02/23 P -> p로 수정 (대소문자 주의)
		
		//2) 1차 카테고리 정보
		model.addAttribute("mainCategory", service.mainCategory());
		
		//3) 1차 카테고리를 참조하는 2차카테고리 정보.
		model.addAttribute("subCategory", service.subCategory(vo.getCg_prt_code()));
		//4) 페이징, 검색파라미터 정보 : cri
		
		System.out.println("메인상품정보 : " + service.mainCategory());
		System.out.println("서브상품정보 : " + service.subCategory(vo.getCg_prt_code()));
	}
	
	// 상품등록 수정저장(폼에서 상품정보, 페이징정보(검색포함) 전송)-- cri추가
	@PostMapping("/productEdit")
	public String product_edit(Criteria cri,  ProductVO vo, RedirectAttributes rttr) {
		
		//System.out.println("수정저장값 : " + vo);
		
		// 상품이미지 변경을 할 경우 : 기존이미지는 삭제한다.
		// 상품이미지 변경을 하지 않는 경우 : 기존이미지명을  그대로 수정처리한다.
		
		//1) 파일업로드 작업
		if(vo.getUpload().getSize() > 0) {   // 이미지 수정이 되면
			
			//1) 기존이미지 정보 파일삭제
			UploadFileUtils.deleteFile(uploadFolder, vo.getPro_uploadpath(), vo.getPro_img());
			
			//2)변경이미지 업로드 작업
			vo.setPro_img(UploadFileUtils.uploadFile(uploadFolder, vo.getUpload()));
			vo.setPro_uploadpath(UploadFileUtils.getFolder());  // 날짜폴더명
		}
		
		service.product_editOk(vo);
		
		rttr.addFlashAttribute("msg", "editOk"); // jsp에서 참조
		
		rttr.addAttribute("PageNum", cri.getPageNum()); // 주소에서 호출되는 메서드 파라미터 참조. (아래의 productList)
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/product/productList";
	}
	
	// 상품리스트의 이미지 출력작업(썸네일)
	@ResponseBody
	@GetMapping("/displayFile")  // 클라이언트에서 보내는 특수문자중에 역슬래시 데이터를 스프링에서 지원하지 않는다 
	public ResponseEntity<byte[]> displayFile(String uploadPath, String fileName){   
		
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFileUtils.getFileByte(uploadFolder, uploadPath, fileName );
		
		return entity;
	}
	
	
	// 상품삭제(ajax호출)	pro_uploadpathArr 400에러 발생의미 : 클라이언트에서 보내는 데이터를 스프링에서 못받고 있다.  ajax로 사용시 파라미터를 []로 사용해야 한다.
	@ResponseBody
	@PostMapping("/checkDelete")
	public ResponseEntity<String> checkDelete(
								    @RequestParam("pro_numArr[]") List<Integer> pro_numArr, 
							   	    @RequestParam("pro_imgArr[]") List<String> pro_imgArr,
								    @RequestParam("pro_imgArr[]") List<String> pro_uploadpathArr){
		
		ResponseEntity<String> entity = null;
		
		try {
			for(int i=0; i<pro_numArr.size(); i++) {
				// 상품이미지 삭제
				UploadFileUtils.deleteFile(uploadFolder, pro_uploadpathArr.get(i), pro_imgArr.get(i));
				
				// 상품테이블 삭제작업
				service.product_delete(pro_numArr.get(i));
			}
			
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
			
//		System.out.println("상품코드: " + pro_numArr);
//		System.out.println("이미지: " + pro_imgArr);
		

		return entity;
	}
	
	// 상품개별삭제
	@PostMapping("/productDelete")
	public String productDelete(Criteria cri, @RequestParam("pro_num") Integer pro_num, RedirectAttributes rttr) {
		
		service.product_delete(pro_num);
		
		rttr.addFlashAttribute("msg", "deleteOk"); // jsp에서 참조
		
		rttr.addAttribute("PageNum", cri.getPageNum()); // 주소에서 호출되는 메서드 파라미터 참조. (아래의 productList)
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/product/productList";
	}
}
