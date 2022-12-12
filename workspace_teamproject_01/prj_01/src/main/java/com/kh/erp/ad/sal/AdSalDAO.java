package com.kh.erp.ad.sal;

import java.util.List;
import java.util.Map;

public interface AdSalDAO {
	
	List<Map<String, String>> getEmpSalList();
	
	List<Map<String, String>> getPayList();
	
	List<Map<String, String>> getNoEmp();
	
	int searchPay(AmpaymentDTO ampaymentDTO);
	
	int insertPay(AmpaymentDTO ampaymentDTO);
	

}
