-- PS/SQL ���ν��� (PROCEDURE )
SET SERVEROUTPUT ON; -- ��°�� �� �� �ְ� ����

--=============================
-- PROCEDURE
BEGIN
    DBMS_OUTPUT.PUT_LINE('�׽�Ʈ~');
END;
--------------------------

DECLARE -- ���� �����
    V_EMPID NUMBER; -- ���α׷����� ����� ���� ����
    V_NAME VARCHAR2(30);
BEGIN   -- ���๮ ���� (�ڹٿ����� �߰�ȣ{} ����)
    V_EMPID := 100; -- ġȯ��(���Թ�) ��ȣ :=
    V_NAME := 'ȫ�浿';
    DBMS_OUTPUT.PUT_LINE('V_EMPID :' || V_EMPID); -- (�ڹٿ����� System.out.println();�� ���� �뵵)
    DBMS_OUTPUT.PUT_LINE('V_NAME :' || V_NAME);
END;    -- ���๮ ��

------------------------------
-- BOOK ���̺� ������ �� 1���� �����ؼ� ȭ�� ���
DECLARE
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    -- SELECT ~ INTO ~ FROM ���·� DB������ �����ϰ� INTO���� ������ ���� => PL/SQL�� ����
    -- �� �� �� 1���� �����͸� ó�� ����
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE 
      INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE 
    FROM BOOK WHERE BOOKID = 1;
    
    DBMS_OUTPUT.PUT_LINE(V_BOOKID || ',' ||V_BOOKNAME ||','||
                            V_PUBLISHER||','||V_PRICE);

END;

--========================================
/* �������ν��� ( Stroed PROCEDURE ) 
-- DBMS�� �����س���ȣ���ؼ� ����ϴ� ����

�Ű����� (�Ķ����,PARAMETER ) ����
- IN : �Է��� �ޱ⸸ �ϴ� ����(�⺻��-���� ����)
- OUT : ��¸� �ϴ� ���� 
        ( ���� ���� ���� ����, ���ν��� ���� �� ȣ���� ������ ������ ���� �� ����)
- IN OUT : �Էµ� �ް�, ���� ������ ���� ����(���)ó���� �Ѵ�.

*******************************/
CREATE OR REPLACE PROCEDURE BOOK_DISP -- ���ν��� �����
( -- �Ű����� �ۼ� ����
    IN_BOOKID IN NUMBER
) 
AS  -- ���� ����� ( AS (�Ǵ� IS ��� ����) ~ BEGIN�� ����)
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE 
      INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE 
    FROM BOOK WHERE BOOKID = IN_BOOKID;
    
    DBMS_OUTPUT.PUT_LINE(V_BOOKID || ',' ||V_BOOKNAME ||','||
                            V_PUBLISHER||','||V_PRICE);
END;

---------------------------
-- ���ν��� ���� : EXCUTE ���ν�����
EXECUTE BOOK_DISP(1);
EXEC BOOK_DISP(2);

-- ���ν��� ����
DROP PROCEDURE BOOK_DISP;

--============================
-- ���ν��� �Ķ���� ���� : IN, OUT
create or replace PROCEDURE GET_BOOKINFO (
    IN_BOOKID IN NUMBER, -- �Ű����� ����� Ÿ�Ը� ����
    OUT_BOOKNAME OUT VARCHAR2,
    OUT_PUBLISHER OUT VARCHAR2,
    OUT_PRICE OUT NUMBER
) AS
    -- %TYPE ��� : ���̺��.�÷���%TYPE
    -- ���̺� �÷��� ������ Ÿ������ ����(����ÿ��� �ڵ� ����)
    -- ex) BOOK���̺��� ���̺� �÷��� ���� �� ��� ���������� �ٷ� �����.
    -- ex) V_BOOKID NUMBER(2) �� ��� 3�ڸ����� �־�� �� ��Ȳ�� ���� ���� ��
    V_BOOKID BOOK.BOOKID%TYPE; -- �̷��� ����ϸ� ���� �� ? : ���������� Ÿ��
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
    V_PUBLISHER BOOK.PUBLISHER%TYPE;
    V_PRICE BOOK.PRICE%TYPE;

