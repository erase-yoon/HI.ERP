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
import com.kh.erp.login.InfoDTO;
import com.kh.erp.login.LoginDAO;

@Controller
public class AdSalController {

	@Autowired
	private LoginDAO loginDAO;

	@RequestMapping(value="/adSal.do")
	public ModelAndView adNotice(
		InfoDTO infoDTO

		, HttpSession session
	) {
		
		String user_id = (String)session.getAttribute("user_id");
		infoDTO.setUser_id(user_id);
		
		List<Map<String, String>> infoList = this.loginDAO.getInfoList(infoDTO);
		
		// BoardDAOImpl 객체의 
		// getBoardList 메소드 호출로 [게시판 목록] 얻기
//		List<Map<String, String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);
		
		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("infoList", infoList);

		mav.setViewName("adSal.jsp");
		
		// [ModelAndView 객체] 리턴
		return mav;

	}
}
