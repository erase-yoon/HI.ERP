package com.kh.erp.login;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

// ---------------------------------------------------------------
// URL 주소로 접속하면 호출되는 자격을 가진
// 메소드를 소유한 [컨트롤러 클래스] 선언
// ---------------------------------------------------------------
// 관용적으로 Controller가 들어간 클래스는
// URL 주소 접속 시에 대응하여 호출되는 메소드를 소유하고 있다.
// 클래스의 이름 앞에는 @Controller 어노테이션이 붙는다.
// 클래스 내부의 URL 주소 접속 시 호출되는 메소드명 앞에는
// @RequestMapping 어노테이션이 붙는다.
// URL 주소 접속 시 호츨되는 메소드를 소유하고 있는 클래스를
// [Controller 클래스] 또는 [Controller 객체]라고 지칭한다.
// ---------------------------------------------------------------
// @Controller라는 어노테이션을 붙임으로서
// 스프링 프레임 워크가 객체를 생성하고 관리하고
// [컨트롤러 클래스]임이 지정된다.
// ---------------------------------------------------------------
@Controller
public class LoginController {
	
	// loginDAO 속성변수에
	// LoginDAO 인터페이스를 구현한 클래스를 객체화 하여
	// 객체의 메모리 위치 주소 값을 저장한다.
	@Autowired
	private LoginDAO loginDAO;
	// Autowired로 [ = new ~;]을 생략하고 선언하면
	// LoginDAO 인터페이스를 구현할 클래스를 찾을 때(호출할 때?)
	// 그 클래스의 이름은 무엇이든 상관없다.
	// 단 LoginDAO 인터페이스를 구현한 클래스는 1개만 생성해야 한다.
	
	// <참고> 관용적으로 클래스 이름에 DAO가 있으면 
	// 직접 DB연동을 하는 메소드를 소유한 클래스이다.
	
	// ---------------------------------------------------------------
	// 가상 URL 주소 /loginForm.do로 접근하면 호출되는 메소드 선언
	// ---------------------------------------------------------------
	// URL 주소에 대응하여 호출되려면 메소드 앞에
	// @RequestMapping(value="가상 URL 주소")라는 어노테이션이 붙어야 한다.
	
	// <주의> @RequestMapping이 붙은 메소드의 이름은 원하는 명칭으로 설정 가능하다.
	// 보통 URL 주소의 의도를 살리는 메소드 이름으로 설정하는 것이 좋다.
	
	// @RequestMapping이 붙은 메소드의 특징
	// - 가상 URL 주소로 접근하면 호출된다.
	// - 메소드의 리턴형이 ModelAndView 객체일 경우
	// DB 연동 결과물과 호출할 JSP 페이지명이 저장되어 있다.
	// 필수 입력 : 호출할 JSP 페이지명
	// 선택 입력 : DB 연동 결과물
	// - DB 연동 결과물은 HttpServletRequest 객체에도 저장된다.
	// - 메소드 호출 후 ModelAndView 객체가 리턴되면
	// 스프링 프레임 워크는 ModelAndView 객체에 저장된 JSP를 호출한다.
	// - JSP가 호출된 후 생성되는 HTML이 웹 브라우저 쪽으로
	// 전송, 실행 되어 결과물을 보게 된다.
	// - JSP 페이지의 역할은 HttpServletRequest 객체에 저장된 데이터를 꺼내
	// JSP 페이지의 HTML 또는 JS 코드 사이에 삽입하는 것이다.
	@RequestMapping(value="/loginForm.do")
	public ModelAndView loginForm() {
		
		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		// [ModelAndView 객체]의
		// setViewName 메소드를 호출하여
		// [호출할 JSP 페이지명]을 문자로 저장
		// [호출할 JSP 페이지명] 앞, 뒤에 붙는 위치 경로 및 확장자는
		// application.properties에서 
		// spring.mvc.view.prefix=위치 경로
		// spring.mvc.view.suffix=확장자
		// 로 설정 가능하다.
		// <참고> 기본 저장 경로에서 webapp까지는 설정되어 있다.
		mav.setViewName("loginForm.jsp");
		
		// [ModelAndView 객체] 리턴
		return mav;
	}

