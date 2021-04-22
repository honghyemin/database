/* UNION, UNION ALL : ������ ó��
-- UNION : �ߺ������͸� �����ϰ� �ϳ��� ǥ�����·� ������
-- UNION ALL : �ߺ������� �����ؼ� ������
��, ��ȸ�ϴ� �÷��� �̸�, ����, ����, Ÿ���� ��ġ�ϵ��� �ۼ�
*******************************/

-- UNION ��� ����
SELECT CUSTID, NAME FROM CUSTOMER
WHERE CUSTID IN (1, 2, 3);

SELECT CUSTID, NAME FROM CUSTOMER 
WHERE CUSTID IN (3, 4, 5);

-- UNION���� ���ϱ�(�ߺ������� �ϳ��� ǥ��)
SELECT CUSTID, NAME FROM CUSTOMER
WHERE CUSTID IN (1, 2, 3)
UNION
SELECT CUSTID, NAME FROM CUSTOMER 
WHERE CUSTID IN (3, 4, 5);

-- UNION ALL���� ���ϱ�(�ߺ������� ��� ǥ��(���))
SELECT CUSTID, NAME FROM CUSTOMER
WHERE CUSTID IN (1, 2, 3)
UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER 
WHERE CUSTID IN (3, 4, 5)
ORDER BY NAME; -- ORDER BY ���� �� �������� ���.

------------------------------------
-- MINUS : ������ ( ���� ����) -> �ߺ������� ����
SELECT CUSTID, NAME FROM CUSTOMER
WHERE CUSTID IN (1, 2, 3)
MINUS
SELECT CUSTID, NAME FROM CUSTOMER 
WHERE CUSTID IN (3, 4, 5);

---------------------------------------
-- INTERSECT : ������ -> �ߺ��� �����͸� ����(��ȸ)
---> ���ι��� ����� ����� ����
SELECT CUSTID, NAME FROM CUSTOMER
WHERE CUSTID IN (1, 2, 3)
INTERSECT
SELECT CUSTID, NAME FROM CUSTOMER 
WHERE CUSTID IN (3, 4, 5);
--- ���ι�(JOIN��)
SELECT * 
FROM (SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (1, 2, 3)) A,
    (SELECT CUSTID, NAME FROM CUSTOMER WHERE CUSTID IN (3, 4, 5)) B
WHERE A.CUSTID = B.CUSTID
;







