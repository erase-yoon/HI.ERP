<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 -->
<!-- 현 JSP 페이지 처리 방식 선언 -->
<!-- 모든 JSP 페이지 상단에 항상 아래와 같은 설정이 들어간다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- contectType="text/html; charset=UTF-8" -->
<!-- 현재 JSP 페이지 실행 후 생성되는 문서는 HTML이고, -->
<!-- 문서 안의 데이터는 UTF-8 방식으로 인코딩 -->
<!-- pageEncoding="UTF-8" -->
<!-- 현재 JSP 페이지는 UTF-8 방식으로 인코딩한다. -->
<!-- <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> -->

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>로그인 화면</title>
        <script src="/js/jquery-1.11.0.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="/css/login/style.css" type="text/css">
        <link rel="stylesheet" href="/css/login/login_bg.css" type="text/css">
        <script src="/js/login/jquery.min.js"></script>
        <script src="/js/loginjs/popper.js"></script>
        <script src="/js/loginjs/bootstrap.min.js"></script>
        <script src="/js/loginjs/main.js"></script>
        <script>
            // body 태그 안의 모든 코드를 읽은 이후 
            // 호출될 Javascript 코드 설정
            $(function(){

                // class="loginBtn" 가진 태그에
                // click 이벤트가 발생할 경우
                // checkLoginForm() 함수 호출
                $(".loginBtn").bind("click", function(){
                    checkLoginForm();
                });

                // -----------------------
                // 웹 서버에 접속한 클라이언트가 가져온 쿠키값을
                // 아이디와 암호 입력란에 삽입
                // -----------------------
                // 접속한 클라이언트가 가져온 쿠키 중
                // 쿠키명 "mid"에 대응하는 쿠키값을
                // {cookie.mid.value}에 삽입하여
                // name='mid' 태그의 value 값으로 입력
                $("[name='mid']").val("${cookie.mid.value}");

                // 접속한 클라이언트가 가져온 쿠키 중
                // 쿠키명 "pwd"에 대응하는 쿠키값을
                // {cookie.pwd.value}에 삽입하여
                // name='pwd' 태그의 value 값으로 입력
                $("[name='pwd']").val("${cookie.pwd.value}");

                // -----------------------
                // 접속한 클라이언트가 가져온 쿠키 값은
                // EL 문법을 사용하여 꺼낸다.
                // 쿠키값을[EL] 문법으로 꺼내는 형식
                // $ {cookie.쿠키명.value}
                // $ 와 {} 사이의 공백은 제거하여야 작동됨
                // 주석문에서도 EL 문법이 실행됨
                // -----------------------

            });
            
            // 입력한 아이디와 함호의 유효성을 체크하는
            // checkLoginForm() 함수 선언
            function checkLoginForm(){
                // -----------------------
                // 아이디 유효성 체크
                // -----------------------

                // name='mid'를 가진 태그를 관리하는
                // JQuery 객체의 메모리 위치 주소 값을 얻어
                // midObj 변수에 저장
                var midObj = $("[name='mid']");

                // 화면에서 입력한 데이터를 가져와
                // midVal 변수에 저장
                var midVal = midObj.val();

                // midVal 데이터가 문자가 아닐 경우
                // 비어있는 문자열("")을 midVal 변수에 저장
                if(typeof(midVal)!="string"){
                    midVal="";
                }

                // midVal 데이터가
                // 길이가 없거나 공백으로만 이루어져 있을 경우
                if(midVal.split(" ").join("")==""){

                    // 경고창 띄우기
                    // alert("아이디를 입력해 주세요.");

                    // 비어있는 문자열("")로 변경
                    midObj.val("");

                    // 커서를 올림
                    midObj.focus();

                    // checkLoginForm() 함수 종료
                    return;
                }
                
                // -----------------------
                // 암호 유효성 체크
                // -----------------------

                // name='pwd'를 가진 태그를 관리하는
                // JQuery 객체의 메모리 위치 주소 값을 얻어
                // pwdObj 변수에 저장
                var pwdObj = $("[name='pwd']");

                // 화면에서 입력한 데이터를 가져와
                // pwdVal 변수에 저장
                var pwdVal = pwdObj.val();
                
                // pwdObj 데이터가 문자가 아닐 경우
                // 비어있는 문자열("")을 pwdObj 변수에 저장
                if(typeof(pwdVal)!="string"){
                    pwdVal="";
                }

                // pwdVal 데이터가
                // 길이가 없거나 공백으로만 이루어져 있을 경우
                if(pwdVal.split(" ").join("")==""){

                    // 경고창 띄우기
                    // alert("암호를 입력해 주세요.");

                    // 비어있는 문자열("")로 변경
                    pwdObj.val("");

                    // 커서를 올림
                    pwdObj.focus();

                    // checkLoginForm() 함수 종료
                    return;
                }

                // -----------------------
                // 비동기 방식으로 웹 서버에 접근하여
                // 아이디, 암호의 데이터를 판단하여
                // 로그인의 성공, 실패 여부 확인
                // 웹 서버 접속 시 사용할 URL : /loginProc.do
                // -----------------------
                $.ajax({

                    // 웹 서버 접속 시 사용할 URL 지정
                    url : "/loginProc.do"

                    // 웹 서버에 데이터 전송 방식 지정
                    // 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
                    // 두가지를 보내는 방식 지정
                    , type : "post"

                    // 서버로 전송할 파라미터명(입력양식name값), 파라미터값(입력양식value값)을
                    // 아래 형식의 문자열로 조합해서 설정
                    // "파라미터명1=파라미터값1 & 파라미터명2=파라미터값2 & ~"
                    , data : $("[name='loginForm']").serialize()
                    // , data : {"admin_id" : admin_idVal, "pwd" : pwdVal}
                    // , data : "admin_id = " + admin_idVal + "& pwd = " + pwdVal

                    // 웹 서버와 통신 후 
                    // 웹 서버의 응답을 성공적으로 받을 경우 
                    // 실행할 익명함수 설정
                    // 익명함수의 매개변수에는 웹 서버에서 받은
                    // [아이디, 암호의 존재개수]가 들어온다.
                    , success : function(idCnt){
                        
                        if(idCnt==1){

                            document.adNotice.submit();

                            // if(midVal=="abc"){
                            //     document.adNotice.submit();
                            // }else{
                            //     document.empNotice.submit();
                            // }
                            // alert("로그인 성공");

                            // 웹 서버에 "/boardList.do" URL 주소로 접속 시도
                            // 사용 메소드 : location.replace("URL 주소");
                            // 해당 메소드 접속 방식은 get 방식이다.
                            // location.replace("/boardList.do");
                            
                            // POST 방식을 사용하고 싶을 경우
                            // HTML form 태그 생성 method와 action 값을 준 후
                            // document.~.submit();으로 접속한다.
                        }else{
                            alert("로그인 실패");
                            admin_idObj.val("");
                            pwdObj.val("");
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
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="login-wrap p-4 p-md-5">
                            <div class="login-logo-align">
                                <img src="/img/login/loginLogo.png">
                            </div>
                            <div class="icon d-flex align-items-center justify-content-center">
                                <span class="fa fa-user-o"></span>
                            </div>
                            <br>
                            <form action="/adNotice.do" name="adNotice" method="post"></form>
                            <form action="/empNotice.do" name="empNotice" method="post"></form>
                            <form action="/loginProc.do" name="loginForm" method="post">
                                <div class="form-group">
                                    <input type="text" name="mid" class="form-control rounded-left" placeholder="ID">
                                </div>
                                <div class="form-group d-flex">
                                    <input type="password" name="pwd" class="form-control rounded-left" placeholder="Password">
                                </div>
                                <div class="form-group">
                                    <button type="button" class="loginBtn form-control btn btn-primary rounded submit px-3">Login</button>
                                </div>
                                <div class="form-group d-md-flex">
                                    <div class="w-50">
                                        <label class="checkbox-wrap checkbox-primary">정보 기억
                                            <input type="checkbox" value="yes" name="is_login" class="is_login" ${empty cookie.mid.value?'':'checked'}>
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>