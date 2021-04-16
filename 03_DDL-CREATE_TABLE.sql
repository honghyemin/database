/* *************************
데이타 정의어
- DDL(Data Definition Language) : 데이타를 정의하는 언어
- CREATE(생성), DROP(삭제), ALTER(수정)
- {}반복가능, []생략가능, | 또는(선택)
CREATE TABLE 테이블명 (
{컬럼명 데이타타입
    [NOT NULL | UNIQUE | DEFAULT 기본값 | CHECK 체크조건]
}
    [PRIMARY KEY 컬럼명]
    {[FOREIGN KEY 컬럼명 REFERENCES 테이블명(컬럼명)]
    [ON DELETE [CASCADE | SET NULL]
    }
);
--------
컬럼의 기본 데이타 타입 - 크기까지 포함
VARCHAR2(n) : 문자열 가변길이
CHAR(n) : 문자열 고정길이
NUMBER(p, s) : 숫자타입 p:전체길이, s:소수점이하 자리수
  예) (5,2) : 정수부 3자리, 소수부 2자리 - 전체 5자리
DATE : 날짜형 년,월,일 시간 값 저장

문자열 처리 : UTF-8 형태로 저장
- 숫자, 알파벳 문자, 특수문자 : 1 byte 처리(키보드 자판 글자들)
- 한글 : 3 byte 처리
***************************/
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, -- NOT NULL, UNIQUE 속성이 기본적으로 함께 적용됨.
    NAME VARCHAR2(30) NOT NULL, -- 영문이름일경우 30글자까지, 한글이름일경우 10글자만
    PASSWORD VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(300)
);

---------------------------------
INSERT INTO MEMBER (ID, NAME, PASSWORD)     -- ID 또는 ID,NAME 만 넣었을 경우 오류 발생!
VALUES ('HONG', '홍길동', '1234');            -- 동일한 데이터(ID)를 한 번 더 넣었을 경우 오류 발생(UNIQUE 조건에 의해)

INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG2', '홍길동', '1234');

-- unique 설정 컬럼 중복 데이타 입력시 오류 발생
-- ORA-00001: unique constraint (MYSTUDY.SYS_C006999) violated
INSERT INTO MEMBER (ID, NAME, PASSWORD) -- NOTNULL인것만 넣어줌
VALUES ('HONG2', '홍길동', '1234');
---------------------------------------------
SELECT * FROM MEMBER;

-- 입력 : 컬럼명을 명시적으로 작성하지 않은 경우 모든 컬럼 값 입력
-- 테이블에 있는 컬럼의 순서에 맞게 데이터 입력.
INSERT INTO MEMBER      -- NOT NULL인 것을 포함하여 모든 컬럼(항목)을 넣어주어야 함
VALUES ('HONG5', '홍길동5', '1234', '010-1111-1111', '서울시');

--실수 : 전화번호 위치에 잘못해서 주소값 입력한 경우
INSERT INTO MEMBER 
VALUES ('HONG6', '홍길동6', '1234', '서울시', '010-1111-1111'); -- 문법적 오류는 아니지만 논리적 오류가 발생.
----------------------------------------------------------
INSERT INTO MEMBER (ID, NAME, PASSWORD, PHONE, ADDRESS )
VALUES ('HONG7', '홍길동7', '7777', '010-7777-7777', '부산시');
COMMIT;

SELECT * FROM MEMBER;
-------------------------------------------
-- 수정 : HONG6 전화번호 -> '010-6666-6666' 으로 변경
-- 수정 : HONG6 주소 -> '서울시'로 변경 
UPDATE MEMBER 
    SET PHONE = '010-6666-6666', ADDRESS = '서울시' WHERE ID = 'HONG6';
COMMIT;

