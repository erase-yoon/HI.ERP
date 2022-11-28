<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSP 기술의 한 종류인 [Include Direcctive]를 이용하여 -->
<!-- common.jsp 파일 소스 삽입 -->
<%@ include file="common.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시판 수정/삭제</title>
		<script>
			$(function(){

				// class="boardUpBtn" 태그에 click 이벤트가 발생하면
				// boardUpFormCheck 함수 호출
				// 수정
				$(".boardUpBtn").bind("click",function(){
					boardUpFormCheck();
				});

				// class="boardDelBtn" 태그에 click 이벤트가 발생하면
				// boardDelFormCheck 함수 호출
				// 삭제
				$(".boardDelBtn").bind("click",function(){
					boardDelFormCheck();
				});

				// class="boardDetailBtn" 태그에 click 이벤트가 발생하면
				// class="boardDetailBtn" form 태그의 action 값의
				// URL 주소로 웹 서버에 접속하기
				$(".boardDetailBtn").bind("click",function(){

					// $("[name=boardDetailForm] [name=b_no]").val(${requestScope.boardDTO.b_no});
					
					// location.replace("/goBoardDetailForm.do?b_no=" + b_no);

					document.boardDetailForm.submit();
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

			// 수정 관련 유효성 체크,비동기 방식으로 웹 서버에 접속하는  함수 선언
			function boardUpFormCheck(){

				// -----------------------
				// 삭제 여부 확인
				// -----------------------
				if(confirm("수정하시겠습니까?")==false){
					return;
				}

				// -----------------------
				// 비동기 방식으로 웹 서버에 접근하여
				// 게시판 [수정] 관련 입력양식의 데이터 전송
				// -----------------------
				$.ajax({

					// 웹 서버 접속 시 사용할 URL 지정
					url : "/boardUpProc.do"

					// 웹 서버에 데이터 전송 방식 지정
					// 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 두가지를 보내는 방식 지정
					, type : "post"

					// 서버로 전송할 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 아래 형식의 문자열로 조합해서 설정
					// "파라미터명1=파라미터값1 & 파라미터명2=파라미터값2 & ~"
					, data : $("[name='boardUpDelForm']").serialize()

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
						// 입력된 행의 개수를 꺼내 updateBoardCnt 변수에 저장
						var boardUpCnt = json["boardUpCnt"];

						// msg가 비어있지 않을 경우
						// msg를 경고창에 띄운 후 함수 중단
						if(msg!=""){
							alert(msg);
							
							var formObj = $("[name='boardUpDelForm']");

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

							return;
						}
						
						// 게시판 글 입력 성공 시
						// 웹 서버에서 보낸 경고 문구가 없고 (유효성 체크를 통과할 경우)
						// 게시판 글의 입력 성공 행의 개수가 1이면
						if(boardUpCnt==1){
						// if(parseInt(boardUpCnt, 10)==1){
						// if(boardRegCnt=="1"){
						// 주석문의 2가지 방법이 정확한 방법

							alert("게시글 수정 성공");

							// name="boardListForm"을 가진 form 태그의
							// method의 접속방식으로
							// action 속성값의 URL 주소로 웹 서버 접속
							document.boardListForm.submit();

						// 수정된 행이 없을 경우(boardUpCnt==0)
						// 수정될 게시물이 삭제된 경우
						}else if(boardUpCnt==0){

							alert("삭제된 게시글입니다.");

							// name="boardListForm"을 가진 form 태그의
							// method의 접속방식으로
							// action 속성값의 URL 주소로 웹 서버 접속
							document.boardListForm.submit();

						// 암호가 틀렸을 경우(boardUpCnt==-1)
						}else if(boardUpCnt==-1){

							alert("암호가 틀립니다.");

							// name="pwd"의 value 비우기
							$("[name=pwd]").val("");

							// name="pwd"의 입력란에 focus 주기
							$("[name=pwd]").focus();
						}
					}

				});
			}


			// 수정 관련 유효성 체크,비동기 방식으로 웹 서버에 접속하는 함수 선언
			function boardUpFormCheck2(){
				// -----------------------
				// 수정 관련 유효성 체크
				// -----------------------
				// 유효성 체크할 데이터를 가져와 각각의 변수에 저장 및 유효성 체크
				var formObj = $("[name='boardUpDelForm']");

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
						formObj.find(".subject").val(subject.substring(0,15));
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
				regExp = new RegExp('[a-z0-9]+@[a-z]+\.[a-z]{2,3}');
				if(regExp.test(email)==false){
					alert("이메일 형식에 맞지 않습니다..");
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
						formObj.find(".content").val(content.substring(0,500));
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

					// 내용 전체를 지우지 않고 <script> 부분만 지우고 싶을 경우
					// 주석 처리된 if문으로 변경 후 아래 주석 부분 주석 해제제
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
				if(typeof(pwd)!="string"){
					pwd="";
				}
				pwd = $.trim(pwd);
				if(pwd==""){
					alert("암호를 입력해주세요.");
					return;
				}

				// -----------------------
				// 삭제 여부 확인
				// -----------------------
				if(confirm("수정하시겠습니까?")==false){
					return;
				}

				// -----------------------
				// 비동기 방식으로 웹 서버에 접근하여
				// 게시판 [수정] 관련 입력양식의 데이터 전송
				// -----------------------
				$.ajax({

					// 웹 서버 접속 시 사용할 URL 지정
					url : "/boardUpProc2.do"

					// 웹 서버에 데이터 전송 방식 지정
					// 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 두가지를 보내는 방식 지정
					, type : "post"

					// 서버로 전송할 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 아래 형식의 문자열로 조합해서 설정
					// "파라미터명1=파라미터값1 & 파라미터명2=파라미터값2 & ~"
					, data : $("[name='boardUpDelForm']").serialize()

					// 웹 서버와 통신 후 
					// 웹 서버의 응답을 성공적으로 받을 경우 
					// 실행할 익명함수 설정
					// 익명함수의 매개변수에는 웹 서버에서 받은
					// [수정 적용행의 개수]가 들어온다.
					, success : function(boardUpCnt){

						// 게시판 글 수정 성공 시
						if(boardUpCnt==1){
							alert("게시글 수정 성공");
							document.boardListForm.submit();

							// $("[name=boardDetailForm] [name=b_no]").val(${requestScope.boardDTO.b_no});
							// document.boardDetailForm.submit();

						}else if(boardUpCnt==0){
							alert("삭제된 게시글입니다.");
							document.boardListForm.submit();

						}else if(boardUpCnt==-1){
							alert("암호가 틀립니다.");
							$("[name=pwd]").val("");
							$("[name=pwd]").focus();
						}
					}

					// 웹 서버와 통신이 실패할 경우 
					// 실행할 익명함수 설정
					, error : function(){
						alert("웹 서버 접속 실패");
					}
				});
			}

			// 삭제 관련 유효성 체크,비동기 방식으로 웹 서버에 접속하는  함수 선언
			function boardDelFormCheck(){
			// 게시판 삭제를 위해서는 [삭제할 게시판의 번호]와 [암호]가 필요하다.

				// -----------------------
				// 삭제 관련 유효성 체크
				// -----------------------

				var formObj = $("[name='boardUpDelForm']");

				// -----------------------
				// pwd 변수에 데이터 저장 및
				// pwd의 데이터가 영소문자 또는 숫자이고 4자가 아닐 경우 경고 후 함수 중단
				// -----------------------
				var pwd = formObj.find(".pwd").val();
				if(typeof(pwd)!="string"){
					pwd="";
				}
				pwd = $.trim(pwd);
				if(pwd==""){
					alert("암호를 입력해주세요.");
					return;
				}

				// -----------------------
				// 삭제 여부 확인
				// -----------------------
				if(confirm("삭제하시겠습니까?")==false){
					return;
				}

				// -----------------------
				// 비동기 방식으로 웹 서버에 접근하여
				// 게시판 [삭제] 관련 입력양식의 데이터 전송
				// -----------------------
				$.ajax({

					// 웹 서버 접속 시 사용할 URL 지정
					url : "/boardDelProc.do"

					// 웹 서버에 데이터 전송 방식 지정
					// 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 두가지를 보내는 방식 지정
					, type : "post"

					// 서버로 전송할 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
					// 아래 형식의 문자열로 조합해서 설정
					// "파라미터명1=파라미터값1 & 파라미터명2=파라미터값2 & ~"
					, data : $("[name='boardUpDelForm']").serialize()

					// 웹 서버와 통신 후 
					// 웹 서버의 응답을 성공적으로 받을 경우 
					// 실행할 익명함수 설정
					// 익명함수의 매개변수에는 웹 서버에서 받은
					// [삭제 적용행의 개수]가 들어온다.
					, success : function(boardDelCnt){

						// 게시판 글 삭제 성공 시
						if(boardDelCnt==1){
							alert("게시글 삭제 성공");
							document.boardListForm.submit();

							// $("[name=boardDetailForm] [name=b_no]").val(${requestScope.boardDTO.b_no});
							// document.boardDetailForm.submit();

						}else if(boardDelCnt==0){
							alert("삭제된 게시글입니다.");
							document.boardListForm.submit();

						}else if(boardDelCnt==-1){
							alert("암호가 틀립니다.");
							$("[name=pwd]").val("");
							$("[name=pwd]").focus();
							
						}else if(boardDelCnt==-2){
							alert("제목과 내용이 삭제됩니다.");
							document.boardListForm.submit();
						}
					}

					// 웹 서버와 통신이 실패할 경우 
					// 실행할 익명함수 설정
					, error : function(){
						alert("웹 서버 접속 실패");
					}
				});
			}

			function goBoardDetailForm(b_no){
				document.boardDetailForm.submit();
			}

		</script>
	</head>
	<body>
		<center>
			<form action="" name="boardUpDelForm">
				<table border="1" cellpadding="5" style="border-collapse:collapse" align="center"> 
					<caption>[수정/삭제]</caption>
					<tr>
						<th bgcolor="${requestScope.headerColor}">작성자</th>
						<td>
							<input type="text" name="writer" class="writer" size="10" maxlength="10" value="${requestScope.boardDTO.writer}">
						</td>
					<tr>
						<th bgcolor="${requestScope.headerColor}">제목</th>
						<td>
							<input type="text" name="subject" class="subject" size="40" maxlength="30" value="${requestScope.boardDTO.subject}">
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">이메일</th>
						<td>
							<input type="text" name="email" class="email" size="40" maxlength="30" value="${requestScope.boardDTO.email}">
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">내용</th>
						<td>
							<textarea name="content"  class="content" rows="13" cols="40"  maxlength="300">${requestScope.boardDTO.content}</textarea>
						</td>
					</tr>
					<tr>
						<th bgcolor="${requestScope.headerColor}">비밀번호</th>
						<td>
							<input type="password" name="pwd" class="pwd"  size="8"  maxlength="4">
						</td>
					</tr>
				</table>

				<!-- 해당 form의 URL 주소로 접속 시 가져갈 데이터 저장 목적의 hidden 태그 선언 -->
				<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">
				
				<div style="height:5px;"></div>

				<input type="button" value="수정" class="boardUpBtn">
				<input type="button" value="삭제" class="boardDelBtn">
				<input type="button" value="취소" class="boardDetailBtn">
				<input type="button" value="목록보기" class="boardListBtn">
			</form>

			<!-- 웹 서버에 action="/boardList.do" URL 주소로 접속하기 위한 from 태그 선언 -->
			<form action="/boardList.do" name="boardListForm" method="post">
				<%@include file="/WEB-INF/views/moveData.jsp" %>
			</form>

			<!-- 웹 서버에 action="/boardDetailForm.do" URL 주소로 접속하기 위한 from 태그 선언 -->
			<form action="/boardDetailForm.do" name="boardDetailForm" method="post">

				<!-- 해당 form의 URL 주소로 접속 시 가져갈 데이터 저장 목적의 hidden 태그 선언 -->
				<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">
			</form>
		</center>
	</body>
</html>