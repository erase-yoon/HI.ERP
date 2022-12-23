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
    <title>통계자료</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart1);
      google.charts.setOnLoadCallback(drawChart2);
      google.charts.setOnLoadCallback(drawChart3);
      google.charts.setOnLoadCallback(drawChart4);
      
      function drawChart1() {

        var data = google.visualization.arrayToDataTable([
          ['Dept', 'Dept Count'],
          ['인사부', ${requestScope.deptCount[0].deptcount}],
          ['총무부', ${requestScope.deptCount[1].deptcount}],
          ['회계부', ${requestScope.deptCount[2].deptcount}],
          ['기획부', ${requestScope.deptCount[3].deptcount}],
          ['영업부', ${requestScope.deptCount[4].deptcount}]
        ]);

        var options = {
          title: '부서별 사원 수'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart1'));
        chart.draw(data, options);
      }

      function drawChart2() {

        var data = google.visualization.arrayToDataTable([
          ['jikup', 'jikup Count'],
          ['사장', ${requestScope.jikupCount[0].jikcount}],
          ['부사장', ${requestScope.jikupCount[1].jikcount}],
          ['전무이사', ${requestScope.jikupCount[2].jikcount}],
          ['상무이사', ${requestScope.jikupCount[3].jikcount}],
          ['이사', ${requestScope.jikupCount[4].jikcount}],
          ['부장', ${requestScope.jikupCount[5].jikcount}],
          ['차장', ${requestScope.jikupCount[6].jikcount}],
          ['과장', ${requestScope.jikupCount[7].jikcount}],
          ['대리', ${requestScope.jikupCount[8].jikcount}],
          ['주임', ${requestScope.jikupCount[9].jikcount}],
          ['사원', ${requestScope.jikupCount[10].jikcount}]
        ]);

        var options = {
          title: '직급별 사원 수'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart2'));
        chart.draw(data, options);
      }

      function drawChart3() {
        var sum = ${requestScope.deptCount[0].deptcount} 
        + ${requestScope.deptCount[1].deptcount} 
        + ${requestScope.deptCount[2].deptcount} 
        + ${requestScope.deptCount[3].deptcount} 
        + ${requestScope.deptCount[4].deptcount};
        var data = google.visualization.arrayToDataTable([
          ['Dept', 'Dept Count', { role: "style" } ],
          ['총원', sum, "lightblue"],
          ['인사부', ${requestScope.deptCount[0].deptcount}, "color: #e5e4e2"],
          ['총무부', ${requestScope.deptCount[1].deptcount}, "silver"],
          ['회계부', ${requestScope.deptCount[2].deptcount}, "gold"],
          ['기획부', ${requestScope.deptCount[3].deptcount}, "#b87333"],
          ['영업부', ${requestScope.deptCount[4].deptcount}, "silver"]
        ]);

        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
                        { calc: "stringify",
                          sourceColumn: 1,
                          type: "string",
                          role: "annotation" },
                        2]);

        var options = {
          title: "부서별 사원 수",
          width: 800,
          height: 500,
          bar: {groupWidth: "95%"},
          legend: { position: "none" },
        };
        var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values1"));
        chart.draw(view, options);
      }

      function drawChart4() {
        var sum = ${requestScope.jikupCount[0].jikcount} 
        + ${requestScope.jikupCount[1].jikcount} 
        + ${requestScope.jikupCount[2].jikcount} 
        + ${requestScope.jikupCount[3].jikcount} 
        + ${requestScope.jikupCount[4].jikcount}
        + ${requestScope.jikupCount[5].jikcount}
        + ${requestScope.jikupCount[6].jikcount}
        + ${requestScope.jikupCount[7].jikcount}
        + ${requestScope.jikupCount[8].jikcount}
        + ${requestScope.jikupCount[9].jikcount}
        + ${requestScope.jikupCount[10].jikcount};

        var data = google.visualization.arrayToDataTable([
          ['Dept', 'Dept Count', { role: "style" } ],
          ['총원', sum, "lightblue"],
          ['사장', ${requestScope.jikupCount[0].jikcount}, "color: #e5e4e2"],
          ['부사장', ${requestScope.jikupCount[1].jikcount}, "#b87333"],
          ['전무이사', ${requestScope.jikupCount[2].jikcount}, "color: #e5e4e2"],
          ['상무이사', ${requestScope.jikupCount[3].jikcount}, "color: #e5e4e2"],
          ['이사', ${requestScope.jikupCount[4].jikcount}, "#b87333"],
          ['부장', ${requestScope.jikupCount[5].jikcount}, "silver"],
          ['차장', ${requestScope.jikupCount[6].jikcount}, "#b87333"],
          ['과장', ${requestScope.jikupCount[7].jikcount}, "#b87333"],
          ['대리', ${requestScope.jikupCount[8].jikcount}, "silver"],
          ['주임', ${requestScope.jikupCount[9].jikcount}, "gold"],
          ['사원', ${requestScope.jikupCount[10].jikcount}, "color: #e5e4e2"]
        ]);

        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
                        { calc: "stringify",
                          sourceColumn: 1,
                          type: "string",
                          role: "annotation" },
                        2]);

        var options = {
          title: "직급별 사원 수",
          width: 800,
          height: 500,
          bar: {groupWidth: "95%"},
          legend: { position: "none" },
        };
        var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values2"));
        chart.draw(view, options);
      }
    </script>
    <script>
	//******************************************************** 
	// body 태그 안의 모든 내용을 읽어들인 이후 호출할 자스 코딩 설정하기
	//******************************************************** 
		
		function goEmpNoticeDetail(
				b_no	//클릭한 행의 게시판 번호가 들어오는 매개변수
		){
		
			document.empNoticeDetail.action = "/adNoticeDetail.do";
			document.empNoticeDetail.method = "post";
			
			$("[name=empNoticeDetail]").find(".selectPageNo").val(
					$("[name=boardSearchForm]").find(".selectPageNo").val()
			);
			$("[name=empNoticeDetail]").find(".rowCntPerPage").val(
					$("[name=boardSearchForm]").find(".rowCntPerPage").val()
			);
			//-------------------------------------------------
			// name=boardDetailForm 를 가진 form 태그 내부에 
			// name=b_no 가진 태그에 매개변수로 들어온 게시판 번호를 삽입해라
			//-------------------------------------------------
			$("[name=empNoticeDetail]").find("[name=b_no]").val(b_no);
			document.empNoticeDetail.submit();
		}
		
		function boardSearch( ){
			
			
			document.boardSearchForm.submit();
		}
		//**********************************************
		// [페이지 번호]를 클릭하면 호출되는 함수 선언
		//**********************************************
		function pageNoBtn( pageNo ){
			
			//------------------------------------
			// class=selectPageNo 를 가진 입력양식에 
			// 클릭한(=선택한) 페이지 번호를 value 값으로 삽입하기
			// 왜? 서버에로 보낼려고!
			//------------------------------------
			$(".selectPageNo").val(pageNo);
			//------------------------------------
			// boardSearch 함수 호출하기
			//------------------------------------
			boardSearch();
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
                <span class="icon"><i class="Licon ico-my" onclick="$.Lithium.popupHandler.open({ full: false, warning: false })" title="내정보"></i></span>
              </a>
              <a class="utility logout">
                <span class="icon" title="로그아웃"><i class="Licon ico-logout"></i></span>
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
      
  <!-- 사이드 바 메뉴 -->
  
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
                <li><a href="adSal.do"><span class="label">급여입력</span></a></li>
              </ul>
            </li>
            <li class="active">
              <a href="adStats.do"><span class="label">통계자료</span></a>
            </li>
          </ul>
        </div>
      </div>
  
      <div id="contents-wrapper">
        <div class="content-header">
          <div class="content-title-bar">
            <h5>통계자료</h5>
            <div class="tools responsive-except-desktop" >
              <div class="tools-group" style="cursor:none;">
                <button class="tool-item" disabled style="cursor:default;">
                  <span class="icon"><i class="Licon ico-datareset"></i></span>
                  <span class="label">조회</span>
                </button>
                <button class="tool-item" disabled style="cursor:default;">
                  <span class="icon"><i class="Licon ico-save"></i></span>
                  <span class="label">저장</span>
                </button>
                <button class="tool-item" disabled style="cursor:default;">
                  <span class="icon"><i class="Licon ico-add"></i></span>
                  <span class="label">추가</span></a>
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
        <!-- <br><br><br><br> -->
        <div id="piechart1" style="width: 800px; height: 500px; margin-left: auto; margin-right: auto;"></div>
        <div id="piechart2" style="width: 800px; height: 500px; margin-left: auto; margin-right: auto;"></div>
        <div id="columnchart_values1" style="width: 800px; height: 500px; margin-left: auto; margin-right: auto;"></div>
        <div id="columnchart_values2" style="width: 800px; height: 500px; margin-left: auto; margin-right: auto;"></div>
        <br><br>
  
  	<!-- <br><br><br><br> -->
    </div>
  </div>
  
  
  <!--  내정보 팝업 -->
  
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