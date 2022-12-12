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
	
	@Autowired
	private AdSalDAO adSalDAO;

	@RequestMapping(value="/adSal.do")
	public ModelAndView adNotice(
		InfoDTO infoDTO

		, HttpSession session
	) {
		
		// ---------------------------------------------
		// session에 저장한 user_id를 user_id 변수에 저장
		String user_id = (String)session.getAttribute("user_id");
		
		// user_id 변수의 값을 infoDTO의 user_id에 저장
		infoDTO.setUser_id(user_id);
		
		// infoDTO의 정보를 매개변수로 하여 getInfoList 메소드 실행
		// 실행한 결과 값을 infoList에 저장
		List<Map<String, String>> infoList = this.loginDAO.getInfoList(infoDTO);
		// ---------------------------------------------
		
		List<Map<String, String>> empSalList = this.adSalDAO.getEmpSalList();
		
//		List<Map<String, String>> payList = this.adSalDAO.payList();
		
		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		mav.addObject("empList", empSalList);
		
//		mav.addObject("payList", payList);
		
		mav.addObject("infoList", infoList);

		mav.setViewName("adSal.jsp");
		
		// [ModelAndView 객체] 리턴
		return mav;

	}
}
