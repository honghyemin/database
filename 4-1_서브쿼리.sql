-- �������� ( �μ�����, SUB QUERY )
-- SQL�� ( SELECT, INSERT, UPDATE, DELETE) ���� �ִ� ������
--------------------------------

-- �������� ������ ������ �˻�
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMER WHERE NAME = '������'; -- CUSTID : 1
SELECT * FROM ORDERS 
WHERE CUSTID = 1;
----------------------
-- �������� ���
SELECT * FROM ORDERS 
WHERE CUSTID = (SELECT * FROM CUSTOMER WHERE NAME = '������');
-- > ���������� ���� ������ �ǰ� �� ���� ���ο� �ִ� ������ �̸� ������ �����

-- ���ι����� ó��
SELECT *
FROM ORDERS O, CUSTOMER C
WHERE O.CUSTID = C.CUSTID
AND C.NAME = '������'
;

---------------------
-- WHERE ������ �������� ��� �� ��ȸ����� 2�� �̻��� ��� IN ���
-- ( EQUAL��ȣ(=)�� ������ 1���϶��� )
-- ������, �迬�� ���Գ���( �������� )
SELECT * FROM ORDERS
--WHERE CUSTID = (SELECT CUSTID
--                FROM CUSTOMER WHERE NAME IN ('������', '�迬��')) -- �����߻�(������ 2���̻�)
WHERE CUSTID IN (SELECT CUSTID
                FROM CUSTOMER WHERE NAME IN ('������', '�迬��')) -- �����߻�(������ 2���̻�)
;

----------------
-- å �� ������ ���� ��� ������ �̸��� ���Ͻÿ�
SELECT MAX(PRICE) FROM BOOK; -- ���� ��� å
SELECT * FROM BOOK WHERE PRICE = 35000;
---- ���� ������ ���������� ���� ��ħ
SELECT * FROM BOOK
WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);

----------------------
-- ���������� FROM���� ����ϴ� ���
SELECT *
FROM BOOK B, 
    (SELECT MAX(PRICE) MAX_PRICE FROM BOOK)M
WHERE B.PRICE = M.MAX_PRICE
;

-----------------------------
-- ������, �迬�� ���� ���� ( �������� )
SELECT *
FROM ORDERS O, 
    (SELECT * FROM CUSTOMER WHERE NAME IN ('������', '�迬��')) C 
    -- �� ���� �������� ������(CUSTOMER�� ��� ������ �������� ���� �ƴ�
WHERE O.CUSTID = C.CUSTID
;

-- SELECT ���� �������� ��� ��
-- �߰��� �̸�, å������ ������ ���ھ�� ��
-- => ��� �������� 
SELECT * FROM ORDERS;
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
        (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME, -- �ܺο� �ִ� ���̺� �����Ͱ� ��� ��
        (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME,
        O.SALEPRICE, O.ORDERDATE
FROM ORDERS O
;

--------------------
-- �������� ������ å ��� ( å ���� )
-- å�� ã��� ã�µ� ������ ������ �־�� ��
-- ������������� �ƴ϶� ������������ ����
-- ���������� �а� �ؼ��� �� �� ���� SQL���� ����ż� �߰�-> �ٱ������� ������
SELECT * 
FROM BOOK
WHERE BOOKID IN (SELECT BOOKID 
                    FROM ORDERS 
                    WHERE CUSTID IN (SELECT CUSTID 
                                    FROM CUSTOMER
                                    WHERE NAME = '������'))
                                    -- �� �������� ���������� ���� ������
;

---------------------------
-- ( �ǽ� ) �������� �̿� ( ��������, ���ι� )
-- 1. �� ���̶� ������ ������ �ִ� ���
SELECT *
FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS)
;
----- ( �Ǵ� �ѹ��� �������� ���� ��� )
SELECT *
FROM CUSTOMER
WHERE CUSTID NOT IN (SELECT DISTINCT CUSTID FROM ORDERS)
;

-- JOIN�� ��� : �� ���� �������� ���� ���
SELECT C.* -- C���̺��� VALUE���� ��ȸ
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID(+)
AND O.ORDERID IS NULL
;


-- 2. 2���� �̻� �Ǵ� å�� ������ �� ��� ��ȸ
-- (���_1)_JOIN�� ���
SELECT *
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND O.SALEPRICE >= 20000
;

-- (���_2)
SELECT *
FROM CUSTOMER 
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS WHERE SALEPRICE>=20000)
;


-- 3. '���ѹ̵��' ���ǻ��� å�� ������ �� �̸� ��ȸ
-- (���_1)
SELECT *
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND B.BOOKID = O.BOOKID
AND B.PUBLISHER = '���ѹ̵��'
;

-- (���_2)
SELECT *
FROM CUSTOMER 
WHERE CUSTID IN (SELECT CUSTID
                FROM ORDERS
                WHERE BOOKID IN (SELECT BOOKID
                                FROM BOOK
                                WHERE PUBLISHER = '���ѹ̵��'))
;

-- (���_3)_JOIN�� ���
SELECT C.*, B.BOOKNAME, B.PUBLISHER, O.SALEPRICE, O.ORDERDATE
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND B.BOOKID = O.BOOKID
AND B.PUBLISHER = '���ѹ̵��'
;


-- 4. ��ü å ���� ��պ��� ��� å�� ��� ��ȸ
-- (���_1)
SELECT *
FROM BOOK 
WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK ) -- ��� 14450��
ORDER BY PRICE
;

-- ( ���_2)_JOIN�� ���
SELECT * 
FROM BOOK B, 
        (SELECT AVG(PRICE) AVG_PRICE FROM BOOK) AVG
WHERE PRICE > AVG_PRICE
;


-----------------------------











