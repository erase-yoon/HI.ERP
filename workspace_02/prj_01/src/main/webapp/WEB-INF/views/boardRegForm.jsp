<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSP 기술의 한 종류인 [Include Direcctive]를 이용하여 -->
<!-- common.jsp 파일 소스 삽입 -->
<%@ include file="common.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${empty param.mom_b_no?"새 글 쓰기":"답글 쓰기"}</title>
		<script>
			$(function(){
				$("[name='writer']").val("사오정");
				$("[name='subject']").val("제목111");
				$("[name='content']").val("내용 111");
				$("[name='email']").val("abc111@naver.com");
				$("[name='pwd']").val("1111");
				
				// class="regBtn" 태그에 click 이벤트가 발생하면
				// regFormCheck 함수 호출
				$(".boardRegBtn").bind("click",function(){
					boardRegFormCheck();
				});

				// class="boardListBtn" 태그에 click 이벤트가 발생하면
				// class="boardListBtn" form 태그의 action 값의
				// URL 주소로 웹 서버에 접속하기
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
			});

			// 유효성 체크,비동기 방식으로 웹서버에 접속하는 boardRegFormCheck 함수 선언
			function boardRegFormCheck(){

				// -----------------------
				// 작성 여부 확인
				// -----------------------
				if(confirm("${empty param.mom_b_no?'새 글':'답글'}을 작성하시겠습니까?")==false){
					return;
				}

				$("[name='content']").val($("[name='content']").val().replace("\\s+", " "));
				// alert($("[name='test']").html());
				// -----------------------
				// 비동기 방식으로 웹 서버에 접근하여
				// 게시판 [새 글 쓰기] 관련 입력양식의 데이터 전송
				// -----------------------
				$.ajax({

					// 웹 서버 접속 시 사용할 URL 지정
					url : "/boardRegProc.do"

					// 웹 서버에 데이터 전송 방식 지정
					// 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 두가지를 보내는 방식 지정
					, type : "post"

					// 서버로 전송할 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 아래 형식의 문자열로 조합해서 설정
					// "파라미터명1=파라미터값1 & 파라미터명2=파라미터값2 & ~"
					, data : $("[name='boardRegForm']").serialize()

					// 웹 서버와 통신 후 
					// 웹 서버의 응답을 성공적으로 받을 경우 
					// 실행할 익명함수 설정
					// 익명함수의 매개변수에는 웹 서버에서 받은
					// [JSON 객체]가 들어온다.
					, success : function(json){

						// 웹 서버에서 받은 JSON 객체에서
						// 경고문구를 꺼내 msg 변수에 저장
						var msg = json["msg"];

						// 웹 서버에서 받은 JSON 객체에서
						// 입력된 행의 개수를 꺼내 boardRegCnt 변수에 저장
						var boardRegCnt = json["boardRegCnt"];
						
						// 게시판 글 입력 성공 시
						// 웹 서버에서 보낸 경고 문구가 없고 (유효성 체크를 통과할 경우)
						// 게시판 글의 입력 성공 행의 개수가 1이면
						if(msg=="" && boardRegCnt==1){
						// if(msg=="" && parseInt(boardRegCnt, 10)==1){
						// if(msg=="" && boardRegCnt=="1"){
						// 주석문의 2가지 방법이 정확한 방법

							// confirm의 결과가 false일 경우
							// 새글 또는 답글을 다시 작성하지 않을 경우
							if(confirm("${empty param.mom_b_no?'새 글':'답글'} 쓰기 성공 \n${empty param.mom_b_no?'새 글':'답글'}을 한 번 더 작성하시겠습니까?")==false){

								// 웹 서버에 "/boardList.do" URL 주소로 접속 시도
								// 사용 메소드 : location.replace("URL 주소");
								// 해당 메소드 접속 방식은 get 방식이다.
								location.replace("/boardList.do");

								// POST 방식을 사용하고 싶을 경우
								// HTML form 태그 생성 method와 action 값을 준 후
								// document.~.submit();으로 접속한다.
								// document.boardListForm.submit();

							// confirm의 결과가 true일 경우
							// 새글 또는 답글을 다시 작성할 경우
							}else{
								document.boardRegForm.reset();
							}

						// 게시판 글 입력 실패 시
						// 웹 서버에서 보낸 경고 문구가 있거나 (유효성 체크에 통과 못할 경우)
						// 게시판 글의 입력 성공 행의 개수가 1이 아닐 경우
						}else{
							alert("${empty param.mom_b_no?'새 글':'답글'} 쓰기 실패\n" + msg);

							var formObj = $("[name='boardRegForm']");

							if(msg.indexOf("작성자")>=0){
								formObj.find(".writer").val("");
							}

							if(msg.indexOf("제목")>=0){
								if(confirm("제목을 15자만으로 자르시겠습니까?")){
									var subject = formObj.find(".subject").val();
									formObj.find(".subject").val(subject.substring(0, 15));
								}else{
									formObj.find(".subject").val("");
								}
							}

							if(msg.indexOf("이메일")>=0){
								formObj.find(".email").val("");
							}

							if(msg.indexOf("암호")>=0){
								formObj.find(".pwd").val("");
							}

							if(msg.indexOf("<script>")>=0){
								var resubject = formObj.find(".subject").val();
								resubject = resubject.toLowerCase().replace("<script>", "").replace("<\/script>", "");
								formObj.find(".subject").val(resubject);
								
								var recontent = formObj.find(".content").val();
								recontent = recontent.toLowerCase().replace("<script>", "").replace("<\/script>", "");
								formObj.find(".content").val(recontent);
							}

							if(msg.indexOf("<\/script>")>=0){
								var resubject = formObj.find(".subject").val();
								resubject = resubject.toLowerCase().replace("<script>", "").replace("<\/script>", "");
								formObj.find(".subject").val(resubject);
								
								var recontent = formObj.find(".content").val();
								recontent = recontent.toLowerCase().replace("<script>", "").replace("<\/script>", "");
								formObj.find(".content").val(recontent);
							}
						}
					}

					// 웹 서버와 통신이 실패할 경우 
					// 실행할 익명함수 설정
					, error : function(){
						alert("웹 서버 접속 실패");
					}
				});

			}

			
			// 유효성 체크,비동기 방식으로 웹서버에 접속하는 boardRegFormCheck 함수 선언
			function boardRegFormCheck2(){
				// -----------------------
				// 유효성 체크
				// -----------------------
				// 유효성 체크할 데이터를 가져와 각각의 변수에 저장 및 유효성 체크
				var formObj = $("[name='boardRegForm']");

				// writer 변수에 데이터 저장 및
				// writer의 데이터가 한글이고 2~10자가 아닐 경우 경고 후 함수 중단
				var writer = formObj.find(".writer").val();
				var regExp = new RegExp(/^[가-힣]{2,10}$/);
				if(regExp.test(writer)==false){
					alert("작성자는 한글 2~10자로 작성해주세요.");
					formObj.find(".writer").val("");
					return;
				}

				// -----------------------
				// subject 변수에 데이터 저장 및
				// subject의 데이터가 1~15자가 아닐 경우 경고 후 함수 중단
				// -----------------------
				var subject = formObj.find(".subject").val();

				// subject 변수 안의 데이터 타입이 string이 아닐 경우 "" 저장
				if(typeof(subject)!="string"){
					subject = "";
				}

				// 데이터의 앞, 뒤 공백 제거
				subject = $.trim(subject);

				// 앞, 뒤 공백 제거된 데이터를 웹 화면에 삽입
				formObj.find(".subject").val(subject);

				// subject가 1~15자가 아닐경우 경고 후 함수 중단
				if(subject.length>15){
					// alert("제목은 1~15자로 작성해주세요.");
					if(confirm("제목은 1~15자로 작성해주세요. \n15자 까지만 제목으로 입력하시겠습니까?")){
						formObj.find(".subject").val(subject.substring(0, 15));
					}else{
						formObj.find(".subject").val("");
					}
					return;
				}else if(subject.length==0){
					alert("제목은 1~15자로 작성해주세요.");
					return;
				}

				// subject에 <script>가 포함될 경우 경고 후 함수 중단
				if(subject.toUpperCase().indexOf(("<script>").toUpperCase())>=0){
					alert("<script>는 사용할 수 없습니다.");
					formObj.find(".subject").val("");
					
					return;
				}
				
				// -----------------------
				// email 변수에 데이터 저장 및
				// email의 데이터가 이메일 형식에 맞지 않을 경우 경고 후 함수 중단
				// -----------------------
				var email = formObj.find(".email").val();
				regExp = new RegExp('^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$');
				if(regExp.test(email)==false){
					alert("이메일 형식에 맞지 않습니다.");
					formObj.find(".email").val("");
					return;
				}

				// -----------------------
				// content 변수에 데이터 저장 및
				// content의 데이터가 500자 이상일 경우 경고 후 함수 중단
				// -----------------------
				var content = formObj.find(".content").val();

				// content가 500자 이내가 아닐경우 경고 후 함수 중단
				if(content.length>500){
					// alert("내용은 500자 이내로 작성해주세요.");
					if(confirm("내용은 500자 이내로 작성해주세요. \n500자 까지만 내용으로 입력하시겠습니까?")){
						formObj.find(".content").val(content.substring(0, 500));
					}else{
						formObj.find(".content").val("");
					}
					return;
				}else if(content.length==0){
					alert("내용은 500자 이내로 작성해주세요.");
					return;
				}

				// content에 <script>가 포함될 경우 경고 후 함수 중단
				if(content.toUpperCase().indexOf(("<script>").toUpperCase())>=0){
				// if(content.toLowerCase().indexOf("<script>")>=0 || content.toLowerCase().indexOf("<\/script>")>=0){

					alert("<script>는 사용할 수 없습니다.");
					formObj.find(".content").val("");

					// 내용 전체를 지우지 않고 <script>, <\/script> 부분만 지우고 싶을 경우
					// 주석 처리된 if문으로 변경 후 아래 주석 부분 주석 해제
					// var recontent = formObj.find(".content").val();
					// recontent = recontent.toLowerCase().replace("<script>", "").replace("<\/script>", "");
					// formObj.find(".content").val(recontent);

					return;
				}

				// -----------------------
				// pwd 변수에 데이터 저장 및
				// pwd의 데이터가 영소문자 또는 숫자이고 4자가 아닐 경우 경고 후 함수 중단
				// -----------------------
				var pwd = formObj.find(".pwd").val();
				regExp = new RegExp(/^[a-z0-9]{4}$/);
				if(regExp.test(pwd)==false){
					alert("암호는 영소문자 또는 숫자이고 4자여야 합니다.");
					formObj.find(".pwd").val("");
					return;
				}

				// -----------------------
				// 작성 여부 확인
				// -----------------------
				if(confirm("${empty param.mom_b_no?'새 글':'답글'}을 작성하시겠습니까?")==false){
					return;
				}
				// -----------------------
				// 비동기 방식으로 웹 서버에 접근하여
				// 게시판 [새 글 쓰기] 관련 입력양식의 데이터 전송
				// -----------------------
				$.ajax({

					// 웹 서버 접속 시 사용할 URL 지정
					url : "/boardRegProc2.do"

					// 웹 서버에 데이터 전송 방식 지정
					// 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 두가지를 보내는 방식 지정
					, type : "post"

					// 서버로 전송할 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 아래 형식의 문자열로 조합해서 설정
					// "파라미터명1=파라미터값1 & 파라미터명2=파라미터값2 & ~"
					, data : $("[name='boardRegForm']").serialize()

					// 웹 서버와 통신 후 
					// 웹 서버의 응답을 성공적으로 받을 경우 
					// 실행할 익명함수 설정
					// 익명함수의 매개변수에는 웹 서버에서 받은
					// [새 글의 입력된 행 개수]가 들어온다.
					, success : function(regCnt){

						// 게시판 글 입력 성공 시
						if(regCnt==1){
							// alert("새 글 쓰기 성공");

							if(confirm("${empty param.mom_b_no?'새 글':'답글'} 쓰기 성공 \n${empty param.mom_b_no?'새 글':'답글'}을 한 번 더 작성하시겠습니까?")==false){
								// 웹 서버에 "/boardList.do" URL 주소로 접속 시도
								// 사용 메소드 : location.replace("URL 주소");
								// 해당 메소드 접속 방식은 get 방식이다.
								location.replace("/boardList.do");

								// POST 방식을 사용하고 싶을 경우
								// HTML form 태그 생성 method와 action 값을 준 후
								// document.~.submit();으로 접속한다.
								// document.boardListForm.submit();
							}else{
								document.boardRegForm.reset();
							}

						}else{
							alert("${empty param.mom_b_no?'새 글':'답글'} 쓰기 실패");
						}
					}

					// 웹 서버와 통신이 실패할 경우 
					// 실행할 익명함수 설정
					, error : function(){
						alert("웹 서버 접속 실패");
					}
				});
			}
		</script>
	</head>
	<body>
		<center>
			<form action="" name="boardRegForm">
				<table border="1" cellpadding="5" style="border-collapse:collapse" align="center"> 
					<caption>
						<!-- 
							<c:if test="${empty param.mom_b_no}">
								[새 글 쓰기]
							</c:if>
							<c:if test="${!empty param.mom_b_no}">
								[답글 쓰기]
							</c:if>
						-->

						<!-- EL의 삼항 연산자 표현 -->
						<!-- $ {empty 조건?데이터1:데이터2} -->
						<!-- 조건이 null 또는 "" : 데이터1 -->
						<!-- 조건이 null 또는 ""이 아니면 : 데이터2 -->

						<!-- 파라미터명이 mom_b_no인 파라미터값의 유무에 따라 -->
						<!-- 원하는 문자를 JSP 페이지에 표현 -->
						${empty param.mom_b_no?"[새 글 쓰기]":"[답글 쓰기]"}
						<!-- 파라미터값 O : [답글 쓰기] -->
						<!-- 파라미터값 X : [새 글 쓰기] -->

					</caption>
					<tr>
						<th bgcolor="${requestScope.headerColor}">작성자</th>
						<td>
							<input type="text" name="writer" class="writer" size="10" maxlength="10">
						</td>
					<tr>
						<th bgcolor="${requestScope.headerColor}">제목</th>
						<td>
							<input type="text" name="subject" class="subject" size="40" maxlength="30">
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">이메일</th>
						<td>
							<input type="text" name="email" class="email" size="40" maxlength="30" >
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">내용</th>
						<td name="test">
							<textarea name="content" class="content" rows="13" cols="40" maxlength="300"></textarea>
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">비밀번호</th>
						<td>
							<input type="password" name="pwd" class="pwd"  size="8"  maxlength="4">
						</td>
					</tr>
				</table>

				<!-- c 코어 태그 if문 설정 -->
				<!-- test="조건"이 맞다면 if문 안의 내용 실행 -->
				<c:if test="${!empty param.mom_b_no}">
					<input type="hidden" name="b_no" value="${param.mom_b_no}">
				</c:if> 

				<div style="height:5px;"></div>

				<input type="button" value="저장" class="boardRegBtn">
				<input type="reset" value="다시작성">
				<input type="button" value="목록보기" class="boardListBtn">
			</form>

			<!-- 웹 서버에 action="/boardList.do" URL 주소로 접속하기 위한 from 태그 선언 -->
			<form action="/boardList.do" name="boardListForm" method="post">
				<%@include file="/WEB-INF/views/moveData.jsp" %>
			</form>

		</center>
	</body>
</html>