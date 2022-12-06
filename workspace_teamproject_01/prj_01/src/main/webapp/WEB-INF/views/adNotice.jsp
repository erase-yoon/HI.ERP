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
              <a class="utility">
                <span class="icon"><i class="Licon ico-logout"></i></span>
              </a>
            </div>
          </div>
          <div class="user-area responsive-except-desktop">
            <span class="user-info">${requestScope.user_id} 윤지우 (12345)</span>
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
              <a href="#"><span class="label">인사관리</span></a>
              <ul class="tree-view-menu">
                <li><a href="adEmpReg.html"><span class="label">사원등록</span></a></li>
                <li><a href="adUserInfoReg.html"><span class="label">사용자정보등록</span></a></li>
                <li><a href="adEmpList.html"><span class="label">사원명부 및 수정/삭제</span></a></li>
              </ul>
            </li>
            <li class="tree-view">
              <a href="#"><span class="label">급여관리</span></a>
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
            <h5>공지사항<button class="btn btn-sm btn-icon"><span class="icon"></span></button></h5>
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
                <button class="tool-item">
                  <a href="adNoticeReg.html">
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
  
  
  
  
        <br><br><br><br><br><br><br><br>
  
  
  
  
  
        <table class="table table-md table-top">
          <thead>
          <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성일</th>
            <th>조회수</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <th>
              <span class="label">5</span>
            </th>
            <td>목록 텍스트텍스트 목록 텍스트텍스트 목록 텍스트텍스트</td>
            <td>2022.11.25</td>
            <td>5</td>
          </tr>
          <tr>
            <th>
              <span class="label">4</span>
            </th>
            <td>목록 텍스트텍스트 목록 텍스트텍스트 목록 텍스트텍스트</td>
            <td>2021.11.25</td>
            <td>523</td>
          </tr>
          <tr>
            <th>
              <span class="label">3</span>
            </th>
            <td>목록 텍스트텍스트 목록 텍스트텍스트 목록 텍스트텍스트</td>
            <td>2020.11.25</td>
            <td>5432</td>
          </tr>
          <tr>
            <th>
              <span class="label">2</span>
            </th>
            <td>목록 텍스트텍스트 목록 텍스트텍스트 목록 텍스트텍스트</td>
            <td>2019.11.25</td>
            <td>56432</td>
          </tr>
          <tr>
            <th>
              <span class="label">1</span>
            </th>
            <td>목록 텍스트텍스트 목록 텍스트텍스트 목록 텍스트텍스트</td>
            <td>2018.11.25</td>
            <td>5423453</td>
          </tr>
          </tbody>
        </table>
        <div class="pagination-wrapper">
          <div class="pagination">
            <div class="pagination-group direction">
              <ul>
                <li class="disabled"><a href="#" class="pagination-item prev"><i class="Licon ico-prev"></i></a></li>
                <li class="disabled"><a href="#" class="pagination-item left"><i class="Licon ico-left"></i></a></li>
              </ul>
            </div>
            <div class="pagination-group">
              <ul>
                <li class="on"><a href="#" class="pagination-item"><i>1</i></a></li>
                <li class=""><a href="#" class="pagination-item"><i>2</i></a></li>
                <li class=""><a href="#" class="pagination-item"><i>3</i></a></li>
                <li class=""><a href="#" class="pagination-item"><i>4</i></a></li>
                <li class=""><a href="#" class="pagination-item"><i>5</i></a></li>
              </ul>
            </div>
            <div class="pagination-group direction">
              <ul>
                <li class=""><a href="#" class="pagination-item right"><i class="Licon ico-right"></i></a></li>
                <li class=""><a href="#" class="pagination-item next"><i class="Licon ico-next"></i></a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
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
                <td>윤지우 대리</td>                                     
              </tr>
              <tr align="center">
                <td>(DB개발팀)</td>                                     
              </tr>
              <tr align="center">
                <td>010-1111-2222</td>
              </tr>
              <tr align="center">
                <td>dbswldn@naver.com</td>
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