BEGIN
    -- IN, OUT �Ű������� ���
    DBMS_OUTPUT.PUT_LINE('�Ű�������: '||IN_BOOKID||','||OUT_BOOKNAME||','||
                        OUT_PUBLISHER||','||OUT_PRICE);
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE 
    INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE 
    FROM BOOK WHERE BOOKID = IN_BOOKID;
    
    -- �����͸� ȣ���� ������ �����ϱ� ���ؼ� OUT ������ �Ű������� ����
    OUT_BOOKNAME := V_BOOKNAME;
    OUT_PUBLISHER := V_PUBLISHER;
    OUT_PRICE := V_PRICE;
    DBMS_OUTPUT.PUT_LINE('�Ű�������: '||IN_BOOKID||','||OUT_BOOKNAME||','||
                        OUT_PUBLISHER||','||OUT_PRICE);
    
    DBMS_OUTPUT.PUT_LINE(V_BOOKID || ',' ||V_BOOKNAME ||','||
                            V_PUBLISHER||','||V_PRICE);

END;


--=========================================
-- ���ν��� OUT �Ű����� �� Ȯ�ο� ���ν���
CREATE OR REPLACE PROCEDURE GET_BOOKINFO_TEST (
  IN_BOOKID IN NUMBER 
) AS 
    V_BOOKNAME book.bookname%TYPE;
    V_PUBLISHER book.publisher%TYPE;
    V_PRICE book.price%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('>>GET_BOOKINFO_TEST - '|| IN_BOOKID);
    
    --GET_BOOKINFO ���ν��� ȣ��(����)
    GET_BOOKINFO(IN_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE);
    
    --GET_BOOKINFO ���ν����� ���� ���޹��� �� Ȯ��(ȭ�� ���)
    DBMS_OUTPUT.PUT_LINE('>>GET_BOOKINFO OUT�� - '|| IN_BOOKID
        ||'/'|| V_BOOKNAME ||'/'|| V_PUBLISHER ||'/'|| V_PRICE);
    
END GET_BOOKINFO_TEST;
---==========================================

/* ( �ǽ� ) ���ν��� �ۼ��ϰ� �����ϱ�
�����̺�(CUSTOMER)�� �ִ� ������ ��ȸ ���ν��� �ۼ�
- ���ν����� : GET_CUSTINFO
- �Է¹޴� �� : ��ID
- ó�� : �Է¹��� �� ID�� �ش��ϴ� �����͸� ã�Ƽ� ȭ�鿡 ���
- ����׸� : ��ID, ����, �ּ�, ��ȭ��ȣ
******************************/
CREATE OR REPLACE PROCEDURE GET_CUSTINFO (
    IN_CUSTID IN NUMBER,
    OUT_NAME OUT VARCHAR2,
    OUT_ADDRESS OUT VARCHAR2,
    OUT_PHONE OUT VARCHAR2
)
AS 
    V_CUSTID CUSTOMER.CUSTID%TYPE;
    V_NAME CUSTOMER.NAME%TYPE;
    V_ADDRESS CUSTOMER.ADDRESS%TYPE;
    V_PHONE CUSTOMER.PHONE%TYPE;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('�Ű����� �� : '||IN_CUSTID||','||
                    OUT_NAME||','||OUT_ADDRESS||','||OUT_PHONE);
    SELECT CUSTID, NAME, ADDRESS, PHONE
    INTO V_CUSTID, V_NAME, V_ADDRESS, V_PHONE
    FROM CUSTOMER WHERE CUSTID = IN_CUSTID;
    
    OUT_NAME := V_NAME;
    OUT_ADDRESS := V_ADDRESS;
    OUT_PHONE := V_PHONE;
    DBMS_OUTPUT.PUT_LINE('�Ű�������: '||IN_CUSTID||','||OUT_NAME||','||
                        OUT_ADDRESS||','||OUT_PHONE);
    
    DBMS_OUTPUT.PUT_LINE(V_CUSTID || ',' ||V_NAME ||','||
                            V_ADDRESS||','||V_PHONE);
    
END;

EXECUTE GET_CUSTINFO(2);
--------------------------------------------------

CREATE OR REPLACE PROCEDURE GET_CUSTINFO1 (
    IN_CUSTID IN NUMBER
) AS
    V_CUSTID CUSTOMER.CUSTID%TYPE;
    V_NAME CUSTOMER.NAME%TYPE;
    V_ADDRESS CUSTOMER.ADDRESS%TYPE;
    V_PHONE CUSTOMER.PHONE%TYPE;
BEGIN
    SELECT CUSTID, NAME, ADDRESS,PHONE
    INTO V_CUSTID, V_NAME, V_ADDRESS, V_PHONE
    FROM CUSTOMER
    WHERE CUSTID = IN_CUSTID;
    
    DBMS_OUTPUT.PUT_LINE('>> ��� : '||V_CUSTID||','|| V_NAME||','|| V_ADDRESS||'.'|| V_PHONE);
END;
    

