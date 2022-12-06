package com.kh.erp.ad.sal;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.erp.ad.notice.BoardDAO;
import com.kh.erp.ad.notice.BoardSearchDTO;
import com.kh.erp.ad.notice.BoardService;
import com.kh.erp.ad.notice.Util;

@Controller
public class AdSalController {
	// boardDAO 속성변수에
	// BoardDAO 인터페이스를 구현한 클래스를 객체화 하여
	// 객체의 메모리 위치 주소 값을 저장한다.
	@Autowired
	private BoardDAO boardDAO;
	// Autowired로 [ = new ~;]을 생략하고 선언하면
	// BoardDAO 인터페이스를 구현할 클래스를 찾을 때(호출할 때?)
	// 그 클래스의 이름은 무엇이든 상관없다.
	// 단 BoardDAO 인터페이스를 구현한 클래스는 1개만 생성해야 한다.
	
	// boardService 속성변수에
	// BoardService 인터페이스를 구현한 클래스를 객체화 하여
	// 객체의 메모리 위치 주소 값을 저장한다.
	@Autowired
	private BoardService boardService;
	// Autowired로 [ = new ~;]을 생략하고 선언하면
	// BoardService 인터페이스를 구현할 클래스를 찾을 때(호출할 때?)
	// 그 클래스의 이름은 무엇이든 상관없다.
	// 단 BoardService 인터페이스를 구현한 클래스는 1개만 생성해야 한다.
	
	// ---------------------------------------------------------------
	// 가상주소 /boardList.do로 접근하면 호출되는 메소드 선언
	// @RequestMapping 내부에 method="RequestMethod.POST"가 없으므로
	// 가상주소 /boardList.do로 접근 시 get 또는 post 접근 모두 허용
	// ---------------------------------------------------------------
	@RequestMapping(value="/adSal.do")
	public ModelAndView adNotice( 
			
			// 파라미터값을 저장할 [BoardSearchDTO 객체]를 매개변수로 선언
			BoardSearchDTO boardSearchDTO
			// [파라미터명]과 [BoardSearchDTO 객체]의 [속성변수명]이 같을 경우
			// setter 메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다.
			
//			미 로그인 시 보여줄 창 띄우기(직접설정)
			, HttpSession session
	) {
		
		String user_id = (String)session.getAttribute("user_id");
		
		// BoardDAOImpl 객체의 
		// getBoardList 메소드 호출로 [게시판 목록] 얻기
//		List<Map<String, String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);
		
		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		mav.addObject("user_id", user_id);

		mav.setViewName("adSal.jsp");
		
		// [ModelAndView 객체] 리턴
		return mav;

	}
}
