package com.youthmusic.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.youthmusic.domain.MemberVO;

// 사용자 로그인 인터셉터 클래스
public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	/*
	 servlet-context.xml파일의 내용
	 아래 매핑주소의 특징은 인증된 사용자만 접근해야 한다.
	 <mapping path="/member/mypage"/>
	 <mapping path="/order/*"/>
	 <mapping path="/cart/*"/>
	 <beans:ref bean="loginInterceptor"/> 
	 
	 1)/member/mypage 매핑주소요청 -> preHandle() 호출. return true -> /member/mypage 매핑주소의 메서드가 동작
	                                              return false -> /member/mypage 매핑주소의 메서드가 동작안함(종료)
	 */
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.info("======== LoginInterceptor preHandle() called ========");
		
		// 세션처리 작업
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO) session.getAttribute("loginStatus");
		
		if(user == null) {  // 사용자 미 로그인 시, 로그인 페이지 로드
			logger.info("===== User not logged in =====");
			
			// Ajax요청인지 또는 일반요청인지 체크
			if(isAjaxRequest(request)){
                response.sendError(400); // ajax요청시 응답에러 코드 400 리턴
                return false;
			} else {
				// 로그인 페이지 로드 전에 요청된 주소 저장
				getDestination(request);
				
				response.sendRedirect("/member/login/");
				
				return false;
			}
	
		}
		
		return true;
	}
	
//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
//			ModelAndView modelAndView) throws Exception {
//		
//		logger.info("======== LoginInterceptor postHandle() called ========");
//		
//		// 세션처리작업
//		HttpSession session = request.getSession();
//		MemberDTO user = (MemberDTO) session.getAttribute("user");
//		
//		if(user != null) {
//			logger.info("로그인 프로세스");
//			
//			session.setAttribute("userLogin", user);
//			
//			// 요청한 주소의 존재 유무 확인
//			// 존재하면 해당 주소로 이동
//			Object destination = session.getAttribute("destination");
//			response.sendRedirect(destination != null ? (String) destination : "/member/loginOk");
//			/*
//			String destination = (String) session.getAttribute("destination");
//			
//			if(destination != null) {
//				response.sendRedirect(destination);
//			}else {
//				response.sendRedirect("/");
//			}
//			*/
//		}
//	}
	
	// 인터셉터 동작 전에 요청된 주소 정보를 저장하는 메소드
	private void getDestination(HttpServletRequest request) {
		
		// /board/get?idx=100
		String uri = request.getRequestURI(); // 요청주소 /board/get
		String query = request.getQueryString(); // 쿼리스트링 idx=100
		
		// 쿼리스트링
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;  // ?idx=100
		}
		
		String destination = uri + query; // /board/get?idx=100
		
		if(request.getMethod().equals("GET")) {
			logger.info("destination : " + destination);
			
			// 원래 요청된 주소
			request.getSession().setAttribute("dest", destination);  // "dest" : /board/get?idx=100
			
		}
		
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {
        String header = req.getHeader("AJAX");
        if ("true".equals(header)){
         return true;
        }else{
        	
         return false;
         
        }
    }

	
}
