-- HTTP 포트확인 
SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL;

-- HTTP 포트 변경 : 8080 -> 8090
EXEC DBMS_XDB.SETHTTPPORT(8090);