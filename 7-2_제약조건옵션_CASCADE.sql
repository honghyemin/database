/* �������� �ɼ�
CASCADE : �θ����̺�(PARENT)�� ���������� ��Ȱ��ȭ(����) ��Ű�鼭
        �����ϰ� �ִ� �ڳ�(CHILD) ���̺��� �������Ǳ��� ��Ȱ��ȭ(����)

******************************/
ALTER TABLE DEPT DISABLE PRIMARY KEY;
-->> ���� �߻� : ORA-02297: cannot disable constraint (MADANG.SYS_C007004) - dependencies exist
------>> �÷��� ���� �����ϰ� �ִ� �����Ͱ� �����Ƿ� ó�� �Ұ�

-- ��� 1 : �ڳ����̺� ����Ű ��� ���� �Ǵ� ��Ȱ��ȭ
ALTER TABLE EMP01 DISABLE CONSTRAINT SYS_C007018;
ALTER TABLE EMP02 DISABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 DISABLE CONSTRAINT EMP03_FK_DEPTNO;

ALTER TABLE DEPT DISABLE PRIMARY KEY; -- �������̺��� ������ ���� ó�� ��

-- DEPT ���̺� PK, �ڳ����̺� FK Ȱ��ȭ
ALTER TABLE DEPT ENABLE PRIMARY KEY;
ALTER TABLE EMP01 ENABLE CONSTRAINT SYS_C007018;
ALTER TABLE EMP02 ENABLE CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP03 ENABLE CONSTRAINT EMP03_FK_DEPTNO;

-- ��� 2 : DEPT ���̺��� PK ��Ȱ��ȭ ��Ű�鼭
--          �����ϰ� �ִ� ���̺�(EMP01, EMP02, EMP03) �Բ� ��Ȱ��ȭ ó��
---- > CASCADE �ɼ� ��� : �θ����̺� PK + �ڳ����̺� FK ���ÿ� ��Ȱ��ȭ ó��
ALTER TABLE DEPT DISABLE PRIMARY KEY CASCADE;

--========================================
/* �������� �ɼ� : ON DELETE CASCADE
 - ���̺��� ���迡�� �θ����̺� ������ ������ �ڳ����̺� �����͵� �Բ� ���� ó��

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
    -- CASCADE �ɼ�(�����ϰ� �ִ� �θ��� �����Ͱ� �����Ǹ� �����ϴ� �ڽ��� �����͵� ������.)
);
------
INSERT INTO C_TEST_MAIN VALUES (1111, '1�� ���� ������');
INSERT INTO C_TEST_MAIN VALUES (2222, '2�� ���� ������');
INSERT INTO C_TEST_MAIN VALUES (3333, '3�� ���� ������');
COMMIT;
---
INSERT INTO C_TEST_SUB VALUES (1, '1�� ���� ������', 1111);
INSERT INTO C_TEST_SUB VALUES (2, '2�� ���� ������', 2222);
INSERT INTO C_TEST_SUB VALUES (3, '3�� ���� ������', 3333);
INSERT INTO C_TEST_SUB VALUES (4, '4�� ���� ������', 3333);
COMMIT;

---------------------
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;

-- ���� ���̺� �ִ� ������ ����
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 1111;
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 3333;
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;

--==================================
-- ���̺� ���� : �θ�-�ڳ� ���� ������ 
DROP TABLE C_TEST_MAIN; --�������迡 �����Ƿ� ����X
-->> ���� : ORA-02449: unique/primary keys in table referenced by foreign keys

-- ��� 1 ) �������̺� ��� ���� �� �θ����̺� ����
DROP TABLE C_TEST_SUB;
DROP TABLE C_TEST_MAIN;

-- ��� 2 ) �������̺� �ִ� FK������ ��� ����(�������踦 ����) �� �θ����̺� ����
----> FK ��Ȱ��ȭ (DISABLE) �������δ� �ȵ� >> �������� �ʵ��� �� ������ ���� ��ü�� ���� ���� �ƴϱ� ����
DROP TABLE C_TEST_MAIN; -- ����
ALTER TABLE C_TEST_SUB DROP CONSTRAINT C_TEST_SUB_FK;
DROP TABLE C_TEST_MAIN;

-- ��� 3 ) �θ����̺� ������ CASCADE CONSTRAINTS �ɼ� ���
---- �������̺��� ��������(FK) ���� �� �θ����̺�(MAIN) ���� ó��
DROP TABLE C_TEST_MAIN CASCADE CONSTRAINTS;
--===================================





