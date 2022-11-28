<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSP 기술의 한 종류인 [Include Direcctive]를 이용하여 -->
<!-- common.jsp 파일 소스 삽입 -->
<%@ include file="common.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>상세보기</title>
		<script>
			$(function(){

				// class="boardListBtn" 태그에 click 이벤트가 발생하면
				// class="boardListBtn" form 태그의 action 값의
				// URL 주소로 웹 서버에 접속하기
				// 목록보기
				$(".boardListBtn").bind("click",function(){

					// 웹 서버에 "/boardList.do" URL 주소로 접속 시도
					// 사용 메소드 : location.replace("URL 주소");
					// 해당 메소드 접속 방식은 get 방식이다.
					// location.replace("/boardList.do");

					// POST 방식을 사용하고 싶을 경우
					// HTML form 태그 생성 method와 action 값을 준 후
					// document.~.submit();으로 접속한다.
					document.boardListForm.submit();
				});

				// class="regFormBtn" 태그에 click 이벤트가 발생하면
				// goBoardRegForm 함수 호출
				// 답글
				$(".boardReplyBtn").bind("click",function(){
					goBoardReplyForm();
				});

				// class="boardUpDelBtn" 태그에 click 이벤트가 발생하면
				// goBoardUpDelForm 함수 호출
				// 수정/삭제
				$(".boardUpDelBtn").bind("click",function(){
					goBoardUpDelForm();
				});
			});

			// 게시판 수정/삭제 화면으로 이동하는 함수 선언
			function goBoardUpDelForm(){

				// 웹 서버에 "/boardUpDelForm.do" URL 주소로 접속 시도
				// 사용 메소드 : location.replace("URL 주소");
				// 해당 메소드 접속 방식은 get 방식이다.
				// location.replace("/boardUpDelForm.do");

				// form 태그를 사용 하지 않을 경우
				// location.replace("/boardUpDelForm.do?b_no=${requestScope.boardDTO.b_no}");

				// POST 방식을 사용하고 싶을 경우
				// HTML form 태그 생성 method와 action 값을 준 후
				// document.~.submit();으로 접속한다.
				document.boardUpDelForm.submit();
			}

			// 게시판 글의 답글 화면으로 이동하는 함수 선언
			function goBoardReplyForm(){

				// 웹 서버에 "/boardRegForm.do" URL 주소로 접속 시도
				// 사용 메소드 : location.replace("URL 주소");
				// 해당 메소드 접속 방식은 get 방식이다.
				// location.replace("/boardRegForm.do");

				// POST 방식을 사용하고 싶을 경우
				// HTML form 태그 생성 method와 action 값을 준 후
				// document.~.submit();으로 접속한다.
				document.boardReplyForm.submit();
			}

		</script>
	</head>
	<body>
		<center>
			<form action="" name="boardDetailForm">
				<table border="1" cellpadding="5" style="border-collapse:collapse" align="center"> 
					<caption>[게시판 글 보기]</caption>
					<tr>
						<th bgcolor="${requestScope.headerColor}">작성자</th>
						<td>
							${requestScope.boardDTO.writer}
						</td>
					<tr>
						<th bgcolor="${requestScope.headerColor}">제목</th>
						<td>
							${requestScope.boardDTO.subject}
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">조회수</th>
						<td>
							${requestScope.boardDTO.readcount}
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">이메일</th>
						<td>
							${requestScope.boardDTO.email}
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">날짜</th>
						<td>
							${requestScope.boardDTO.reg_date}
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">내용</th>
						<td>
							<div style="width: 300px; height: 300px; background-color : white; padding: 0px;">
								${requestScope.boardDTO.content}
							</div>							
						</td>
					</tr>
				</table>

				<div style="height:5px;"></div>

				<input type="button" value="목록보기" class="boardListBtn">
				<input type="button" value="답글" class="boardReplyBtn">
				<input type="button" value="수정/삭제" class="boardUpDelBtn">
			</form>

			<!-- 웹 서버에 action="/boardList.do" URL 주소로 접속하기 위한 from 태그 선언 -->
			<form action="/boardList.do" name="boardListForm" method="post">

				<%@include file="/WEB-INF/views/moveData.jsp" %>

				<!-- <input type="hidden" name="keyword1" class="keyword1" value="${param.keyword1}" id=""> -->

				<!-- 클릭한 페이지 번호를 저장할 hidden 입력양식 선언 -->
				<!-- 페이징 처리 관련 데이터 -->
				<!-- <input type="hidden" name="selectPageNo" class="selectPageNo" value="${param.selectPageNo}"> -->
	
				<!-- 한 화면에 보여지는 행의 개수를 저장할 hidden 입력양식 선언 -->
				<!-- <input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="${param.rowCntPerPage}"> -->
			</form>

			<!-- 웹 서버에 action="/boardRegForm.do" URL 주소로 접속하기 위한 from 태그 선언 -->
			<form action="/boardRegForm.do" name="boardReplyForm" method="post">

				<!-- 해당 form의 URL 주소로 접속 시 가져갈 데이터 저장 목적의 hidden 태그 선언 -->
				<input type="hidden" name="mom_b_no" value="${requestScope.boardDTO.b_no}">

				<%@include file="/WEB-INF/views/moveData.jsp" %>
			</form>

			<!-- 웹 서버에 action="/boardUpDelForm.do" URL 주소로 접속하기 위한 from 태그 선언 -->
			<form action="/boardUpDelForm.do" name="boardUpDelForm" method="post">

				<!-- 해당 form의 URL 주소로 접속 시 가져갈 데이터 저장 목적의 hidden 태그 선언 -->
				<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">

				<%@include file="/WEB-INF/views/moveData.jsp" %>
			</form>
		</center>
	</body>
</html>