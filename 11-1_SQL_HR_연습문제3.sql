/*5�� HR ��Ű���� �ִ� Job_history ���̺��� ������� ���� ���� �̷��� ��Ÿ���� ���̺��̴�. 
  �� ������ �̿��Ͽ� ��� ����� ���� �� ������ ���� �̷� ������ ����ϰ��� �Ѵ�. 
  �ߺ��� ��������� ������ �� ���� ǥ���Ͽ� ����Ͻÿ�
  (�����ȣ, ����)
*********************************************************************/
SELECT EMPLOYEE_ID, JOB_ID FROM JOB_HISTORY 
UNION -- �ߺ������� �ϳ��� ǥ��
SELECT EMPLOYEE_ID, JOB_ID FROM EMPLOYEES 
ORDER BY EMPLOYEE_ID -- UNION ��� �� ORDER BY�� �� �������� �� ���� �ۼ�
;


/*6�� �� �������� �� ����� ���� �̷� ������ Ȯ���Ͽ���. ������ '��� �����
  ���� �̷� ��ü'�� ������ ���ߴ�. ���⿡���� ��� ����� 
  ���� �̷� ���� ����(JOB_HISTORY) �� �������濡 ���� �μ������� 
  �����ȣ�� ���� ������� ����Ͻÿ�(���տ����� UNION)
  (�����ȣ, �μ�����, ����)
**********************************************************************/
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID FROM JOB_HISTORY
UNION ALL -- �ߺ� �����͵� ��� ǥ��
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID FROM EMPLOYEES
ORDER BY EMPLOYEE_ID
;



/*7�� HR �μ������� �ű� ������Ʈ�� �������� �̲� �ش� �����ڵ��� 
  �޿��� �λ� �ϱ�� �����Ͽ���. 
  ����� ���� 107���̸� 19���� ������ �ҼӵǾ� �ٹ� ���̴�. 
  �޿� �λ� ����ڴ� ȸ���� ����(Distinct job_id) �� ���� 5�� �������� 
  ���ϴ� ����� �ش�ȴ�. ������ ������ ���ؼ��� �޿��� ����ȴ�. 
  5�� ������ �޿� �λ���� ������ ����.
  HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%)
**********************************************************************/
-- CASE WHEN ���
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
                END AS "���� �λ� �ݾ�"
FROM EMPLOYEES E
;

-- DECODE ��� (����񱳸� ����)
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME, JOB_ID,
            SALARY, 
            DECODE(JOB_ID,
                'HR_REP', 1.10 * SALARY, -- SALARY + (SALARY * 0.1)
                'MK_REP' , 1.12 * SALARY,
                'PR_REP', 1.15 * SALARY,
                'SA_REP', 1.18 * SALARY,
                'IT_PROG', 1.20 * SALARY,
                0 -- ���� 5�� ������ �ش����� �ʴ� ���
           ) AS "NEW_SALARY",
            DECODE(JOB_ID,
                'HR_REP', 0.10 * SALARY, 
                'MK_REP' , 0.12 * SALARY,
                'PR_REP', 0.15 * SALARY,
                'SA_REP', 0.18 * SALARY,
                'IT_PROG', 0.20 * SALARY,
                0 -- ���� 5�� ������ �ش����� �ʴ� ���
           ) AS "���� �λ� �ݾ�"
    FROM EMPLOYEES;

/*8�� HR �μ������� �ֻ��� �Ի��Ͽ� �ش��ϴ� 2001����� 2003����� �Ի��ڵ��� �޿��� 
  ���� 5%, 3%, 1% �λ��Ͽ� ���п� ���� �������� �����ϰ��� �Ѵ�. 
  ��ü ����� �� �ش� �⵵�� �ش��ϴ� ������� �޿��� �˻��Ͽ� �����ϰ�, 
  �Ի����ڿ� ���� �������� ������ �����Ͻÿ�
**********************************************************************/
-- SELECT MIN(HIRE_DATE) FROM EMPLOYEES; -- ������ �� ���� ���� �Ի���
-- 2001�� ���� �Ի��ڰ� ���ٴ� �����Ͽ� 2001�� �Ի��� Ȯ��
SELECT EMPLOYEE_ID, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < TO_DATE('2002/01/01', 'YYYY/MM/DD');
-- ��¥ Ÿ�� �����Ϳ��� �⵵ 4�ڸ��� �����ؼ� ��
SELECT EMPLOYEE_ID, HIRE_DATE FROM EMPLOYEES
WHERE TO_CHAR(HERE_DATE, 'YYYY') = '2001';


