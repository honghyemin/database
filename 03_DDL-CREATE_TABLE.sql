/* *************************
����Ÿ ���Ǿ�
- DDL(Data Definition Language) : ����Ÿ�� �����ϴ� ���
- CREATE(����), DROP(����), ALTER(����)
- {}�ݺ�����, []��������, | �Ǵ�(����)
CREATE TABLE ���̺�� (
{�÷��� ����ŸŸ��
    [NOT NULL | UNIQUE | DEFAULT �⺻�� | CHECK üũ����]
}
    [PRIMARY KEY �÷���]
    {[FOREIGN KEY �÷��� REFERENCES ���̺��(�÷���)]
    [ON DELETE [CASCADE | SET NULL]
    }
);
--------
�÷��� �⺻ ����Ÿ Ÿ�� - ũ����� ����
VARCHAR2(n) : ���ڿ� ��������
CHAR(n) : ���ڿ� ��������
NUMBER(p, s) : ����Ÿ�� p:��ü����, s:�Ҽ������� �ڸ���
  ��) (5,2) : ������ 3�ڸ�, �Ҽ��� 2�ڸ� - ��ü 5�ڸ�
DATE : ��¥�� ��,��,�� �ð� �� ����

���ڿ� ó�� : UTF-8 ���·� ����
- ����, ���ĺ� ����, Ư������ : 1 byte ó��(Ű���� ���� ���ڵ�)
- �ѱ� : 3 byte ó��
***************************/
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, -- NOT NULL, UNIQUE �Ӽ��� �⺻������ �Բ� �����.
    NAME VARCHAR2(30) NOT NULL, -- �����̸��ϰ�� 30���ڱ���, �ѱ��̸��ϰ�� 10���ڸ�
    PASSWORD VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(300)
);

---------------------------------
INSERT INTO MEMBER (ID, NAME, PASSWORD)     -- ID �Ǵ� ID,NAME �� �־��� ��� ���� �߻�!
VALUES ('HONG', 'ȫ�浿', '1234');            -- ������ ������(ID)�� �� �� �� �־��� ��� ���� �߻�(UNIQUE ���ǿ� ����)

INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('HONG2', 'ȫ�浿', '1234');

-- unique ���� �÷� �ߺ� ����Ÿ �Է½� ���� �߻�
-- ORA-00001: unique constraint (MYSTUDY.SYS_C006999) violated
INSERT INTO MEMBER (ID, NAME, PASSWORD) -- NOTNULL�ΰ͸� �־���
VALUES ('HONG2', 'ȫ�浿', '1234');
---------------------------------------------
SELECT * FROM MEMBER;

-- �Է� : �÷����� ��������� �ۼ����� ���� ��� ��� �÷� �� �Է�
-- ���̺� �ִ� �÷��� ������ �°� ������ �Է�.
INSERT INTO MEMBER      -- NOT NULL�� ���� �����Ͽ� ��� �÷�(�׸�)�� �־��־�� ��
VALUES ('HONG5', 'ȫ�浿5', '1234', '010-1111-1111', '�����');

--�Ǽ� : ��ȭ��ȣ ��ġ�� �߸��ؼ� �ּҰ� �Է��� ���
INSERT INTO MEMBER 
VALUES ('HONG6', 'ȫ�浿6', '1234', '�����', '010-1111-1111'); -- ������ ������ �ƴ����� ���� ������ �߻�.
----------------------------------------------------------
INSERT INTO MEMBER (ID, NAME, PASSWORD, PHONE, ADDRESS )
VALUES ('HONG7', 'ȫ�浿7', '7777', '010-7777-7777', '�λ��');
COMMIT;

SELECT * FROM MEMBER;
-------------------------------------------
-- ���� : HONG6 ��ȭ��ȣ -> '010-6666-6666' ���� ����
-- ���� : HONG6 �ּ� -> '�����'�� ���� 
UPDATE MEMBER 
    SET PHONE = '010-6666-6666', ADDRESS = '�����' WHERE ID = 'HONG6';
COMMIT;

