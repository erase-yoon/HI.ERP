<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        
        
        
        
<div class="searchCondition">
	<input type="text" name="min_year_month" class="min_year_month"  value="${param.min_year_month}">1  
	<input type="text" name="max_year_month" class="max_year_month" value="${param.max_year_month}" >2
	
	
	<input type="text" name="keyword1" class="keyword1"  value="${param.keyword1}">
	<input type="text" name="keyword2" class="keyword2" value="${param.keyword2}">
	<input type="text" name="selectPageNo" class="selectPageNo"  value="${param.selectPageNo}">
	<input type="text" name="rowCntPerPage" class="rowCntPerPage"  value="${param.rowCntPerPage}">
	
	<c:forEach var="xxx" items="${paramValues.date}">
		<input type="checkbox" name="date" class="date"  value="${xxx}" checked>오늘
	</c:forEach>
				
	<input type="text" name="min_year" class="min_year"  value="${param.min_year}">  
	<input type="text" name="min_month" class="min_month"  value="${param.min_month}"> 
	<input type="text" name="max_year" class="max_year"  value="${param.max_year}">
	<input type="text" name="max_month" class="max_month"  value="${param.max_month}">
	<input type="text" name="max_month" class="max_month"  value="${param.max_month}">
	
	<input type="text" name="orAnd" class="orAnd"  value="${param.orAnd}">
	
	<input type="text" name="sort" class="sort"  value="${param.sort}">
</div>

<script>
	$(".searchCondition").hide();
</script>