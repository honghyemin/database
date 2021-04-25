/* 테이블 생성 시 제약조건
컬럼을 정의하면서 컬럼레벨에서 제약조건을 지정
- 외래키(FOREIGN KEY) 지정으로 관계 설정
- 형태 : 컬럼명 REFERENCES 대상테이블 (컬럼명)

*******************************/
SELECT * FROM DEPT;
CREATE TABLE EM01 (
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT (ID) 
            -->> DEPT테이블에 있는 ID를 참조하여 데이터를 작성해야 함. => 외래키 설정 ( 컬럼레벨)
            -->> 참조관계 설정이 안되어있으면 상관이 없으므로 EM01테이블엔 아무 데이터나 입력해도 됨.
            -->> 즉, 참조관계면 DEPT테이블의 ID만 넣어야 함.
            -->> 참조관계 일 때 DEPT테이블의 ID데이터 외의 것들, 즉 40, 50... 등을 넣어도 결과출력X
);

----------
SELECT * FROM EM01;
INSERT INTO EM01 ( EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');

-- 오류 : ORA-02291: integrity constraint (MADANG.SYS_C007018) violated - parent key not found
--> 관계설정이 되어있지 않으면 데이터 입력이 될 것이다.
--INSERT INTO EMP01 ( EMPNO, ENAME, JOB, DEPTNO) 
--VALUES (2222, '홍길동2', '직무2', '40'); -- DEPT테이블의 ID컬럼에 없는 데이터(40)입력 못함

--=========================================
-- 테이블 레벨에서 제약 조건 지정
CREATE TABLE EMP02 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY (EMPNO), --기본키(PRIMARY KEY) 설정
    FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID) -- 외래키를 어디에서 참조할 것인지 명시해줌
);

INSERT INTO EMP02 ( EMPNO, ENAME, JOB, DEPTNO) 
VALUES (1111, '홍길동1', '직무1', '10'); 

COMMIT;
--INSERT INTO EMP02 ( EMPNO, ENAME, JOB, DEPTNO)  -- 오류 발생 
--VALUES (2222, '홍길동2', '직무2', '40'); 


--=========================================
-- 제약조건을 명시적으로 선언해서 사용
-- 형태 : CONSTRAINT 제약조건명 적용할제약조건
CREATE TABLE EMP03 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL, -- 컬럼레벨에서 작성된 제약조건
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO), 
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID) 
);

INSERT INTO EMP03 ( EMPNO, ENAME, JOB, DEPTNO) 
VALUES (1111, '홍길동1', '직무1', '10'); 

--INSERT INTO EMP03 ( EMPNO, ENAME, JOB, DEPTNO)  -- 오류 발생 
--VALUES (2222, '홍길동2', '직무2', '40'); 
COMMIT;

--=====================================
-- 기본키(PRIMARY KEY) 설정 시 복합 키 사용
CREATE TABLE HSCHOOL (
    HAK NUMBER(1), -- 학년
    BAN NUMBER(2), -- 반
    BUN NUMBER(2), -- 번호
    NAME VARCHAR2(30),
    -- 별도로 학번을 설정해서 동일데이터가 들어오지 않도록 UNIQUE 설정
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN) 
    -->> 세 개(HAK,BAN,BUN)을 조합해서 PRIMARY KEY를 만듦
);
SELECT * FROM HSCHOOL;
INSERT INTO HSCHOOL VALUES (1,1,1,'홍길동1');
INSERT INTO HSCHOOL VALUES (1,1,1,'홍길동~~'); 
--> UNIQUE하지 않으므로 오류 발생 : ORA-00001: unique constraint (MADANG.HSCHOOL_HAK_BAN_BUN_PK) violated
INSERT INTO HSCHOOL VALUES (1,1,2,'홍길동2');
INSERT INTO HSCHOOL VALUES (1,2,1,'홍길동3');
INSERT INTO HSCHOOL VALUES (3,1,1,'홍길동4');

--==========================================
/* 테이블에 제약조건 추가 / 삭제
-- 제약조건 추가
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 적용할제약조건(형태);

-- 제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

******************************/
-- EMP01 테이블의 PRIMARY KEY 삭제 : SYS_C007017
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007017;

-- EMP01 테이블에 PRIMARY KEY 추가
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
-------------------
-- PK가 존재하는 경우 
INSERT INTO EMP01 VALUES (1111, '홍길동2', '직무2', '10');
-->> 오류 : ORA-00001: unique constraint (MADANG.EMP01_EMPNO_PK) violated

-- PK 삭제 후
ALTER TABLE EMP01 DROP CONSTRAINT EMP01_EMPNO_PK; -- PK삭제
INSERT INTO EMP01 VALUES (1111, '홍길동2', '직무2', '10'); -- 중복데이터 OK

-- 중복데이터가 있을 때 PRIMARY KEY를 설정한다면? : 오류발생 -> 중복데이터를 없앤 후 적용
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
-- >> 오류 : ORA-02437: cannot validate (MADANG.EMP01_EMPNO_PK) - primary key violated

-- ( 실습 ) EMP02, EMP03 외래키(FOREIGN KEY) 이름 변경 처리
-- 수정은 기존의 데이터를 삭제 후 수정
------ EMP02 : EMP02_DEPTNO_FK, EMP03:EMP03_FK_DEPTNO
ALTER TABLE EMP02 DROP CONSTRAINT SYS_C007021;
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);

ALTER TABLE EMP03 DROP CONSTRAINT EMP03_DEPTNO_FK;
ALTER TABLE EMP03 ADD CONSTRAINT EMP03_FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);

--======================================
/* 제약조건 활성화 또는 비활성화 
-> 재활성화 시킬 때는 제약조건이 맞아야 함.

-- 제약조건이 설정되어 있는 것을 적용 또는 적용 해제
ALTER TABLE 테이블명 DISABLE CONSTRAINT 제약조건명; -- 설정은 되어있으나 사용X
ALTER TABLE 테이블명 ENABLE CONSTRAINT 제약조건명; -- 사용 중인 상태로 변환

**********************/
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_DEPTNO_FK;
-- 외래키 DISABLED 상태인 경우 
INSERT INTO EMP02 VALUES (2222, '홍길동2', '직무2', '40'); -- 입력 성공
--> 참조하고 있는 것이 없으므로 데이터 추가 할 수 있음
COMMIT;
-- 제약조건 재활성화(적용상태로 바꾸기)
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_DEPTNO_FK;
--> 오류 발생 : ORA-02298: cannot validate (MADANG.EMP02_DEPTNO_FK) - parent keys not found
-->> 참조데이터가 부모테이블에 없으면 오류 발생.

--======================================
-- 데이터 사전 테이블 사용 제약 조건 확인
SELECT * FROM USER_CONS_COLUMNS; -- 어떤 테이블이 있는지
SELECT * FROM USER_CONSTRAINTS; -- 어떤 설정이 되어 있는지

SELECT A.OWNER, A.TABLE_NAME, A.COLUMN_NAME, A.CONSTRAINT_NAME,
        B.CONSTRAINT_TYPE,
        DECODE(B.CONSTRAINT_TYPE, 'P', 'PRIMARY KEY',
                                'U', 'UNIQUE',
                                'C', 'CHECK OR NOT NULL',
                                'R', 'FOREIGN KEY' )CONSTRAINT_TYPE_DESC
    FROM USER_CONS_COLUMNS A, USER_CONSTRAINTS B
WHERE A.TABLE_NAME = B.TABLE_NAME -- 테이블명 일치
    AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME -- 제약조건명 일치
    AND A.TABLE_NAME LIKE 'EMP%'
;