SELECT * FROM MEMBER WHERE ID = 'HONG6';
--------------------------------------------
-- ���� : HONG7 ������ ����
-- ���� : �̸��� ȫ�浿�� ��� ����
DELETE FROM MEMBER WHERE ID = 'HONG7';
SELECT * FROM MEMBER;
SELECT COUNT(*) FROM MEMBER WHERE NAME = 'ȫ�浿'; -- 'ȫ�浿'�̶�� �̸��� ���� �������� ���� ��.
DELETE FROM MEMBER WHERE NAME = 'ȫ�浿';
SELECT * FROM MEMBER;
COMMIT;
------------------------------------
/* (�ǽ�) CRUD - �Է�, ��ȸ, ����, ����
�Է� : ���̵� -hong8, �̸� - ȫ�浿8, ��ȣ -1111, �ּ� - ����� ���ʱ�
��ȸ(�˻�) : �̸��� 'ȫ�浿8'�� ����� ���̵�, �̸� �ּ� �����͸� ��ȸ
���� : ���̵� : hong8 ����� 
    ��ȭ��ȣ : 010-8888-8888
    ��ȣ : 8888
    �ּ� : ����� ������
���� : ���̵� hong8�� ���
*/
-----------------------------------
SELECT * FROM MEMBER;

INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS)
VALUES('hong8', 'ȫ�浿8', '1111', '����ü��ʱ�');
SELECT ID,NAME,ADDRESS FROM MEMBER WHERE NAME = 'ȫ�浿8';

UPDATE MEMBER 
SET PHONE ='010-8888-8888', PASSWORD = '8888', ADDRESS ='����� ������'
WHERE ID = 'hong8';

SELECT * FROM MEMBER WHERE ID = 'hong8';

DELETE FROM MEMBER WHERE ID = 'hong8';

SELECT * FROM MEMBER;
COMMIT;

--=======================================
-- �÷� Ư���� Ȯ���ϱ� ���� ���̺�
CREATE TABLE TEST(
    NUM NUMBER(5,2), -- ��ü �ڸ����� 5�ڸ��̸� ������ 3�ڸ� �Ҽ��� 2�ڸ���.
    STR1 CHAR(10), -- ��������
    STR2 VARCHAR2(10), -- ��������
    DATE1 DATE -- ��¥������ : ��,��,��,��,��,��(��,��,�ϸ� �����ֵ��� �����Ǿ� ����)    
);

INSERT INTO TEST VALUES (100.454, 'ABC', 'ABC', SYSDATE); -- SYSDATE: ��������� �����Ͻú��ʸ� ��¥Ÿ������ �Է����ִ� ..�Լ�?
INSERT INTO TEST VALUES (100.455, 'ABC', 'ABC', SYSDATE); -- 100.455�� ��� �Ҽ��� �ڸ��� ���ڸ��� �;��ϹǷ� ���� 5�� �ݿø� �Ǿ� 100.46�� ��.
SELECT * FROM TEST;
SELECT '-' || STR1 || '-', '-' ||STR2|| '-' FROM TEST;   -- �����Ͱ� ������ ����Ǿ� �ִ��� Ȯ��
INSERT INTO TEST VALUES (100.456, 'DEF', 'DEF ', SYSDATE);
COMMIT;
SELECT LENGTHB (STR1), LENGTHB(STR2) FROM TEST; -- BYTE������ ���̸� ���� ������
--------------------------------------------

-- �����͸� ��ȸ�� �� CHAR Ÿ�� vs  VARCHAR2 Ÿ��
SELECT * FROM TEST WHERE STR1 = STR2; -- ��ȸ�� ������ ����.
SELECT * FROM TEST WHERE STR1 = 'ABC'; -- ����Ŭ������ ��ȸ��(�ٸ� �����ͺ��̽������� ��ȸ�� �� �� ���� ����.)
SELECT * FROM TEST WHERE STR1 = 'ABC     '; --����Ŭ������ ��ȸ��(�ٸ� �����ͺ��̽������� ��ȸ�� �� �� ���� ����.)
SELECT * FROM TEST WHERE STR1 = 'ABC       '; -- �����̽��ٰ� �ԷµǾ� �־ ��ȸ ������
SELECT * FROM TEST WHERE STR1 = 'DEF'; -- 'DEF' VS 'DEF  ' : ������ ������ �ٸ� ������������ ��ȸ�� ����.(CHAR Ÿ�� �� ��)
SELECT * FROM TEST WHERE STR1 = 'DEF   ';
--------------------------------------------------
SELECT * FROM TEST WHERE NUM = 100.45; -- NUMBERŸ�� = NUMVER(����) VS NUMVER(����)
SELECT * FROM TEST WHERE NUM = '100.45'; -- NUMBER VS ���� // ���� Ÿ�Կ� ���ڰ� ������ ��� �ϴ� ��ȯ�� �ϰ� ��ġ�Ǹ� ��ȸ��. ( ����Ŭ�� ����)
SELECT * FROM TEST WHERE NUM = '100.45A'; -- ��ȸ �Ұ�(���ڷ� ��ȯ �Ұ�)

