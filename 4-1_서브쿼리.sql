-- 서브쿼리 ( 부속질의, SUB QUERY )
-- SQL문 ( SELECT, INSERT, UPDATE, DELETE) 내에 있는 쿼리문
--------------------------------

-- 박지성이 구입한 내역을 검색
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER WHERE NAME = '박지성'; -- CUSTID : 1
SELECT * FROM ORDERS 
WHERE CUSTID = 1;
----------------------
-- 서브쿼리 사용
SELECT * FROM ORDERS 
WHERE CUSTID = (SELECT * FROM CUSTOMER WHERE NAME = '박지성');
-- > 서브쿼리가 먼저 동작이 되고 그 다음 메인에 있는 쿼리가 이를 가져다 사용함

-- 조인문으로 처리
SELECT *
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID
AND C.NAME = '박지성'
;

---------------------
-- WHERE 절에서 서브쿼리 사용 시 조회결과가 2건 이상인 경우 IN 사용
-- ( EQUAL부호(=)는 데이터 1개일때만 )
-- 박지성, 김연아 구입내역( 서브쿼리 )
SELECT * FROM ORDERS
--WHERE CUSTID = (SELECT CUSTID
--                FROM CUSTOMER WHERE NAME IN ('박지성', '김연아')) -- 오류발생(데이터 2개이상)
WHERE CUSTID IN (SELECT CUSTID
                FROM CUSTOMER WHERE NAME IN ('박지성', '김연아')) -- 오류발생(데이터 2개이상)
;

----------------
-- 책 중 정가가 가장 비싼 도서의 이름을 구하시오
SELECT MAX(PRICE) FROM BOOK; -- 가장 비싼 책
SELECT * FROM BOOK WHERE PRICE = 35000;
---- 위의 내용을 서브쿼리로 만들어서 합침
SELECT * FROM BOOK
WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);

----------------------
-- 서브쿼리를 FROM절에 사용하는 경우
SELECT *
FROM BOOK B, 
    (SELECT MAX(PRICE) MAX_PRICE FROM BOOK)M
WHERE B.PRICE = M.MAX_PRICE
;

-----------------------------
-- 박지성, 김연아 구입 내역 ( 서브쿼리 )
SELECT *
FROM ORDERS O, 
    (SELECT * FROM CUSTOMER WHERE NAME IN ('박지성', '김연아')) C 
    -- 두 명의 고객정보면 가져옴(CUSTOMER의 모든 정보를 가져오는 것이 아님
WHERE O.CUSTID = C.CUSTID
;

-- SELECT 절에 서브쿼리 사용 예
-- 추가로 이름, 책제목이 들어갔으면 좋겠어요 ㅠ
-- => 상관 서브쿼리 
SELECT * FROM ORDERS;
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
        (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME, -- 외부에 있는 테이블 데이터가 사용 됨
        (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME,
        O.SALEPRICE, O.ORDERDATE
FROM ORDERS O
;

--------------------
-- 박지성이 구매한 책 목록 ( 책 제목 )
-- 책을 찾기는 찾는데 구매한 내역이 있어야 함
-- 상관서브쿼리가 아니라 독립서브쿼리 형태
-- 서브쿼리를 읽고 해석할 때 맨 안쪽 SQL부터 적용돼서 중간-> 바깥쪽으로 진행함
SELECT * 
FROM BOOK
WHERE BOOKID IN (SELECT BOOKID 
                    FROM ORDERS 
                    WHERE CUSTID IN (SELECT CUSTID 
                                    FROM CUSTOMER
                                    WHERE NAME = '박지성'))
                                    -- 각 쿼리들은 독립적으로 실행 가능함
;

---------------------------
-- ( 실습 ) 서브쿼리 이용 ( 서브쿼리, 조인문 )
-- 1. 한 번이라도 구매한 내역이 있는 사람
SELECT *
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS)
;
----- ( 또는 한번도 구매하지 않은 사람 )
SELECT *
FROM CUSTOMER
WHERE CUSTID NOT IN (SELECT DISTINCT CUSTID FROM ORDERS)
;

-- JOIN문 사용 : 한 번도 구매하지 않은 사람
SELECT C.* -- C테이블의 VALUE값만 조회
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID(+)
AND O.ORDERID IS NULL
;


-- 2. 2만원 이상 되는 책을 구입한 고객 명단 조회
-- (방법_1)_JOIN문 사용
SELECT *
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND O.SALEPRICE >= 20000
;

-- (방법_2)
SELECT *
FROM CUSTOMER 
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS WHERE SALEPRICE>=20000)
;


-- 3. '대한미디어' 출판사의 책을 구매한 고객 이름 조회
-- (방법_1)
SELECT *
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND B.BOOKID = O.BOOKID
AND B.PUBLISHER = '대한미디어'
;

-- (방법_2)
SELECT *
FROM CUSTOMER 
WHERE CUSTID IN (SELECT CUSTID
                FROM ORDERS
                WHERE BOOKID IN (SELECT BOOKID
                                FROM BOOK
                                WHERE PUBLISHER = '대한미디어'))
;

-- (방법_3)_JOIN문 사용
SELECT C.*, B.BOOKNAME, B.PUBLISHER, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND B.BOOKID = O.BOOKID
AND B.PUBLISHER = '대한미디어'
;


-- 4. 전체 책 가격 평균보다 비싼 책의 목록 조회
-- (방법_1)
SELECT *
FROM BOOK 
WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK ) -- 평균 14450원
ORDER BY PRICE
;

-- ( 방법_2)_JOIN문 사용
SELECT * 
FROM BOOK B, 
        (SELECT AVG(PRICE) AVG_PRICE FROM BOOK) AVG
WHERE PRICE > AVG_PRICE
;


-----------------------------











