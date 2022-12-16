DROP TABLE "MA_EMP" CASCADE CONSTRAINTS;
DROP TABLE "MA_CODE_EMP" CASCADE CONSTRAINTS;
DROP TABLE "MA_DEPT" CASCADE CONSTRAINTS;
DROP TABLE "MA_JIKUP" CASCADE CONSTRAINTS;
DROP TABLE "MA_EMP_PRIVATE" CASCADE CONSTRAINTS;
DROP TABLE "MA_USER" CASCADE CONSTRAINTS;
DROP TABLE "MA_BOARD" CASCADE CONSTRAINTS;
DROP TABLE "MA_RE_BOARD" CASCADE CONSTRAINTS;
DROP TABLE "HR_PAYREPORT" CASCADE CONSTRAINTS;
DROP TABLE "HR_PAYLIST" CASCADE CONSTRAINTS;
DROP TABLE "MA_BIZAREA" CASCADE CONSTRAINTS;
DROP TABLE "MA_COMPANY" CASCADE CONSTRAINTS;
DROP TABLE "HR_AMPAYMENT" CASCADE CONSTRAINTS;
DROP TABLE "HR_CDPAYMENT" CASCADE CONSTRAINTS;
-- BOARD, MEMBER 테이블 삭제 구문은 없음!


  -- 사원정보 테이블 생성 : MA_EMP
CREATE TABLE MA_EMP
    ( NO_EMP        VARCHAR2(20)
    , NM_EMP        VARCHAR2(20)   NOT NULL
    , ENTER_DATE    DATE           NOT NULL
    , BIRTH_DATE    DATE           NOT NULL
    , RETIRE_DATE   DATE
    , CD_EMP        VARCHAR2(20)   DEFAULT '001' NOT NULL
    , CD_DEPT       VARCHAR2(20)   NOT NULL
    , CD_JIK        VARCHAR2(20)   NOT NULL
    , PRIMARY KEY(NO_EMP) );



-- 재직구분코드 테이블 생성 : MA_CODE_EMP
CREATE TABLE MA_CODE_EMP
    (    CD_EMP     VARCHAR2(20)    DEFAULT '001'
    , NM_CD_EMP     VARCHAR2(20)    NOT NULL
    , PRIMARY KEY (CD_EMP) );



-- 부서코드 테이블 생성 : MA_DEPT
CREATE TABLE MA_DEPT
    (CD_DEPT    VARCHAR2(20)
    , NM_DEPT   VARCHAR2(30)    NOT NULL
    , PRIMARY KEY (CD_DEPT) );



-- 직급코드 테이블 생성 : MA_JIKUP
CREATE TABLE MA_JIKUP
    (CD_JIK     VARCHAR2(20)
    , NM_JIK    VARCHAR2(30)    NOT NULL
    , PRIMARY KEY(CD_JIK)   );


-- 개인정보 테이블 생성 : MA_EMP_PRIVATE
CREATE TABLE MA_EMP_PRIVATE
    ( NO_EMP  VARCHAR2(20)             NOT NULL
    , EMAIL     VARCHAR2(50)
    , NM_ADDR   VARCHAR2(200)
    , PHONE     VARCHAR2(50)     NOT NULL
    , NO_RES    VARCHAR2(20)     NOT NULL
    , FOREIGN KEY(NO_EMP)   REFERENCES MA_EMP (NO_EMP)  );


-- 사용자정보 테이블 생성 : MA_USER
CREATE TABLE MA_USER
    (NO_EMP VARCHAR2(20)               NOT NULL
    , USER_ID   VARCHAR2(50)    NOT NULL
    , USER_PWD  VARCHAR2(50)    NOT NULL

    , FOREIGN KEY(NO_EMP) REFERENCES MA_EMP (NO_EMP)    );


-- 급여정보 테이블 생성 : HR_CALCPAY
CREATE TABLE HR_CALCPAY
    (NO_EMP VARCHAR2(20)                NOT NULL
    , YM    VARCHAR2(20)          NOT NULL
    , CD_PAY VARCHAR2(20)         NOT NULL
    , AM_TOTPAY NUMBER
    , CD_DEDUCT     VARCHAR2(20)  NOT NULL
    , AM_TOTDEDUCT  NUMBER
    , FOREIGN KEY(NO_EMP) REFERENCES MA_EMP (NO_EMP)    );

