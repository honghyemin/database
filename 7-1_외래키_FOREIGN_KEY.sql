/* ���̺� ���� �� ��������
�÷��� �����ϸ鼭 �÷��������� ���������� ����
- �ܷ�Ű(FOREIGN KEY) �������� ���� ����
- ���� : �÷��� REFERENCES ������̺� (�÷���)

*******************************/
SELECT * FROM DEPT;
CREATE TABLE EM01 (
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT (ID) 
            -->> DEPT���̺� �ִ� ID�� �����Ͽ� �����͸� �ۼ��ؾ� ��. => �ܷ�Ű ���� ( �÷�����)
            -->> �������� ������ �ȵǾ������� ����� �����Ƿ� EM01���̺� �ƹ� �����ͳ� �Է��ص� ��.
            -->> ��, ��������� DEPT���̺��� ID�� �־�� ��.
            -->> �������� �� �� DEPT���̺��� ID������ ���� �͵�, �� 40, 50... ���� �־ ������X
);

----------
SELECT * FROM EM01;
INSERT INTO EM01 ( EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10');

-- ���� : ORA-02291: integrity constraint (MADANG.SYS_C007018) violated - parent key not found
--> ���輳���� �Ǿ����� ������ ������ �Է��� �� ���̴�.
--INSERT INTO EMP01 ( EMPNO, ENAME, JOB, DEPTNO) 
--VALUES (2222, 'ȫ�浿2', '����2', '40'); -- DEPT���̺��� ID�÷��� ���� ������(40)�Է� ����

--=========================================
-- ���̺� �������� ���� ���� ����
CREATE TABLE EMP02 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY (EMPNO), --�⺻Ű(PRIMARY KEY) ����
    FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID) -- �ܷ�Ű�� ��𿡼� ������ ������ �������
);

INSERT INTO EMP02 ( EMPNO, ENAME, JOB, DEPTNO) 
VALUES (1111, 'ȫ�浿1', '����1', '10'); 

COMMIT;
--INSERT INTO EMP02 ( EMPNO, ENAME, JOB, DEPTNO)  -- ���� �߻� 
--VALUES (2222, 'ȫ�浿2', '����2', '40'); 


--=========================================
-- ���������� ��������� �����ؼ� ���
-- ���� : CONSTRAINT �������Ǹ� ��������������
CREATE TABLE EMP03 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL, -- �÷��������� �ۼ��� ��������
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO), 
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT (ID) 
);

INSERT INTO EMP03 ( EMPNO, ENAME, JOB, DEPTNO) 
VALUES (1111, 'ȫ�浿1', '����1', '10'); 

--INSERT INTO EMP03 ( EMPNO, ENAME, JOB, DEPTNO)  -- ���� �߻� 
--VALUES (2222, 'ȫ�浿2', '����2', '40'); 
COMMIT;

--=====================================
-- �⺻Ű(PRIMARY KEY) ���� �� ���� Ű ���
CREATE TABLE HSCHOOL (
    HAK NUMBER(1), -- �г�
    BAN NUMBER(2), -- ��
    BUN NUMBER(2), -- ��ȣ
    NAME VARCHAR2(30),
    -- ������ �й��� �����ؼ� ���ϵ����Ͱ� ������ �ʵ��� UNIQUE ����
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN) 
    -->> �� ��(HAK,BAN,BUN)�� �����ؼ� PRIMARY KEY�� ����
);
SELECT * FROM HSCHOOL;
INSERT INTO HSCHOOL VALUES (1,1,1,'ȫ�浿1');
INSERT INTO HSCHOOL VALUES (1,1,1,'ȫ�浿~~'); 
--> UNIQUE���� �����Ƿ� ���� �߻� : ORA-00001: unique constraint (MADANG.HSCHOOL_HAK_BAN_BUN_PK) violated
INSERT INTO HSCHOOL VALUES (1,1,2,'ȫ�浿2');
INSERT INTO HSCHOOL VALUES (1,2,1,'ȫ�浿3');
INSERT INTO HSCHOOL VALUES (3,1,1,'ȫ�浿4');

