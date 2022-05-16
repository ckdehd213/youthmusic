package com.youthmusic.controller;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.youthmusic.domain.AdminVO;
import com.youthmusic.service.AdminService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/admin/*")
@Controller
public class AdminManage {

	private AdminService service;
	
	private PasswordEncoder cryptPassEnc;
	
	// 관리자 로그인 폼
	@GetMapping("/logon")
	public void adLoginForm() {
		
	}
	
	// 관리자 로그인 인증
	@PostMapping("/logon")
	public String adLoginOk(String ad_id, String ad_pw, HttpSession session, RedirectAttributes rttr) {
		
		
		log.info("관리자 아이디: " + ad_id);
		log.info("관리자 비밀번호: " + ad_pw);
		
		String redirectUrl = "";
		
		AdminVO vo = service.adminLogin(ad_id);
		
		// 아이디가 존재하면
		if(!StringUtils.isEmpty(vo)) {
			
			// 비밀번호가 일치하면(=인증성공)
			if(cryptPassEnc.matches(ad_pw, vo.getAd_pw())) {
				
				session.setAttribute("adminStatus", vo);
				redirectUrl = "/admin/main";
			}else { // 비밀번호가 틀린경우
				redirectUrl = "/admin/logon";
				rttr.addFlashAttribute("msg", "failPw");
			}
			
		}else {			// 아이디가 틀린경우
			redirectUrl = "/admin/logon";
			rttr.addFlashAttribute("msg", "failId");
		}
		
		return "redirect:" + redirectUrl;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "/admin/logon";
	}
	// 관리자 로그온 후에 보여질 페이지
	@GetMapping("/main")
	public void main() {
		
	}
	
	// 관리자회원 추가 폼
	@GetMapping("/adminRegister")
	public void adminRegister() {
		
	}
	
	// 관리자회원 저장
	@PostMapping("/adminRegister")
	public String adminRegister(AdminVO vo, RedirectAttributes rttr) {
		
		vo.setAd_pw(cryptPassEnc.encode(vo.getAd_pw()));
		
		
		int result = service.adminRegister(vo);
		
		if(result == 1) {
			rttr.addFlashAttribute("msg", "success");
		}else {
			rttr.addFlashAttribute("msg", "fail");
		}
		
		return "redirect:/admin/adminRegister";
	}
	
	
}