-- 공지사항 테이블  생성 : MA_BOARD
CREATE TABLE MA_BOARD
    (B_NO   NUMBER
    , NO_EMP    VARCHAR2(20)          NOT NULL
    , SUBJECT   VARCHAR2(50)    NOT NULL
    , CONTENT VARCHAR2(3000)
    , REG_DATE  DATE    DEFAULT SYSDATE NOT NULL
    , READCOUNT NUMBER          NOT NULL
    , PRINT_NO NUMBER           NOT NULL
    , PRIMARY KEY (B_NO)
    , FOREIGN KEY(NO_EMP) REFERENCES MA_EMP (NO_EMP) );


-- 공지사항 댓글 관련 테이블 생성 : MA_RE_BOARD
CREATE TABLE MA_RE_BOARD
    (B_NO   NUMBER                 NOT NULL
    , NO_EMP    VARCHAR2(20)              NOT NULL
    , CONTENT   VARCHAR2(3000)     NOT NULL
    , REG_DATE  DATE    DEFAULT SYSDATE  NOT NULL
    , PRINT_LEVEL   NUMBER NOT NULL
    , FOREIGN KEY(B_NO) REFERENCES MA_BOARD(B_NO)
    , FOREIGN KEY(NO_EMP)  REFERENCES MA_EMP(NO_EMP)    );


-- 보고서양식 테이블 생성 : HR_PAYREPORT
CREATE TABLE HR_PAYREPORT
    (CD_PAYREPORT   VARCHAR2(50)    NOT NULL
    , NM_PAYREPORT  VARCHAR2(50)    NOT NULL    );


-- 급여기본정보 테이블 생성 : HR_PAYLIST
CREATE TABLE HR_PAYLIST
    (NO_EMP VARCHAR2(20)                   NOT NULL
    , PAY_PER_HOUR      NUMBER
    , PAY_PER_DAY      NUMBER
    , PAY_PER_MONTH      NUMBER
    , PAY_PER_YEAR      NUMBER
    , FOREIGN KEY (NO_EMP) REFERENCES MA_EMP (NO_EMP)   );



-- 지급항목 테이블 생성 : HR_PCALCPAY
CREATE TABLE HR_PCALCPAY
    ( NO_EMP VARCHAR2(20)  NOT NULL
    , YM VARCHAR2(20)       NOT NULL
    , CD_PAY01 VARCHAR2(20)
    , CD_PAY02 VARCHAR2(20)
    , CD_PAY03 VARCHAR2(20)
    , CD_PAY04 VARCHAR2(20)
     , NM_PAY01 VARCHAR2(50)
     , NM_PAY02 VARCHAR2(50)
     , NM_PAY03 VARCHAR2(50)
     , NM_PAY04 VARCHAR2(50)
    , AM_PAY01  NUMBER
    , AM_PAY02  NUMBER
    , AM_PAY03  NUMBER
    , AM_PAY04  NUMBER );

-- 공제항목 테이블 생성 : HR_DCALCPAY
CREATE TABLE HR_DCALCPAY
    ( NO_EMP VARCHAR2(20)  NOT NULL
    , YM VARCHAR2(20)       NOT NULL
    , CD_DEDUCT01 VARCHAR2(20)
    , CD_DEDUCT02 VARCHAR2(20)
    , CD_DEDUCT03 VARCHAR2(20)
    , CD_DEDUCT04 VARCHAR2(20)
     , NM_DEDUCT01 VARCHAR2(50)
     , NM_DEDUCT02 VARCHAR2(50)
     , NM_DEDUCT03 VARCHAR2(50)
     , NM_DEDUCT04 VARCHAR2(50)
    , AM_DEDUCT01  NUMBER
    , AM_DEDUCT02  NUMBER
    , AM_DEDUCT03  NUMBER
    , AM_DEDUCT04  NUMBER );


CREATE TABLE MA_BIZAREA
    (CD_BIZAREA       VARCHAR2(20)    NOT NULL
     , NM_BIZAREA     VARCHAR2(20)    NOT NULL
);

CREATE TABLE MA_COMPANY
    (CD_COMPANY       VARCHAR2(20)    NOT NULL
     , NM_COMPANY     VARCHAR2(20)    NOT NULL
);



