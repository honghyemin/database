/* 비교구문(분기처리) IF문
IF (조건식) THEN ~ END IF;
IF (조건식) THEN ~ ELSE END IF;
IF (조건식) THEN ~ ELSIF ~...~ ELSIF ~ ELSE ~ END IF;

***************************/
-- 홀수, 짝수 판별
CREATE OR REPLACE PROCEDURE PRC_IF (
  IN_NUM IN NUMBER 
) AS 
BEGIN
    DBMS_OUTPUT.PUT_LINE('>> 입력 값 : ' || IN_NUM);
    -- 홀, 짝 판별
    IF (MOD(IN_NUM, 2) = 0 ) THEN -- IN_NUM을 2로 나눠서 나머지가 0인 조건
        DBMS_OUTPUT.PUT_LINE(IN_NUM||'- 짝수');
    ELSE  
        DBMS_OUTPUT.PUT_LINE(IN_NUM||'- 홀수');
    END IF;
END PRC_IF;

------------------------------------------
-- 4로 나눈 나머지 값 확인
CREATE OR REPLACE PROCEDURE PRC_IF2 (
  IN_NUM IN NUMBER 
) AS 
BEGIN
    DBMS_OUTPUT.PUT_LINE('>> 입력 값 : ' || IN_NUM);
    -- 4로 나눈 나머지 값 확인
    IF (MOD(IN_NUM,4)=0) THEN
        DBMS_OUTPUT.PUT_LINE('>> 4로 나눈 나머지 0');
    ELSIF (MOD(IN_NUM,4) = 1) THEN
        DBMS_OUTPUT.PUT_LINE('>> 4로 나눈 나머지 1');
    ELSIF (MOD(IN_NUM,4) = 2) THEN
        DBMS_OUTPUT.PUT_LINE('>> 4로 나눈 나머지 2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('>> 4로 나눈 나머지 3');
    END IF;
  
END PRC_IF2;

--===================================================
-- 반복문 : FOR, WHILE
-- FOR문
---- FOR 변수IN 초기값 .. 최종값 LOOP ~ END LOOP;

-- 숫자(N) 하나를 입력 받아서 1~N 까지 출력
CREATE OR REPLACE PROCEDURE PRC_FOR_N (
  IN_NUM IN NUMBER 
) AS 
BEGIN
    -- 1부터 1씩 증가하면서 전달받은 숫자까지 출력
    DBMS_OUTPUT.PUT_LINE('>> 입력 값 : ' || IN_NUM);
    
    -- FOR문으로 반복처리
    -- FOR 변수IN 초기값 .. 최종값 LOOP ~ END LOOP;
    FOR I IN 1 .. IN_NUM LOOP
        DBMS_OUTPUT.PUT_LINE('> I : '|| I);    
    END LOOP;

END PRC_FOR_N;

-----=================================
-- ( 실습 ) 숫자(N) 하나를 입력받아서 합계 출력 ( 1~N 까지의 합계)
CREATE OR REPLACE PROCEDURE PRC_FOR_SUM (
  IN_NUM IN NUMBER 
) AS 
    V_SUM NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('>> 입력 값 : '|| IN_NUM);
    FOR I IN 1 .. IN_NUM LOOP
        V_SUM := V_SUM + I;
    END LOOP; 
    DBMS_OUTPUT.PUT_LINE('>> 합계 : '|| V_SUM);

END PRC_FOR_SUM;

--=========================================
/* LOOP ~ END LOOP; -- LOOP문 내에서는 무한 반복
LOOP    

    EXIT WHEN ( 종결조건식 - 조건식이 TRUE면 반복문 종료)
END LOOP;

***********************************/
CREATE OR REPLACE PROCEDURE LOOP1
AS
    I NUMBER := 1;

BEGIN
    LOOP 
        DBMS_OUTPUT.PUT_LINE('I : '|| I); -- 종결조건을 주지 않고 이 상태로 놔두면 무한루프
        EXIT WHEN (I>=10);
        I := I + 1;
        END LOOP;    
END;
--====================================
--WHILE문
-- WHILE (조건식) LOOP ~ END LOOP;
----
-- 숫자 하나를 전달받아 합계 출력 ( 1~N까지의 합계 )
create or replace PROCEDURE PRC_WHILE_SUM (
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    I NUMBER := 1; -- 반복인자
BEGIN
    -- 입력 값 확인
    DBMS_OUTPUT.PUT_LINE('입력값:' || IN_NUM);
       
    -- 1부터 입력값까지의 합계 구하기 
    WHILE (I <= IN_NUM) LOOP
        DBMS_OUTPUT.PUT_LINE(' I : ' || I );
        V_SUM := V_SUM + I;
        
        I := I + 1; -- I값을 1씩 증가시켜줌
        
     END LOOP;
    DBMS_OUTPUT.PUT_LINE('>> 합계 : ' || V_SUM);
END;
--=======================================
/*(실습) 숫자를 하나 입력 받아  1~입력받은 숫자까지의 합계 구하기
프로시저명 : PRC_SUM_EVENODD
-- 입력 값이 홀수면 홀수 값만 더하고
-- 입력 값이 짝수면 짝수 값만 더해서
최종 합계 값을 화면에 출력
< 출력 형태 >
-- 입력 숫자 : 입력 값, 홀짝 여부, 합계 결과
    출력 예 ) 입력 숫자 : 4, 짝수, 합계 : 6
    출력 예 ) 입력 숫자 : 5, 홀수, 합계 : 9

********************************/
-- 방법 1
create or replace PROCEDURE PRC_SUM_EVENODD (
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('입력 숫자 : ' || IN_NUM);
    IF (MOD(IN_NUM, 2) = 0) THEN
        DBMS_OUTPUT.PUT_LINE(IN_NUM|| ' : 짝수');
        FOR I IN 1 .. IN_NUM LOOP
            IF(MOD(I,2)=0) THEN
            V_SUM := V_SUM + I;
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('합계 : '|| V_SUM);
    ELSE 
        DBMS_OUTPUT.PUT_LINE(IN_NUM|| ' : 홀수');
        FOR I IN 1 .. IN_NUM LOOP
            IF(MOD(I,2)!=0) THEN
            V_SUM := V_SUM + I;
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('합계 : '|| V_SUM);
    END IF;
END;

--=======================================
-- 방법 2
CREATE OR REPLACE PROCEDURE PRC_SU_EVENODD (
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    I NUMBER := 0;
    V_EVEN_ODD VARCHAR2(10); -- 홀수, 짝수
BEGIN
    -- 입력 값 홀/짝 여부 확인
    IF (MOD(IN_NUM,2)=0) THEN
        V_EVEN_ODD := '짝수';
    ELSE 
        V_EVEN_ODD := '홀수';
    END IF;
    
    -- 1부터 입력된 숫자값까지 숫자를 홀/짝 판별하고 입력된 숫자와 같은 형태(홀/짝)면 합산
    FOR I IN 1 .. IN_NUM LOOP
        IF(MON(I, 2)=0 AND V_EVEN_ODD = '짝수') THEN
            V_SUM := V_SUM + I;
        END IF;
        IF (MOD(I,2) <> 0 AND V_EVEN_ODD = '홀수') THEN
            V_SUM := V_SUM + I;
        END IF;
    
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('입력숫자: '|| IN_NUM || ',' || V_EVEN_ODD || 
                            ', 합계: ' || V_SUM);
    
    DBMS_OUTPUT.PUT_LINE('홀/짝 여부 : ' || V_EVEN_ODD);
    
END PRC_SUM_EVENODD;

--==============================================
--  방법 3
create or replace PROCEDURE PRC_SU_EVENODD2 (
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    I NUMBER := 0;
    V_EVEN_ODD VARCHAR2(10); -- 홀수, 짝수
    V_MOD NUMBER(1) := 0;
BEGIN
    -- 입력 값 홀/짝 여부 확인
    V_MOD := MOD(IN_NUM,2); -- 0 또는 1
    IF (V_MOD=0) THEN
        V_EVEN_ODD := '짝수';
    ELSE 
        V_EVEN_ODD := '홀수';
    END IF;

    -- 1부터 입력된 숫자값까지 숫자를 홀/짝 판별하고 입력된 숫자와 같은 형태(홀/짝)면 합산
    FOR I IN 1 .. IN_NUM LOOP
        IF (MOD(I,2)=V_MOD) THEN
            V_SUM := V_SUM + I;
        END IF;

    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('홀/짝 여부 : ' || V_EVEN_ODD);

    DBMS_OUTPUT.PUT_LINE('입력숫자: '|| IN_NUM || ', ' || V_EVEN_ODD || 
                            ', 합계: ' || V_SUM);

    
END;



