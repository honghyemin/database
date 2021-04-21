-- (번외) 고객 중 한 권도 구입 안 한 사람은 누구?
-- CUSTOMER 테이블에는 있고, ORDERS 테이블에는 없는 사람
-- (방법1) MINUS : 차집합 처리.
SELECT CUSTID
FROM CUSTOMER --1,2,3,4,5
MINUS
SELECT DISTINCT CUSTID
FROM ORDERS; -- 1,2,3,4

-- (방법2) 서브쿼리 방식
SELECT * -- 매출이 있는 사람 모두 조회
FROM CUSTOMER
WHERE CUSTID IN(
SELECT DISTINCT CUSTID
FROM ORDERS
);

-----
SELECT * -- 매출이 없는 사람 모두 조회
FROM CUSTOMER
WHERE CUSTID NOT IN (
SELECT DISTINCT CUSTID
FROM ORDERS
 );

---------------------
-- (방법3) 외부조인 (OUTER JOIN)
-- 동등조인(JOIN)
SELECT DISTINCT
   C.CUSTID,
    C.NAME -- 구매이력이 있는 사람만 선택
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID -- 조인조건(동등조인-EQUIT JOIN)
;

-- 외부조인(좌측기준)
-- SELECT DISTINCT C.CUSTID, C.NAME -- 구매이력이 있는 사람만 선택
SELECT *
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID(+) -- 조인조건(좌측기준 외부조인)
AND O.ORDERID IS NULL
-- AND O.ORDERIS IS NOT NULL -- 구매이력이 있는 사람 조회
;

-- ANSI 표준 SQL(LEFT OUTER JOIN) -- OUTER JOIN인데 좌측 기준
SELECT *
FROM CUSTOMER C
LEFT OUTER JOIN ORDERS O -- 좌측에 있는 데이터를 기준으로 우측의 데이터를 매칭시켜 표시
ON C.CUSTID = O.CUSTID
WHERE O.ORDERID IS NULL;
-- ANSI 표준 SQL(RIGHT OUTER JOIN) -- OUTER JOIN인데 우측 기준

SELECT *
FROM ORDERS O
RIGHT OUTER JOIN CUSTOMER C 
ON C.CUSTID = O.CUSTID
WHERE O.ORDERID IS NULL;


-- 외부조인(우측기준)
SELECT C.*
FROM CUSTOMER C, ORDERS O
WHERE O.CUSTID(+) = C.CUSTID -- 조인조건(우측기준 외부조인), 부호가 없는 쪽 기준
            -- 우측에 있는 데이블은 다 표시, 왼쪽 테이블은 없는 부분만 채워넣기 위해 + 표시
AND O.ORDERID IS NULL;

--------------------
--동등 조인(JOIN, INNER JOIN) : 조인된 테이블 모두에 존재하는 데이터 검색
--외부 조인(OUTER JOIN) : 어느 한 쪽 테이블에 있는 데이터가 다른 테이블의 존재하지 않는 데이터 검색
---- 기준테이블 모든 데이터 표시하고, 일치하지 않는 
CREATE TABLE DEPT (
    ID    VARCHAR2(10) PRIMARY KEY,
    NAME  VARCHAR2(30)
);

INSERT INTO DEPT VALUES (
    '10',
    '총무부'
);

INSERT INTO DEPT VALUES (
    '20',
    '급여부'
);

INSERT INTO DEPT VALUES (
    '30',
    'IT부'
);

COMMIT;

----------

CREATE TABLE DEPT_1 (
    ID    VARCHAR2(10) PRIMARY KEY,
    NAME  VARCHAR2(30)
);

INSERT INTO DEPT_1 VALUES (
    '10',
    '총무부'
);

INSERT INTO DEPT_1 VALUES (
    '20',
    '급여부'
);

COMMIT;

CREATE TABLE DEPT_2 (
    ID    VARCHAR2(10) PRIMARY KEY,
    NAME  VARCHAR2(30)
);

INSERT INTO DEPT_2 VALUES (
    '10',
    '총무부'
);

INSERT INTO DEPT_2 VALUES (
    '30',
    'IT부'
);

COMMIT;

----------------
SELECT * FROM DEPT;

SELECT * FROM DEPT_1;

SELECT * FROM DEPT_2;

---------- 
-- DEPT = DEPT_1
SELECT *
FROM DEPT D, DEPT_1 D1
WHERE D.ID = D1.ID;

SELECT *
FROM DEPT D, DEPT_2 D2
WHERE D.ID = D2.ID;

--------
--- DEPT에는 있고, DEPT_1에는 없는 데이터(부서) 조회
-- LEFT OUTER JOIN : 좌측 테이블 기준
------ DEPT데이터 전체 표시하고, 우측(DEPT_1)에 없으면 NULL표시
SELECT *
FROM DEPT D, DEPT_1 D1
WHERE D.ID = D1.ID(+) -- 조인조건(좌측기준 외부조인)
AND D1.ID IS NULL
;

-- 표준 SQL
SELECT * 
FROM DEPT D LEFT OUTER JOIN DEPT_1 D1
ON D.ID = D1.ID
WHERE D1.ID IS NULL
;
-------------------
-- RIGHT OUTER JOIN : 우측 테이블 기준
SELECT * 
FROM DEPT_1 D1, DEPT D
WHERE D1.ID(+) = D.ID
AND D1.ID IS NULL
;

--- 표준SQL
SELECT *
FROM DEPT_1 D1
RIGHT OUTER JOIN DEPT D -- 조인방식 : 우측 테이블 기준 외부조인
ON D1.ID = D.ID
WHERE D1.ID IS NULL
;

--------------------
-- FULL OUTER JOIN
SELECT * 
FROM DEPT_1 D1 FULL OUTER JOIN DEPT_2 D2
ON D1.ID = D2.ID
;

-------------------
--(실습) DEPT_1, DEPT_2 테이블을 이용해서
--1. DEPT_1에는 있고, DEPT_2 테이블에는 없는 데이터 찾기(LEFT OUTER JOIN)
SELECT *
FROM DEPT_1 D1, DEPT_2 D2
WHERE D1.ID = D2.ID(+)
AND D2.ID IS NULL
;

--2. DEPT_1에는 있고, DEPT_2 테이블에는 없는 데이터 찾기(RIGHT OUTER JOIN)
SELECT *
FROM DEPT_1 D1, DEPT_2 D2
WHERE D1.ID(+) = D2.ID
AND D1.ID IS NULL
;