-- MA_EMP 테이블 FK 생성 : CD_EMP(FK)
ALTER TABLE MA_EMP
ADD CONSTRAINT FK_MA_EMP_01 FOREIGN KEY (CD_EMP)
REFERENCES MA_CODE_EMP (CD_EMP) ;



-- MA_EMP 테이블 FK 생성 : CD_DEPT(FK)
ALTER TABLE MA_EMP
ADD CONSTRAINT FK_MA_EMP_02 FOREIGN KEY (CD_DEPT)
REFERENCES MA_DEPT (CD_DEPT) ;

-- MA_EMP 테이블 FK 생성 : CD_JIK(FK)
ALTER TABLE MA_EMP
ADD CONSTRAINT FK_MA_EMP_03 FOREIGN KEY (CD_JIK)
REFERENCES MA_JIKUP (CD_JIK) ;





-- HR_CALCPAY 테이블의 YM 컬럼 PK로 지정
ALTER TABLE HR_CALCPAY ADD PRIMARY KEY (YM);


-- HR_PCALCPAY, HR_DCLACPAY 테이블의 YM을 FK로 지정, HR_CALCPAY 참조
ALTER TABLE HR_PCALCPAY
ADD CONSTRAINT FK_HR_PCALCPAY_01 FOREIGN KEY (YM)
REFERENCES HR_CALCPAY (YM);

ALTER TABLE HR_DCALCPAY
ADD CONSTRAINT FK_HR_DCALCPAY_01 FOREIGN KEY (YM)
REFERENCES HR_CALCPAY (YM);

ALTER TABLE HR_PCALCPAY
ADD CONSTRAINT FK_HR_PCALCPAY_02 FOREIGN KEY (NO_EMP)
REFERENCES
 MA_EMP(NO_EMP) ;

ALTER TABLE HR_DCALCPAY
ADD CONSTRAINT FK_HR_DCALCPAY_02 FOREIGN KEY (NO_EMP)
REFERENCES MA_EMP (NO_EMP) ;

-- 컬럼 이름 변경
ALTER TABLE MA_BOARD RENAME COLUMN NO_EMP TO GROUP_NO;
-- GROUP_NO 컬럼 삭제
ALTER TABLE MA_BOARD DROP COLUMN GROUP_NO;
-- (READCOUNT, PRINT_NO)NULL 가능 설정, GROUP_NO 컬럼 추가
ALTER TABLE MA_BOARD MODIFY READCOUNT NUMBER NULL;
ALTER TABLE MA_BOARD MODIFY PRINT_NO NUMBER NULL;
ALTER TABLE MA_BOARD ADD GROUP_NO NUMBER;

-- MA_EMP_PRIVATE 테이블에  NM_ADDR1, NM_ADDR2 컬럼 추가
ALTER TABLE MA_EMP_PRIVATE ADD NM_ADDR1 VARCHAR2(50);
ALTER TABLE MA_EMP_PRIVATE ADD NM_ADDR2 VARCHAR2(50);




-- 기존 지급, 공제 테이블 3개 삭제
DROP TABLE "HR_PCALCPAY" CASCADE CONSTRAINTS;
DROP TABLE "HR_DCALCPAY" CASCADE CONSTRAINTS;
DROP TABLE "HR_CALCPAY" CASCADE CONSTRAINTS;

-- 지급/공제항목명과 코드가 있는 테이블 NM~ , CD~
CREATE TABLE HR_CDPAYMENT       (
CD_PAY01    VARCHAR2(50)
,  CD_PAY02    VARCHAR2(50)
,  CD_PAY03    VARCHAR2(50)
,  CD_PAY04    VARCHAR2(50)
,  CD_PAY05    VARCHAR2(50)
,  CD_PAY06    VARCHAR2(50)
,  CD_PAY07    VARCHAR2(50)
,  CD_PAY08    VARCHAR2(50)
, NM_PAY01      VARCHAR2(50)
, NM_PAY02      VARCHAR2(50)
, NM_PAY03      VARCHAR2(50)
, NM_PAY04      VARCHAR2(50)
, NM_PAY05      VARCHAR2(50)
, NM_PAY06      VARCHAR2(50)
, NM_PAY07      VARCHAR2(50)
, NM_PAY08      VARCHAR2(50)

,  CD_DEDUCT01    VARCHAR2(50)
,  CD_DEDUCT02    VARCHAR2(50)
,  CD_DEDUCT03    VARCHAR2(50)
,  CD_DEDUCT04    VARCHAR2(50)
,  CD_DEDUCT05    VARCHAR2(50)
,  CD_DEDUCT06    VARCHAR2(50)
,  CD_DEDUCT07   VARCHAR2(50)
,  CD_DEDUCT08    VARCHAR2(50)
, NM_DEDUCT01      VARCHAR2(50)
, NM_DEDUCT02      VARCHAR2(50)
, NM_DEDUCT03      VARCHAR2(50)
, NM_DEDUCT04      VARCHAR2(50)
, NM_DEDUCT05      VARCHAR2(50)
, NM_DEDUCT06      VARCHAR2(50)
, NM_DEDUCT07      VARCHAR2(50)
, NM_DEDUCT08      VARCHAR2(50)
) ;


