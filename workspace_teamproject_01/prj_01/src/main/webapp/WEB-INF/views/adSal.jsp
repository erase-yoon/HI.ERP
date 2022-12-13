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
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Responsive Viewport & Fixed Scaling -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover">
    <script>

      // 오늘 날짜 관련 각종 데이터를 저장한 
      // JSON 객체를 리턴하는 함수 선언
      function json_today(){
        var today = new Date();
        var weeks = ["일", "월", "화", "수", "목", "금", "토"];
        var week = weeks[today.getDay()];
        var json = {
          "year" : today.getFullYear()
          , "month" : today.getMonth()+1
          , "date" : today.getDate()
          , "week" : week
          , "ymd" : today.getFullYear() + "-" + today.getMonth()+1 + "-" + today.getDate()
        }
        return json;
      }

      function insertPay(){
        var year_obj = $("[name='year']");
        var month_obj = $("[name='month']");
        var no_emp_obj = $("[name='no_emp']");

        $.ajax({
          url : "/insertPayProc.do"
          , type : "post"
          , data : $("[name='insertPayForm']").serialize()
          , success : function(Cnt){
            if(Cnt==1){
              alert("추가 성공");
              location.replace("/adSal.do");
            }else if(Cnt==-1){
              alert("이미 있는 귀속년월 입니다.");
              year_obj.val("");
              month_obj.val("");
              no_emp_obj.val("");
            }else{
              alert("에러입니다.");
              return;
            }
          }
          , error : function(){
              alert("웹 서버 접속 실패");
          }
        });
      }

      function getNo_erpYM(no_emp, sel_ym){
        
        var year = sel_ym.substr(0, 4);
        var month = sel_ym.substr(6, 2);
        var ym = sel_ym.substr(0, 4) + sel_ym.substr(6, 2);

        // return;
        $.ajax({
          url : "/selPayProc.do"
          , type : "post"
          , data : {no_emp, ym}
          , success : function(selectPayList){
            alert("${requestScope.selectPayList[0].am_pay01}");
            $(".am_pay01").val("1");
            $(".am_pay02").val("1");
            $(".am_pay03").val("1");
            $(".am_pay04").val("1");
            $(".am_pay05").val("1");
            $(".am_pay06").val("1");
            $(".am_pay07").val("1");
            $(".am_pay08").val("1");
            $(".am_deduct01").val("1");
            $(".am_deduct02").val("1");
            $(".am_deduct03").val("1");
            $(".am_deduct04").val("1");
            $(".am_deduct05").val("1");
            $(".am_deduct06").val("1");
            $(".am_deduct07").val("1");
            $(".am_deduct08").val("1");
            alert(selectPayList.am_pay01);
          }
          , error : function(){
            alert("웹 서버 접속 실패");
          }
        });

      }

      $(function (nm_emp){

        // // 사원번호 삽입
        // var nmemp_obj = $("[name='nmemp']");

        // for(var i=maxYear; i>=minYear; i--){
        //   year_obj.append("<option value='" + i + "'>" + i + "</option>");
        // }

        // 귀속년 삽입(3년치)
        var thisYear = json_today()["year"];
        var year_obj = $("[name='year']");

        maxYear = thisYear;
        minYear = maxYear-2;

        for(var i=maxYear; i>=minYear; i--){
          year_obj.append("<option value='" + i + "'>" + i + "</option>");
        }
      });

    </script>
    <title>급여명세서</title>
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
          <span class="icon"><i class="Licon ico-menu"></i></span>
          <span class="icon"><i class="Licon ico-close"></i></span>
        </button>
      </aside>

      <div id="side-bar-sub" class="">
        <div class="tab-contents" data-tab-contents="DEFAULT" data-tab-contents-group="SIDE_MENU">
          <!-- search bar -->
          <div class="searchbar_con"><img src="assets/images/Biglogo.png"></div>
          <!-- menu -->
          <ul class="menu-accordion">
            <li>
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
              </ul>
            </li>
          </ul>
        </div>
      </div>

      <div id="contents-wrapper">
        <div class="content-header">
          <div class="content-title-bar">
            <h5>급여계산<button class="btn btn-sm btn-icon"><span class="icon"></span></button></h5>
            <div class="tools responsive-except-desktop" >
              <div class="tools-group" style="cursor:none;">
                <button class="tool-item">
                  <span class="icon"><i class="Licon ico-datareset"></i></span>
                  <span class="label">조회</span>
                </button>
                <button class="tool-item">
                  <span class="icon"><i class="Licon ico-save"></i></span>
                  <span class="label">저장</span>
                </button>
                <button class="tool-item" onclick="insertPay();">
                  <span class="icon"><i class="Licon ico-add"></i></span>
                  <span class="label">추가</span>
                </button>
                <button class="tool-item">
                  <span class="icon"><i class="Licon ico-minus"></i></span>
                  <span class="label">삭제</span>
                </button>
              </div>
            </div>
          </div>
        </div>

        <br><br>

        <!-- 메인 -->

        <!-- 위쪽 탭(select box) -->
        <table border="1" cellspacing="0" style="border-color:rgb(229, 229, 229);" align="center" width="85%;">
          <tr>
            <td>
              <table align="center" width="90%" cellpadding="10" >
                <tr>
                  <td width="5%">
                    <label>회사명</label>
                    <td width="10%">하이이알피</td>
                  </td>
                  <form action="/asSal.do" name="asSal" method="post"></form>
                  <form action="/insertPayProc.do" name="insertPayForm" method="post">
                    <td width="5%">
                      <label>사원번호</label>
                      <td width="10%">
                        <select name="no_emp">
                          <option value=""></option>
                          <c:forEach var="noEmp" items="${requestScope.noEmp}" varStatus="status">
                            <option value="${noEmp.no_emp}">${noEmp.no_emp}</option>
                          </c:forEach>
                        </select>
                      </td>
                    </td>

                    <td width="5%">
                      <label>귀속년</label>
                      <td width="10%">
                        <select name="year">
                          <option value=""></option>
                        </select>
                      </td>
                    </td>

                    <td width="5%">
                      <label>귀속월</label>
                      <td width="10%">
                        <select name="month">
                          <option value=""></option>
                          <option value="01">01</option>
                          <option value="02">02</option>
                          <option value="03">03</option>
                          <option value="04">04</option>
                          <option value="05">05</option>
                          <option value="06">06</option>
                          <option value="07">07</option>
                          <option value="08">08</option>
                          <option value="09">09</option>
                          <option value="10">10</option>
                          <option value="11">11</option>
                          <option value="12">12</option>
                        </select>
                      </td>
                    </td>
                  </form>
                </tr>

                <!-- <tr>
                  <td>
                    <label>부서</label>
                    <td>
                      <select name="">
                        <option value=""></option>
                        <option value="000">관리부</option>
                        <option value="001">인사부</option>
                        <option value="002">총무부</option>
                        <option value="003">회계부</option>
                        <option value="004">기획부</option>
                        <option value="005">영업부</option>     
                      </select>
                    </td>
                  </td>
              
                  <td>
                    <label>재직구분</label>
                    <td>
                      <select name="">
                        <option value=""></option>
                        <option value="재직">재직</option>
                        <option value="퇴직">퇴직</option>
                        <option value="휴직">휴직</option>
                      </select>
                    </td>
                  </td>

                  <td>
                    <label>급여제목</label>
                    <td>
                      <input type="text">
                    </td>
                  </td>
                </tr> -->
              </table>
            </td>
          </tr>
        </table>


        <!-- 급여계산 테이블 -->
        <div class="content-body">
          <div class="container">
            <section>
              <div style="height: 444px;">
                <div id="top" class="split">
                  <div class="data-table-wrapper">
                    <div class="data-table-container">
                
                      <!-- 총액 테이블 -->
                      <table class="data-table data-table-sm" id="empListTable">
                        <thead>
                          <tr>
                            <th></th>
                            <th>사원명</th>
                            <th>사원번호</th>
                            <th>부서</th>
                            <th>직급</th>
                            <th>귀속년월</th>
                            <!-- <th>재직구분</th> -->
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="empList" items="${requestScope.empList}" varStatus="status">
                            <tr style="cursor: pointer;" onclick="getNo_erpYM('${empList.no_emp}', '${empList.ym}');">
                              <th>${status.count}</th>
                              <td>${empList.nm_emp}</td>
                              <td>${empList.no_emp}</td>
                              <td>${empList.nm_dept}</td>
                              <td>${empList.nm_jik}</td>
                              <td>${empList.ym}</td>
                              <!-- <td>${empList.nm_cd_emp}</td> -->
                            </tr>
                          </c:forEach>

                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>

                <!-- 지급내역 테이블 -->
                <div id="bottom" class="split">
                  <div id="bottom-left" class="split split-horizontal">
                    <div class="data-table-wrapper">
                      <div class="data-table-container">
                        <label style="margin-left:60px;"><em class="txt-error">*</em> 지 급 내 역<br></label>
                        <table class="data-table data-table-sm">
                          <thead>
                            <tr>
                              <th></th>
                              <th class="with-tools">
                                지급내역
                                <div class="tools overflow overflow-sm overflow-right">
                                  <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                                    <span class="icon"><i></i></span>
                                  </button>
                                  <div class="overflow-menu">
                                    <ul>
                                      <li><a class="overflow-menu-item">없음</a></li>
                                      <li><a class="overflow-menu-item">오름차순</a></li>
                                      <li><a class="overflow-menu-item">내림차순</a></li>
                                    </ul>
                                  </div>
                                </div>
                              </th>
                              <th class="with-tools">
                                금 액
                                <div class="tools overflow overflow-sm overflow-right">
                                  <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                                    <span class="icon"><i></i></span>
                                  </button>
                                  <div class="overflow-menu">
                                    <ul>
                                      <li><a class="overflow-menu-item">없음</a></li>
                                      <li><a class="overflow-menu-item">오름차순</a></li>
                                      <li><a class="overflow-menu-item">내림차순</a></li>
                                    </ul>
                                  </div>
                                </div>
                              </th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr style="cursor: default;">
                              <th>1</th>
                              <td>${requestScope.payList[0].nm_pay01}</td>
                              <td><input type="text" class="am_pay01" value="" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>2</th>
                              <td>${requestScope.payList[0].nm_pay02}</td>
                              <td><input type="text" class="am_pay02" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>3</th>
                              <td>${requestScope.payList[0].nm_pay03}</td>
                              <td><input type="text" class="am_pay03" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>4</th>
                              <td>${requestScope.payList[0].nm_pay04}</td>
                              <td><input type="text" class="am_pay04" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>5</th>
                              <td>${requestScope.payList[0].nm_pay05}</td>
                              <td><input type="text" class="am_pay05" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>6</th>
                              <td>${requestScope.payList[0].nm_pay06}</td>
                              <td><input type="text" class="am_pay06" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>7</th>
                              <td>${requestScope.payList[0].nm_pay07}</td>
                              <td><input type="text" class="am_pay07" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>8</th>
                              <td>${requestScope.payList[0].nm_pay08}</td>
                              <td><input type="text" class="am_pay08" style="width:100%;"></td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>

                  <!-- 공제내역 테이블 -->
                  <div id="bottom-right" class="split split-horizontal">
                    <div class="data-table-wrapper">
                      <div class="data-table-container">
                        <label style="margin-left:60px;"><em class="txt-error">*</em> 공 제 내 역<br></label>
                        <table class="data-table data-table-sm">
                          <thead>
                            <tr>
                              <th></th>
                              <th class="with-tools">
                                공제내역
                                <div class="tools overflow overflow-sm overflow-right">
                                  <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                                    <span class="icon"><i></i></span>
                                  </button>
                                  <div class="overflow-menu">
                                    <ul>
                                      <li><a class="overflow-menu-item">없음</a></li>
                                      <li><a class="overflow-menu-item">오름차순</a></li>
                                      <li><a class="overflow-menu-item">내림차순</a></li>
                                    </ul>
                                  </div>
                                </div>
                              </th>
                              <th class="with-tools">
                                금 액
                                <div class="tools overflow overflow-sm overflow-right">
                                  <button class="btn btn-icon btn-xs btn-tool btn-sorter default">
                                    <span class="icon"><i></i></span>
                                  </button>
                                  <div class="overflow-menu">
                                    <ul>
                                      <li><a class="overflow-menu-item">없음</a></li>
                                      <li><a class="overflow-menu-item">오름차순</a></li>
                                      <li><a class="overflow-menu-item">내림차순</a></li>
                                    </ul>
                                  </div>
                                </div>
                              </th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr style="cursor: default;">
                              <th>1</th>
                              <td>${requestScope.payList[0].nm_deduct01}</td>
                              <td><input type="text" class="am_deduct01" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>2</th>
                              <td>${requestScope.payList[0].nm_deduct02}</td>
                              <td><input type="text" class="am_deduct02" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>3</th>
                              <td>${requestScope.payList[0].nm_deduct03}</td>
                              <td><input type="text" class="am_deduct03" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>4</th>
                              <td>${requestScope.payList[0].nm_deduct04}</td>
                              <td><input type="text" class="am_deduct04" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>5</th>
                              <td>${requestScope.payList[0].nm_deduct05}</td>
                              <td><input type="text" class="am_deduct05" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>6</th>
                              <td>${requestScope.payList[0].nm_deduct06}</td>
                              <td><input type="text" class="am_deduct06" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>7</th>
                              <td>${requestScope.payList[0].nm_deduct07}</td>
                              <td><input type="text" class="am_deduct07" style="width:100%;"></td>
                            </tr>
                            <tr style="cursor: default;">
                              <th>8</th>
                              <td>${requestScope.payList[0].nm_deduct08}</td>
                              <td><input type="text" class="am_deduct08" style="width:100%;"></td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <script>
                Split(['#top', '#bottom'], {
                  direction: 'vertical',
                  gutterSize: 12,
                  sizes: [50, 50]
                })

                Split(['#bottom-left', '#bottom-right'], {
                  gutterSize: 12,
                  sizes: [50, 50]
                })
              </script>
            </section>
          </div>
        </div>
      </div>

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
    </div>
  </body>
</html>