--==========================================
/* ���̺� �������� �߰� / ����
-- �������� �߰�
ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������������(����);

-- �������� ����
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

******************************/
-- EMP01 ���̺��� PRIMARY KEY ���� : SYS_C007017
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007017;

-- EMP01 ���̺� PRIMARY KEY �߰�
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
-------------------
-- PK�� �����ϴ� ��� 
INSERT INTO EMP01 VALUES (1111, 'ȫ�浿2', '����2', '10');
-->> ���� : ORA-00001: unique constraint (MADANG.EMP01_EMPNO_PK) violated

-- PK ���� ��
ALTER TABLE EMP01 DROP CONSTRAINT EMP01_EMPNO_PK; -- PK����
INSERT INTO EMP01 VALUES (1111, 'ȫ�浿2', '����2', '10'); -- �ߺ������� OK

-- �ߺ������Ͱ� ���� �� PRIMARY KEY�� �����Ѵٸ�? : �����߻� -> �ߺ������͸� ���� �� ����
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
-- >> ���� : ORA-02437: cannot validate (MADANG.EMP01_EMPNO_PK) - primary key violated

-- ( �ǽ� ) EMP02, EMP03 �ܷ�Ű(FOREIGN KEY) �̸� ���� ó��
-- ������ ������ �����͸� ���� �� ����
------ EMP02 : EMP02_DEPTNO_FK, EMP03:EMP03_FK_DEPTNO
ALTER TABLE EMP02 DROP CONSTRAINT SYS_C007021;
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);

ALTER TABLE EMP03 DROP CONSTRAINT EMP03_DEPTNO_FK;
ALTER TABLE EMP03 ADD CONSTRAINT EMP03_FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);

--======================================
/* �������� Ȱ��ȭ �Ǵ� ��Ȱ��ȭ 
-> ��Ȱ��ȭ ��ų ���� ���������� �¾ƾ� ��.

-- ���������� �����Ǿ� �ִ� ���� ���� �Ǵ� ���� ����
ALTER TABLE ���̺�� DISABLE CONSTRAINT �������Ǹ�; -- ������ �Ǿ������� ���X
ALTER TABLE ���̺�� ENABLE CONSTRAINT �������Ǹ�; -- ��� ���� ���·� ��ȯ

**********************/
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_DEPTNO_FK;
-- �ܷ�Ű DISABLED ������ ��� 
INSERT INTO EMP02 VALUES (2222, 'ȫ�浿2', '����2', '40'); -- �Է� ����
--> �����ϰ� �ִ� ���� �����Ƿ� ������ �߰� �� �� ����
COMMIT;
-- �������� ��Ȱ��ȭ(������·� �ٲٱ�)
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_DEPTNO_FK;
--> ���� �߻� : ORA-02298: cannot validate (MADANG.EMP02_DEPTNO_FK) - parent keys not found
-->> ���������Ͱ� �θ����̺� ������ ���� �߻�.

--======================================
-- ������ ���� ���̺� ��� ���� ���� Ȯ��
SELECT * FROM USER_CONS_COLUMNS; -- � ���̺��� �ִ���
SELECT * FROM USER_CONSTRAINTS; -- � ������ �Ǿ� �ִ���

SELECT A.OWNER, A.TABLE_NAME, A.COLUMN_NAME, A.CONSTRAINT_NAME,
        B.CONSTRAINT_TYPE,
        DECODE(B.CONSTRAINT_TYPE, 'P', 'PRIMARY KEY',
                                'U', 'UNIQUE',
                                'C', 'CHECK OR NOT NULL',
                                'R', 'FOREIGN KEY' )CONSTRAINT_TYPE_DESC
    FROM USER_CONS_COLUMNS A, USER_CONSTRAINTS B
WHERE A.TABLE_NAME = B.TABLE_NAME -- ���̺�� ��ġ
    AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME -- �������Ǹ� ��ġ
    AND A.TABLE_NAME LIKE 'EMP%'
;