-- 지급/공제항목금액이 있는 테이블
CREATE TABLE HR_AMPAYMENT (
NO_EMP VARCHAR2(20) NOT NULL
, YM VARCHAR2(20) NOT NULL
, AM_PAY01  NUMBER
, AM_PAY02  NUMBER
, AM_PAY03  NUMBER
, AM_PAY04  NUMBER
, AM_PAY05  NUMBER
, AM_PAY06  NUMBER
, AM_PAY07  NUMBER
, AM_PAY08  NUMBER
, AM_DEDUCT01   NUMBER
, AM_DEDUCT02   NUMBER
, AM_DEDUCT03   NUMBER
, AM_DEDUCT04   NUMBER
, AM_DEDUCT05   NUMBER
, AM_DEDUCT06   NUMBER
, AM_DEDUCT07   NUMBER
, AM_DEDUCT08   NUMBER
);



--------------------------------------------
-- 테스트 데이터 인서트
---------------------------------------------
-- 재직구분 데이터 넣기
INSERT INTO MA_CODE_EMP VALUES('000','관리자');
INSERT INTO MA_CODE_EMP VALUES('001','재직');
INSERT INTO MA_CODE_EMP VALUES('002','휴직');
INSERT INTO MA_CODE_EMP VALUES('099','퇴사');

-- 직급
INSERT INTO MA_JIKUP VALUES('000','관리자');
INSERT INTO MA_JIKUP VALUES('001','사장');
INSERT INTO MA_JIKUP VALUES('002','부사장');
INSERT INTO MA_JIKUP VALUES('003','전무이사');
INSERT INTO MA_JIKUP VALUES('004','상무이사');
INSERT INTO MA_JIKUP VALUES('005','이사');
INSERT INTO MA_JIKUP VALUES('006','부장');
INSERT INTO MA_JIKUP VALUES('007','차장');
INSERT INTO MA_JIKUP VALUES('008','과장');
INSERT INTO MA_JIKUP VALUES('009','대리');
INSERT INTO MA_JIKUP VALUES('010','주임');
INSERT INTO MA_JIKUP VALUES('011','사원');

-- 부서
INSERT INTO MA_DEPT VALUES('000','관리부');
INSERT INTO MA_DEPT VALUES('001','인사부');
INSERT INTO MA_DEPT VALUES('002','총무부');
INSERT INTO MA_DEPT VALUES('003','회계부');
INSERT INTO MA_DEPT VALUES('004','기획부');
INSERT INTO MA_DEPT VALUES('005','영업부');

--테스트 데이터(시스템, 김철수)
insert into ma_emp values ('system', 'system',sysdate,sysdate,null, '000','000','000');
insert into ma_emp_private values('system','erperp_system@gmail.com','서울시 강남구 어프어프빌딩 102-1703','01028287733','9007072000000','서울시 강남구','어프어프빌딩 102-1703');

insert into ma_emp values ('erp001', '김철수',sysdate,sysdate,null, '001','001','001');
insert into ma_emp_private values('erp001','erperp_sajang01@gmail.com','서울시 동작구 카카오아파트 102-1502','01012341234','9010101231234','서울시 동작구','카카오아파트 102-1502');

insert into ma_emp values ('erp002', '이강인',to_date('20160730','yyyy-mm-dd'),to_date('19991017','yyyy-mm-dd'),null, '001','003','006');
insert into ma_emp_private values ('erp002','erperp_kangin18@gmail.com','서울시 관악구 마요르카빌라 103-122','01013547985','9910171231234','서울시 관악구','마요르카빌라 103-122');

