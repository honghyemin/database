/* 제약조건 옵션
CASCADE : 부모테이블(PARENT)의 제약조건을 비활성화(삭제) 시키면서
        참조하고 있는 자녀(CHILD) 테이블의 제약조건까지 비활성화(삭제)

******************************/
ALTER TABLE DEPT DISABLE PRIMARY KEY;
-->> 오류 발생 : ORA-02297: cannot disable constraint (MADANG.SYS_C007004) - dependencies exist
------>> 컬럼에 대해 의존하고 있는 데이터가 있으므로 처리 불가

-- 방법 1 : 자녀테이블 참조키 모두 삭제 또는 비활성화
ALTER TABLE EMP01 DISABLE CONSTRAINT SYS_C007018;
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 DISABLE CONSTRAINT EMP03_FK_DEPTNO;

ALTER TABLE DEPT DISABLE PRIMARY KEY; -- 참조테이블이 없으면 해제 처리 됨

-- DEPT 테이블 PK, 자녀테이블 FK 활성화
ALTER TABLE DEPT ENABLE PRIMARY KEY;
ALTER TABLE EMP01 ENABLE CONSTRAINT SYS_C007018;
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 ENABLE CONSTRAINT EMP03_FK_DEPTNO;

-- 방법 2 : DEPT 테이블의 PK 비활성화 시키면서
--          참조하고 있는 테이블(EMP01, EMP02, EMP03) 함께 비활성화 처리
---- > CASCADE 옵션 사용 : 부모테이블 PK + 자녀테이블 FK 동시에 비활성화 처리
ALTER TABLE DEPT DISABLE PRIMARY KEY CASCADE;

--========================================
/* 제약조건 옵션 : ON DELETE CASCADE
 - 테이블간의 관계에서 부모테이블 데이터 삭제시 자녀테이블 데이터도 함께 삭제 처리

****************************************/
CREATE TABLE C_TEST_MAIN (
    MAIN_PK NUMBER PRIMARY KEY,
    MAIN_DATA VARCHAR2(30)
);

CREATE TABLE C_TEST_SUB (
    SUB_PK NUMBER PRIMARY KEY,
    SUB_DATA VARCHAR2(30),
    SUB_FK NUMBER,
    CONSTRAINT C_TEST_SUB_FK FOREIGN KEY (SUB_FK) 
    REFERENCES C_TEST_MAIN(MAIN_PK) ON DELETE CASCADE 
    -- CASCADE 옵션(참조하고 있는 부모의 데이터가 삭제되면 참조하는 자식의 데이터도 삭제됨.)
);
------
INSERT INTO C_TEST_MAIN VALUES (1111, '1번 메인 데이터');
INSERT INTO C_TEST_MAIN VALUES (2222, '2번 메인 데이터');
INSERT INTO C_TEST_MAIN VALUES (3333, '3번 메인 데이터');
COMMIT;
---
INSERT INTO C_TEST_SUB VALUES (1, '1번 서브 데이터', 1111);
INSERT INTO C_TEST_SUB VALUES (2, '2번 서브 데이터', 2222);
INSERT INTO C_TEST_SUB VALUES (3, '3번 서브 데이터', 3333);
INSERT INTO C_TEST_SUB VALUES (4, '4번 서브 데이터', 3333);
COMMIT;

---------------------
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;

-- 메인 테이블에 있는 데이터 삭제
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 1111;
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 3333;
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;

--==================================
-- 테이블 삭제 : 부모-자녀 관계 설정된 
DROP TABLE C_TEST_MAIN; --참조관계에 있으므로 삭제X
-->> 오류 : ORA-02449: unique/primary keys in table referenced by foreign keys

-- 방법 1 ) 서브테이블 모두 삭제 후 부모테이블 삭제
DROP TABLE C_TEST_SUB;
DROP TABLE C_TEST_MAIN;

-- 방법 2 ) 서브테이블에 있는 FK설정을 모두 삭제(참조관계를 없앰) 후 부모테이블 삭제
----> FK 비활성화 (DISABLE) 설정으로는 안됨 >> 동작하지 않도록 한 것이지 설정 자체를 없앤 것이 아니기 때문
DROP TABLE C_TEST_MAIN; -- 오류
ALTER TABLE C_TEST_SUB DROP CONSTRAINT C_TEST_SUB_FK;
DROP TABLE C_TEST_MAIN;

-- 방법 3 ) 부모테이블 삭제시 CASCADE CONSTRAINTS 옵션 사용
---- 서브테이블이 제약조건(FK) 삭제 후 부모테이블(MAIN) 삭제 처리
DROP TABLE C_TEST_MAIN CASCADE CONSTRAINTS;
--===================================





