<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<!-- 모든 JSP 페이지 상단에 무조건 아래 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<!--JSP 페이지에서 사용할 [사용자 정의 태그]의 한 종류인 [JSTL의 C 코어 태그]를 사용하겠다고 선언-->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 사용자 정의 태그(Custom Tag) -->
<!-- 사용자가 원하는 기능을 구현하고 -->
<!-- [HTML 형태]로 표현하여 사용할 수 있는 -->
<!-- [사용자 정의 태그]를 말한다. -->

<!-- JQuery 라이브러리 수입 -->
<script src="/jquery-1.11.0.min.js"></script>



