/*5■ HR 스키마에 있는 Job_history 테이블은 사원들의 업무 변경 이력을 나타내는 테이블이다. 
  이 정보를 이용하여 모든 사원의 현재 및 이전의 업무 이력 정보를 출력하고자 한다. 
  중복된 사원정보가 있으면 한 번만 표시하여 출력하시오
  (사원번호, 업무)
*********************************************************************/
SELECT EMPLOYEE_ID, JOB_ID FROM JOB_HISTORY 
UNION -- 중복데이터 하나만 표시
SELECT EMPLOYEE_ID, JOB_ID FROM EMPLOYEES 
ORDER BY EMPLOYEE_ID -- UNION 사용 시 ORDER BY는 맨 마지막에 한 번만 작성
;


/*6■ 위 문제에서 각 사원의 업무 이력 정보를 확인하였다. 하지만 '모든 사원의
  업무 이력 전체'를 보지는 못했다. 여기에서는 모든 사원의 
  업무 이력 변경 정보(JOB_HISTORY) 및 업무변경에 따른 부서정보를 
  사원번호가 빠른 순서대로 출력하시오(집합연산자 UNION)
  (사원번호, 부서정보, 업무)
**********************************************************************/
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID FROM JOB_HISTORY
UNION ALL -- 중복 데이터도 모두 표시
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID FROM EMPLOYEES
ORDER BY EMPLOYEE_ID
;



/*7■ HR 부서에서는 신규 프로젝트를 성공으로 이끈 해당 업무자들의 
  급여를 인상 하기로 결정하였다. 
  사원은 현재 107명이며 19개의 업무에 소속되어 근무 중이다. 
  급여 인상 대상자는 회사의 업무(Distinct job_id) 중 다음 5개 업무에서 
  일하는 사원에 해당된다. 나머지 업무에 대해서는 급여가 동결된다. 
  5개 업무의 급여 인상안은 다음과 같다.
  HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%)
**********************************************************************/
-- CASE WHEN 방식
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, JOB_ID,
            SALARY, 
    CASE JOB_ID 
                WHEN 'HR_REP' THEN 1.10 * SALARY
                WHEN 'MK_REP' THEN 1.12 * SALARY
                WHEN 'PR_REP' THEN 1.15 * SALARY
                WHEN 'SA_REP' THEN 1.18 * SALARY
                WHEN 'IT_PROG' THEN 1.20 * SALARY
                ELSE 0 
                END AS "NEW SALARY",
        CASE JOB_ID 
                WHEN 'HR_REP' THEN 0.10 * SALARY
                WHEN 'MK_REP' THEN 0.12 * SALARY
                WHEN 'PR_REP' THEN 0.15 * SALARY
                WHEN 'SA_REP' THEN 0.18 * SALARY
                WHEN 'IT_PROG' THEN 0.20 * SALARY
                ELSE 0
                END AS "순수 인상 금액"
FROM EMPLOYEES E
;

-- DECODE 방식 (동등비교만 가능)
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, JOB_ID,
            SALARY, 
            DECODE(JOB_ID,
                'HR_REP', 1.10 * SALARY, -- SALARY + (SALARY * 0.1)
                'MK_REP' , 1.12 * SALARY,
                'PR_REP', 1.15 * SALARY,
                'SA_REP', 1.18 * SALARY,
                'IT_PROG', 1.20 * SALARY,
                0 -- 위의 5개 직무에 해당하지 않는 사람
           ) AS "NEW_SALARY",
            DECODE(JOB_ID,
                'HR_REP', 0.10 * SALARY, 
                'MK_REP' , 0.12 * SALARY,
                'PR_REP', 0.15 * SALARY,
                'SA_REP', 0.18 * SALARY,
                'IT_PROG', 0.20 * SALARY,
                0 -- 위의 5개 직무에 해당하지 않는 사람
           ) AS "순수 인상 금액"
    FROM EMPLOYEES;

/*8■ HR 부서에서는 최상위 입사일에 해당하는 2001년부터 2003년까지 입사자들의 급여를 
  각각 5%, 3%, 1% 인상하여 지분에 따른 배당금으로 지급하고자 한다. 
  전체 사원들 중 해당 년도에 해당하는 사원들의 급여를 검색하여 적용하고, 
  입사일자에 따른 오름차순 정렬을 수행하시오
**********************************************************************/
-- SELECT MIN(HIRE_DATE) FROM EMPLOYEES; -- 직원들 중 가장 빠른 입사자
-- 2001년 이전 입사자가 없다는 전제하에 2001년 입사자 확인
SELECT EMPLOYEE_ID, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < TO_DATE('2002/01/01', 'YYYY/MM/DD');
-- 날짜 타입 데이터에서 년도 4자리만 추출해서 비교
SELECT EMPLOYEE_ID, HIRE_DATE FROM EMPLOYEES
WHERE TO_CHAR(HERE_DATE, 'YYYY') = '2001';


