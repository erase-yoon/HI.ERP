package com.kh.erp.ad.stats;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.authenticator.DigestAuthenticator.DigestInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.erp.ad.notice.BoardDAO;
import com.kh.erp.ad.notice.BoardDTO;
import com.kh.erp.ad.notice.BoardSearchDTO;
import com.kh.erp.ad.notice.BoardService;
import com.kh.erp.ad.notice.Util;
import com.kh.erp.ad.sal.AdSalDAO;
import com.kh.erp.ad.sal.AmpaymentDTO;
import com.kh.erp.login.InfoDTO;
import com.kh.erp.login.LoginDAO;

@Controller
public class StatsController {

	@Autowired
	private LoginDAO loginDAO;
	
	@Autowired
	private AdStatsDAO adStatsDAO;

	@RequestMapping(value = "/adStats.do")
	public ModelAndView adNotice(InfoDTO infoDTO, HttpSession session, AmpaymentDTO qwe) {

		// ---------------------------------------------
		// session에 저장한 user_id를 user_id 변수에 저장
		String user_id;
		if (session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
		} else {
			user_id = "";
		}
		if (!(user_id.equals("system"))) {

//			System.out.println(user_id);
			// session의 모든 값 삭제
			session.invalidate();

			// [ModelAndView 객체] 생성
			// 로그아웃 버튼 클릭 시 로그인 화면으로 redirect
			ModelAndView mav = new ModelAndView("redirect:/loginForm.do");

			return mav;
		}

		// user_id 변수의 값을 infoDTO의 user_id에 저장
		infoDTO.setUser_id(user_id);

		// infoDTO의 정보를 매개변수로 하여 getInfoList 메소드 실행
		// 실행한 결과 값을 infoList에 저장
		List<Map<String, String>> infoList = this.loginDAO.getInfoList(infoDTO);

		session.setAttribute("no_emp", infoList.get(0).get("NO_EMP"));
		// ---------------------------------------------

		List<Map<String, String>> deptCountList = this.adStatsDAO.getDeptCountList();
//		Map<String, String> deptCount = deptCountList.get(0);
		List<Map<String, String>> jikupCountList = this.adStatsDAO.getJikupCountList();
//		Map<String, String> jikupCount = jikupCountList.get(0);
		
		System.out.println(deptCountList);
		System.out.println(jikupCountList);

		// [ModelAndView 객체] 생성
		ModelAndView mav = new ModelAndView();

		// ---------------------------------------------
		mav.addObject("infoList", infoList);
		mav.addObject("deptCount", deptCountList);
		mav.addObject("jikupCount", jikupCountList);
		// ---------------------------------------------


		mav.setViewName("adStats.jsp");

		// [ModelAndView 객체] 리턴
		return mav;
	}
}