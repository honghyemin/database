/* **** ������ (SEQUENCE) ***
SEQUENCE : DB���� �����ϴ� �ڵ�ä�� ��ü
���� : CREATE SEQUENCE ��������;
����: DROP SEQUENCE ��������;

��������.NEXVAL : ������ ��ȣ(��) ����
��������.CURRVAL : ���� ������ �� Ȯ��(NAXVAL �ѹ� �̻� ���� ��)



*************/
CREATE SEQUENCE SEQUENCE1;

CREATE SEQUENCE  "MADANG"."SEQUENCE1"  
MINVALUE 1 MAXVALUE 9999999999999999999999999999 -- NUMBERŸ���� ������ �� �ִ� �ִ� ��
INCREMENT BY 1 -- 1�� ����
START WITH 1  -- ���� ���� 1
CACHE 20 -- �ӽ���������� �̸� 20���� ��������
NOORDER  NOCYCLE ; -- ��MAXVALUE���� �� ���� �ٽ� 1������ �ݺ�

------------------------------------
SELECT SEQUENCE1.NEXTVAL FROM DUAL; -- NEXTVAL : ���ο� ��ȣ ����
SELECT SEQUENCE1.CURRVAL FROM DUAL; -- CURRVAL : ���� ������ ��ȣ(������ ��ȣ)
------------------------
SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT MAX(BOOKID), NVL(MAX(BOOKID),0) +1 FROM BOOK;

-- BOOK ���̺� INSERT�۾�, BOOKID �ִ� + 1 ���
INSERT INTO BOOK
        (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES((SELECT NVL(MAX(BOOKID),0)+1 FROM BOOK),
        'MAX(BOOKID)+1', 'IT_BOOK', 20000);
        
SELECT * FROM BOOK ORDER BY BOOKID DESC;
---------------------------------
-- �������� ����ϴ� ���
CREATE SEQUENCE SEQ_BOOK
START WITH 50 -- ���۹�ȣ 50
INCREMENT BY 1 -- 1�� ����(DEFAULT���̹Ƿ� ���� ����)
NOCACHE; -- CACHE�� ����ϴ� ���� DEFAULT
---
SELECT SEQ_BOOK.NEXTVAL FROM DUAL;


SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT MAX(BOOKID), NVL(MAX(BOOKID),0) +1 FROM BOOK;

INSERT INTO BOOK
        (BOOKID, BOOKNAME, PUBLISHER, PRICE) -- �����Ҷ� ���� ������(��ȣ �����ϸ鼭)
VALUES(SEQ_BOOK.NEXTVAL, '���������', 'IT_BOOK', 25000);
        
SELECT * FROM BOOK ORDER BY BOOKID DESC;