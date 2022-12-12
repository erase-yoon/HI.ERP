package com.kh.erp.ad.sal;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdSalDAOImpl implements AdSalDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Map<String, String>> getEmpSalList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.sal.AdSalDAO.getEmpSalList");

		return data;
	}
	
	public List<Map<String, String>> payList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.sal.AdSalDAO.payList");

		return data;
	}

}
