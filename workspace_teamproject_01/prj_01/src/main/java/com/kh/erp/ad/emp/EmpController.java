package com.kh.erp.ad.emp;

import java.util.HashMap;
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

@Controller
public class EmpController {

	@Autowired
	private EmpDAO empDAO;
	
	@Autowired
	private EmpService empService;

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
	public ModelAndView AdEmpList(EmpListDTO empListDTO
			,HttpSession httpSession) {
		ModelAndView mav = new ModelAndView();
		List<Map<String, String>> empList = this.empDAO.getEmpList(empListDTO);
		List<Map<String, String>> partList = this.empDAO.getPartList();
		List<Map<String, String>> proofList = this.empDAO.getProofList();
		List<Map<String, String>> jikupList = this.empDAO.getJikupList();
		mav.addObject("empList", empList);
		mav.addObject("partList", partList);
		mav.addObject("proofList", proofList);
		mav.addObject("jikupList", jikupList);
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
	
	@RequestMapping(value = "/checkNo.do")
	@ResponseBody
	public int checkNo(String emp_no) {
		int data = this.empDAO.checkNo(emp_no);
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

	@RequestMapping(value = "/adEmpRegProc.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, String> adEmpRegProc(RegDTO regDTO) {

		Map<String, String> regDateMap = new HashMap<String, String>();
		

		regDateMap.put("emp_no", regDTO.getEmp_no());
		regDateMap.put("emp_name", regDTO.getEmp_name());
		regDateMap.put("emp_birth", regDTO.getEmp_birth());
		regDateMap.put("emp_jumin", regDTO.getEmp_jumin());
		regDateMap.put("emp_part", regDTO.getEmp_part());
		regDateMap.put("emp_jikup", regDTO.getEmp_jikup());
		regDateMap.put("emp_phone", regDTO.getEmp_phone());
		regDateMap.put("emp_email", regDTO.getEmp_email());
		regDateMap.put("emp_loc", regDTO.getEmp_loc());
		regDateMap.put("emp_detailloc", regDTO.getEmp_detailloc());
		regDateMap.put("emp_hire", regDTO.getEmp_hire());


		this.empDAO.adEmpRegForm(regDTO);

		this.empDAO.adEmpRegPrivate(regDTO);
		
		return regDateMap;

	}

	@RequestMapping(value = "/adEmpListUp.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int adEmpListUp(
			RegDTO regDTO
			
			) {
		

		int updateListCnt = this.empService.updateList(regDTO);
		System.out.println(updateListCnt);
		return updateListCnt;
	}
	
	@RequestMapping(value = "/adEmpListDel.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int adEmpListDel(
			RegDTO regDTO
			
			) {

		int deleteListCnt = this.empService.deleteList(regDTO);
		return deleteListCnt;
	}
	
}
