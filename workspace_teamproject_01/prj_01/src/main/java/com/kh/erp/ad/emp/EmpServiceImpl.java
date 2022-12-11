package com.kh.erp.ad.emp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class EmpServiceImpl implements EmpService{
	@Autowired
	EmpDAO empDAO;
	public int updateList(RegDTO regDTO) {
		
		int updateListCnt1 = this.empDAO.adEmpListUp1(regDTO);
		int updateListCnt2 = this.empDAO.adEmpListUp1(regDTO);
		int updateListCnt = updateListCnt1+updateListCnt2;
		return updateListCnt;
	}
	
	public RegDTO getEmpListCorr(String no_emp) {
	
		
		
		return empDAO.getEmpListCorr(no_emp);
	}
}