-- 방법 1 )
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, HIRE_DATE,
        JOB_ID, SALARY,
    CASE 
        WHEN TO_CHAR(HIRE_DATE, 'YYYY')='2001' THEN 1.05 * SALARY
        WHEN TO_CHAR(HIRE_DATE, 'YYYY')='2002' THEN 1.03 * SALARY
        WHEN TO_CHAR(HIRE_DATE, 'YYYY')='2003' THEN 1.01 * SALARY
        ELSE SALARY END "NEW SALARY"
FROM EMPLOYEES 
ORDER BY HIRE_DATE
;

-- 방법 2 )
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, HIRE_DATE,
        JOB_ID, SALARY,
    CASE WHEN HIRE_DATE < TO_DATE('2002/01/01', 'YYYY/MM/DD') -- 2001년 입사자
        THEN 1.05 * SALARY
        WHEN HIRE_DATE < TO_DATE('2003/01/01', 'YYYY/MM/DD') -- 2002년 입사자
        THEN 1.03 * SALARY
        WHEN HIRE_DATE < TO_DATE('2004/01/01', 'YYYY/MM/DD') -- 2003년 입사자
        THEN 1.01 * SALARY
        ELSE SALARY END "NEW SALARY"
FROM EMPLOYEES 
WHERE HIRE_DATE >= TO_DATE('2001/01/01', 'YYYY/MM/DD') -- 해당 기간에 입사한 사원들만 추출
    AND HIRE_DATE < TO_DATE('2004/01/01', 'YYYY/MM/DD') -- 전직원을 보려면 WHERE절 주석처리
ORDER BY HIRE_DATE
;

-- 방법 3 (DECODE방식) )
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, HIRE_DATE,
        JOB_ID, SALARY,
        DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 
                '2001', ROUND(SALARY * 1.05),
                '2002', ROUND(SALARY * 1.03),
                '2003', ROUND(SALARY * 1.01),
                0
            ) AS "배당금"
    FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY' ) IN ('2001', '2002', '2003') -- 해당 기간 직원만 추출
ORDER BY HIRE_DATE
;


/*9■ 부서별 급여 합계를 구하고, 그 결과를 다음과 같이 표현하시오.
  Sum Salary > 100000 이면, "Excellent"
  Sum Salary > 50000 이면, "Good"
  Sum Salary > 10000 이면, "Medium"
  Sum Salary <= 10000 이면, "Well"
**********************************************************************/
SELECT DEPARTMENT_ID, SUM(SALARY) DEPT_SUM_SALARY,
        CASE 
            WHEN SUM(SALARY) > 100000 THEN 'Excellent'
            WHEN SUM(SALARY) > 50000 THEN 'Good'
            WHEN SUM(SALARY) > 10000 THEN 'Medium'
            WHEN SUM(SALARY) <= 10000 THEN 'Well'
            ELSE 'Well' END "평가결과"          
FROM EMPLOYEES E
GROUP BY DEPARTMENT_ID
ORDER BY DEPT_SUM_SALARY
;


/*10■ 2005년 이전에 입사한 사원 중 업무에 "MGR"이 포함된 사원은 15%, 
  "MAN"이 포함된 사원은 20% 급여를 인상한다. 
  또한 2005년부터 근무를 시작한 사원 중 "MGR"이 포함된 사원은 25% 급여를 인상한다. 
  이를 수행하는 쿼리를 작성하시오
**********************************************************************/
-- 업무가 있는지 확인 (LIKE조건을 사용할 때는 동등조건을 사용할 수 없음)
SELECT JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MGR%';
SELECT JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN%';

-- 업무들 중 MGR과 MAN만 추출 (동등 조건을 사용할 수 있음)
SELECT DISTINCT JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MGR%' OR JOB_ID LIKE '%MAN%';
-- 또는
SELECT DISTINCT JOB_ID FROM EMPLOYEES WHERE SUBSTR(JOB_ID, -3) = 'MGR' OR SUBSTR(JOB_ID, -3) = 'MAN';


