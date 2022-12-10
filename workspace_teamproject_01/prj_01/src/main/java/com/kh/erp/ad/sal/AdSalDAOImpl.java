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
	
	public List<Map<String, String>> getEmpList() {
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.sal.AdSalDAO.getEmpList");

		return data;
	}

}
