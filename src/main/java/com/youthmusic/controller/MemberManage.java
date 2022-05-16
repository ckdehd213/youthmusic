package com.youthmusic.controller;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.youthmusic.domain.EmailDTO;
import com.youthmusic.domain.MemberVO;
import com.youthmusic.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


/*
 *** 회원관리 컨트롤러 ***
 * 회원가입	 22/02/11
 * 메일인증 	 22/02/14
 * 로그인, 로그아웃  22/02/14
 * 회원수정	 22/02/16
 * 비밀번호 찾기(이메일 이용) 22/02/17
 * 비밀번호 변경하기 22/02/22
 * 회원탈퇴 22/02/22
 */



@AllArgsConstructor
@Log4j
@RequestMapping("/member/*")
@Controller 
public class MemberManage {

	@Inject
	private MemberService service; 
	
	@Inject
	private PasswordEncoder cryptPassEnc;
	
	@Inject
	private JavaMailSender mailSender;
	
	// 주요기능 : 회원기능
	
	
	
		// 1) 회원가입 폼 : /member/join ->jsp파일명
		@GetMapping("/join")
		public void join() {
			
		}
		
		// 회원가입저장
		@PostMapping("/join")
		public String joinOk(MemberVO vo, RedirectAttributes rttr) throws Exception{
			
			vo.setMem_pw(cryptPassEnc.encode(vo.getMem_pw()));
			
			vo.setMem_echk(!StringUtils.isEmpty(vo.getMem_echk()) ? "Y" : "N" );
			
			
			service.join(vo);
			
			return "redirect:/member/login";
		}
		
		// 아이디 중복체크
		@ResponseBody
		@GetMapping("/checkID")
		public ResponseEntity<String> checkID(@RequestParam("mem_id") String mem_id) throws Exception {
			
			String result = "";
			ResponseEntity<String> entity = null;
			
			result = StringUtils.isEmpty(service.checkID(mem_id)) ? "Y" : "N";
			
			entity = new ResponseEntity<String>(result, HttpStatus.OK);
			
			return entity;
		}
		
		
		// 메일인증요청
		@ResponseBody
		@GetMapping("/sendMailAuth")
		public ResponseEntity<String> sendMailAuth(@RequestParam("mem_email") String mem_email, HttpSession session){
			
			ResponseEntity<String> entity = null;
			
			String authCode = makeAuthCode();
			session.setAttribute("authCode", authCode);
			
			EmailDTO dto = new EmailDTO("youthmusic", "ckdehd213@gmail.com", mem_email, "youthmusic 인증메일", authCode);
			
			// 메일 내용을 구성
			MimeMessage message = mailSender.createMimeMessage();
			
			try {
				message.addRecipient(RecipientType.TO, new InternetAddress(mem_email));
				message.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
				message.setSubject(dto.getSubject(), "utf-8");
				message.setText(dto.getMessage(), "utf-8");
				
				mailSender.send(message);
				
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			}catch(Exception e) {
				e.printStackTrace();
				
				entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
			}
			
			return entity;
		}
		
		// 메일인증요청 확인
		@ResponseBody
		@GetMapping("/mailAuthConfirm")
		public ResponseEntity<String> MailAuthConfirm(@RequestParam("uAuthCode") String uAuthCode, HttpSession session){
			
			ResponseEntity<String> entity = null;
			
			String authCode = (String) session.getAttribute("authCode");
			
			if(authCode.equals(uAuthCode)) {
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			}else {
				entity = new ResponseEntity<String>("fail", HttpStatus.OK);
			}
			
			return entity;
		}
			
		
		// 회원가입시 메일인증코드 생성
		private String makeAuthCode() {
			
			String authCode = "";
			
			for(int i=0; i<6; i++) {
				authCode += String.valueOf((int) (Math.random() * 9) + 1);
			}
			
			return authCode;
			
		}
		
		// 2) 회원수정
		// 폼
		@GetMapping(value = {"/edit", "/mypage"})
		public void edit(HttpSession session, Model model) {
			
			MemberVO vo = (MemberVO) session.getAttribute("loginStatus");
			
			String mem_id = vo.getMem_id();
			
			model.addAttribute(service.login(mem_id));
		}
		
