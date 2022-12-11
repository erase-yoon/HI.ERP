package com.kh.erp.emp.sal;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmpSalDAOImpl implements EmpSalDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int checkSalPwd(Map<String, String> salPwd) {
		
		int check_SalPwdCnt = this.sqlSession.selectOne(
			"com.kh.erp.emp.sal.EmpSalDAO.checkSalPwd"	
			, salPwd
		);
		//return 1;
		return check_SalPwdCnt;
		
	}
	// 급여명세서에 개인정보 출력
	public List<Map<String, String>> getEmpSalInfoList(EmpSalDTO empSalDTO){
		List<Map<String, String>> empSalInfoList = this.sqlSession.selectList(
				"com.kh.erp.emp.sal.EmpSalDAO.getEmpSalInfoList"	
				, empSalDTO
		);
		return 	empSalInfoList;
	}
	
	// 급여명세서에 지급, 공제 항목 출력
	public List<Map<String, String>> getEmpSalAmountInfoList(EmpSalDTO empSalDTO){
		List<Map<String, String>> empSalAmountInfoList = this.sqlSession.selectList(
			"com.kh.erp.emp.sal.EmpSalDAO.getEmpSalAmountList"	
				, empSalDTO
				
		);
		return empSalAmountInfoList ;
	} 
	
	// 급여명세서에 지급, 공제 금액 출력
	public List<Map<String, String>> getEmpSalList(EmpSalDTO empSalDTO){
		List<Map<String, String>> empSalList = this.sqlSession.selectList(
				"com.kh.erp.emp.sal.EmpSalDAO.getEmpSalList"
				, empSalDTO
		);
		return empSalList;
	}
	
	
	
	
	
	
	

//	// no_emp 리턴
//	public EmpSalDTO getNo_emp(String no_emp) {
//		EmpSalDTO empSal_no_emp = this.sqlSession.selectOne(
//			"com.kh.erp.emp.sal.EmpSalDAO.getNo_emp"
//				, no_emp
//		);
//		return empSal_no_emp ;
//	}
//	
//	// no_res 리턴
//	public EmpSalDTO getNo_res(String no_res) {
//		EmpSalDTO empSal_no_res = this.sqlSession.selectOne(
//			"com.kh.erp.emp.sal.EmpSalDAO.getNo_res"
//				, no_res
//		);
//		return empSal_no_res ;
//	}

}