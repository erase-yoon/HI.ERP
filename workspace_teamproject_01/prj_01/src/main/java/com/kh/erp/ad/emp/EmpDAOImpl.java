package com.kh.erp.ad.emp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmpDAOImpl implements EmpDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int adUserInfoReg(UserInfoDTO userInfoDTO) {
		int data = this.sqlSession.insert(

				"com.kh.erp.ad.emp.EmpDAO.adUserInfoReg", userInfoDTO);

		return data;
	}

	public int checkId(String emp_id) {
		int data = this.sqlSession.selectOne(

				"com.kh.erp.ad.emp.EmpDAO.checkId", emp_id);

		return data;
	}

	public List<Map<String, String>> searchForm(EmpListDTO empListDTO) {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.emp.EmpDAO.searchForm", empListDTO);

		return data;
	}

	public List<Map<String, String>> getEmpList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.emp.EmpDAO.getEmpList");

		return data;
	}

	public int adEmpRegForm(RegDTO regDTO) {
		System.out.println("3333333333333333333333333333333333");
		int data = this.sqlSession.insert(

				"com.kh.erp.ad.emp.EmpDAO.adEmpRegForm", regDTO);

		return data;
	}

	public int adEmpRegPrivate(RegDTO regDTO) {
		int data = this.sqlSession.insert(

				"com.kh.erp.ad.emp.EmpDAO.adEmpRegPrivate", regDTO);

		return data;
	}

	public List<Map<String, String>> getPartList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.emp.EmpDAO.getPartList");

		return data;
	}

	public List<Map<String, String>> getJikupList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.emp.EmpDAO.getJikupList");

		return data;
	}

	public RegDTO getEmpListCorr(String no_emp) {
		RegDTO data = this.sqlSession.selectOne(

				"com.kh.erp.ad.emp.EmpDAO.getEmpListCorr", no_emp);
		return data;
	}
	
	public int getUpDelCnt(String emp_no) {

		int updelCnt = this.sqlSession.selectOne(
				"com.kh.erp.ad.notice.BoardDAO.getUpDelCnt"

				, emp_no
		);
		return updelCnt;
	}
	
	public int adEmpListUp1(RegDTO regDTO) {
		int data = this.sqlSession.update(
				"com.kh.erp.ad.emp.EmpDAO.adEmpRegForm", regDTO);
		return data;
	}
	
	public int adEmpListUp2(RegDTO regDTO) {
		int data = this.sqlSession.update(
				"com.kh.erp.ad.emp.EmpDAO.adEmpRegForm", regDTO);
		return data;
	}

}