-- ��� 1 )
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

-- ��� 2 )
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, HIRE_DATE,
        JOB_ID, SALARY,
    CASE WHEN HIRE_DATE < TO_DATE('2002/01/01', 'YYYY/MM/DD') -- 2001�� �Ի���
        THEN 1.05 * SALARY
        WHEN HIRE_DATE < TO_DATE('2003/01/01', 'YYYY/MM/DD') -- 2002�� �Ի���
        THEN 1.03 * SALARY
        WHEN HIRE_DATE < TO_DATE('2004/01/01', 'YYYY/MM/DD') -- 2003�� �Ի���
        THEN 1.01 * SALARY
        ELSE SALARY END "NEW SALARY"
FROM EMPLOYEES 
WHERE HIRE_DATE >= TO_DATE('2001/01/01', 'YYYY/MM/DD') -- �ش� �Ⱓ�� �Ի��� ����鸸 ����
    AND HIRE_DATE < TO_DATE('2004/01/01', 'YYYY/MM/DD') -- �������� ������ WHERE�� �ּ�ó��
ORDER BY HIRE_DATE
;

-- ��� 3 (DECODE���) )
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME, HIRE_DATE,
        JOB_ID, SALARY,
        DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), 
                '2001', ROUND(SALARY * 1.05),
                '2002', ROUND(SALARY * 1.03),
                '2003', ROUND(SALARY * 1.01),
                0
            ) AS "����"
    FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY' ) IN ('2001', '2002', '2003') -- �ش� �Ⱓ ������ ����
ORDER BY HIRE_DATE
;


/*9�� �μ��� �޿� �հ踦 ���ϰ�, �� ����� ������ ���� ǥ���Ͻÿ�.
  Sum Salary > 100000 �̸�, "Excellent"
  Sum Salary > 50000 �̸�, "Good"
  Sum Salary > 10000 �̸�, "Medium"
  Sum Salary <= 10000 �̸�, "Well"
**********************************************************************/
SELECT DEPARTMENT_ID, SUM(SALARY) DEPT_SUM_SALARY,
        CASE 
            WHEN SUM(SALARY) > 100000 THEN 'Excellent'
            WHEN SUM(SALARY) > 50000 THEN 'Good'
            WHEN SUM(SALARY) > 10000 THEN 'Medium'
            WHEN SUM(SALARY) <= 10000 THEN 'Well'
            ELSE 'Well' END "�򰡰��"          
FROM EMPLOYEES E
GROUP BY DEPARTMENT_ID
ORDER BY DEPT_SUM_SALARY
;


/*10�� 2005�� ������ �Ի��� ��� �� ������ "MGR"�� ���Ե� ����� 15%, 
  "MAN"�� ���Ե� ����� 20% �޿��� �λ��Ѵ�. 
  ���� 2005����� �ٹ��� ������ ��� �� "MGR"�� ���Ե� ����� 25% �޿��� �λ��Ѵ�. 
  �̸� �����ϴ� ������ �ۼ��Ͻÿ�
**********************************************************************/
-- ������ �ִ��� Ȯ�� (LIKE������ ����� ���� ���������� ����� �� ����)
SELECT JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MGR%';
SELECT JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN%';

-- ������ �� MGR�� MAN�� ���� (���� ������ ����� �� ����)
SELECT DISTINCT JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MGR%' OR JOB_ID LIKE '%MAN%';
-- �Ǵ�
SELECT DISTINCT JOB_ID FROM EMPLOYEES WHERE SUBSTR(JOB_ID, -3) = 'MGR' OR SUBSTR(JOB_ID, -3) = 'MAN';


