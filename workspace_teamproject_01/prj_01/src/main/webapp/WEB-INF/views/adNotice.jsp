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
        <title>메인 화면</title>
        <!-- icon font -->
        <link rel="stylesheet" href="/js/assets/fonts/material-icons/material-icons.css" />
        <!-- style -->
        <link rel="stylesheet" href="/js/assets/js/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.css" />
        <link rel="stylesheet" href="/js/assets/js/plugins/date-rage-picker/daterangepicker.css" />
        <link rel="stylesheet" href="/js/assets/js/plugins/fotorama/fotorama.min.css" />
        <link rel="stylesheet" href="/js/assets/css/lithium.css" />
        <link rel="stylesheet" href="/js/assets/css/lithium-ie.css" />
        <!--[if gte IE 9]>
        <link rel="stylesheet" href="assets/css/lithium-ie-9.css" />
        <![endif]-->
        <!-- scripts -->
        <script src="/js/assets/js/jquery.js"></script>
        <script src="/js/assets/js/prefix.js"></script>
        <script src="/js/assets/js/plugins/moment/moment-with-locales.js"></script>
        <script src="/js/assets/js/plugins/bootstrap/transition.js"></script>
        <script src="/js/assets/js/plugins/bootstrap/collapse.js"></script>
        <script src="/js/assets/js/plugins/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
        <script src="/js/assets/js/plugins/date-rage-picker/daterangepicker.min.js"></script>
        <script src="/js/assets/js/plugins/fotorama/fotorama.min.js"></script>
        <script src="/js/assets/js/plugins/rangeslider/rangeslider.min.js"></script>
        <script src="/js/assets/js/plugins/split/split.js"></script>
        <script src="/js/assets/js/lithium.js"></script>
    </head>
    <body class="side-first by-menu popup-menu-open">
        <div id="wrapper">
            <header id="header-bar" class="on-light">
                <div id="header-bar-main">
                    <button class="menu-toggle float-l" onclick="$('body').addClass('mobile-menu-open')">
                        <span class="icon"><i class="Licon ico-menu"></i></span>
                    </button>
                    <div class="logo-area">
                        <a href="">
                            <img src="/js/assets/images/Hierp_Logo1.png" class="on-light">
                        </a>
                    </div>
                    <div class="utility-area">
                        <div class="utility-group">
                            <a class="utility">
                                <span class="icon"><i class="Licon size-24 ico-my"></i></span>
                            </a>
                            <a class="utility">
                                <span class="icon"><i class="Licon ico-logout"></i></span>
                            </a>
                        </div>
                    </div>
                    <div class="user-area responsive-except-desktop">
                        <span class="user-info">세아베스틸 제강팀 관리자 김세아</span>
                    </div>
                </div>
            </header>
        
            <aside id="side-bar" class="slim tab">
                <button class="side-bar-toggle tab-item" data-tab-contents="DEFAULT" data-tab-contents-group="SIDE_MENU"  onclick="$.Lithium.sideSubMenuToggle().toggleSideBar();">
                    <span class="icon"><i class="Licon ico-menu"></i></span>
                    <span class="icon"><i class="Licon ico-close"></i></span>
                </button>
                <div class="menu-area">
                    <div class="menu menu-vertical"></div>
                </div>
            </aside>
        
            <div id="side-bar-sub" class="">
                <div class="tab-contents" data-tab-contents="DEFAULT" data-tab-contents-group="SIDE_MENU">
                    <!-- search bar -->
                    <div class="search-bar-container">
                        <div class="input-container input-container-md search-bar">
                            <div class="input-group">
                                <input type="search" placeholder="Menu Search..." class="input-box">
                                <div class="search-history-panel">
                                    <div class="search-history-panel-dim" onclick="$.Lithium.search().closeSearchHistoryPanel()"></div>
                                        <div class="inner">
                                            <div class="list">
                                                <ul>
                                                    <li>
                                                        <div class="search-history-item">
                                                            <button class="history-call" onclick="$.Lithium.search().closeSearchHistoryPanel()">검색기록1</button>
                                                            <button class="history-remove"><i class="material-icons">cancel</i></button>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="search-history-item">
                                                            <button class="history-call" onclick="$.Lithium.search().closeSearchHistoryPanel()">검색기록2</button>
                                                            <button class="history-remove"><i class="material-icons">cancel</i></button>
                                                        </div>
                                                    </li>
                                                    <li>
                                                        <div class="search-history-item">
                                                            <button class="history-call" onclick="$.Lithium.search().closeSearchHistoryPanel()">검색기록3</button>
                                                            <button class="history-remove"><i class="material-icons">cancel</i></button>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="tools">
                                                <ul>
                                                    <li class="float-l">
                                                        <button class="tools-item"><span class="v-middle">검색 기록 삭제</span></button>
                                                        <button class="tools-item history-mode"><span class="v-middle">검색어 저장 끄기</span></button>
                                                        <button class="tools-item auto-complete-mode"><span class="v-middle">검색어 저장 끄기</span></button>
                                                    </li>
                                                    <li class="float-r">
                                                        <button class="tools-item close" onclick="$.Lithium.search().closeSearchHistoryPanel()">닫기</button>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="input-group-tools">
                                        <button class="clear"><i class="material-icons">cancel</i></button>
                                        <button class="search"><i class="Licon size-24 ico-search"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- menu -->
                        <ul class="menu-accordion">
                            <li>
                                <a href="#"><span class="label">공지사항</span></a>
                                <!-- <ul class="tree-view-menu">
                                <li><a href="#"><span class="label">Menu1-1</span></a></li>
                                <li><a href="#"><span class="label">Menu1-2</span></a></li>
                                <li class="tree-view">
                                    <a href="#"><span class="label">Menu1-3</span></a>
                                    <ul class="tree-view-menu">
                                    <li><a href="#"><span class="label">Menu1-3-1</span></a></li>
                                    <li><a href="#"><span class="label">Menu1-3-2</span></a></li>
                                    <li><a href="#"><span class="label">Menu1-3-3</span></a></li>
                                    </ul>
                                </li>
                                <li class="tree-view">
                                    <a href="#"><span class="label">Menu1-4</span></a>
                                    <ul class="tree-view-menu">
                                    <li><a href="#"><span class="label">Menu1-4-1</span></a></li>
                                    <li><a href="#"><span class="label">Menu1-4-2</span></a></li>
                                    <li><a href="#"><span class="label">Menu1-4-3</span></a></li>
                                    </ul>
                                </li>
                                <li><a href="#"><span class="label">Menu1-5</span></a></li>
                                </ul> -->
                            </li>
                            <li class="tree-view">
                                <a href="#"><span class="label">인사관리</span></a>
                                <ul class="tree-view-menu">
                                    <li><a href="#"><span class="label">사원등록</span></a></li>
                                    <li><a href="#"><span class="label">사용자정보등록</span></a></li>
                                    <li><a href="#"><span class="label">사원명부</span></a></li>
                                </ul>
                            </li>
                            <li class="tree-view">
                                <a href="#"><span class="label">급여관리</span></a>
                                <ul class="tree-view-menu">
                                    <li><a href="#"><span class="label">급여계산</span></a></li>
                                    <!--<li><a href="#"><span class="label">Menu3-1</span></a></li>--> 
                                </ul>
                            </li>
                        </ul>
                    </div>
        
                    <div class="tab-contents" data-tab-contents="TAB1" data-tab-contents-group="SIDE_MENU">
                        <ul class="menu-accordion">
                            <li>
                                <p class="group-label">Menu1</p>
                            </li>
                        </ul>
                    </div>
        
                    <div class="tab-contents" data-tab-contents="TAB2" data-tab-contents-group="SIDE_MENU">
                        <ul class="menu-accordion">
                            <li>
                                <p class="group-label">Menu2</p>
                            </li>
                        </ul>
                    </div>
        
                    <div class="tab-contents" data-tab-contents="TAB3" data-tab-contents-group="SIDE_MENU">
                        <div class="menu-accordion-wrapper">
                            <ul class="menu-accordion">
                                <li>
                                    <p class="group-label">Menu3</p>
                                </li>
                                <li>
                                    <a href="#"><span class="label">공지사항</span></a>
                                    <ul class="tree-view-menu">
                                        <li><a href="#"><span class="label">사용자정보등록</span></a></li>
                                        <li><a href="#"><span class="label">사원명부</span></a></li>
                                    </ul>
                                </li>
                                <li class="tree-view">
                                    <a href="#"><span class="label">인사관리</span></a>
                                    <ul class="tree-view-menu">
                                        <li><a href="#"><span class="label">사원등록</span></a></li>
                                    </ul>
                                </li>
                                <li class="tree-view">
                                    <a href="#"><span class="label">급여관리</span></a>
                                    <ul class="tree-view-menu">
                                        <li><a href="#"><span class="label">급여계산</span></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
        
                    <div class="tab-contents" data-tab-contents="TAB4" data-tab-contents-group="SIDE_MENU">
                        <ul class="menu-accordion">
                            <li>
                                <p class="group-label">Menu4</p>
                            </li>
                        </ul>
                    </div>
                
                    <div class="tab-contents" data-tab-contents="TAB5" data-tab-contents-group="SIDE_MENU">
                        <ul class="menu-accordion">
                            <li>
                                <p class="group-label">Menu5</p>
                            </li>
                        </ul>
                    </div>
                
                    <div class="tab-contents" data-tab-contents="TAB6" data-tab-contents-group="SIDE_MENU">
                        <ul class="menu-accordion">
                            <li>
                                <p class="group-label">Menu6</p>
                            </li>
                        </ul>
                    </div>
        
                    <div class="tab-contents" data-tab-contents="TAB7" data-tab-contents-group="SIDE_MENU">
                        <ul class="menu-accordion">
                            <li>
                                <p class="group-label">Menu7</p>
                            </li>
                        </ul>
                    </div>
                
                    <div class="tab-contents" data-tab-contents="TAB8" data-tab-contents-group="SIDE_MENU">
                        <ul class="menu-accordion">
                            <li>
                                <p class="group-label">Menu8</p>
                            </li>
                        </ul>
                    </div>
                </div>
        
                <div id="contents-wrapper">
                    <div class="content-header">
                        <div class="content-title-bar">
                            <h5>공지사항<button class="btn btn-sm btn-icon"><span class="icon"></span></button></h5>
                            <!-- <h5>Menu Name 1<button class="btn btn-sm btn-icon"><span class="icon"><i class="material-icons">star</i></span></button></h5> -->
                            <div class="tools responsive-except-desktop">
                                <div class="tools-group">
                                    <a href="#" class="tool-item">
                                        <span class="icon"><i class="Licon ico-datareset"></i></span>
                                        <span class="label">조회</span>
                                    </a>
                                    <a href="#" class="tool-item">
                                        <span class="icon"><i class="Licon ico-save"></i></span>
                                        <span class="label">저장</span>
                                    </a>
                                    <a href="#" class="tool-item">
                                        <span class="icon"><i class="Licon ico-add"></i></span>
                                        <span class="label">추가</span>
                                    </a>
                                    <a href="#" class="tool-item">
                                        <span class="icon"><i class="Licon ico-minus"></i></span>
                                        <span class="label">삭제</span>
                                    </a>
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
                </div>
            </div>
        </div>
    </body>
</html>