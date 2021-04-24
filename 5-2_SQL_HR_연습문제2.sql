/* ** �ǽ����� : HR����(DB)���� �䱸���� �ذ� **********
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
-- ������ �ִ� ���޿� �˻�
-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
-- ������ ��ձ޿� �̻��� ���� ��ȸ
**********************************************************/
--1. ���(employee_id)�� 100�� ���� ���� ��ü ����
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID = 100;

--2. ����(salary)�� 15000 �̻��� ������ ��� ���� ����
SELECT * FROM EMPLOYEES
WHERE SALARY >= 15000;

--3. ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE SALARY >= 15000;

--4. ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000
ORDER BY SALARY DESC;

--5. �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
SELECT *
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = LOWER('john'); -- ������ ǥ��ȭ�� �ȵ��ִ� ���(UPPER||LOWER)

SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = INITCAP('john'); -- ������ ǥ��ȭ�� �Ǿ��ִ� ���

--6. �̸�(first_name)�� john�� ����� �� ���ΰ�?
SELECT COUNT(*)
FROM EMPLOYEES
WHERE FIRST_NAME IN 'John';

--7. 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
--���1
SELECT  HIRE_DATE, EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '08%'
ORDER BY HIRE_DATE; 
--���2
SELECT  HIRE_DATE, EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN TO_DATE('2008-01-01', 'YYYY-MM-DD') AND TO_DATE('2008/12/31', 'YYYY-MM-DD')
ORDER BY HIRE_DATE; 

SELECT  HIRE_DATE, EMPLOYEE_ID, 
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD HH24:MI:SS'), 
        TO_CHAR(HIRE_DATE, 'YYYY') -- ������ �̾Ƴ�
FROM EMPLOYEES;
--���3(������ ǥ��)
SELECT EMPLOYEE_ID, FIRST_NAME||' '|| LAST_NAME AS FULLNAME, SALARY
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY')='2008';


--8. ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME FULLNAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 20000 AND 30000;

--9. ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
SELECT * FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

--10. ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
SELECT MAX(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

-- ����
SELECT 'IT_PROG', COUNT(*), SUM(SALARY), AVG(SALARY), MAX(SALARY), MIN(SALARY)
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

--11. ������ �ִ� ���޿� �˻�
SELECT JOB_ID,MAX(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY MAX(SALARY) DESC;

--12. ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
SELECT JOB_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING MAX(SALARY) >= 10000
ORDER BY MAX(SALARY) DESC;

--13. ������ ��ձ޿� �̻��� ���� ��ȸ
SELECT JOB_ID, AVG(SALARY) -- ������ ��� �޿� ����
FROM EMPLOYEES
GROUP BY JOB_ID 
;

SELECT EMPLOYEE_ID, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
AND SALARY >= 5760;

-- �� �ΰ��� ������ ���ν�Ŵ
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

-- ������ ��ձ޿� �̻��� ���� ��ȸ(�����������) , ��ձ޿� ��� ���� �� �� ����.
SELECT * 
FROM EMPLOYEES E --���ο� �ִ� EMPLOYEES E
WHERE 1=1 -- ������ ��ȸ(TRUE�� ��)
-- AND JOB_ID = 'IT_PROG'
AND SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = E.JOB_ID)
;