-----
-----CASE WHEN �̿��ؼ� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME NAME, HIRE_DATE,
        JOB_ID, SALARY,
        -- '2005'�� ���� �Ի� ���� Ȯ��
        CASE 
        WHEN TO_CHAR(HIRE_DATE, 'YYYY') < '2005' 
        THEN  CASE WHEN JOB_ID LIKE '%MGR%' THEN SALARY*1.15
                   WHEN JOB_ID LIKE '%MAN%' THEN SALARY*1.20
                   ELSE SALARY
            END
        -- '2005'�� ���� �ٹ��� ����
        ELSE CASE WHEN JOB_ID LIKE '%MGR%' THEN SALARY*1.25
                  ELSE SALARY
            END
    END AS "����� �޿�"
 
FROM EMPLOYEES
ORDER BY HIRE_DATE
;

--------------
-----DECODE������ ����
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME NAME, HIRE_DATE,
        JOB_ID, SALARY,
        -- '2005'�� ���� �Ի� ���� Ȯ��
        CASE 
        WHEN TO_CHAR(HIRE_DATE, 'YYYY') < '2005' 
        THEN DECODE (SUBSTR(JOB_ID, -3)
                   , 'MGR', SALARY*1.15
                   , 'MAN', SALARY*1.20
                   , SALARY)
        -- '2005'�� ���� �ٹ��� ����
        ELSE DECODE (SUBSTR(JOB_ID, -3), 'MGR', SALARY*1.25
                 , SALARY)
    END AS "����� �޿�"
 
FROM EMPLOYEES
ORDER BY HIRE_DATE
;




/*11�� ������ �Ի��� ��� �� ���
  (���1) ������ �Ի��� ��� ���� �Ʒ��� ���� �� �ະ�� ��µǵ��� �Ͻÿ�(12��).
  1�� xx
  2�� xx
  3�� xx
  ..
  12�� xx
  �հ� XXX
**********************************************************************/  
-- (�밡��) ��� 1)
SELECT 
    
    DECODE(TO_CHAR(HIRE_DATE, 'MM'),
            '01', ' 1��',
            '02', ' 2��',
            '03', ' 3��',
            '04', ' 4��',
            '05', ' 5��',
            '06', ' 6��',
            '07', ' 7��',
            '08', ' 8��',
            '09', ' 9��',
            '10', ' 10��',
            '11', ' 11��',
            '12', ' 12��') "MONTH", COUNT(*) AS "�����"
    
    
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'MM')
ORDER BY TO_CHAR(HIRE_DATE, 'MM')
;
---------------
-- ��� 2)
SELECT DECODE(MM, 99, '�հ�', MM||'��') AS "�Ի��", CNT AS "��� ��"
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
/* (���2) ù �࿡ ��� ���� �Ի� ��� ���� ��µǵ��� �Ͻÿ�
  1�� 2�� 3�� 4�� .... 11�� 12��
  xx  xx  xx xx  .... xx   xx
**********************************************************************/

SELECT MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '01', COUNT(*), 0)) "1��",
    -- SUM(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '01', COUNT(*))) "1��" �̷��� �ص� ��
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '02', COUNT(*), 0)) "2��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '03', COUNT(*), 0)) "3��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '04', COUNT(*), 0)) "4��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '05', COUNT(*), 0)) "5��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '06', COUNT(*), 0)) "6��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '07', COUNT(*), 0)) "7��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '08', COUNT(*), 0)) "8��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '09', COUNT(*), 0)) "9��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '10', COUNT(*), 0)) "10��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '11', COUNT(*), 0)) "11��",
        MAX(DECODE (TO_CHAR(HIRE_DATE, 'MM'), '12', COUNT(*), 0)) "12��",
        SUM(COUNT(*)) AS "��ü ��� ��"
        
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'MM')
;




