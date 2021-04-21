-- (����) �� �� �� �ǵ� ���� �� �� ����� ����?
-- CUSTOMER ���̺��� �ְ�, ORDERS ���̺��� ���� ���
-- (���1) MINUS : ������ ó��.
SELECT CUSTID
FROM CUSTOMER --1,2,3,4,5
MINUS
SELECT DISTINCT CUSTID
FROM ORDERS; -- 1,2,3,4

-- (���2) �������� ���
SELECT * -- ������ �ִ� ��� ��� ��ȸ
FROM CUSTOMER
WHERE CUSTID IN(
SELECT DISTINCT CUSTID
FROM ORDERS
);

-----
SELECT * -- ������ ���� ��� ��� ��ȸ
FROM CUSTOMER
WHERE CUSTID NOT IN (
SELECT DISTINCT CUSTID
FROM ORDERS
 );

---------------------
-- (���3) �ܺ����� (OUTER JOIN)
-- ��������(JOIN)
SELECT DISTINCT
   C.CUSTID,
    C.NAME -- �����̷��� �ִ� ����� ����
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID -- ��������(��������-EQUIT JOIN)
;

-- �ܺ�����(��������)
-- SELECT DISTINCT C.CUSTID, C.NAME -- �����̷��� �ִ� ����� ����
SELECT *
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID(+) -- ��������(�������� �ܺ�����)
AND O.ORDERID IS NULL
-- AND O.ORDERIS IS NOT NULL -- �����̷��� �ִ� ��� ��ȸ
;

-- ANSI ǥ�� SQL(LEFT OUTER JOIN) -- OUTER JOIN�ε� ���� ����
SELECT *
FROM CUSTOMER C
LEFT OUTER JOIN ORDERS O -- ������ �ִ� �����͸� �������� ������ �����͸� ��Ī���� ǥ��
ON C.CUSTID = O.CUSTID
WHERE O.ORDERID IS NULL;
-- ANSI ǥ�� SQL(RIGHT OUTER JOIN) -- OUTER JOIN�ε� ���� ����

SELECT *
FROM ORDERS O
RIGHT OUTER JOIN CUSTOMER C 
ON C.CUSTID = O.CUSTID
WHERE O.ORDERID IS NULL;


-- �ܺ�����(��������)
SELECT C.*
FROM CUSTOMER C, ORDERS O
WHERE O.CUSTID(+) = C.CUSTID -- ��������(�������� �ܺ�����), ��ȣ�� ���� �� ����
            -- ������ �ִ� ���̺��� �� ǥ��, ���� ���̺��� ���� �κи� ä���ֱ� ���� + ǥ��
AND O.ORDERID IS NULL;

--------------------
--���� ����(JOIN, INNER JOIN) : ���ε� ���̺� ��ο� �����ϴ� ������ �˻�
--�ܺ� ����(OUTER JOIN) : ��� �� �� ���̺� �ִ� �����Ͱ� �ٸ� ���̺��� �������� �ʴ� ������ �˻�
---- �������̺� ��� ������ ǥ���ϰ�, ��ġ���� �ʴ� 
CREATE TABLE DEPT (
    ID    VARCHAR2(10) PRIMARY KEY,
    NAME  VARCHAR2(30)
);

INSERT INTO DEPT VALUES (
    '10',
    '�ѹ���'
);

INSERT INTO DEPT VALUES (
    '20',
    '�޿���'
);

INSERT INTO DEPT VALUES (
    '30',
    'IT��'
);

COMMIT;

----------

CREATE TABLE DEPT_1 (
    ID    VARCHAR2(10) PRIMARY KEY,
    NAME  VARCHAR2(30)
);

INSERT INTO DEPT_1 VALUES (
    '10',
    '�ѹ���'
);

INSERT INTO DEPT_1 VALUES (
    '20',
    '�޿���'
);

COMMIT;

CREATE TABLE DEPT_2 (
    ID    VARCHAR2(10) PRIMARY KEY,
    NAME  VARCHAR2(30)
);

INSERT INTO DEPT_2 VALUES (
    '10',
    '�ѹ���'
);

INSERT INTO DEPT_2 VALUES (
    '30',
    'IT��'
);

COMMIT;

----------------
SELECT * FROM DEPT;

SELECT * FROM DEPT_1;

SELECT * FROM DEPT_2;

---------- 
-- DEPT = DEPT_1
SELECT *
FROM DEPT D, DEPT_1 D1
WHERE D.ID = D1.ID;

SELECT *
FROM DEPT D, DEPT_2 D2
WHERE D.ID = D2.ID;

--------
--- DEPT���� �ְ�, DEPT_1���� ���� ������(�μ�) ��ȸ
-- LEFT OUTER JOIN : ���� ���̺� ����
------ DEPT������ ��ü ǥ���ϰ�, ����(DEPT_1)�� ������ NULLǥ��
SELECT *
FROM DEPT D, DEPT_1 D1
WHERE D.ID = D1.ID(+) -- ��������(�������� �ܺ�����)
AND D1.ID IS NULL
;

-- ǥ�� SQL
SELECT * 
FROM DEPT D LEFT OUTER JOIN DEPT_1 D1
ON D.ID = D1.ID
WHERE D1.ID IS NULL
;
-------------------
-- RIGHT OUTER JOIN : ���� ���̺� ����
SELECT * 
FROM DEPT_1 D1, DEPT D
WHERE D1.ID(+) = D.ID
AND D1.ID IS NULL
;

--- ǥ��SQL
SELECT *
FROM DEPT_1 D1
RIGHT OUTER JOIN DEPT D -- ���ι�� : ���� ���̺� ���� �ܺ�����
ON D1.ID = D.ID
WHERE D1.ID IS NULL
;

--------------------
-- FULL OUTER JOIN
SELECT * 
FROM DEPT_1 D1 FULL OUTER JOIN DEPT_2 D2
ON D1.ID = D2.ID
;

-------------------
--(�ǽ�) DEPT_1, DEPT_2 ���̺��� �̿��ؼ�
--1. DEPT_1���� �ְ�, DEPT_2 ���̺��� ���� ������ ã��(LEFT OUTER JOIN)
SELECT *
FROM DEPT_1 D1, DEPT_2 D2
WHERE D1.ID = D2.ID(+)
AND D2.ID IS NULL
;

--2. DEPT_1���� �ְ�, DEPT_2 ���̺��� ���� ������ ã��(RIGHT OUTER JOIN)
SELECT *
FROM DEPT_1 D1, DEPT_2 D2
WHERE D1.ID(+) = D2.ID
AND D1.ID IS NULL
;