		// 저장
		@PostMapping("/edit")
		public String edit(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
			
			String resirectURL = "";
			
			vo.setMem_echk(!StringUtils.isEmpty(vo.getMem_echk()) ? "Y" : "N");
			
			MemberVO session_vo = (MemberVO) session.getAttribute("loginStatus");
			
			if(cryptPassEnc.matches(vo.getMem_pw(), session_vo.getMem_pw())) {
				
				service.edit(vo);
				
				resirectURL = "/";
				rttr.addFlashAttribute("msg", "editOk");  	// index.jsp에서 msg를 참조해서 사용
				
			}else {
				resirectURL = "/member/edit";
				rttr.addFlashAttribute("msg", "editFail"); 	 // "edit.jsp"에서 msg를 참조해서 사용
			}
			
			return "redirect:" + resirectURL;
		}
		
		
		// 3) 회원삭제
		@ResponseBody
		@PostMapping("/memDelete")
		public ResponseEntity<String> memDelete(String mem_pw, HttpSession session){
			
			ResponseEntity<String> entity = null;
			
			MemberVO vo = (MemberVO) session.getAttribute("loginStatus");
			
			String mem_id = vo.getMem_id();
			
			entity = new ResponseEntity<String>(String.valueOf(service.memDelete(mem_id, cryptPassEnc, mem_pw)), HttpStatus.OK);
			
			return entity;
		}
		
		
		
		// 4) 로그인 폼 /member/login
		@GetMapping("/login")
		public void login() {
			
		}
		
		//로그인
		@ResponseBody
		@PostMapping("/login")
		public ResponseEntity<String> login(@RequestParam("mem_id") String mem_id, @RequestParam("mem_pw") String mem_pw, HttpSession session)throws Exception{
			
			String result = "";
			ResponseEntity<String> entity = null;
			
			MemberVO vo = service.login(mem_id);
			
			if(vo == null) {
				result = "idFail";
			}else {
				
				if(cryptPassEnc.matches(mem_pw, vo.getMem_pw())) {
					result = "success";
					
					session.setAttribute("loginStatus", vo);
			}else {
				result = "pwFail";
			}
				
		}
		
			entity = new ResponseEntity<String>(result, HttpStatus.OK);
			
			return entity;
			
		}
		
		
		
		// 5) 로그아웃
		@GetMapping("/logout")
		public String logout(HttpSession session, RedirectAttributes rttr) {
			
			rttr.addFlashAttribute("msg", "logoutOk");
			session.invalidate();
			 
			
			return "redirect:/";
		}
		
		
		// 비밀번호 찾기 폼
		@GetMapping("/searchPw")
		public void searchPw() {
			
		}
		
		// 비밀번호 찾기
		@ResponseBody
		@PostMapping("/searchPw")
		public ResponseEntity<String> searchPwAction(@RequestParam("mem_email") String mem_email){
			
			ResponseEntity<String> entity = null;
			
			// 비밀번호 랜덤생성, 메일발송
			if(!StringUtils.isEmpty(service.searchPwByEmail(mem_email))) {
				
				String tempPw = makeAuthCode();
				
				EmailDTO dto = new EmailDTO("youthmusic", "ckdehd213@gmail.com", mem_email, "youthmusic 인증메일", tempPw);
				
				//메일내용을 구성하는 클래스
				MimeMessage message = mailSender.createMimeMessage();
				
				try {
					//받는 사람 메일설정
					message.addRecipient(RecipientType.TO, new InternetAddress(mem_email));
					//보내는 사람설정(이메일, 이름)
					message.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
					//제목
					message.setSubject(dto.getSubject(), "utf-8");
					//본문내용(인증코드)
					message.setText(dto.getMessage(), "utf-8");
					
					mailSender.send(message);
					
					// 암호화 처리 후 DB에 저장    	22/02/16 암호화 작업 추가해야 함 										
					
					 String encryptPw = cryptPassEnc.encode(tempPw);
					 service.changePw(mem_email, encryptPw);			// -> 22/02/20수정완료

					
					entity = new ResponseEntity<String>("success", HttpStatus.OK);
					
				}catch(Exception e) {
					e.printStackTrace();
				
					entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
				}
				
			}else { // 이메일이 존자 하지 않는다면
				
				entity = new ResponseEntity<String>("noMail", HttpStatus.OK);
			}
			
			return entity;
		}
		
		// 비밀번호 변경하기
		@ResponseBody
		@PostMapping("/changePw")
		public ResponseEntity<String> changePw(@RequestParam("current_mem_pw") String current_mem_pw, @RequestParam("changed_mem_pw") String changed_mem_pw, HttpSession session){
			
			ResponseEntity<String> entity = null;
			
			MemberVO vo = (MemberVO) session.getAttribute("loginStatus");
			
			String mem_id = vo.getMem_id();
			
			String result = service.currentPw(mem_id, cryptPassEnc, current_mem_pw, cryptPassEnc.encode(changed_mem_pw));
			
			entity = new ResponseEntity<String>(result, HttpStatus.OK);
			
			return entity;
		}
		
		
		// 6) 마이페이지
		//폼
		/*
		@GetMapping("/mypage")
		public void mypage() {
			
		}
		*/
		
		
		// 7) 아이디 및 비밀번호 찾기
		/*
		@GetMapping("/searchIDPW")
		public void searchIDPW() {
			
		}
		*/
}
