/* *************************
SELECT [* | DISTINCT] {�÷���, �÷���, ...}
  FROM ���̺��
[WHERE ������]
[GROUP BY {�÷���, ....}
    [HAVING ����] ] --GROUP BY ���� ���� ����
[ORDER BY {�÷��� [ASC | DESC], ....}] --ASC : ��������(�⺻/��������)
                                      --DESC : ��������
***************************/

-- GROUP BY : �����͸� �׷����ؼ� ó���� ��� ���
/* GROUP BY ���� ����ϸ� SELECT �׸��� GROUP BY ���� ���� �÷� �Ǵ�
�׷��Լ�(COUNT, SUM, AVG, MAX, MIN)�� ����� �� �ִ�.    */

--============================================
-- ���� ������ ���űݾ��� �հ踦 ���Ͻÿ�
SELECT CUSTID, SUM(SALEPRICE)
FROM ORDERS
GROUP BY CUSTID
;

---- 
SELECT C.NAME, SUM(SALEPRICE)
  FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID --��������
GROUP BY C.NAME
-- ORDER BY SUM(SALEPRICE) -- ���űݾ� �հ� ��
ORDER BY 2 -- SELECT���� �÷��� ���� ������ ���� ����
;  

-- �ֹ�(�Ǹ�) ���̺��� ���� ������ ��ȸ(�Ǽ�, �հ�, ���, �ִ�, �ּ�)
SELECT C.CUSTID, C.NAME, COUNT(*), SUM(SALEPRICE), 
        TRUNC(AVG(SALEPRICE)), 
        MAX(SALEPRICE), MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.CUSTID, C.NAME
;

-- �߽ż�, ������ ���� ������ ��ȸ(�Ǽ�, �հ�, ���, �ִ�, �ּ�)
SELECT C.NAME, COUNT(*), SUM(SALEPRICE), 
        TRUNC(AVG(SALEPRICE)), 
        MAX(SALEPRICE), MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND C.NAME IN ('�߽ż�', '������')
GROUP BY C.NAME
;


----(�ǽ�) ���� �������� ���� ������ ��ȸ ( �Ǽ�, �հ�,���,�ִ�,�ּ�)
-------�߽ż�, ��̶� ��2�� ��ȸ
SELECT C.NAME, 
        COUNT(*) AS CNT,
        SUM(SALEPRICE) SUM_PRICE,
        TRUNC(AVG(SALEPRICE)) AVG_PRICE,
        MAX(SALEPRICE),
        MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
AND NAME IN ('�߽ż�','��̶�')
GROUP BY C.NAME
;

------ǥ�� SQL���
SELECT C.NAME, 
        COUNT(*) AS CNT,
        SUM(SALEPRICE) SUM_PRICE,
        TRUNC(AVG(SALEPRICE)) AVG_PRICE,
        MAX(SALEPRICE) MAX_PRICE,
        MIN(SALEPRICE) MIM_PRICE
FROM CUSTOMER C INNER JOIN ORDERS O
ON C.CUSTID = O.CUSTID
WHERE C.NAME IN('�߽ż�','��̶�')
GROUP BY C.NAME
;


-----------------------------------
--HAVING ��: GROUP BY ���� ���� ������� �����Ϳ��� �˻� ���� �ο�
--HAVING ���� �ܵ����� ����� �� ����, GROUP BY ���� �Բ� ���Ǿ�� ��

--------------------------------------

-- 3�� �̻� ������ �� ��ȸ
SELECT C.NAME, COUNT(*) AS CNT
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING COUNT(*) >=3 -- �׷��ε� �����Ϳ��� ���ϴ� ������ �˻�(���� �ο�)
;

-----------
-- ������ å �߿��� 20000�� �̻��� å�� ������ ����� ��� ������
----- (�Ǽ�, �հ�, ���, �ִ�, �ּ�)
SELECT C.NAME,
        COUNT(*),
        SUM(SALEPRICE), TRUNC(AVG(SALEPRICE)),
        MAX(SALEPRICE), MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID=O.CUSTID
GROUP BY C.NAME
HAVING MAX(SALEPRICE) >= 20000 -- ��赥���� ���� �� 2���� �̻��� å �����̷� �ִ� ���
;
------------------------------
-- *���� : WHERE ���� ���Ǵ� ã�� ���� ( ���̺� ������ ���� )
--------- HAVING ������ ���Ǵ� ������ �׷��� �� ������ �������� �˻�
--------- ( ������� �ٸ��� ó���ǹǷ� ã�������Ͱ� �������� ��Ȯ�� �ϴ� ���� �߿�)
------------------------------
SELECT C.NAME,
        COUNT(*),
        SUM(SALEPRICE), TRUNC(AVG(SALEPRICE)),
        MAX(SALEPRICE), MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID=O.CUSTID
AND O.SALEPRICE >=20000 -- 2���� �̻��� å�� �������
GROUP BY C.NAME
;

--=======================
-- (�ǽ�) �ʿ�� ���ΰ� GROUP BY, HAVING ������ ����ؼ� ó��
-- 1. ���� �ֹ��� ������ �� �Ǹ� �Ǽ�, �Ǹž�, ��հ�, �ְ�, ������ ���ϱ�
SELECT  COUNT(*) AS TOTAL_COUNT,
        SUM(SALEPRICE) AS "�Ǹž� �հ�", -- �ѱ��� �� ���� ������ �ǵ��� X
        TRUNC(AVG(SALEPRICE)) ��հ�AVG,
        MAX(SALEPRICE) "�ְ�(MAX)",
        MIN(SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
;

-- 2. �� ���� �ֹ��� ������ �� ����, �� �Ǹž� ���ϱ�
SELECT C.NAME, COUNT(*), SUM(SALEPRICE) AS SUM_PRICE
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
-- ORDER BY C.NAME
-- ORDER BY SUM(O.SALEPRICE) DESC -- ����� �׷� �Լ��� ����
-- ORDER BY 3 DESC -- �÷� ��ġ������ ����
ORDER BY SUM_PRICE DESC -- �÷� ��Ī(alias)���� ����
;


-- 3. ���� �̸��� ���� �ֹ��� ������ �Ǹ� ������ �˻�
SELECT C.NAME, O.SALEPRICE,  B.BOOKNAME, B.PRICE
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.CUSTID = O.CUSTID
AND O.BOOKID = B.BOOKID
;



-- 4. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, �������� ����
SELECT C.NAME, SUM(SALEPRICE)
FROM CUSTOMER C,ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
ORDER BY C.NAME
;

-- 5. ������ �ֹ��� �Ǽ�, �հ� �ݾ�, ��� �ݾ��� ���ϱ� (3�Ǻ��� ���� ������ ���)
SELECT C.NAME, COUNT(*), SUM(SALEPRICE), 
        TRUNC(AVG(SALEPRICE))
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
HAVING COUNT(*) < 3
;

-- (����) �� �� �� �ǵ� ���� �� �� ����� ����?
--SELECT C.NAME
--FROM CUSTOMER C, ORDERS O
--WHERE O.CUSTID NOT IN C.CUSTID
--;







