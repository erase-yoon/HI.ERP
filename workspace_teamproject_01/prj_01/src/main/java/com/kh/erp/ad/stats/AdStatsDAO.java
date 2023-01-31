package com.kh.erp.ad.stats;

import java.util.List;
import java.util.Map;

public interface AdStatsDAO {
	
	List<Map<String, String>> getDeptCountList();
	
	List<Map<String, String>> getJikupCountList();
	
}
