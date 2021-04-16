/* STUDENT 테이블 생성
제약조건 없이 컬럼만 추가
*/
CREATE TABLE STUDENT(
    ID VARCHAR2(20),
    NAME VARCHAR2(30),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MATH NUMBER(3),
    TOT NUMBER(3),
    AVG NUMBER(5,2)
);
-------------------------------------------
-- CRUD : INSERT(입력), SELECT, UPDATE(수정), DELETE(삭제)
SELECT * FROM STUDENT; --전체 데이터 검색
SELECT ID, NAME FROM STUDENT; -- ID와 NAME만 검색

-- 데이터 추가(입력) : INSERT INTO
INSERT INTO STUDENT 
        (ID, NAME, KOR, ENG, MATH)
VALUES ('1111', '홍길동', 100, 90, 80); -- 순서가 정확히 1:1로 매칭되어야 함 
COMMIT; -- 최종적인 작업 결과를 DB에 반영. 사용하지 않으면 후에 ROCK이 걸리는 등의 상황이 발생할 수 있음.
ROLLBACK; -- 작업취소(INSERT, UPDATE, DELETE 작업)

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2222', '김유신', 90, 80, 70); -- 제약조건을 걸지 않으면 다시 실행시켰을 때 똑같은 내용이 테이블에 추가됨.
COMMIT; 
------------------------------------------
-- 수정 : 데이터를 수정 -UPDATE (SET)
UPDATE  STUDENT
SET ENG = 88, MATH = 77 -- 바꿀 데이터를 선택하지 않으면 전체 데이터가 바뀜.
WHERE NAME = '김유신';
COMMIT;
SELECT * FROM STUDENT WHERE NAME = '김유신'; -- 원하는 데이터만 검색
SELECT * FROM STUDENT WHERE NAME = '홍길동';
------------------------------------------
-- 삭제 : 데이터를 삭제 -DELETE FROM
SELECT * FROM STUDENT WHERE ID = '2222';
DELETE FROM STUDENT WHERE ID = '2222'; -- DELETE FROM STUDENT 만 사용할 경우 전체 데이터가 다 삭제됨
DELETE FROM STUDENT WHERE NAME = '김유신';
SELECT * FROM STUDENT WHERE NAME = '김유신';
COMMIT;
-- ===============================================
INSERT INTO STUDENT (ID)VALUES('3333'); -- ID컬럼 하나만 삽입. -> ID를 제외한 모든 항목은 다 NULL 값