insert into ma_emp values('erp003', '손흥민',to_date('20020826','yyyy-mm-dd'),to_date('19850708','yyyy-mm-dd'),null, '001','002','003');
insert into ma_emp_private values('erp003','erperp_son7@gmail.com','서울시 광진구 토트넘아파트 117-017','01013798521','8507081112222','서울시 광진구','토트넘아파트 117-017');

insert into ma_emp values ('erp004', '조규성',to_date('20141008','yyyy-mm-dd'),to_date('19980125','yyyy-mm-dd'),null, '001','005','009');
insert into ma_emp_private values('erp004','erperp_forward09@gmail.com','서울시 양천구 현대모터스빌라 110-1903','01013798521','9801251532692','서울시 양천구','현대모터스빌라 110-1903');

insert into ma_emp values ('erp005', '황의조',to_date('19960214','yyyy-mm-dd'),to_date('19720215','yyyy-mm-dd'),null, '001','003','005');
insert into ma_emp_private values('erp005','erperp_eujo16@naver.com','서울시 종로구 카카오아파트 117-415','01045169712','7202151421697','서울시 종로구','카카오아파트 117-415');

insert into ma_emp values ('erp006', '송민규',to_date('20050108','yyyy-mm-dd'),to_date('19851227','yyyy-mm-dd'),null, '001','004','007');
insert into ma_emp_private values('erp006','erperp_songmk26@gmail.com','전라북도 군산시 현대아파트 102-1017','01064581256','8512271784125','전라북도 군산시','현대아파트 102-1017');

insert into ma_emp values ('erp007', '백승호',to_date('20160214','yyyy-mm-dd'),to_date('19970915','yyyy-mm-dd'),null, '001','005','009');
insert into ma_emp_private values('erp007','erperp_goal08@gmail.com','충청남도 예산군 까치아파트 118-1302','01041261005','9709151124879','충청남도 예산군','까치아파트 118-1302');

insert into ma_emp values ('erp008', '나상호',to_date('20010113','yyyy-mm-dd'),to_date('19850402','yyyy-mm-dd'),null, '001','004','008');
insert into ma_emp_private values('erp008','erperp_rocket17@hanmail.net','서울시 성동구 현대아파트 115-1061','01091754112','8504021236574','서울시 성동구','현대아파트 115-1061');

insert into ma_emp values ('erp009', '정우영',to_date('20080319','yyyy-mm-dd'),to_date('19811207','yyyy-mm-dd'),null, '001','002','007');
insert into ma_emp_private values('erp009','erperp_scfb25@gmail.com','서울시 종로구 카카오아파트 127-011','01064871523','8112071549782','서울시 종로구','카카오아파트 127-011');

insert into ma_emp values ('erp010', '황인범',to_date('20040708','yyyy-mm-dd'),to_date('19940604','yyyy-mm-dd'),null, '001','004','010');
insert into ma_emp_private values('erp010','erperp_yellowintiger06@gmail.com','서울시 금천구 토트넘아파트 103-1522','01046125547','9406041245665','서울시 금천구','토트넘아파트 103-1522');

insert into ma_emp values ('erp011', '황희찬',to_date('19980629','yyyy-mm-dd'),to_date('19790823','yyyy-mm-dd'),null, '001','004','006');
insert into ma_emp_private values('erp011','erperp_khwangso11@gmail.com','서울시 마포구 제일아파트 109-112','01064971226','7908231332654','서울시 마포구','제일아파트 109-112');

COMMIT;


-- MA_USER 에 데이터 넣기
--시스템 계정의 아이디 비번
insert into ma_user values ('system', 'system','123');
--김철수 사장의 아이디 비번
insert into ma_user values ('erp001', 'abc','123');
--------------------------
insert into ma_user values ('erp002', 'a02','002');
insert into ma_user values ('erp003', 'a03','003');
insert into ma_user values ('erp004', 'a04','004');
insert into ma_user values ('erp005', 'a05','005');
insert into ma_user values ('erp006', 'a06','006');
insert into ma_user values ('erp007', 'a07','007');
insert into ma_user values ('erp008', 'a08','008');
insert into ma_user values ('erp009', 'a09','009');
insert into ma_user values ('erp010', 'a10','010');
insert into ma_user values ('erp011', 'a11','011');

