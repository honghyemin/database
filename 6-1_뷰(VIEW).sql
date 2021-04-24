/* ************************
��(VIEW) : �ϳ� �Ǵ� �� �̻��� ���̺�� ����
   �������� �κ������� ���̺��� ��ó�� ����ϴ� ��ü(�������̺�)
--��(VIEW) ������
CREATE [OR REPLACE] VIEW ���̸� [(�÷���Ī1, �÷���Ī2, ..., �÷���Īn)]
AS
SELECT ����
[�ɼ�];

--�б����� �ɼ� : WITH READ ONLY

--��(VIEW) ����
DROP VIEW ���̸�;
***************************/
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';

-- ��(VIEW) �����
CREATE VIEW VW_BOOK
AS 
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%'
WITH READ ONLY; -- �б� ���� �� ����

-- �� ����ؼ� ������ �˻�
SELECT * FROM VW_BOOK
WHERE PUBLISHER = '�½�����';

SELECT * 
FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%') -- �ζ��� ��
WHERE PUBLISHER = '�½�����'; -- ���� ����� ����� ����.

-------------------------
-- ��(VIEW) ���� -> �÷� ��Ī(alias) ���
CREATE VIEW VW_BOOK2 
    (BID, BNAME, PUB, PRICE) -- �÷� ��Ī
AS
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
FROM BOOK
WHERE BOOKNAME LIKE '%�౸%';

--===========================
CREATE OR REPLACE VIEW VW_ORDERS
AS
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
        B.BOOKNAME, B.PUBLISHER, B.PRICE,
        C.NAME, C.PHONE, C.ADDRESS,
        O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
AND O.CUSTID = C.CUSTID
WITH READ ONLY
;

-- �並 ����Ͽ� ������ ��ȸ : ������, �迬�ư� ������ å ����, ���� �ݾ�, ���� ����
SELECT NAME, BOOKNAME, SALEPRICE, ORDERDATE
FROM VW_ORDERS
WHERE NAME IN ('������', '�迬��')
;

-- ��(VIEW)�� ������� �ʴ´ٸ�? -- ���ι� ���
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
AND O.CUSTID = C.CUSTID
AND NAME IN ('������', '�迬��')
;

-- ���� ���� ���� : SQL ����� �信 ��ϵ� SELECT������ �����
---> ���������� ����Ǵ� ���� ���̺���!
SELECT NAME, BOOKNAME, SALEPRICE, ORDERDATE
FROM (SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
        B.BOOKNAME, B.PUBLISHER, B.PRICE,
        C.NAME, C.PHONE, C.ADDRESS,
        O.SALEPRICE, O.ORDERDATE
        FROM ORDERS O, BOOK B, CUSTOMER C
        WHERE O.BOOKID = B.BOOKID
        AND O.CUSTID = C.CUSTID)
WHERE NAME IN ('������', '�迬��')
;

--============================
--(�ǽ�) �並 ����, ��ȸ, ����
--1. ����� - ���Ī : VW_ORD_ALL
---- �ֹ�(�Ǹ�)����, å����, ������ ��� ��ȸ�� �� �ִ� ���� �� 
CREATE OR REPLACE VIEW VW_ORD_ALL
AS
SELECT O.ORDERID, O.CUSTID, O.BOOKID, 
        B.BOOKNAME, B.PUBLISHER, B.PRICE,
        C.NAME, C.PHONE, C.ADDRESS,
        O.SALEPRICE, O.ORDERDATE
FROM ORDERS O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
AND O.CUSTID = C.CUSTID
WITH READ ONLY
;

--2. �̻�̵��� ������ å�� �Ǹŵ� å����, �Ǹűݾ�, �Ǹ��� ��ȸ
SELECT BOOKNAME, SALEPRICE, ORDERDATE, PUBLISHER
FROM VW_ORD_ALL
WHERE PUBLISHER = '�̻�̵��'
;

--3. �̻�̵��� ������ å �߿��� �߽ż�, ��̶��� ������ å ���� ��ȸ
---- ����׸� : ������ ����̸�, å����, ���ǻ�, ����(����), �ǸŰ�, �Ǹ�����
---- ���� : ������ ����̸�, �������� �ֱټ�
SELECT NAME, BOOKNAME,PUBLISHER, PRICE, SALEPRICE, ORDERDATE 
FROM VW_ORD_ALL
WHERE PUBLISHER = '�̻�̵��'
AND NAME IN ('�߽ż�', '��̶�')
ORDER BY NAME, ORDERDATE
;

--4. �Ǹŵ� å�� ���Ͽ� �����ں� �Ǽ�, �հ�ݾ�, ��ձݾ�, �ְ�, ������ ��ȸ
--(����) ����� : VW_ORD_ALL ���� ó��
SELECT NAME ,COUNT(*) "�Ǽ�", MAX(SALEPRICE) "�հ�ݾ�", TRUNC(AVG(SALEPRICE))"��ձݾ�",
        MAX(SALEPRICE) "�ְ�", MIN(SALEPRICE) "������"
FROM VW_ORD_ALL
WHERE CUSTID IS NOT NULL
GROUP BY NAME
ORDER BY NAME
;



--================================

-- FORCE : SELECT���� ���̺��� ��� �並 ������ ����
CREATE OR REPLACE FORCE VIEW VW_AAA
AS
SELECT ID, NAME, PHONE, FROM AAA;

