 -- INSERT, UPDATE, DELETE
 /****************************
 ■ INSERT 문
 INSERT INTO 테이블명
    (컬럼명1, 컬럼명2 ......, 컬럼명n)
 VALUES (값1, 값2,....., 값n) ;
 
 ■ UPDATE문
 UPDATE 테이블명
    SET 컬럼명1 = 값1, 컬럼명2 = 값2, ....., 컬럼명 n = 값 n
[WHERE 대상조건]    
 
 ■ DELETE문
 DELETE FROM 테이블명
 [WHERE 대상조건]
 ****************************/
 
 SELECT * FROM BOOK ORDER BY BOOKID DESC;
 INSERT INTO BOOK
    (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES(30, '자바란 무엇인가?', 'ITBOOK', 30000);
COMMIT;

 INSERT INTO BOOK
    (BOOKID, PUBLISHER, BOOKNAME, PRICE)
VALUES(31,  'ITBOOK', '자바란 무엇인가2?', 30000);
ROLLBACK;
COMMIT;

-----------------------------------------
/* INSERT : 컬럼명을 나열하지 않고 입력
---- 테이블 생성 시 작성된 컬럼의 값을 모두 입력( 누락 시 오류 )
---- 테이블 생성 시 작성된 컬럼의 순서에 따라 데이터를 입력하지 않는 경우
    > (입력 성공) 논리적 오류가 발생 - 잘못된 위치에 데이터 입력
    > (입력 실패) 데이터타입 불일치, 데이터 크기 불일치 오류 발생
****************************************/

INSERT INTO BOOK
VALUES (32,  '자바란 무엇인가3?', 'ITBOOK', 30000 );
COMMIT;

INSERT INTO BOOK
VALUES (33,  '자바란 무엇인가4?', '', 30000 ); -- 출판사 : NULL > NULL값이라도 입력해야함.
-----
INSERT INTO BOOK
VALUES (34,  '자바란 무엇인가5?', 'ITBOOK' ); -- (오류)컬럼이 4개가 다 와야 함.

--------------------------------
-- 일괄입력 : 테이블 데이터를 이용해서 여러 데이터를 한번에 입력 처리
---- IMPORTED_BOOK --> BOOK : 일괄입력
INSERT INTO BOOK
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
FROM IMPORTED_BOOK
;

--===================================
/* ■ UPDATE문
 UPDATE 테이블명
    SET 컬럼명1 = 값1, 컬럼명2 = 값2, ....., 컬럼명 n = 값 n
[WHERE 대상조건] */
------------------------
SELECT * FROM CUSTOMER;
-- 박세리 주소 수정 : 대한민국 대전 -> 대한민국 부산
UPDATE CUSTOMER 
SET ADDRESS = '대한민국 부산'
WHERE NAME = '박세리'
;
COMMIT;
SELECT * FROM CUSTOMER WHERE NAME = '박세리';

-- 박세리의 주소, 전화번호 수정 : '대한민국 대전', '010-1111-1111'
UPDATE CUSTOMER 
SET ADDRESS = '대한민국 대전', PHONE = '010-1111-1111'
WHERE NAME = '박세리'
;
COMMIT;
SELECT * FROM CUSTOMER WHERE NAME = '박세리';

---------------------------
-- 박세리 주소 수정 : 김연아의 주소와 동일하게 수정
SELECT * FROM CUSTOMER WHERE NAME = '김연아';
---- UPDATE문에 서브쿼리 형식으로 수정할 데이터 찾아 적용
---- 서브쿼리의 결과 데이터가 1개 이하여야 한다 (2개 이상인 경우 오류)
UPDATE CUSTOMER 
SET ADDRESS = '대한민국 서울'
WHERE NAME ='박세리'
;
UPDATE CUSTOMER
SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER WHERE NAME = '김연아')
WHERE NAME = '박세리'
;
SELECT * FROM CUSTOMER WHERE NAME = '박세리';

---------------------------------
-- 박세리 주소, 전화번호 수정 : 추신수와 동일하게 적용
UPDATE CUSTOMER 
SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER WHERE NAME = '추신수'),
    PHONE = (SELECT PHONE FROM CUSTOMER WHERE NAME = '추신수')
WHERE NAME = '박세리'
;
COMMIT;


-----------------------------
/* ■ DELETE문
 DELETE FROM 테이블명
 [WHERE 대상조건]
 ************************/
 
SELECT * FROM TEST_LIKE;
-- DELETE FROM TEST_LIKE WHERE NAME = '홍길동';
-- DELETE FROM TEST_LIKE WHERE NAME LIKE '홍길동2';
-- DELETE FROM TEST_LIKE WHERE NAME LIKE '홍길동%';
----------------------------
SELECT * FROM BOOK ORDER BY BOOKID DESC;

-- (실습)책 제목이 '자바'로 시작하고 출판사가 ITBOOK인 데이터 삭제 
SELECT * -- 삭제할 데이터 확인
FROM BOOK 
WHERE BOOKNAME LIKE '자바%'
AND PUBLISHER = 'ITBOOK'
;
DELETE FROM BOOK 
WHERE BOOKNAME LIKE '자바%'
AND PUBLISHER = 'ITBOOK'
;
COMMIT;

--===============================================