COMMIT;


-- 급여항목 테스트 데이터
insert into hr_cdpayment
values (
'p01','p02','p03','p04','p05','p06','p07','p08'
,'기본급','연장근무수당','상여금','직무수당','식대','자격수당','기타수당','소급금'
,'d01','d02','d03','d04','d05','d06','d07','d08'
, '국민연금','건강보험','고용보험','동호회비','정산소득세','정산주민세','소득세','주민세' );

insert into hr_ampayment
values (
'erp001','202212',3000000,100000,20000,0,100000,0,0,0
,200000,50000,50000,15000,150000,0,0,0 );

COMMIT;




--------------------------------------------
-- 사원전체정보 뷰테이블 생성
--------------------------------------------

SELECT E.*, U.*
FROM MA_EMP E JOIN MA_USER U
ON E.NO_EMP = U.NO_EMP;

CREATE VIEW TEST_01 AS
SELECT E.NO_EMP, E.NM_EMP, E.ENTER_DATE, E.BIRTH_DATE, E.RETIRE_DATE, E.CD_EMP, E.CD_DEPT, E.CD_JIK
, U.USER_ID, U.USER_PWD
FROM MA_EMP E JOIN MA_USER U
ON E.NO_EMP = U.NO_EMP;

CREATE VIEW MA_EMP_TMP AS
SELECT T1.NO_EMP, T1.NM_EMP, T1.ENTER_DATE, T1.BIRTH_DATE, T1.RETIRE_DATE, T1.CD_EMP, T1.CD_DEPT, T1.CD_JIK
, T1.USER_ID, T1.USER_PWD, EP.EMAIL, EP.NM_ADDR, EP.NM_ADDR1, EP.NM_ADDR2, EP.PHONE, EP.NO_RES
FROM TEST_01 T1 JOIN MA_EMP_PRIVATE EP
ON T1.NO_EMP = EP.NO_EMP ;


-- 뷰 추가
CREATE VIEW MA_EMP_TMP_JIK    AS
SELECT TMP.NO_EMP, TMP.NM_EMP, TMP.ENTER_DATE, TMP.BIRTH_DATE, TMP.RETIRE_DATE, TMP.CD_EMP, TMP.CD_DEPT, TMP.USER_ID, TMP.USER_PWD, TMP.EMAIL, TMP.NM_ADDR, TMP.NM_ADDR1, TMP.NM_ADDR2, TMP.PHONE, TMP.NO_RES
,TMP.CD_JIK , JIK.NM_JIK
FROM MA_EMP_TMP TMP INNER JOIN MA_JIKUP JIK
ON TMP.CD_JIK = JIK.CD_JIK;

CREATE VIEW MA_EMP_TMP_CE AS
SELECT TMPJ.NO_EMP, TMPJ.NM_EMP, TMPJ.ENTER_DATE, TMPJ.BIRTH_DATE, TMPJ.RETIRE_DATE, TMPJ.CD_EMP, TMPJ.CD_JIK, TMPJ.CD_DEPT, TMPJ.USER_ID, TMPJ.USER_PWD, TMPJ.EMAIL, TMPJ.NM_ADDR, TMPJ.NM_ADDR1, TMPJ.NM_ADDR2, TMPJ.PHONE, TMPJ.NO_RES
, MCE.NM_CD_EMP, TMPJ.NM_JIK
FROM MA_EMP_TMP_JIK TMPJ INNER JOIN MA_CODE_EMP MCE
ON TMPJ.CD_EMP = MCE.CD_EMP;

CREATE VIEW MA_EMP_TOTAL AS
SELECT MCE.NO_EMP, MCE.NM_EMP, MCE.ENTER_DATE, MCE.BIRTH_DATE, MCE.RETIRE_DATE, MCE.CD_EMP, MCE.CD_JIK, MCE.CD_DEPT, MCE.USER_ID, MCE.USER_PWD, MCE.EMAIL, MCE.NM_ADDR, MCE.NM_ADDR1, MCE.NM_ADDR2, MCE.PHONE, MCE.NO_RES
, MCE.NM_CD_EMP, MCE.NM_JIK, DEP.NM_DEPT
FROM MA_EMP_TMP_CE MCE JOIN MA_DEPT DEP
ON MCE.CD_DEPT = DEP.CD_DEPT;

select * from ma_emp_total;