SELECT * FROM MEMBER WHERE ID = 'HONG6';
--------------------------------------------
-- 삭제 : HONG7 데이터 삭제
-- 삭제 : 이름이 홍길동인 사람 삭제
DELETE FROM MEMBER WHERE ID = 'HONG7';
SELECT * FROM MEMBER;
SELECT COUNT(*) FROM MEMBER WHERE NAME = '홍길동'; -- '홍길동'이라는 이름을 가진 데이터의 수를 셈.
DELETE FROM MEMBER WHERE NAME = '홍길동';
SELECT * FROM MEMBER;
COMMIT;
------------------------------------
/* (실습) CRUD - 입력, 조회, 수정, 삭제
입력 : 아이디 -hong8, 이름 - 홍길동8, 암호 -1111, 주소 - 서울시 서초구
조회(검색) : 이름이 '홍길동8'인 사람의 아이디, 이름 주소 데이터만 조회
수정 : 아이디 : hong8 사람의 
    전화번호 : 010-8888-8888
    암호 : 8888
    주소 : 서울시 강남구
삭제 : 아이디 hong8인 사람
*/
-----------------------------------
SELECT * FROM MEMBER;

INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS)
VALUES('hong8', '홍길동8', '1111', '서울시서초구');
SELECT ID,NAME,ADDRESS FROM MEMBER WHERE NAME = '홍길동8';

UPDATE MEMBER 
SET PHONE ='010-8888-8888', PASSWORD = '8888', ADDRESS ='서울시 강남구'
WHERE ID = 'hong8';

SELECT * FROM MEMBER WHERE ID = 'hong8';

DELETE FROM MEMBER WHERE ID = 'hong8';

SELECT * FROM MEMBER;
COMMIT;

--=======================================
-- 컬럼 특성을 확인하기 위한 테이블
CREATE TABLE TEST(
    NUM NUMBER(5,2), -- 전체 자릿수가 5자리이며 정수부 3자리 소수부 2자리임.
    STR1 CHAR(10), -- 고정길이
    STR2 VARCHAR2(10), -- 가변길이
    DATE1 DATE -- 날짜데이터 : 연,월,일,시,분,초(연,월,일만 보여주도록 설정되어 있음)    
);

INSERT INTO TEST VALUES (100.454, 'ABC', 'ABC', SYSDATE); -- SYSDATE: 현재시점의 연월일시분초를 날짜타입으로 입력해주는 ..함수?
INSERT INTO TEST VALUES (100.455, 'ABC', 'ABC', SYSDATE); -- 100.455일 경우 소숫점 자리는 두자리만 와야하므로 뒤의 5는 반올림 되어 100.46이 됨.
SELECT * FROM TEST;
SELECT '-' || STR1 || '-', '-' ||STR2|| '-' FROM TEST;   -- 데이터가 어디까지 저장되어 있는지 확인
INSERT INTO TEST VALUES (100.456, 'DEF', 'DEF ', SYSDATE);
COMMIT;
SELECT LENGTHB (STR1), LENGTHB(STR2) FROM TEST; -- BYTE단위로 길이를 보고 싶을때
--------------------------------------------

-- 데이터를 조회할 때 CHAR 타입 vs  VARCHAR2 타입
SELECT * FROM TEST WHERE STR1 = STR2; -- 조회된 데이터 없음.
SELECT * FROM TEST WHERE STR1 = 'ABC'; -- 오라클에서는 조회됨(다른 데이터베이스에서는 조회가 안 될 수도 있음.)
SELECT * FROM TEST WHERE STR1 = 'ABC     '; --오라클에서는 조회됨(다른 데이터베이스에서는 조회가 안 될 수도 있음.)
SELECT * FROM TEST WHERE STR1 = 'ABC       '; -- 스페이스바가 입력되어 있어도 조회 가넝한
SELECT * FROM TEST WHERE STR1 = 'DEF'; -- 'DEF' VS 'DEF  ' : 엄밀히 따지면 다른 데이터이지만 조회는 가능.(CHAR 타입 일 때)
SELECT * FROM TEST WHERE STR1 = 'DEF   ';
--------------------------------------------------
SELECT * FROM TEST WHERE NUM = 100.45; -- NUMBER타입 = NUMVER(숫자) VS NUMVER(숫자)
SELECT * FROM TEST WHERE NUM = '100.45'; -- NUMBER VS 문자 // 숫자 타입에 문자가 들어왔을 경우 일단 변환을 하고 일치되면 조회됨. ( 오라클은 가넝)
SELECT * FROM TEST WHERE NUM = '100.45A'; -- 조회 불가(숫자로 변환 불가)

