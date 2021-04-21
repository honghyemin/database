-- 박지성이 구입한 책의 합계금액
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --CUSTID : 1

-- 구입 내역 확인
SELECT * FROM ORDERS WHERE CUSTID =1;

-- 서브쿼리(SUB QUERY) 방식 : 쿼리 내에 또 다른 쿼리가 있음
SELECT * FROM ORDERS 
-- ' =(equal) ' 부호가 사용 될 때는 단 하나의 데이터만 와야 함.
WHERE CUSTID =(SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');
----------------------

-- 테이블 조인(JOIN) 방식
SELECT * FROM CUSTOMER WHERE CUSTID =1;
SELECT * FROM ORDERS WHERE CUSTID =1;

-- 양쪽 테이블의 CUSTID가 같은 것들 목록
-- CUSTOMER, ORDERS 테이블 데이터를 동시 조회
SELECT * FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID -- 두개 테이블을 조인할 때 사용한 조인 조건
AND CUSTOMER.NAME = '박지성'; -- 찾을 조건(WHERE) / 데이타를 걸러냄

-- 테이블 별칭 사용으로 간단하게 표시하고 사용
-- WHERE절 조인조건 사용 - 오라클 사용 방식
-- SELECT절에서는 동일한 컬럼을 중복선언 할 수 없음. -> 별칭을 써주던지 해야 함.
SELECT * FROM CUSTOMER C, ORDERS O -- 컬럼명에 대한 별칭을 써줌, 별칭을 쓰게 되면 그 후에는 테이블명을 가지고 쓰면 안됨.
WHERE C.CUSTID = O.CUSTID -- 두개 테이블을 조인할 때 사용한 조인 조건
AND C.NAME = '박지성'; -- 찾을 조건(WHERE) / 데이타를 걸러냄


-- ANSI 표준 조인 쿼리 (모든 DB에서 적용 가능)
SELECT *
FROM CUSTOMER C INNER JOIN ORDERS O -- 조인 방식 지정
    ON C.CUSTID = O.CUSTID -- 조인 조건 지정
WHERE C.NAME = '박지성'; -- 검색 조건

--=====================
-- 박지성이 구입한 책의 합계 금액
SELECT SUM(O.SALEPRICE) AS SUM --> 구입한 책의 합계 금액 조회 / 컬럼명의 별칭 : AS 별칭
-- SELECT * -> 전체 데이터 조회할때 
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID -- 실제 구입한 책들만 출력하게 함.
    AND C.NAME = '박지성' -- 박지성이 실제 구입한 책들만 검색
;


-- 조인된 데이터에서 컬럼 조회시 : 테이블명(별칭).컬럼명 형태로 사용
SELECT C.CUSTID -- 양쪽 테이블에 동일 컬럼명 존재하는 경우 위치 지정 필수
    ,C.NAME, C.ADDRESS
    , O.CUSTID AS ORD_CUSTID -- 조회된 컬럼명 중복 시 별칭으로 다르게 지정
    , O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O -- 조인할 테이블
WHERE C.CUSTID = O.CUSTID -- 조인 조건
AND C.NAME = '박지성' -- 검색 조건
;


--------------------------
SELECT * FROM BOOK;
SELECT * FROM ORDERS;
-- 출판한 책 중 판매된 책 목록 ( 미디어로 끝나는 출판사)
SELECT *
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID -- 조인 조건
-- AND PUBLISHER LIKE '%미디어'
-- AND PUBLISHER = '굿스포츠'
ORDER BY B.PUBLISHER, B.BOOKNAME
;

--======================
-- ( 실습 ) 테이블 조인을 통해 데이터 찾기.
-- 1. '야구를 부탁해'라는 책이 팔린 내역 확인( 책 제목, 판매 금액, 판매일자)
SELECT B.BOOKNAME, B.PRICE, O.ORDERDATE 
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID
AND B.BOOKNAME = '야구를 부탁해' 
;
-- ANSI 표준 조인 쿼리
SELECT B.BOOKNAME, B.PRICE, O.ORDERDATE
FROM BOOK B INNER JOIN ORDERS O -- 조인 방식 지정
    ON B.BOOKID = O.BOOKID -- 조인 조건 지정
WHERE B.BOOKNAME= '야구를 부탁해' -- 검색조건
;

-- 2. '야구를 부탁해'라는 책이 몇 권이 팔렸는지 확인
SELECT COUNT(*) AS CNT
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID
AND B.BOOKNAME ='야구를 부탁해'
;
-- ANSI 표준 조인 쿼리
SELECT COUNT(*) AS CNT
FROM BOOK B INNER JOIN ORDERS O
    ON B.BOOKID = O.BOOKID
WHERE B.BOOKNAME='야구를 부탁해';

-------
-- 3. '추신수'가 구입한 책 값과 구입일자를 확인(책값, 구입일자)
SELECT O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND C.NAME = '추신수';

-- ANSI 표준 조인 쿼리
SELECT O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID
WHERE C.NAME = '추신수';


-- 4. '추신수'가 구입한 합계 금액 확인
SELECT '추신수' AS CUST_NAME, SUM(O.SALEPRICE) SUM_PRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND C.NAME = '추신수';

-- ANSI 표준 조인 쿼리
SELECT SUM(O.SALEPRICE)
FROM CUSTOMER C INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID
WHERE C.NAME = '추신수';


-- 5. '박지성, 추신수'가 구입한 내역을 확인 ( 이름, 판매금액, 판매일자)
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND C.NAME IN ('추신수', '박지성');
-- AND (C.NAME = '박지성' OR C.NAME ='추신수'); /2번째 방법

-- ANSI 표준 조인 쿼리
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID
WHERE C.NAME IN ('추신수','박지성');




