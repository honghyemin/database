/****** HR 데이타 조회 문제2 ****************
/*1■ HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. 
  Tucker 사원 보다 급여를 많이 받고 있는 사원의 
  이름과 성(Name으로 별칭), 업무, 급여를 출력하시오
*****************************************************/
SELECT FIRST_NAME||' '||LAST_NAME NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEES WHERE FIRST_NAME = 'Tucker' OR LAST_NAME = 'Tucker')
ORDER BY SALARY DESC
;

/*2■ 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 
  이름과 성(Name으로별칭), 업무, 급여, 입사일을 출력하시오
********************************************************/
-- 방법 1
SELECT FIRST_NAME||' '||LAST_NAME NAME, 
        JOB_ID, SALARY, HIRE_DATE 
FROM EMPLOYEES 
WHERE (JOB_ID, SALARY) 
IN (SELECT JOB_ID, MIN(SALARY) FROM EMPLOYEES GROUP BY JOB_ID)           
ORDER BY SALARY
;
-- 방법 2
SELECT FIRST_NAME||' '||LAST_NAME NAME, 
        E.JOB_ID, E.SALARY, E.HIRE_DATE 
FROM EMPLOYEES E, 
            (SELECT JOB_ID, MIN(SALARY) MINS 
                FROM EMPLOYEES GROUP BY JOB_ID) M 
WHERE E.JOB_ID = M.JOB_ID -- 조인조건
AND E.SALARY = M.MINS
ORDER BY SALARY
;

-- 서브쿼리 방식으로 조회
SELECT FIRST_NAME||' '||LAST_NAME NAME, 
        E.JOB_ID, SALARY, E.HIRE_DATE 
FROM EMPLOYEES E
WHERE SALARY = 
        (SELECT MIN(SALARY) 
            FROM EMPLOYEES WHERE JOB_ID = E.JOB_ID GROUP BY JOB_ID)
ORDER BY JOB_ID
;

/*3■ 소속 부서의 평균 급여보다 많은 급여를 받는 사원의 
  이름과 성(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오
***********************************************************/
SELECT FIRST_NAME||' '||LAST_NAME NAME, 
        SALARY, E.DEPARTMENT_ID, JOB_ID, A.AVG_SALARY
FROM EMPLOYEES E, 
    (SELECT DEPARTMENT_ID, ROUND(AVG(SALARY)) AVG_SALARY
    FROM EMPLOYEES 
    GROUP BY DEPARTMENT_ID) A
WHERE E.DEPARTMENT_ID = A.DEPARTMENT_ID
AND E.SALARY > A.AVG_SALARY
ORDER BY SALARY DESC
;


--상관 서브쿼리 방식으로 조회 (평균급여 확인 못함, 데이터를 가져다 쓰지 못하므로)
SELECT FIRST_NAME||' '||LAST_NAME NAME,
       E.DEPARTMENT_ID, E.JOB_ID, SALARY
FROM EMPLOYEES E
WHERE SALARY > (SELECT ROUND(AVG(SALARY)) -- 평균 급여
            FROM EMPLOYEES 
            WHERE DEPARTMENT_ID = E.DEPARTMENT_ID) -- 같은 부서
ORDER BY DEPARTMENT_ID, SALARY
;


/*4■ 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 이름과 성(Name으로 별칭),
  업무, 급여, 부서번호, 부서평균연봉(Department Avg Salary로 별칭)을 출력하시오
***************************************************************/

SELECT FIRST_NAME||' '||LAST_NAME NAME, JOB_ID, 
         E.DEPARTMENT_ID, SALARY, ROUND(SALARY*12) MY_A_SALARY,  
         A.AVG AS "Department Avg Salary"
FROM EMPLOYEES E,  
        (SELECT DEPARTMENT_ID, ROUND(AVG(SALARY)),
            ROUND(AVG(SALARY * 12)) AVG -- 평균 연봉
          --  ROUND(AVG(SALARY*(1+NVL(COMMISSION_PCT,0)))) AVG1, -- 커미션적용된 월급여 평균
          --  ROUND(AVG(SALARY*(1+NVL(COMMISSION_PCT,0))*12)) AVG2 -- 커미션 적용된 평균 연봉
            FROM EMPLOYEES 
            GROUP BY DEPARTMENT_ID) A
WHERE E.DEPARTMENT_ID = A.DEPARTMENT_ID
ORDER BY DEPARTMENT_ID
;


-- 상관 서브쿼리 - SELECT 절에 서브쿼리 사용
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, SALARY, E.DEPARTMENT_ID,
        ROUND(SALARY * 12 ) AVG_SALARY12,
        (SELECT ROUND(AVG(SALARY*12)) 
            FROM EMPLOYEES 
            WHERE DEPARTMENT_ID = E.DEPARTMENT_ID) 
                AS "Department Avg Salary"
    FROM EMPLOYEES E
;