------------------------------------------------------
-- ��¥Ÿ�� DATE�� ���ο� ��,��,��,��,��,�� ������ ����
-- TO_CHAR() : ����Ÿ������ �ٲٱ�. / TO_NUM() ����Ÿ������ ��ȯ ...
SELECT DATE1, TO_CHAR(DATE1, 'YYYY-MM-DD HH24:MI:SS') FROM TEST; -- ( ��ȯ��ų �÷�? , ��ȯ��ų ���?)

-- �ѱ۵����� : 3 byte, ASCII�ڵ� : 1byte
SELECT * FROM TEST;
INSERT INTO TEST (STR1, STR2) VALUES ('ABCEDFGHIJ', 'ABCEDFGHIJ');
-- �ѱ� 4���� * 3byte = 12byte�̹Ƿ� 10byte�� ���س��� ��������� �ʰ��ܾ� ������ 
-- : ORA-12899: value too large for column
INSERT INTO TEST (STR1, STR2) VALUES ('ABCEDFGHIJ', 'ȫ�浿');

-----------------------------------------------------------
-- NULL(��) : �����Ͱ� ���� ����
-- NULL�� ��ó���� �ȵ�: =(����),!=(�����ʴ�), <>(�����ʴ�), >, <, >=, <= ���� �� ó���� �ǹ� ����.
-- NULL���� �������� �׻� NULL(���� �ǹ� ����)
-- NULL���� ���� ��ȸ�� IS NULL, IS NOT NULL Ű���带 ����Ͽ� ó��
---
SELECT * FROM TEST WHERE NUM = NULL; -- ��ȸ�ȵ�(NULL �񱳿��� �ǹ� X)
SELECT * FROM TEST WHERE NUM IS NULL; -- NUM���� NULL�� �͸� ��ȸ��
-- '<>', '!=' : ���� �ʴ�(�ٸ���)�� ǥ��
SELECT * FROM TEST WHERE NUM <> NULL; -- ��ȸ���� ����
SELECT * FROM TEST WHERE NUM IS NOT NULL; -- NUM���� NULL�� �ƴ� �����͵鸸 ��ȸ��.
--------------
-- NULL ���� ���� ó�� ���
SELECT * FROM DUAL;
-- DUAL : DUMMY ���̺� �÷��� �Ѱ�, ���̺� �Ѱ�!
SELECT 100 + 200 FROM DUAL;
SELECT NUM, NUM + 100 FROM TEST; -- NULL���� �������� �׻� NULL!
------------------------
-- ���� NULL 
SELECT * FROM TEST ORDER BY STR2; -- DEFAULT�� �������� ����, ASC Ű����(��������Ű����) ���� ����
SELECT * FROM TEST ORDER BY STR2 DESC; -- DESC : �������� ����
-- ���Ľ� ����Ŭ������ NULL ���� ���� ū ������ ó���Ѵ�.(�� ������ ���)
-- NULL���� ��ȸ ���� ���� : NULLS FIRST, NULLS LAST -> Ű���带 ���� ��ġ ��������� ���� ����
SELECT * FROM TEST ORDER BY NUM; -- DEFAULT �������� ����
SELECT * FROM TEST ORDER BY NUM DESC;
SELECT * FROM TEST ORDER BY NUM NULLS FIRST; -- NULL ���� �� �տ� ǥ��
SELECT * FROM TEST ORDER BY NUM DESC NULLS LAST; -- �����͸� ������������ �����ϵ� NULL ���� �� �ڷ� !

-- NULL���� ���� ó��
SELECT NUM FROM TEST;
-- �����Լ� NVL
--NUM�� ���� NULL�̸� 0���� ��ü(���� ���� ��� �״�� ��)
SELECT NUM, NUM + 10, NVL(NUM,0), NVL(NUM,0) +10  FROM TEST;
---------------------------------------
INSERT INTO TEST(NUM, STR1, STR2) VALUES ( 200, '', NULL);
SELECT * FROM TEST WHERE STR1 = ''; -- ���ڿ� ������ ��ȸ �ȵ�.
--------------------------------------
--DDL
-- ���� : CREATE 
-- ���� : ALTER
-- ���� : DROP
COMMIT;









