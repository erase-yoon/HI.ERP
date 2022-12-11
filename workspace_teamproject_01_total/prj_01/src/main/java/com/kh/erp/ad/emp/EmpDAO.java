package com.kh.erp.ad.emp;

import java.util.List;
import java.util.Map;

//@Mapper
public interface EmpDAO {
	int adUserInfoReg(UserInfoDTO userInfoDTO);

	int checkId(String emp_id);

	List<Map<String, String>> searchForm(EmpListDTO empListDTO);

	List<Map<String, String>> getEmpList();

	int adEmpRegForm(RegDTO regDTO);

	int adEmpRegPrivate(RegDTO regDTO);

	List<Map<String, String>> getPartList();

	List<Map<String, String>> getJikupList();

	RegDTO getEmpListCorr(String no_emp);
}
