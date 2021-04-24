/* ************************
뷰(VIEW) : 하나 또는 둘 이상의 테이블로 부터
   데이터의 부분집합을 테이블인 것처럼 사용하는 객체(가상테이블)
--뷰(VIEW) 생성문
CREATE [OR REPLACE] VIEW 뷰이름 [(컬럼별칭1, 컬럼별칭2, ..., 컬럼별칭n)]
AS
SELECT 문장
[옵션];

--읽기전용 옵션 : WITH READ ONLY

--뷰(VIEW) 삭제
DROP VIEW 뷰이름;
***************************/
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';

-- 뷰(VIEW) 만들기
CREATE VIEW VW_BOOK
AS 
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%'
WITH READ ONLY; -- 읽기 전용 뷰 생성

-- 뷰 사용해서 데이터 검색
SELECT * FROM VW_BOOK
WHERE PUBLISHER = '굿스포츠';

SELECT * 
FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%') -- 인라인 뷰
WHERE PUBLISHER = '굿스포츠'; -- 위의 문장과 결과가 동일.

-------------------------
-- 뷰(VIEW) 생성 -> 컬럼 별칭(alias) 사용
CREATE VIEW VW_BOOK2 
    (BID, BNAME, PUB, PRICE) -- 컬럼 별칭
AS
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
FROM BOOK
WHERE BOOKNAME LIKE '%축구%';

--===========================
CREATE OR REPLACE VIEW VW_ORDERS
AS
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
        B.BOOKNAME, B.PUBLISHER, B.PRICE,
        C.NAME, C.PHONE, C.ADDRESS,
        O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
AND O.CUSTID = C.CUSTID
WITH READ ONLY
;

-- 뷰를 사용하여 데이터 조회 : 박지성, 김연아가 구입한 책 제목, 구입 금액, 구입 일자
SELECT NAME, BOOKNAME, SALEPRICE, ORDERDATE
FROM VW_ORDERS
WHERE NAME IN ('박지성', '김연아')
;

-- 뷰(VIEW)를 사용하지 않는다면? -- 조인문 사용
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
AND O.CUSTID = C.CUSTID
AND NAME IN ('박지성', '김연아')
;

-- 뷰의 동작 원리 : SQL 실행시 뷰에 등록된 SELECT문장이 실행됨
---> 물리적으로 저장되는 것은 테이블에만!
SELECT NAME, BOOKNAME, SALEPRICE, ORDERDATE
FROM (SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
        B.BOOKNAME, B.PUBLISHER, B.PRICE,
        C.NAME, C.PHONE, C.ADDRESS,
        O.SALEPRICE, O.ORDERDATE
        FROM ORDERS O, BOOK B, CUSTOMER C
        WHERE O.BOOKID = B.BOOKID
        AND O.CUSTID = C.CUSTID)
WHERE NAME IN ('박지성', '김연아')
;

--============================
--(실습) 뷰를 생성, 조회, 삭제
--1. 뷰생성 - 뷰명칭 : VW_ORD_ALL
---- 주문(판매)정보, 책정보, 고객정보 모두 조회할 수 있는 형태 뷰 
CREATE OR REPLACE VIEW VW_ORD_ALL
AS
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
        B.BOOKNAME, B.PUBLISHER, B.PRICE,
        C.NAME, C.PHONE, C.ADDRESS,
        O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
AND O.CUSTID = C.CUSTID
WITH READ ONLY
;

--2. 이상미디어에서 출판한 책중 판매된 책제목, 판매금액, 판매일 조회
SELECT BOOKNAME, SALEPRICE, ORDERDATE, PUBLISHER
FROM VW_ORD_ALL
WHERE PUBLISHER = '이상미디어'
;

--3. 이상미디어에서 출판한 책 중에서 추신수, 장미란이 구매한 책 정보 조회
---- 출력항목 : 구입한 사람이름, 책제목, 출판사, 원가(정가), 판매가, 판매일자
---- 정렬 : 구입한 사람이름, 구입일자 최근순
SELECT NAME, BOOKNAME,PUBLISHER, PRICE, SALEPRICE, ORDERDATE 
FROM VW_ORD_ALL
WHERE PUBLISHER = '이상미디어'
AND NAME IN ('추신수', '장미란')
ORDER BY NAME, ORDERDATE
;

--4. 판매된 책에 대하여 구매자별 건수, 합계금액, 평균금액, 최고가, 최저가 조회
--(최종) 뷰삭제 : VW_ORD_ALL 삭제 처리
SELECT NAME ,COUNT(*) "건수", MAX(SALEPRICE) "합계금액", TRUNC(AVG(SALEPRICE))"평균금액",
        MAX(SALEPRICE) "최고가", MIN(SALEPRICE) "최저가"
FROM VW_ORD_ALL
WHERE CUSTID IS NOT NULL
GROUP BY NAME
ORDER BY NAME
;



--================================

-- FORCE : SELECT문에 테이블이 없어도 뷰를 강제로 생성
CREATE OR REPLACE FORCE VIEW VW_AAA
AS
SELECT ID, NAME, PHONE, FROM AAA;

