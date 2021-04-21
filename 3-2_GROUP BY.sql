/* *************************
SELECT [* | DISTINCT] {컬럼명, 컬럼명, ...}
  FROM 테이블명
[WHERE 조건절]
[GROUP BY {컬럼명, ....}
    [HAVING 조건] ] --GROUP BY 절에 대한 조건
[ORDER BY {컬럼명 [ASC | DESC], ....}] --ASC : 오름차순(기본/생략가능)
                                      --DESC : 내림차순
***************************/

-- GROUP BY : 데이터를 그룹핑해서 처리할 경우 사용
/* GROUP BY 문을 사용하면 SELECT 항목은 GROUP BY 절에 사용된 컬럼 또는
그룹함수(COUNT, SUM, AVG, MAX, MIN)만 사용할 수 있다.    */

--============================================
-- 구매 고객별로 구매금액의 합계를 구하시오
SELECT CUSTID, SUM(SALEPRICE)
FROM ORDERS
GROUP BY CUSTID
;

---- 
SELECT C.NAME, SUM(SALEPRICE)
  FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID --조인조건
GROUP BY C.NAME
-- ORDER BY SUM(SALEPRICE) -- 구매금액 합계 순
ORDER BY 2 -- SELECT절의 컬럼의 순서 값으로 정렬 가능
;  

-- 주문(판매) 테이블의 고객별 데이터 조회(건수, 합계, 평균, 최대, 최소)
SELECT C.CUSTID, C.NAME, COUNT(*), SUM(SALEPRICE), 
        TRUNC(AVG(SALEPRICE)), 
        MAX(SALEPRICE), MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.CUSTID, C.NAME
;

-- 추신수, 박지성 고객의 데이터 조회(건수, 합계, 평균, 최대, 최소)
SELECT C.NAME, COUNT(*), SUM(SALEPRICE), 
        TRUNC(AVG(SALEPRICE)), 
        MAX(SALEPRICE), MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND C.NAME IN ('추신수', '박지성')
GROUP BY C.NAME
;


----(실습) 고객명 기준으로 고객별 데이터 조회 ( 건수, 합계,평균,최대,최소)
-------추신수, 장미란 고객2명만 조회
SELECT C.NAME, 
        COUNT(*) AS CNT,
        SUM(SALEPRICE) SUM_PRICE,
        TRUNC(AVG(SALEPRICE)) AVG_PRICE,
        MAX(SALEPRICE),
        MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND NAME IN ('추신수','장미란')
GROUP BY C.NAME
;

------표준 SQL방식
SELECT C.NAME, 
        COUNT(*) AS CNT,
        SUM(SALEPRICE) SUM_PRICE,
        TRUNC(AVG(SALEPRICE)) AVG_PRICE,
        MAX(SALEPRICE) MAX_PRICE,
        MIN(SALEPRICE) MIM_PRICE
FROM CUSTOMER C INNER JOIN ORDERS O
ON C.CUSTID = O.CUSTID
WHERE C.NAME IN('추신수','장미란')
GROUP BY C.NAME
;


-----------------------------------
--HAVING 절: GROUP BY 절에 의해 만들어진 데이터에서 검색 조건 부여
--HAVING 절은 단독으로 사용할 수 없고, GROUP BY 절과 함께 사용되어야 함

--------------------------------------

-- 3건 이상 구매한 고객 조회
SELECT C.NAME, COUNT(*) AS CNT
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING COUNT(*) >=3 -- 그룹핑된 데이터에서 원하는 데이터 검색(조건 부여)
;

-----------
-- 구매한 책 중에서 20000원 이상인 책을 구입한 사람의 통계 데이터
----- (건수, 합계, 평균, 최대, 최소)
SELECT C.NAME,
        COUNT(*),
        SUM(SALEPRICE), TRUNC(AVG(SALEPRICE)),
        MAX(SALEPRICE), MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID=O.CUSTID
GROUP BY C.NAME
HAVING MAX(SALEPRICE) >= 20000 -- 통계데이터 구한 후 2만원 이상인 책 구입이력 있는 사람
;
------------------------------
-- *주의 : WHERE 절에 사용되는 찾을 조건 ( 테이블 데이터 기준 )
--------- HAVING 절에서 사용되는 조건은 그룹핑 된 데이터 기준으로 검색
--------- ( 결과값이 다르게 처리되므로 찾을데이터가 무엇인지 명확히 하는 것이 중요)
------------------------------
SELECT C.NAME,
        COUNT(*),
        SUM(SALEPRICE), TRUNC(AVG(SALEPRICE)),
        MAX(SALEPRICE), MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID=O.CUSTID
AND O.SALEPRICE >=20000 -- 2만원 이상인 책만 대상으로
GROUP BY C.NAME
;

--=======================
-- (실습) 필요시 조인과 GROUP BY, HAVING 구분을 사용해서 처리
-- 1. 고객이 주문한 도서의 총 판매 건수, 판매액, 평균값, 최고가, 최저가 구하기
SELECT  COUNT(*) AS TOTAL_COUNT,
        SUM(SALEPRICE) AS "판매액 합계", -- 한글을 쓸 수는 있지만 되도록 X
        TRUNC(AVG(SALEPRICE)) 평균값AVG,
        MAX(SALEPRICE) "최고가(MAX)",
        MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
;

-- 2. 고객 별로 주문한 도서의 총 수량, 총 판매액 구하기
SELECT C.NAME, COUNT(*), SUM(SALEPRICE) AS SUM_PRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
-- ORDER BY C.NAME
-- ORDER BY SUM(O.SALEPRICE) DESC -- 적용된 그룹 함수로 정렬
-- ORDER BY 3 DESC -- 컬럼 위치값으로 정렬
ORDER BY SUM_PRICE DESC -- 컬럼 별칭(alias)으로 정렬
;


-- 3. 고객의 이름과 고객이 주문한 도서의 판매 가격을 검색
SELECT C.NAME, O.SALEPRICE,  B.BOOKNAME, B.PRICE
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.CUSTID = O.CUSTID
AND O.BOOKID = B.BOOKID
;



-- 4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명으로 정렬
SELECT C.NAME, SUM(SALEPRICE)
FROM CUSTOMER C,ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
ORDER BY C.NAME
;

-- 5. 고객별로 주문한 건수, 합계 금액, 평균 금액을 구하기 (3권보다 적게 구입한 사람)
SELECT C.NAME, COUNT(*), SUM(SALEPRICE), 
        TRUNC(AVG(SALEPRICE))
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING COUNT(*) < 3
;

-- (번외) 고객 중 한 권도 구입 안 한 사람은 누구?
--SELECT C.NAME
--FROM CUSTOMER C, ORDERS O
--WHERE O.CUSTID NOT IN C.CUSTID
--;