	// ---------------------------------------------------------------
	// 가상주소 /loginProc.do 접근 시 호출되는 메소드 선언
	// ---------------------------------------------------------------
	// @RequestMapping(~, produces="application/json;charset=UTF-8")와
	// @ResponseBody 설정 시 리턴 데이터가 클라이언트에게 전송된다.
	// @RequestMapping, @ResponseBody 설정 시 
	// 리턴 데이터가 JSON 형태로 응답메시지에 저장되어 전송된다.
	@RequestMapping(value="/loginProc.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody
	public int loginProc(
			
			// "mid"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 String mid에 저장
			@RequestParam(value = "mid") String mid
			
			// "pwd"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 String pwd에 저장
			, @RequestParam(value = "pwd") String pwd
			
			// "is_login"라는 파라미터 명에 해당하는 파라미터 값을 꺼내 String is_login에 저장
			, @RequestParam(value = "is_login", required = false) String is_login

			// 매개변수에 붙는 @RequestParam 형식
			// @RequestParam(value = "xxx1", required = true or false) String xxx2
			// "xxx1" 파라미터명에 대응하는 파라미터값을 매개변수 xxx2에 저장
			// required true : 파라미터값 필수 입력(required 미 입력시 기본 값으로 설정된다.)
			// required false : 파라미터값 필수 입력 아님

			// HttpSession 객체의 
			// 메모리 위치 주소 값을 저장하는 매개변수 session 선언
			, HttpSession session
			
			// HttpServletResponse 객체의
			// 메모리 위치 주소 값을 저장하는 매개변수 response 선언
			, HttpServletResponse response
	){
		
		// HashMap 객체 생성 후 객체의 메모리 위치 주소 값을 map에 저장
		// HashMap 객체에는 매개변수로 들어온 데이터(아이디, 암호 등)를 저장할 예정이다.
		Map<String, String> map = new HashMap<String, String>();
		
		// 매개변수로 들어온 [로그인 아이디]를 HashMap 객체에 저장
		map.put("mid", mid);
		
		// 매개변수로 들어온 [로그인 암호]를 HashMap 객체에 저장
		map.put("pwd", pwd);
		
		// ---------------------------------------------------------------
		// [로그인 아이디]와 [로그인 암호]의 DB 존재 개수를
		// 저장할 변수 loginIdCnt 선언하고
		// LoginDAOImpl 객체의 getCntLogin 메소드를 호출하여 얻은 데이터 저장
		// ---------------------------------------------------------------
		// 이 메소드는 [로그인 아이디]와 [로그인 암호]의 DB 존재 개수를 구해주는 메소드이다.
		// 이 메소드 호출 시 매개변수로 던져지는 HashMap 객체에는 
		// [로그인 아이디]와 [로그인 암호]가 저장되어 있다.
		int loginIdCnt = loginDAO.getCntLogin(map);
		
		// loginIdCnt==1, 아이디와 암호가 매칭되는 값이 DB에 있을 경우
		if(loginIdCnt==1) {
			
			// HttpSession 객체에 로그인 아이디 저장
			// HttpSession 객체에 저장 시 재 접속할 때 다시 꺼낼 수 있다.
			// <참고> HttpSession 객체는 접속 시 생성되고 
			// 접속 이후에도 바로 제거되지 않고 일정기간 살아있다.
			// <참고> HttpServletRequest, HttpServletResponse 객체는 
			// 접속 시 생성되고 응답 이후 삭제된다.
			session.setAttribute("mid", mid);
			
			// is_login에 null이 저장되어 있을 경우(ID, PW 기억 X)
			if(is_login==null) {
				
				// Cookie 객체 생성 후 쿠키명-쿠키값을
				// ["mid"-null]로 설정
				Cookie cookie1 = new Cookie("mid", mid);
				
				// Cookie 객체의 수명 0으로 설정
				cookie1.setMaxAge(0);
				
				// Cookie 객체 생성 후 쿠키명-쿠키값을
				// ["pwd"-null]로 설정
				Cookie cookie2 = new Cookie("pwd", pwd);
				
				// Cookie 객체의 수명 0으로 설정
				cookie2.setMaxAge(0);
				
				// Cookie 객체가 소유한 쿠키를 응답 메시지에 저장
				// 응답 메시지에 저장되는 쿠키는
				// 웹 브라우저(클라이언트 쪽)에 저장된다.
				response.addCookie(cookie1);
				response.addCookie(cookie2);
				
			// is_login에 "yes"가 저장되어 있을 경우(ID, PW 기억 O)
			}else {
				
				// ---------------------------------------------------------------
				// 클라이언트가 보낸 아이디, 암호를 
				// [응답 메시지]에 쿠키명-쿠키값으로 저장
				// ---------------------------------------------------------------
				// Cookie 객체 생성 후 쿠키명-쿠키값을
				// ["mid"-"입력 아이디"]로 설정
				Cookie cookie1 = new Cookie("mid", mid);
				
				// Cookie 객체의 수명 설정
				cookie1.setMaxAge(86400);

				// Cookie 객체 생성 후 쿠키명-쿠키값을
				// ["pwd"-"입력 암호"]로 설정
				Cookie cookie2 = new Cookie("pwd", pwd);
				
				// Cookie 객체의 수명 설정
				cookie2.setMaxAge(86400);
				
				// Cookie 객체가 소유한 쿠키를 응답 메시지에 저장
				// 응답 메시지에 저장되는 쿠키는
				// 웹 브라우저(클라이언트 쪽)에 저장된다.
				response.addCookie(cookie1);
				response.addCookie(cookie2);

			}
			
		}

		return loginDAO.getCntLogin(map);
	}

}
