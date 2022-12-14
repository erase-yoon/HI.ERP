<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<!-- JSP 기술의 한 종류인 [Include Direcctive]를 이용하여 -->
<!-- common.jsp 파일 소스 삽입 -->
<%@ include file="common.jsp" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Responsive Viewport & Fixed Scaling -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
    <title>공지사항</title>
    
    <script>
		$(function(){

			// 수정
			$(".boardUpBtn").bind("click",function(){
				boardUpFormCheck();
			});

			// 삭제
			$(".boardDelBtn").bind("click",function(){
				boardDelFormCheck();
			});

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

		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		// 수정 관련 유효성 체크,비동기 방식으로 웹 서버에 접속하는  함수 선언
		//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
		
		function boardUpFormCheck(){
			
			// 유효성 체크할 데이터를 가져와 각각의 변수에 저장 및 유효성 체크
			var formObj = $("[name='boardUpDelForm']");

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

				return;
			}

			// -----------------------
			// 수정 여부 확인
			// -----------------------
			if(confirm("수정하시겠습니까?")==false){
				return;
			}

			// -----------------------
			// 비동기 방식으로 웹 서버에 접근하여
			// 게시판 [수정] 관련 입력양식의 데이터 전송
			// -----------------------
			$.ajax({

				url : "/boardUpProc.do"

				, type : "post"

				, data : $("[name='boardUpDelForm']").serialize()

				// 웹 서버와 통신 후 웹 서버의 응답을 성공적으로 받을 경우 실행할 익명함수 설정
				// 익명함수의 매개변수에는 웹 서버에서 받은 [수정 적용행의 개수]가 들어온다.
				, success : function(boardUpCnt){

					// 게시판 글 수정 성공 시
					if(boardUpCnt==1){
						alert("게시글이 수정되었습니다.");
						document.boardListForm.submit();
						// $("[name=boardDetailForm] [name=b_no]").val(${requestScope.boardDTO.b_no});
						// document.boardDetailForm.submit();
					}
					
					else if(boardUpCnt==0){
						alert("이미 삭제된 게시글입니다.");
						document.boardListForm.submit();
					}
				}

				, error : function(){
					alert("웹 서버 접속 실패");
				}
			});
		}

	</script>
	
		
  </head>
  <body class="side-first by-menu popup-menu-open">
  <div id="wrapper">
    <header id="header-bar" class="on-light">
      <div id="header-bar-main">
        <button class="menu-toggle float-l" onclick="$('body').addClass('mobile-menu-open')">
          <span class="icon"><i class="Licon ico-menu"></i></span>
        </button>
        <div class="logo-area">
            <img src="assets/images/Hierp_Logo1.png" class="on-light logo_margin">
        </div>
        <div class="utility-area">
          <div class="utility-group">
            <a class="utility">
              <span class="icon"><i class="Licon ico-my" onclick="$.Lithium.popupHandler.open({ full: false, warning: false })"></i></span>
            </a>
            <a class="utility logout">
              <span class="icon"><i class="Licon ico-logout"></i></span>
            </a>
          </div>
        </div>
        <div class="user-area responsive-except-desktop">
          <span class="user-info">${requestScope.infoList[0].NM_EMP} (${requestScope.infoList[0].NO_EMP})</span>
        </div>
      </div>
    </header>

    <aside id="side-bar" class="slim tab">
      <button class="side-bar-toggle tab-item" data-tab-contents="DEFAULT" data-tab-contents-group="SIDE_MENU"  onclick="$.Lithium.sideSubMenuToggle().toggleSideBar();">
        <span class="icon"><i class="Licon ico-menu" ></i></span>
        <span class="icon"><i class="Licon ico-close"></i></span>
      </button>
      <div class="menu-area">
        <div class="menu menu-vertical">
        </div>
      </div>
    </aside>

    <div id="side-bar-sub" class="">
      <div class="tab-contents" data-tab-contents="DEFAULT" data-tab-contents-group="SIDE_MENU">
        <!-- search bar -->
        <div class="searchbar_con"><img src="assets/images/Biglogo.png"></div>
        <!-- menu -->
        <ul class="menu-accordion">
          <li>
            <!-- <a href="adNotice.do"><span class="label">공지사항</span></a> a 태그 해당 방식으로 추후 모두 변경해야함-->
            <a href="adNotice.do"><span class="label">공지사항</span></a>
          </li>
          <li class="tree-view">
            <a><span class="label">인사관리</span></a>
            <ul class="tree-view-menu">
              <li><a href="adEmpReg.do"><span class="label">사원등록</span></a></li>
              <li><a href="adUserInfoReg.do"><span class="label">사용자정보등록</span></a></li>
              <li><a href="adEmpList.do"><span class="label">사원명부 및 수정/삭제</span></a></li>
            </ul>
          </li>
          <li class="tree-view">
            <a><span class="label">급여관리</span></a>
            <ul class="tree-view-menu">
              <li><a href="adSal.do"><span class="label">급여계산</span></a></li>
              <!--<li><a><span class="label">Menu3-1</span></a></li>--> 
            </ul>
          </li>
        </ul>
      </div>

      
    </div>

    <div id="contents-wrapper">
      <div class="content-header">
        <div class="content-title-bar">
          <h5>공지사항 수정<button class="btn btn-sm btn-icon"><span class="icon"></span></button></h5>
          <!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->
          <div class="tools responsive-except-desktop" >
            <div class="tools-group" style="cursor:none;">
              <button class="tool-item" >
                <a href="adNotice.do">
                <span class="icon"><i class="Licon ico-datareset"></i></span>
                <span class="label">목록</span></a>
              </button>
              <button class="boardUpBtn tool-item" >
                <span class="icon"><i class="Licon ico-save"></i></span>
                <span class="label">저장</span>
              </button>
              <button class="tool-item" disabled style="cursor:default;">
                <span class="icon"><i class="Licon ico-add"></i></span>
                <span class="label">추가</span>
              </button>
              <button class="tool-item" disabled style="cursor:default;">
                <span class="icon"><i class="Licon ico-minus"></i></span>
                <span class="label">삭제</span>
              </button>
            </div>
          </div>
          
        </div>
      </div>

      <br><br>


	<!-- 메인 공지사항 등록 form -->

	<form action="" name="boardUpDelForm">
	  
	  <section class="mg-b-6u">
	    <div class="textarea">
	      <label>제목</label>
	      <textarea class="subject" name="subject" placeholder="제목을 입력해주세요." rows="1" maxlength="50">${requestScope.boardDTO.subject}</textarea>
	    </div>
	  </section>
	  
	  <section class="mg-b-6u">
	    <div class="textarea">
	      <label>내용</label>
	      <textarea class="content" name="content" placeholder="내용을 입력해주세요." rows="40" maxlength="3000">${requestScope.boardDTO.content}</textarea>
	      <div class="message-box">
	        <div class="tools">
	          <span class="count"></span>
	        </div>
	      </div>
	    </div>
	  	</section>
	  
		<input type="hidden" name="b_no" value="${requestScope.boardDTO.b_no}">
		
	</form>
	
	<form name="boardListForm" action="/adNotice.do" method="post"></form>
	
<br><br>
<br><br>


  
  <!-- 내정보 팝업 -->
  <div class="popup-wrapper">
    <div class="popup-dim" onclick="$.Lithium.popupHandler.close()"></div>
    <!-- option class / popup-warning, popup-full -->
    <div class="popup">
      <div class="popup-inner">
        <div class="popup-title">
          <div class="title-wrap">
            <h6 class="title">내정보</h6>              
          </div>
        </div>
        <div class="popup-contents" >
          <table border="0" cellpadding="5" align="center" width="300px" style="font-size:15px; font-weight: bold;">
            <tr align="center">
              <td><img src="./assets/images/test_img.png"></td>
            </tr>
            <tr align="center">
              <td>${requestScope.infoList[0].NM_EMP} ${requestScope.infoList[0].NM_JIK}</td>                                     
            </tr>
            <tr align="center">
              <td>(${requestScope.infoList[0].NM_DEPT})</td>                                     
            </tr>
            <tr align="center">
              <td>${requestScope.infoList[0].PHONE}</td>
            </tr>
            <tr align="center">
              <td>${requestScope.infoList[0].EMAIL}</td>
            </tr>
          </table>

          
        </div>

        <div class="popup-tools txt-right" style="margin-top:-20px;">
          
          <button class="btn btn-md btn-primary btn-container mg-l-2u" onclick="$.Lithium.popupHandler.close()">
            <span class="label" >닫기</span>
          </button>
        </div>
      </div>
    </div>
  </div>
  
</body>
</html>