------------------------------------------------------
-- 날짜타입 DATE는 내부에 년,월,일,시,분,초 데이터 저장
-- TO_CHAR() : 문자타입으로 바꾸기. / TO_NUM() 숫자타입으로 변환 ...
SELECT DATE1, TO_CHAR(DATE1, 'YYYY-MM-DD HH24:MI:SS') FROM TEST; -- ( 변환시킬 컬럼? , 변환시킬 방식?)

-- 한글데이터 : 3 byte, ASCII코드 : 1byte
SELECT * FROM TEST;
INSERT INTO TEST (STR1, STR2) VALUES ('ABCEDFGHIJ', 'ABCEDFGHIJ');
-- 한글 4글자 * 3byte = 12byte이므로 10byte로 정해놓은 저장공간이 초과외어 오류남 
-- : ORA-12899: value too large for column
INSERT INTO TEST (STR1, STR2) VALUES ('ABCEDFGHIJ', '홍길동');

-----------------------------------------------------------
-- NULL(널) : 데이터가 없는 상태
-- NULL은 비교처리가 안됨: =(같다),!=(같지않다), <>(같지않다), >, <, >=, <= 등의 비교 처리가 의미 없음.
-- NULL과의 연산결과는 항상 NULL(연산 의미 없음)
-- NULL값에 대한 조회는 IS NULL, IS NOT NULL 키워드를 사용하여 처리
---
SELECT * FROM TEST WHERE NUM = NULL; -- 조회안됨(NULL 비교연산 의미 X)
SELECT * FROM TEST WHERE NUM IS NULL; -- NUM값이 NULL인 것만 조회됨
-- '<>', '!=' : 같지 않다(다르다)를 표현
SELECT * FROM TEST WHERE NUM <> NULL; -- 조회되지 않음
SELECT * FROM TEST WHERE NUM IS NOT NULL; -- NUM값이 NULL이 아닌 데이터들만 조회됨.
--------------
-- NULL 과의 연산 처리 결과
SELECT * FROM DUAL;
-- DUAL : DUMMY 테이블 컬럼도 한개, 테이블도 한개!
SELECT 100 + 200 FROM DUAL;
SELECT NUM, NUM + 100 FROM TEST; -- NULL과의 연산결과는 항상 NULL!
------------------------
-- 정렬 NULL 
SELECT * FROM TEST ORDER BY STR2; -- DEFAULT는 오름차순 정렬, ASC 키워드(오름차순키워드) 생략 가능
SELECT * FROM TEST ORDER BY STR2 DESC; -- DESC : 내림차순 정렬
-- 정렬시 오라클에서는 NULL 값을 가장 큰 값으로 처리한다.(맨 마지막 출력)
-- NULL값의 조회 순서 조정 : NULLS FIRST, NULLS LAST -> 키워드를 쓰면 위치 명시적으로 지정 가능
SELECT * FROM TEST ORDER BY NUM; -- DEFAULT 오름차순 정렬
SELECT * FROM TEST ORDER BY NUM DESC;
SELECT * FROM TEST ORDER BY NUM NULLS FIRST; -- NULL 값을 맨 앞에 표시
SELECT * FROM TEST ORDER BY NUM DESC NULLS LAST; -- 데이터를 내림차순으로 정렬하되 NULL 값만 맨 뒤로 !

-- NULL값에 대한 처리
SELECT NUM FROM TEST;
-- 내장함수 NVL
--NUM의 값이 NULL이면 0으로 대체(값이 있을 경우 그대로 둠)
SELECT NUM, NUM + 10, NVL(NUM,0), NVL(NUM,0) +10  FROM TEST;
---------------------------------------
INSERT INTO TEST(NUM, STR1, STR2) VALUES ( 200, '', NULL);
SELECT * FROM TEST WHERE STR1 = ''; -- 빈문자열 데이터 조회 안됨.
--------------------------------------
--DDL
-- 생성 : CREATE 
-- 수정 : ALTER
-- 삭제 : DROP
COMMIT;









