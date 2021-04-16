/* (�ǽ�) ���̺�(TABLE) ����� ( ���̺� ��: TEST2)
    NO : ���� Ÿ�� 5�ڸ�, PRIMARY KEY ����
    ID : ����Ÿ�� 10�ڸ� (10BYTE), ���� �ݵ�� �����ؾ� ��.(NULL�� ���X)
    NAME : �ѱ� 10�ڸ� ���� �����ϰ� ����, ���� �ݵ�� ����
    EMAIL : ����, ����, Ư������ ���� 30�ڸ�
    ADDRESS : �ѱ� 100��
    IDNUM : ����Ÿ�� ������7�ڸ�, �Ҽ��� 3�ڸ�(1234567.123)
    REGDATE : ��¥Ÿ��  

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
INSERT INTO TEST2 VALUES (1, '1111', 'ȫ�浿', 'HHH@NAVER.COM', '����� ��õ��', 1234567.123, SYSDATE);
INSERT INTO TEST2 (NO, ID, NAME ) VALUES (22, 'TEST1', 'ȫ�浿2');
COMMIT;
INSERT INTO TEST2 (NO, NAME, ID) VALUES (3, 'ȫ�浿3', 'TEST2');
--========================================
-- Ư�� ���̺��� �����Ϳ� �Բ� ���̺� ������ �Բ� ����
CREATE TABLE TEST3
AS 
SELECT * FROM TEST2;
--------------------------
-- Ư�� ���̺��� Ư�� �÷��� Ư�� �����͸� �����ϸ鼭 ���̺� ����
CREATE TABLE TEST4
AS 
SELECT NO, ID, NAME, EMAIL FROM TEST2 WHERE NO = 1;
------------------
-- Ư�� ���̺��� ������ ���� ( ������ ���� X )
CREATE TABLE TEST5
AS 
SELECT * FROM TEST2 WHERE NO = 11; -- ������ ��ȸ�� ���� �����Ƿ� ������ ������ �� ����. (11�� ���� ��ȣ) / SELECT * FROM TEST2 WHERE 1 = 1;ó�� �� ���� ����. (WHERE������ ����)
--=====================
SELECT * FROM TEST2;
DELETE FROM TEST2 WHERE ID = 'TEST3';
DELETE FROM TEST2; -- �ش� ���̺��� ��ü ������ ���� , Ŀ�������� ���� ����
ROLLBACK; -- ��� ó�� ����
-- TRUNCATE : ���̺� ��ü ������ ����(ROLLBACK���� ���� �ȵ�.)
TRUNCATE TABLE TEST2;
SELECT * FROM TEST2;
--=======================
/* ���̺��� ���� : DROP TABLE
    - �����Ϳ� �Բ� ���̺� ���� ��� ���� ó��
    DROP TABLE ������(��Ű��).���̺��;
    drop table ������(��Ű��).���̺�� cascade constraints PURGE;
    - cascade constraints : ���������Ͱ� �־ ����
    - PURGE : �����뿡 ������� ������ ����
************************/
DROP TABLE TEST4;

--==============================
/* ���̺� ���� : �÷� �߰�, ���� , ����
DDL : ALTER TABLE 
- ADD : �߰�
- MODYFY : ���� - ������ ���¿� ���� ���� ���ɿ��ΰ� ����
    - �÷������� ����-> ū : ������ ���� 
    - �÷������� ū -> ���� : ����� ������ ���¿� ���� 
    - ����-> ���� : �Ұ���
- DROP COLUMN : ����

********************************/
SELECT * FROM TEST3;
-- �÷� �߰� TEST3 ���̺� ADDCOL �÷� �߰�
ALTER TABLE TEST3 ADD ADDCOL VARCHAR2(10);

-- �÷� ���� TEST3 ���̺��� ADDCOL ũ�� -> VARCHAR2(20)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(20);
UPDATE TEST3 SET ADDCOL = '123456789012345';
SELECT * FROM TEST3;

-- �÷� ���� TEST3 ���̺��� ADDCOL ũ�� -> VARCHAR2(10), VARCHAR2(15)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(10); -- ���� �߻�, ����� �������� ũ�Ⱑ �ٲٷ��� ������ũ�⺸�� ŭ.
                                            --> ORA-01441: cannot decrease column length because some value is too big
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(15); -- ���� ����, ���� �Ϸ�

-- �÷� ���� : DROP COLUMN
ALTER TABLE TEST3 DROP COLUMN ADDCOL;

ALTER TABLE "MYSTUDY"."AAAAA" RENAME TO TEST3; -- �ٲ���Ҵ� ���̺��̸�(AAAAA)�� �ٽ� TEST3���� �ٲ�
ALTER TABLE TEST3 RENAME COLUMN ADDCOL TO ADDCOL2; -- �÷��� �ٲٱ�
ALTER TABLE TEST3 MODIFY (ADDCOL2 NOT NULL); -- ()�� �־ �ǰ� ��� �ȴ�.
                                            --> NOT NULL �������� ������ �Ϸ��� ������ �����Ͱ� �����Ƿ� ������ ��.
                                            
-- ADDCOL2�� �����͸� �Է��ϰ� �ٽ� �õ�
ALTER TABLE TEST3 MODIFY (ADDCOL2 NOT NULL);



