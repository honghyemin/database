/* ********* 역할(롤 ROLE) ***********
역할(롤, ROLE) : DB 객체 및 시스템에 대한 권한을 모아둔 집합을 의미
역할 생성 : CREATE ROLE 역할이름
역할 제거 : DROP ROLE 역할이름
역할에 권한 부여 : GRANT 권한 [ON 객체] TO 역할이름
역할의 권한 회수 : REVOKE 권한 [ON 객체] FROM 역할이름
사용자에게 역할 부여 : GRANT 역할이름 TO 사용자

<역할 생성부터 사용자 추가까지의 단계>
CREATE ROLE - 역할생성
GRANT - 만들어진 역할에 권한 부여
GRANT - 사용자에게 역할 부여
-->>역할 제거할 경우 반대로 수행
DROP ROLE - 역할 삭제(사용자에게 부여된 역할에 대한 권한 역시 제거됨)
***************************************/
-- (DBA 계정 - SYSTEM )사용자 생성
CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
-- ROLES 부여
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;
-- 권한 부여
GRANT CREATE VIEW TO "MDGUEST" ;
GRANT CREATE ANY VIEW TO "MDGUEST" ;

----
-- (MADANG) 부여된 롤 확인
SELECT * FROM USER_ROLE_PRIVS; -- CONNECT, RESOURCE

-- (SYSTEM) 부여된 롤 확인
SELECT * FROM USER_ROLE_PRIVS; -- DBA, AQ_ADMINISTRATOR_ROLE

-- (SYSTEM) CONNECT, RESOURCE 롤에 설정된 권한 확인
SELECT * FROM DBA_SYS_PRIVS
WHERE GRANTEE IN ('CONNECT', 'RESOURCE')
ORDER BY GRANTEE, PRIVILEGE
;

-----------------------------------------
-- (SYSTEM) 롤(ROLE) 생성 : PROGRAMMER(개발자)라는 역할(롤)생성
CREATE ROLE PROGRAMMER;

-- (SYSTEM) PROGRAMMER 롤에 권한 부여 테이블, 뷰(VIEW) 생성 권한 담기
GRANT CREATE TABLE, CREATE ANY VIEW TO PROGRAMMER;

-- (SYSTEM) MDGUEST 유저에게 PROGRAMMER롤(역할) 부여
GRANT PROGRAMMER TO MDGUEST;

-- MDGUEST 테이블 생성 권한 사용
CREATE TABLE MADANG.AAA (AAA VARCHAR2(20));
CREATE TABLE HR.BBB ( BBB VARCHAR2(20)); 

-- SYSTEM 롤(역할) 회수(취소)
REVOKE PROGRAMMER FROM MDGUEST;

--(SYSTEM) 롤(ROLE) 삭제
DROP ROLE PROGRAMMER;