-----
-----CASE WHEN 이용해서 조회
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME NAME, HIRE_DATE,
        JOB_ID, SALARY,
        -- '2005'년 이전 입사 여부 확인
        CASE 
        WHEN TO_CHAR(HIRE_DATE, 'YYYY') < '2005' 
        THEN  CASE WHEN JOB_ID LIKE '%MGR%' THEN SALARY*1.15
                   WHEN JOB_ID LIKE '%MAN%' THEN SALARY*1.20
                   ELSE SALARY
            END
        -- '2005'년 부터 근무한 직원
        ELSE CASE WHEN JOB_ID LIKE '%MGR%' THEN SALARY*1.25
                  ELSE SALARY
            END
    END AS "변경된 급여"
 
FROM EMPLOYEES
ORDER BY HIRE_DATE
;

--------------
-----DECODE문으로 변경
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME NAME, HIRE_DATE,
        JOB_ID, SALARY,
        -- '2005'년 이전 입사 여부 확인
        CASE 
        WHEN TO_CHAR(HIRE_DATE, 'YYYY') < '2005' 
        THEN DECODE (SUBSTR(JOB_ID, -3)
                   , 'MGR', SALARY*1.15
                   , 'MAN', SALARY*1.20
                   , SALARY)
        -- '2005'년 부터 근무한 직원
        ELSE DECODE (SUBSTR(JOB_ID, -3), 'MGR', SALARY*1.25
                 , SALARY)
    END AS "변경된 급여"
 
FROM EMPLOYEES
ORDER BY HIRE_DATE
;




/*11■ 월별로 입사한 사원 수 출력
  (방식1) 월별로 입사한 사원 수가 아래와 같이 각 행별로 출력되도록 하시오(12행).
  1월 xx
  2월 xx
  3월 xx
  ..
  12월 xx
  합계 XXX
**********************************************************************/  
-- (노가다) 방법 1)
SELECT 
    
    DECODE(TO_CHAR(HIRE_DATE, 'MM'),
            '01', ' 1월',
            '02', ' 2월',
            '03', ' 3월',
            '04', ' 4월',
            '05', ' 5월',
            '06', ' 6월',
            '07', ' 7월',
            '08', ' 8월',
            '09', ' 9월',
            '10', ' 10월',
            '11', ' 11월',
            '12', ' 12월') "MONTH", COUNT(*) AS "사원수"
    
    
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'MM')
ORDER BY TO_CHAR(HIRE_DATE, 'MM')
;
---------------
-- 방법 2)
SELECT DECODE(MM, 99, '합계', MM||'월') AS "입사월", CNT AS "사원 수"
FROM (SELECT TO_NUMBER(TO_CHAR(HIRE_DATE, 'MM')) MM, COUNT(*) CNT
        FROM EMPLOYEES
        GROUP BY TO_CHAR(HIRE_DATE, 'MM')
        UNION
        SELECT 99, COUNT(*) FROM EMPLOYEES
        ORDER BY MM)
;
---
--SELECT TO_NUMBER(TO_CHAR(HIRE_DATE, 'MM')) MM, COUNT(*) CNT
--FROM EMPLOYEES
--GROUP BY TO_CHAR(HIRE_DATE, 'MM')
--UNION
--SELECT 99, COUNT(*) FROM EMPLOYEES
--ORDER BY MM
--;


---------------------------------------------------------
/* (방식2) 첫 행에 모든 월별 입사 사원 수가 출력되도록 하시오
  1월 2월 3월 4월 .... 11월 12월
  xx  xx  xx xx  .... xx   xx
**********************************************************************/

SELECT MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '01', COUNT(*), 0)) "1월",
    -- SUM(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '01', COUNT(*))) "1월" 이렇게 해도 됨
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '02', COUNT(*), 0)) "2월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '03', COUNT(*), 0)) "3월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '04', COUNT(*), 0)) "4월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '05', COUNT(*), 0)) "5월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '06', COUNT(*), 0)) "6월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '07', COUNT(*), 0)) "7월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '08', COUNT(*), 0)) "8월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '09', COUNT(*), 0)) "9월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '10', COUNT(*), 0)) "10월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '11', COUNT(*), 0)) "11월",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '12', COUNT(*), 0)) "12월",
        SUM(COUNT(*)) AS "전체 사원 수"
        
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'MM')
;




