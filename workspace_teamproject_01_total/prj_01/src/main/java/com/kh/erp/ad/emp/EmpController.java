package com.kh.erp.ad.emp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EmpController {

	@Autowired
	private EmpDAO empDAO;

	@RequestMapping(value = "/adEmpReg.do")
	public ModelAndView AdEmpReg() {
		ModelAndView mav = new ModelAndView();
		List<Map<String, String>> partList = this.empDAO.getPartList();
		mav.addObject("partList", partList);
		List<Map<String, String>> jikupList = this.empDAO.getJikupList();
		mav.addObject("jikupList", jikupList);

		mav.setViewName("adEmpReg.jsp");
		return mav;
	}

	@RequestMapping(value = "/adEmpList.do")
	public ModelAndView AdEmpList() {
		ModelAndView mav = new ModelAndView();
		List<Map<String, String>> empList = this.empDAO.getEmpList();
		List<Map<String, String>> partList = this.empDAO.getPartList();
		List<Map<String, String>> jikupList = this.empDAO.getJikupList();

		mav.addObject("partList", partList);
		mav.addObject("jikupList", jikupList);
		mav.addObject("empList", empList);
		mav.setViewName("adEmpList.jsp");
		return mav;
	}

	@RequestMapping(value = "/adEmpListCorr.do")
	public ModelAndView AdEmpListCorr(@RequestParam(value = "no_emp") String no_emp) {
		ModelAndView mav = new ModelAndView();
		RegDTO regDTO = this.empDAO.getEmpListCorr(no_emp);
		List<Map<String, String>> partList = this.empDAO.getPartList();
		mav.addObject("partList", partList);
		List<Map<String, String>> jikupList = this.empDAO.getJikupList();
		mav.addObject("jikupList", jikupList);
		mav.addObject("regDTO", regDTO);
		mav.setViewName("adEmpListCorr.jsp");
		return mav;
	}

	@RequestMapping(value = "/adUserInfoReg.do")
	public ModelAndView AdUserInfoReg() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adUserInfoReg.jsp");
		return mav;
	}

	@RequestMapping(value = "/adUserInfoRegConfirm.do")
	public ModelAndView AdUserInfoRegConfirm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adUserInfoRegConfirm.jsp");
		return mav;
	}

	@RequestMapping(value = "/adUserInfoRegProc.do")
	@ResponseBody
	public int adUserInfoRegProc(UserInfoDTO userInfoDTO) {
		int data = this.empDAO.adUserInfoReg(userInfoDTO);
		return data;
	}

	@RequestMapping(value = "/checkId.do")
	@ResponseBody
	public int checkId(String emp_id) {
		int data = this.empDAO.checkId(emp_id);
		return data;
	}

	@RequestMapping(value = "/searchForm.do")
	@ResponseBody
	public ModelAndView searchForm(EmpListDTO empListDTO) {
		ModelAndView mav = new ModelAndView();
		List<Map<String, String>> data = this.empDAO.searchForm(empListDTO);
		mav.addObject("searchResult", data);
		return mav;
	}

	@RequestMapping(value = "/adEmpRegConfirm.do")
	public ModelAndView AdEmpRegConfirm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adEmpRegConfirm.jsp");
		return mav;
	}

	@RequestMapping(value = "/adEmpRegProc.do")
	@ResponseBody
	public int adEmpRegProc(RegDTO regDTO) {
		int adEmpRegForm = this.empDAO.adEmpRegForm(regDTO);
		int adEmpRegPrivate = this.empDAO.adEmpRegPrivate(regDTO);

		int data = 1;
		return data;

	}

}
