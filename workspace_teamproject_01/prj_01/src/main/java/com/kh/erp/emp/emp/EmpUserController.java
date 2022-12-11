package com.kh.erp.emp.emp;

import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EmpUserController {
	
	@RequestMapping(value="/empUserInfo.do")
	public ModelAndView empUserInfo(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("empUserInfo.jsp");
		return mav;
	}
}
