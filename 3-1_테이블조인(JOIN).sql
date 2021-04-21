-- �������� ������ å�� �հ�ݾ�
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID : 1

-- ���� ���� Ȯ��
SELECT * FROM ORDERS WHERE CUSTID =1;

-- ��������(SUB QUERY) ��� : ���� ���� �� �ٸ� ������ ����
SELECT * FROM ORDERS 
-- ' =(equal) ' ��ȣ�� ��� �� ���� �� �ϳ��� �����͸� �;� ��.
WHERE CUSTID =(SELECT CUSTID FROM CUSTOMER WHERE NAME = '������');
----------------------

-- ���̺� ����(JOIN) ���
SELECT * FROM CUSTOMER WHERE CUSTID =1;
SELECT * FROM ORDERS WHERE CUSTID =1;

-- ���� ���̺��� CUSTID�� ���� �͵� ���
-- CUSTOMER, ORDERS ���̺� �����͸� ���� ��ȸ
SELECT * FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID -- �ΰ� ���̺��� ������ �� ����� ���� ����
AND CUSTOMER.NAME = '������'; -- ã�� ����(WHERE) / ����Ÿ�� �ɷ���

-- ���̺� ��Ī ������� �����ϰ� ǥ���ϰ� ���
-- WHERE�� �������� ��� - ����Ŭ ��� ���
-- SELECT�������� ������ �÷��� �ߺ����� �� �� ����. -> ��Ī�� ���ִ��� �ؾ� ��.
SELECT * FROM CUSTOMER C, ORDERS O -- �÷��� ���� ��Ī�� ����, ��Ī�� ���� �Ǹ� �� �Ŀ��� ���̺���� ������ ���� �ȵ�.
WHERE C.CUSTID = O.CUSTID -- �ΰ� ���̺��� ������ �� ����� ���� ����
AND C.NAME = '������'; -- ã�� ����(WHERE) / ����Ÿ�� �ɷ���


-- ANSI ǥ�� ���� ���� (��� DB���� ���� ����)
SELECT *
FROM CUSTOMER C INNER JOIN ORDERS O -- ���� ��� ����
    ON C.CUSTID = O.CUSTID -- ���� ���� ����
WHERE C.NAME = '������'; -- �˻� ����

--=====================
-- �������� ������ å�� �հ� �ݾ�
SELECT SUM(O.SALEPRICE) AS SUM --> ������ å�� �հ� �ݾ� ��ȸ / �÷����� ��Ī : AS ��Ī
-- SELECT * -> ��ü ������ ��ȸ�Ҷ� 
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID -- ���� ������ å�鸸 ����ϰ� ��.
    AND C.NAME = '������' -- �������� ���� ������ å�鸸 �˻�
;


-- ���ε� �����Ϳ��� �÷� ��ȸ�� : ���̺��(��Ī).�÷��� ���·� ���
SELECT C.CUSTID -- ���� ���̺� ���� �÷��� �����ϴ� ��� ��ġ ���� �ʼ�
    ,C.NAME, C.ADDRESS
    , O.CUSTID AS ORD_CUSTID -- ��ȸ�� �÷��� �ߺ� �� ��Ī���� �ٸ��� ����
    , O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O -- ������ ���̺�
WHERE C.CUSTID = O.CUSTID -- ���� ����
AND C.NAME = '������' -- �˻� ����
;


--------------------------
SELECT * FROM BOOK;
SELECT * FROM ORDERS;
-- ������ å �� �Ǹŵ� å ��� ( �̵��� ������ ���ǻ�)
SELECT *
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID -- ���� ����
-- AND PUBLISHER LIKE '%�̵��'
-- AND PUBLISHER = '�½�����'
ORDER BY B.PUBLISHER, B.BOOKNAME
;

--======================
-- ( �ǽ� ) ���̺� ������ ���� ������ ã��.
-- 1. '�߱��� ��Ź��'��� å�� �ȸ� ���� Ȯ��( å ����, �Ǹ� �ݾ�, �Ǹ�����)
SELECT B.BOOKNAME, B.PRICE, O.ORDERDATE 
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID
AND B.BOOKNAME = '�߱��� ��Ź��' 
;
-- ANSI ǥ�� ���� ����
SELECT B.BOOKNAME, B.PRICE, O.ORDERDATE
FROM BOOK B INNER JOIN ORDERS O -- ���� ��� ����
    ON B.BOOKID = O.BOOKID -- ���� ���� ����
WHERE B.BOOKNAME= '�߱��� ��Ź��' -- �˻�����
;

-- 2. '�߱��� ��Ź��'��� å�� �� ���� �ȷȴ��� Ȯ��
SELECT COUNT(*) AS CNT
FROM BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID
AND B.BOOKNAME ='�߱��� ��Ź��'
;
-- ANSI ǥ�� ���� ����
SELECT COUNT(*) AS CNT
FROM BOOK B INNER JOIN ORDERS O
    ON B.BOOKID = O.BOOKID
WHERE B.BOOKNAME='�߱��� ��Ź��';

-------
-- 3. '�߽ż�'�� ������ å ���� �������ڸ� Ȯ��(å��, ��������)
SELECT O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND C.NAME = '�߽ż�';

-- ANSI ǥ�� ���� ����
SELECT O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID
WHERE C.NAME = '�߽ż�';


-- 4. '�߽ż�'�� ������ �հ� �ݾ� Ȯ��
SELECT '�߽ż�' AS CUST_NAME, SUM(O.SALEPRICE) SUM_PRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND C.NAME = '�߽ż�';

-- ANSI ǥ�� ���� ����
SELECT SUM(O.SALEPRICE)
FROM CUSTOMER C INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID
WHERE C.NAME = '�߽ż�';


-- 5. '������, �߽ż�'�� ������ ������ Ȯ�� ( �̸�, �Ǹűݾ�, �Ǹ�����)
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND C.NAME IN ('�߽ż�', '������');
-- AND (C.NAME = '������' OR C.NAME ='�߽ż�'); /2��° ���

-- ANSI ǥ�� ���� ����
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID
WHERE C.NAME IN ('�߽ż�','������');




