/* 상호연관 서브쿼리(상관서브쿼리)
- 메인쿼리의 값을 서브쿼리가 사용하고, 서브쿼리의 결과 값을 메인쿼리가 사용
- 메인쿼리와 서브쿼리가 서로 JOIN된 형태로 동작

*********************************/
SELECT O.ORDERID, O.CUSTID, O.BOOKID,
        (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME,
        (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME,
        O.SALEPRICE, O.ORDERDATE
FROM ORDERS O
;

-----------
-- 출판사별로 출판사별 평균 도서 가격보다 비싼 도서 목록을 구하시오
SELECT * FROM BOOK WHERE PUBLISHER = '굿스포츠';
SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = '굿스포츠';

SELECT * FROM BOOK
WHERE PUBLISHER = '굿스포츠'
AND PRICE > (SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = '굿스포츠')
;

SELECT * 
FROM BOOK B
WHERE B.PRICE > (SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = B.PUBLISHER)
;

-- JOIN문
--- 출판사 별 도서 평균가격
SELECT PUBLISHER, AVG(PRICE) AVG_PRICE
FROM BOOK
GROUP BY PUBLISHER
;
-------
SELECT *
FROM BOOK B,
        (SELECT PUBLISHER, AVG(PRICE) AVG_PRICE
            FROM BOOK
            GROUP BY PUBLISHER) AVG
WHERE B.PUBLISHER = AVG.PUBLISHER
AND B.PRICE > AVG.AVG_PRICE
;

-----------------------------
-- EXISTS : 존재 여부 확인시 사용 ( 있으면 TRUE) 
-- NOT EXISTS : 존재하지 않으면 TRUE
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
SELECT *
FROM BOOK
WHERE BOOKNAME IN (SELECT BOOKNAME FROM BOOK 
                    WHERE BOOKNAME LIKE '%축구%');
SELECT *
FROM BOOK B
WHERE EXISTS (SELECT 1 FROM BOOK 
                WHERE B.BOOKNAME LIKE '%축구%'); -- 데이터가 하나라도 있으면 조회가 됨.
-- NOT EXISTS : 존재하지 않으면 TRUE
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
SELECT *
FROM BOOK
WHERE BOOKNAME IN (SELECT BOOKNAME FROM BOOK 
                    WHERE BOOKNAME LIKE '%축구%');
SELECT *
FROM BOOK B
WHERE EXISTS (SELECT 1 FROM BOOK 
                WHERE B.BOOKNAME LIKE '%축구%'); -- 데이터가 하나라도 있으면 조회가 됨.
----------------------

-- 주문내역에 있는 고객의 이름과 전화번호 확인
SELECT *
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS)
;
-- ==> EXISTS 적용, 상관서브쿼리가 쓰여야 함., 데이터의 존재 여부 확인
SELECT *
FROM CUSTOMER C
WHERE EXISTS (SELECT CUSTID FROM ORDERS
                WHERE CUSTID = C.CUSTID)
;

-- NOT EXISTS
SELECT *
FROM CUSTOMER C
WHERE NOT EXISTS (SELECT CUSTID FROM ORDERS
                WHERE CUSTID = C.CUSTID)
;
 