package com.kh.erp.ad.stats;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.erp.ad.notice.BoardSearchDTO;
import com.kh.erp.ad.sal.AmpaymentDTO;

@Repository
public class AdStatsDAOImpl implements AdStatsDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Map<String, String>> getDeptCountList(){
		
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.stats.AdStatsDAO.getDeptCountList");

		return data;
	}

	public List<Map<String, String>> getJikupCountList(){
		
		List<Map<String, String>> data = this.sqlSession.selectList(

				"com.kh.erp.ad.stats.AdStatsDAO.getJikupCountList");

		return data;
	}
}
