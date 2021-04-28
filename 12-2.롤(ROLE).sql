/* ********* ����(�� ROLE) ***********
����(��, ROLE) : DB ��ü �� �ý��ۿ� ���� ������ ��Ƶ� ������ �ǹ�
���� ���� : CREATE ROLE �����̸�
���� ���� : DROP ROLE �����̸�
���ҿ� ���� �ο� : GRANT ���� [ON ��ü] TO �����̸�
������ ���� ȸ�� : REVOKE ���� [ON ��ü] FROM �����̸�
����ڿ��� ���� �ο� : GRANT �����̸� TO �����

<���� �������� ����� �߰������� �ܰ�>
CREATE ROLE - ���һ���
GRANT - ������� ���ҿ� ���� �ο�
GRANT - ����ڿ��� ���� �ο�
-->>���� ������ ��� �ݴ�� ����
DROP ROLE - ���� ����(����ڿ��� �ο��� ���ҿ� ���� ���� ���� ���ŵ�)
***************************************/
-- (DBA ���� - SYSTEM )����� ����
CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
-- ROLES �ο�
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;
-- ���� �ο�
GRANT CREATE VIEW TO "MDGUEST" ;
GRANT CREATE ANY VIEW TO "MDGUEST" ;

----
-- (MADANG) �ο��� �� Ȯ��
SELECT * FROM USER_ROLE_PRIVS; -- CONNECT, RESOURCE

-- (SYSTEM) �ο��� �� Ȯ��
SELECT * FROM USER_ROLE_PRIVS; -- DBA, AQ_ADMINISTRATOR_ROLE

-- (SYSTEM) CONNECT, RESOURCE �ѿ� ������ ���� Ȯ��
SELECT * FROM DBA_SYS_PRIVS
WHERE GRANTEE IN ('CONNECT', 'RESOURCE')
ORDER BY GRANTEE, PRIVILEGE
;

-----------------------------------------
-- (SYSTEM) ��(ROLE) ���� : PROGRAMMER(������)��� ����(��)����
CREATE ROLE PROGRAMMER;

-- (SYSTEM) PROGRAMMER �ѿ� ���� �ο� ���̺�, ��(VIEW) ���� ���� ���
GRANT CREATE TABLE, CREATE ANY VIEW TO PROGRAMMER;

-- (SYSTEM) MDGUEST �������� PROGRAMMER��(����) �ο�
GRANT PROGRAMMER TO MDGUEST;

-- MDGUEST ���̺� ���� ���� ���
CREATE TABLE MADANG.AAA (AAA VARCHAR2(20));
CREATE TABLE HR.BBB ( BBB VARCHAR2(20)); 

-- SYSTEM ��(����) ȸ��(���)
REVOKE PROGRAMMER FROM MDGUEST;

--(SYSTEM) ��(ROLE) ����
DROP ROLE PROGRAMMER;




