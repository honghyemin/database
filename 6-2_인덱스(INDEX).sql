/* *********************************
<�ε��� - INDEX>
���̺� �ִ� ������(�ο�, ���ڵ�)�� ������ ã�� ���� ������� ������ ����
- �ڵ��ε��� : PRIMARY KEY ����� �Ǵ� UNIQUE �������� ������ �����Ǵ� �ε���
- �����ε��� : CREATE INDEX ��ɹ��� ����ؼ� ����� �ε���

<�ε��� ������ �������>
-�ε����� WHERE���� ���� ���Ǵ� �÷��� ����
-�������ǿ� ���� ���Ǵ� �÷��� ����
-�÷��� ������ �������� ���� �� ȿ�� ����(10~15%)
-���� ���̺� �ε����� �ʹ� ���Ƶ� �ӵ� ���� ���� �߻�(���̺�� 4~5����)
-�÷��� �����Ͱ� ����(�Է�,����,����)�Ǵ� ��찡 ������ �ε��� ��뷮 ����
--(������ �Է�, ����, ������ �ε����� ���� �Է�, ����, ���� �۾� �߻�)

<�ε��� ���� ����>
CREATE INDEX �ε����� ON ���̺�� (�÷���1[, �÷���2, ..., �÷���n]);
CREATE [UNIQUE] INDEX ON ���̺�� (�÷���1 [ASC|DESC], �÷���2, .., �÷���n);

<�ε��� ���� ����>
ALTER [UNIQUE] INDEX �ε����� ON ���̺�� (�÷���1[, �÷���2, ..., �÷���n]);

<�ε��� ���� ����>
DROP INDEX �ε�����;

<�ε��� �籸�� ����>
ALTER INDEX �ε����� REBUILD;
ALTER [UNIQUE] INDEX �ε����� [ON ���̺�� (�÷���, ...)] REBUILD;
************************************/

-- �ε��� ���� : BOOK ���̺��� ���ǻ� (PUBLISHER) �÷��� IX BOOK �ε��� �����
CREATE INDEX IX_BOOK ON BOOK(PUBLISHER);
SELECT * FROM BOOK WHERE PUBLISHER = '�½�����';
SELECT PUBLISHER, BOOKID FROM BOOK ORDER BY PUBLISHER;
SELECT * FROM BOOK WHERE BOOKNAME = '�౸�� ����';

-- �ε��� ���� : 2�� �÷� ����
-- BOOK ���̺��� PUBLISHER, PRICE �÷��� ������� IX_BOOK2 �ε��� ����
CREATE INDEX IX_BOOK2 ON BOOK (PUBLISHER, PRICE);
SELECT PUBLISHER, PRICE FROM BOOK ORDER BY PUBLISHER, PRICE; 
-->> PRICE�� ��ü�� ���� ���� ���� ������ �� ���� �ƴϴ�. ������ ���ǻ� ��(ù��° ������)������ ���ĵ�.

SELECT * FROM BOOK WHERE PUBLISHER = '���ѹ̵��';
SELECT * FROM BOOK WHERE PRICE >10000;

-- WHERE ������ PUBLISHER, PRICE ���� ��� �� IX_BOOK2 �ε����� ����� �����
SELECT * FROM BOOK WHERE PUBLISHER = '�½�����' AND PRICE = 7000;
-->> �½����� ������ ���ݿ� �´� ���� ã���Ƿ� ����� ã�ԵǸ� �����. �ӵ��鿡�� ����.
SELECT * FROM BOOK WHERE PRICE=7000 AND PUBLISHER = '�½�����';

-- �ε����� �ִµ� ����� �ȵǴ� ���
SELECT * FROM BOOK WHERE PUBLISHER LIKE '����%'; -- �ε��� ��� (�����˻�)
SELECT * FROM BOOK WHERE PUBLISHER LIKE '%����%'; -- �ε��� ����X (FULL SCAN, ��ü��)
SELECT * FROM BOOK WHERE PUBLISHER LIKE '%�̵��'; -- �ε��� ����X (FULL SCAN, ��ü��)


-- ���� �����͸� ����(����)�ϴ� ��� ( �ε��� ���� �ȵ� )
SELECT * FROM BOOK WHERE SUBSTR(PUBLISHER, 1, 2) = '����';

-- �ε��� ����
DROP INDEX IX_BOOK2;


--======================================
/* *** �ε��� �ǽ� ****************************
���缭�� �����ͺ��̽����� ���� SQL ���� �����ϰ� 
�����ͺ��̽��� �ε����� ����ϴ� ������ Ȯ���Ͻÿ�.
(1) ���� SQL ���� �����غ���.
	SELECT name FROM Customer WHERE name LIKE '�ڼ���';
(2) ���� ��ȹ�� ���캻��. ���� ��ȹ�� [F10]Ű�� ���� �� 
    [��ȹ ����]���� �����ϸ� ǥ�õȴ�.
(3) Customer ���̺� name���� �ε���(ix_customber_name)�� �����Ͻÿ�. 
    ���� �� (1)���� ���Ǹ� �ٽ� �����ϰ� ���� ��ȹ�� ���캸�ÿ�.
(4) ���� ���ǿ� ���� �� ���� ���� ��ȹ�� ���غ��ÿ�.
(5) (3)������ ������ �ε����� �����Ͻÿ�.
******************************************/
SELECT NAME FROM CUSTOMER WHERE NAME LIKE '�ڼ���';

CREATE INDEX IX_COSTOMER_NAME ON CUSTOMER(NAME);

SELECT NAME FROM CUSTOMER WHERE NAME LIKE '�ڼ���';
SELECT * FROM CUSTOMER WHERE NAME = '�ڼ���';


DROP INDEX IX_COSTOMER_NAME;





