/****** HR ����Ÿ ��ȸ ����2 ****************
/*1�� HR �μ��� � ����� �޿������� ��ȸ�ϴ� ������ �ð� �ִ�. 
  Tucker ��� ���� �޿��� ���� �ް� �ִ� ����� 
  �̸��� ��(Name���� ��Ī), ����, �޿��� ����Ͻÿ�
*****************************************************/
SELECT FIRST_NAME||' '||LAST_NAME NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY 
                FROM EMPLOYEES WHERE FIRST_NAME = 'Tucker' OR LAST_NAME = 'Tucker')
ORDER BY SALARY DESC
;

/*2�� ����� �޿� ���� �� ������ �ּ� �޿��� �ް� �ִ� ����� 
  �̸��� ��(Name���κ�Ī), ����, �޿�, �Ի����� ����Ͻÿ�
********************************************************/
-- ��� 1
SELECT FIRST_NAME||' '||LAST_NAME NAME, 
        JOB_ID, SALARY, HIRE_DATE 
FROM EMPLOYEES 
WHERE (JOB_ID, SALARY) 
IN (SELECT JOB_ID, MIN(SALARY) FROM EMPLOYEES GROUP BY JOB_ID)           
ORDER BY SALARY
;
-- ��� 2
SELECT FIRST_NAME||' '||LAST_NAME NAME, 
        E.JOB_ID, E.SALARY, E.HIRE_DATE 
FROM EMPLOYEES E, 
            (SELECT JOB_ID, MIN(SALARY) MINS 
                FROM EMPLOYEES GROUP BY JOB_ID) M 
WHERE E.JOB_ID = M.JOB_ID -- ��������
AND E.SALARY = M.MINS
ORDER BY SALARY
;

-- �������� ������� ��ȸ
SELECT FIRST_NAME||' '||LAST_NAME NAME, 
        E.JOB_ID, SALARY, E.HIRE_DATE 
FROM EMPLOYEES E
WHERE SALARY = 
        (SELECT MIN(SALARY) 
            FROM EMPLOYEES WHERE JOB_ID = E.JOB_ID GROUP BY JOB_ID)
ORDER BY JOB_ID
;

/*3�� �Ҽ� �μ��� ��� �޿����� ���� �޿��� �޴� ����� 
  �̸��� ��(Name���� ��Ī), �޿�, �μ���ȣ, ������ ����Ͻÿ�
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


--��� �������� ������� ��ȸ (��ձ޿� Ȯ�� ����, �����͸� ������ ���� ���ϹǷ�)
SELECT FIRST_NAME||' '||LAST_NAME NAME,
       E.DEPARTMENT_ID, E.JOB_ID, SALARY
FROM EMPLOYEES E
WHERE SALARY > (SELECT ROUND(AVG(SALARY)) -- ��� �޿�
            FROM EMPLOYEES 
            WHERE DEPARTMENT_ID = E.DEPARTMENT_ID) -- ���� �μ�
ORDER BY DEPARTMENT_ID, SALARY
;


/*4�� ��� ����� �ҼӺμ� ��տ����� ����Ͽ� ������� �̸��� ��(Name���� ��Ī),
  ����, �޿�, �μ���ȣ, �μ���տ���(Department Avg Salary�� ��Ī)�� ����Ͻÿ�
***************************************************************/

SELECT FIRST_NAME||' '||LAST_NAME NAME, JOB_ID, 
         E.DEPARTMENT_ID, SALARY, ROUND(SALARY*12) MY_A_SALARY,  
         A.AVG AS "Department Avg Salary"
FROM EMPLOYEES E,  
        (SELECT DEPARTMENT_ID, ROUND(AVG(SALARY)),
            ROUND(AVG(SALARY * 12)) AVG -- ��� ����
          --  ROUND(AVG(SALARY*(1+NVL(COMMISSION_PCT,0)))) AVG1, -- Ŀ�̼������ ���޿� ���
          --  ROUND(AVG(SALARY*(1+NVL(COMMISSION_PCT,0))*12)) AVG2 -- Ŀ�̼� ����� ��� ����
            FROM EMPLOYEES 
            GROUP BY DEPARTMENT_ID) A
WHERE E.DEPARTMENT_ID = A.DEPARTMENT_ID
ORDER BY DEPARTMENT_ID
;


-- ��� �������� - SELECT ���� �������� ���
SELECT FIRST_NAME||' '||LAST_NAME AS NAME, E.JOB_ID, SALARY, E.DEPARTMENT_ID,
        ROUND(SALARY * 12 ) AVG_SALARY12,
        (SELECT ROUND(AVG(SALARY*12)) 
            FROM EMPLOYEES 
            WHERE DEPARTMENT_ID = E.DEPARTMENT_ID) 
                AS "Department Avg Salary"
    FROM EMPLOYEES E
;



