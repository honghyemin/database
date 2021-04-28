/* ********* 사용자 생성, 삭제 *********
-- 사용자 생성 : CREATE USER
CREATE USER 사용자명(유저명) --"MDGUEST" 
IDENTIFIED BY 비밀번호 --"mdguest"  
DEFAULT TABLESPACE 테이블스페이스 --"USERS"
TEMPORARY TABLESPACE 임시작업테이블스페이스 --"TEMP";

-- 사용할 용량 지정(수정)
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";

-- 사용자 수정 : ALTER USER 
ALTER USER 사용자명(유저명) IDENTIFIED BY 비밀번호;

-- 권한부여(롤 사용 권한 부여, 롤 부여)
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;

-- 사용자 삭제 : DROP USER
DROP USER 유저명 [CASCADE];
--CASCADE : 삭제시점에 사용자(유저)가 보유한 모든 데이타 삭제
*************************************/
-- ( 관리자 계정 - SYSTEM ) 유저 생성 유저명 : MDGUEST, 암호 : mdguest
-- 유저 생성 
-- USER SQL
CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
-- 롤(역할, ROLES) 부여
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;
-- 권한 부여
GRANT CREATE VIEW TO "MDGUEST" ;
-- 유저 수정 용량 설정
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";
--------------
-- (SYSTEM) CONNECT, RESOURCE 롤(ROLE)에 있는 권한 확인
SELECT * 
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE IN ('CONNECT','RESOURCE')
 ORDER BY GRANTEE, privilege
;

-- 
GRANT CONNECT, RESOURCE TO MDGUEST; -- 롤/권한 부여 명령문



--=============================
/****** 권한 부여(GRANT), 권한 취소(REVOKE) **********************
GRANT 권한 [ON 객체] TO {사용자|ROLE|PUBLIC,.., n} [WITH GRANT OPTION]
--PUBLIC은 모든 사용자에게 적용을 의미

GRANT 권한 TO 사용자; --권한을 사용자에게 부여
GRANT 권한 ON 객체 TO 사용자; -객체에 대한 권한을 사용자에게 부여
-->> WITH GRANT OPTION :객체에 대한 권한을 사용자에게 부여 
-- 권한을 받은 사용자가 다른 사용자에게 권한부여할 권리 포함
GRANT 권한 ON 객체 TO 사용자 WITH GRANT OPTION;
--------------------
-->>>권한 취소(REVOKE)
REVOKE 권한 [ON 객체] FROM {사용자|ROLE|PUBLIC,.., n} CASCADE
--CASCADE는 사용자가 다른 사용자에게 부여한 권한까지 취소시킴
  (확인 및 검증 후 작업)

REVOKE 권한 FROM 사용자; --권한을 사용자에게 부여
REVOKE 권한 ON 객체 FROM 사용자; -객체에 대한 권한을 사용자에게 부여
*************************************************/
-- 권한 부여 및 확인 : madang 유저의 BOOK 테이블에 대한 SELECT 권한을 MDGUEST에게 부여.
-- (SYSTEM) 권한 부여 
SELECT * FROM MADANG.BOOK; -- MADANG 유저의 BOOK테이블을 보는 명령문
GRANT SELECT ON MADANG.BOOK TO MDGUEST; -- 권한 부여


-- (MDGUEST) 데이터 사용 여부 확인
SELECT * FROM MADANG.BOOK; -- 정상 데이터 조회
                           --> 다른사용자 :MADANG에서 BOOK테이블을 볼 수 있음 / HR 등의 사용자의 테이블은 못봄
DELETE FROM MADANG.BOOK WHERE BOOKID =1; -- 오류 발생(권한없음)
SELECT * FROM MADANG.CUSTOMER; --> MADANG 유저에는 CUSTOMER테이블이 있으나 권한을 부여받지 못했으므로 볼 수 없음.
                               --> 접근 권한 없음.

---- (SYSTEM) 권한 회수 
REVOKE SELECT ON MADANG.BOOK FROM MDGUEST;
SELECT * FROM MADANG.BOOK; --> 권한이 회수되었으므로 조회 불가능

----------------------
-- ( 소유자 MADANG ) 권한 부여, 권한 회수(취소)
GRANT SELECT ON BOOK TO MDGUEST;
REVOKE SELECT ON BOOK FROM MDGUEST;

-- WITH GRANT OPTIOIN : 다른 유저에게 권한 부여할 수 있도록 허용
-- (MADANG) 권한 부여
GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST WITH GRANT OPTION;
-- ( MDGUEST ) HR유저에게  SELECT 권한 부여
GRANT SELECT ON MADANG.CUSTOMER TO HR;

-- ( MADANG) 권한 회수 (취소)
-- 부여된 권한 모두 회수 처리 - MDGUEST를 통해 부여된 권한 회수 처리
REVOKE SELECT, UPDATE ON CUSTOMER FROM MDGUEST; -- 사용중일때는 회수가 안됨.

-- (관리자계정 - SYSTEM) 유저 삭제
DROP USER MDGUEST CASCADE;

