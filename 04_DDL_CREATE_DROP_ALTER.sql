/* (실습) 테이블(TABLE) 만들기 ( 테이블 명: TEST2)
    NO : 숫자 타입 5자리, PRIMARY KEY 선언
    ID : 문자타입 10자리 (10BYTE), 값이 반드시 존재해야 함.(NULL값 허용X)
    NAME : 한글 10자리 저장 가능하게 설정, 값이 반드시 존재
    EMAIL : 영문, 숫자, 특수문자 포함 30자리
    ADDRESS : 한글 100자
    IDNUM : 숫자타입 정수부7자리, 소수부 3자리(1234567.123)
    REGDATE : 날짜타입  

*****************************************/
CREATE TABLE TEST2(
    NO NUMBER(5) PRIMARY KEY,
    ID VARCHAR2(10) NOT NULL,
    NAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(30),
    ADRESS VARCHAR(300),
    IDNUM NUMBER(7,3),
    REGDATE DATE
);
ALTER TABLE TEST2 MODIFY(IDNUM NUMBER(10,3));



SELECT * FROM TEST2;
INSERT INTO TEST2 VALUES (1, '1111', '홍길동', 'HHH@NAVER.COM', '서울시 양천구', 1234567.123, SYSDATE);
INSERT INTO TEST2 (NO, ID, NAME ) VALUES (22, 'TEST1', '홍길동2');
COMMIT;
INSERT INTO TEST2 (NO, NAME, ID) VALUES (3, '홍길동3', 'TEST2');
--========================================
-- 특정 테이블의 데이터와 함께 테이블 구조를 함께 복사
CREATE TABLE TEST3
AS 
SELECT * FROM TEST2;
--------------------------
-- 특정 테이블의 특정 컬럼과 특정 데이터만 복사하면서 테이블 생성
CREATE TABLE TEST4
AS 
SELECT NO, ID, NAME, EMAIL FROM TEST2 WHERE NO = 1;
------------------
-- 특정 테이블의 구조만 복사 ( 데이터 복사 X )
CREATE TABLE TEST5
AS 
SELECT * FROM TEST2 WHERE NO = 11; -- 데이터 조회가 되지 않으므로 구조만 복사할 수 있음. (11은 없는 번호) / SELECT * FROM TEST2 WHERE 1 = 1;처럼 쓸 수도 있음. (WHERE조건이 거짓)
--=====================
SELECT * FROM TEST2;
DELETE FROM TEST2 WHERE ID = 'TEST3';
DELETE FROM TEST2; -- 해당 테이블의 전체 데이터 삭제 , 커밋전에는 복구 가능
ROLLBACK; -- 취소 처리 가능
-- TRUNCATE : 테이블 전체 데이터 삭제(ROLLBACK으로 복구 안됨.)
TRUNCATE TABLE TEST2;
SELECT * FROM TEST2;
--=======================
/* 테이블을 삭제 : DROP TABLE
    - 데이터와 함께 테이블 구조 모두 삭제 처리
    DROP TABLE 유저명(스키마).테이블명;
    drop table 유저명(스키마).테이블명 cascade constraints PURGE;
    - cascade constraints : 참조데이터가 있어도 삭제
    - PURGE : 휴지통에 백업없이 완전히 삭제
************************/
DROP TABLE TEST4;

--==============================
/* 테이블 수정 : 컬럼 추가, 수정 , 삭제
DDL : ALTER TABLE 
- ADD : 추가
- MODYFY : 수정 - 데이터 상태에 따라 적용 가능여부가 결정
    - 컬럼사이즈 작은-> 큰 : 언제나 가능 
    - 컬럼사이즈 큰 -> 작은 : 저장된 데이터 상태에 따라 
    - 문자-> 숫자 : 불가능
- DROP COLUMN : 삭제

********************************/
SELECT * FROM TEST3;
-- 컬럼 추가 TEST3 테이블에 ADDCOL 컬럼 추가
ALTER TABLE TEST3 ADD ADDCOL VARCHAR2(10);

-- 컬럼 수정 TEST3 테이블의 ADDCOL 크기 -> VARCHAR2(20)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(20);
UPDATE TEST3 SET ADDCOL = '123456789012345';
SELECT * FROM TEST3;

-- 컬럼 수정 TEST3 테이블의 ADDCOL 크기 -> VARCHAR2(10), VARCHAR2(15)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(10); -- 오류 발생, 저장된 데이터의 크기가 바꾸려는 데이터크기보다 큼.
                                            --> ORA-01441: cannot decrease column length because some value is too big
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(15); -- 오류 없음, 수정 완료

-- 컬럼 삭제 : DROP COLUMN
ALTER TABLE TEST3 DROP COLUMN ADDCOL;

ALTER TABLE "MYSTUDY"."AAAAA" RENAME TO TEST3; -- 바꿔놓았던 테이블이름(AAAAA)을 다시 TEST3으로 바꿈
ALTER TABLE TEST3 RENAME COLUMN ADDCOL TO ADDCOL2; -- 컬럼명 바꾸기
ALTER TABLE TEST3 MODIFY (ADDCOL2 NOT NULL); -- ()는 있어도 되고 없어도 된다.
                                            --> NOT NULL 제약조건 선언을 하려고 했으나 데이터가 없으므로 오류가 뜸.
                                            
-- ADDCOL2에 데이터를 입력하고 다시 시도
ALTER TABLE TEST3 MODIFY (ADDCOL2 NOT NULL);



