/* ** 실습문제 : HR유저(DB)에서 요구사항 해결 **********
-- 사번(employee_id)이 100인 직원 정보 전체 보기
-- 월급(salary)이 15000 이상인 직원의 모든 정보 보기
-- 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
-- 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
-- 이름(first_name)이 john인 사원의 모든 정보 조회
-- 이름(first_name)이 john인 사원은 몇 명인가?
-- 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
-- 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
-- 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
-- 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
-- 직종별 최대 월급여 검색
-- 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
-- 직종별 평균급여 이상인 직원 조회
**********************************************************/
--1. 사번(employee_id)이 100인 직원 정보 전체 보기
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID = 100;

--2. 월급(salary)이 15000 이상인 직원의 모든 정보 보기
SELECT * FROM EMPLOYEES
WHERE SALARY >= 15000;

--3. 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE SALARY >= 15000;

--4. 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000
ORDER BY SALARY DESC;

--5. 이름(first_name)이 john인 사원의 모든 정보 조회
SELECT *
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = LOWER('john'); -- 데이터 표준화가 안되있는 경우(UPPER||LOWER)

SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = INITCAP('john'); -- 데이터 표준화가 되어있는 경우

--6. 이름(first_name)이 john인 사원은 몇 명인가?
SELECT COUNT(*)
FROM EMPLOYEES
WHERE FIRST_NAME IN 'John';

--7. 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
--방법1
SELECT  HIRE_DATE, EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '08%'
ORDER BY HIRE_DATE; 
--방법2
SELECT  HIRE_DATE, EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN TO_DATE('2008-01-01', 'YYYY-MM-DD') AND TO_DATE('2008/12/31', 'YYYY-MM-DD')
ORDER BY HIRE_DATE; 

SELECT  HIRE_DATE, EMPLOYEE_ID, 
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS'), 
        TO_CHAR(HIRE_DATE, 'YYYY') -- 연도만 뽑아냄
FROM EMPLOYEES;
--방법3(연도만 표시)
SELECT EMPLOYEE_ID, FIRST_NAME||' '|| LAST_NAME AS FULLNAME, SALARY
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY')='2008';


--8. 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULLNAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 20000 AND 30000;

--9. 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
SELECT * FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

--10. 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
SELECT MAX(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- 번외
SELECT 'IT_PROG', COUNT(*), SUM(SALARY), AVG(SALARY), MAX(SALARY), MIN(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

--11. 직종별 최대 월급여 검색
SELECT JOB_ID,MAX(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY MAX(SALARY) DESC;

--12. 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
SELECT JOB_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING MAX(SALARY) >= 10000
ORDER BY MAX(SALARY) DESC;

--13. 직종별 평균급여 이상인 직원 조회
SELECT JOB_ID, AVG(SALARY) -- 직종별 평균 급여 쿼리
FROM EMPLOYEES
GROUP BY JOB_ID 
;

SELECT EMPLOYEE_ID, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
AND SALARY >= 5760;

-- 위 두개의 쿼리를 조인시킴
SELECT E.EMPLOYEE_ID, E.JOB_ID, AVG.JOB_ID AVG_JOB,
        E.SALARY, AVG_SALARY
FROM EMPLOYEES E,
            (SELECT JOB_ID, AVG(SALARY) AVG_SALARY
            FROM EMPLOYEES
            GROUP BY JOB_ID ) AVG
WHERE E.JOB_ID = AVG.JOB_ID
AND E.SALARY >= AVG.AVG_SALARY
ORDER BY E.SALARY DESC
;

-- 직종별 평균급여 이상인 직원 조회(상관서브쿼리) , 평균급여 목록 등은 볼 수 없음.
SELECT * 
FROM EMPLOYEES E --메인에 있는 EMPLOYEES E
WHERE 1=1 -- 전직원 조회(TRUE일 때)
-- AND JOB_ID = 'IT_PROG'
AND SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = E.JOB_ID)
;










