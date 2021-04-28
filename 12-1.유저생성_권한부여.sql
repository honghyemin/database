/* ********* ����� ����, ���� *********
-- ����� ���� : CREATE USER
CREATE USER ����ڸ�(������) --"MDGUEST" 
IDENTIFIED BY ��й�ȣ --"mdguest"  
DEFAULT TABLESPACE ���̺����̽� --"USERS"
TEMPORARY TABLESPACE �ӽ��۾����̺����̽� --"TEMP";

-- ����� �뷮 ����(����)
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";

-- ����� ���� : ALTER USER 
ALTER USER ����ڸ�(������) IDENTIFIED BY ��й�ȣ;

-- ���Ѻο�(�� ��� ���� �ο�, �� �ο�)
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;

-- ����� ���� : DROP USER
DROP USER ������ [CASCADE];
--CASCADE : ���������� �����(����)�� ������ ��� ����Ÿ ����
*************************************/
-- ( ������ ���� - SYSTEM ) ���� ���� ������ : MDGUEST, ��ȣ : mdguest
-- ���� ���� 
-- USER SQL
CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
-- ��(����, ROLES) �ο�
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;
-- ���� �ο�
GRANT CREATE VIEW TO "MDGUEST" ;
-- ���� ���� �뷮 ����
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";
--------------
-- (SYSTEM) CONNECT, RESOURCE ��(ROLE)�� �ִ� ���� Ȯ��
SELECT * 
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE IN ('CONNECT','RESOURCE')
 ORDER BY GRANTEE, privilege
;

-- 
GRANT CONNECT, RESOURCE TO MDGUEST; -- ��/���� �ο� ��ɹ�



--=============================
/****** ���� �ο�(GRANT), ���� ���(REVOKE) **********************
GRANT ���� [ON ��ü] TO {�����|ROLE|PUBLIC,.., n} [WITH GRANT OPTION]
--PUBLIC�� ��� ����ڿ��� ������ �ǹ�

GRANT ���� TO �����; --������ ����ڿ��� �ο�
GRANT ���� ON ��ü TO �����; -��ü�� ���� ������ ����ڿ��� �ο�
-->> WITH GRANT OPTION :��ü�� ���� ������ ����ڿ��� �ο� 
-- ������ ���� ����ڰ� �ٸ� ����ڿ��� ���Ѻο��� �Ǹ� ����
GRANT ���� ON ��ü TO ����� WITH GRANT OPTION;
--------------------
-->>>���� ���(REVOKE)
REVOKE ���� [ON ��ü] FROM {�����|ROLE|PUBLIC,.., n} CASCADE
--CASCADE�� ����ڰ� �ٸ� ����ڿ��� �ο��� ���ѱ��� ��ҽ�Ŵ
  (Ȯ�� �� ���� �� �۾�)

REVOKE ���� FROM �����; --������ ����ڿ��� �ο�
REVOKE ���� ON ��ü FROM �����; -��ü�� ���� ������ ����ڿ��� �ο�
*************************************************/
-- ���� �ο� �� Ȯ�� : madang ������ BOOK ���̺� ���� SELECT ������ MDGUEST���� �ο�.
-- (SYSTEM) ���� �ο� 
SELECT * FROM MADANG.BOOK; -- MADANG ������ BOOK���̺��� ���� ��ɹ�
GRANT SELECT ON MADANG.BOOK TO MDGUEST; -- ���� �ο�


-- (MDGUEST) ������ ��� ���� Ȯ��
SELECT * FROM MADANG.BOOK; -- ���� ������ ��ȸ
                           --> �ٸ������ :MADANG���� BOOK���̺��� �� �� ���� / HR ���� ������� ���̺��� ����
DELETE FROM MADANG.BOOK WHERE BOOKID =1; -- ���� �߻�(���Ѿ���)
SELECT * FROM MADANG.CUSTOMER; --> MADANG �������� CUSTOMER���̺��� ������ ������ �ο����� �������Ƿ� �� �� ����.
                               --> ���� ���� ����.

---- (SYSTEM) ���� ȸ�� 
REVOKE SELECT ON MADANG.BOOK FROM MDGUEST;
SELECT * FROM MADANG.BOOK; --> ������ ȸ���Ǿ����Ƿ� ��ȸ �Ұ���

----------------------
-- ( ������ MADANG ) ���� �ο�, ���� ȸ��(���)
GRANT SELECT ON BOOK TO MDGUEST;
REVOKE SELECT ON BOOK FROM MDGUEST;

-- WITH GRANT OPTIOIN : �ٸ� �������� ���� �ο��� �� �ֵ��� ���
-- (MADANG) ���� �ο�
GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST WITH GRANT OPTION;
-- ( MDGUEST ) HR��������  SELECT ���� �ο�
GRANT SELECT ON MADANG.CUSTOMER TO HR;

-- ( MADANG) ���� ȸ�� (���)
-- �ο��� ���� ��� ȸ�� ó�� - MDGUEST�� ���� �ο��� ���� ȸ�� ó��
REVOKE SELECT, UPDATE ON CUSTOMER FROM MDGUEST; -- ������϶��� ȸ���� �ȵ�.

-- (�����ڰ��� - SYSTEM) ���� ����
DROP USER MDGUEST CASCADE;

