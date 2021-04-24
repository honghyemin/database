/* ***** HR DB ������ ��ȸ �ǽ� *****************
��1 HR �μ����� ���� �� ������ �޿� ���� ������ �ۼ��Ϸ��� �Ѵ�. 
  �������(Employees) ���̺��� �޿��� $7,000~$10,000 ���� �̿��� ����� 
  �̸��� ��(Name���� ��Ī) �� �޿��� �޿��� ���� ������ ����Ͻÿ�
*/
-- ��� 1
SELECT FIRST_NAME||' '||LAST_NAME NAME, SALARY 
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 7000 AND 10000
ORDER BY SALARY 
;
-- ��� 2
SELECT FIRST_NAME||' '||LAST_NAME NAME, SALARY 
FROM EMPLOYEES
WHERE SALARY < 7000 OR SALARY > 10000
ORDER BY SALARY 
;

/*
��2 HR �μ������� �޿�(salary)�� ������(commission_pct)�� ���� ���� ������ �ۼ��Ϸ��� �Ѵ�. 
  ������ �޴� ��� ����� �̸��� ��(Name���� ��Ī), �޿�, ����, �������� ����Ͻÿ�. 
  �̶� �޿��� ū ������� �����ϵ�, �޿��� ������ �������� ū ������� �����Ͻÿ�
*/
SELECT FIRST_NAME||' '||LAST_NAME NAME, 
        SALARY, JOB_ID, COMMISSION_PCT
FROM EMPLOYEES 
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY DESC, COMMISSION_PCT DESC
;

/*  
��3 �̹� �б⿡ 60�� IT �μ������� �ű� ���α׷��� �����ϰ� �����Ͽ� ȸ�翡 �����Ͽ���. 
  �̿� �ش� �μ��� ��� �޿��� 12.3% �λ��ϱ�� �Ͽ���. 
  60�� IT �μ� ����� �޿��� 12.3% �λ��Ͽ� ������(�ݿø�) ǥ���ϴ� ������ �ۼ��Ͻÿ�. 
  ������ �����ȣ, ���� �̸�(Name���� ��Ī), �޿�, �λ�� �޿�(Increase Salary�� ��Ī)������ ����Ͻÿ�
*/  
SELECT EMPLOYEE_ID, LAST_NAME||' '||FIRST_NAME NAME,
        SALARY, DEPARTMENT_ID , 
        -- ROUND(SALARY * 0.123) AS "�λ�ݾ�",
        ROUND(SALARY*1.123) AS INCREASE_SALARY
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 60
;


/*
��4 �� ����� ��(last_name)�� 's'�� ������ ����� �̸��� ������ �Ʒ��� ���� ���� ����ϰ��� �Ѵ�. 
  ��� �� �̸�(first_name)�� ��(last_name)�� ù ���ڰ� �빮��, ������ ��� �빮�ڷ� ����ϰ� 
  �Ӹ���(��ȸ�÷���)�� Employee JOBs.�� ǥ���Ͻÿ�
  ��) FIRST_NAME  LAST_NAME  Employee JOBs.
      Shelley     Higgins    AC_MGR
*/
SELECT INITCAP(FIRST_NAME)||' '||INITCAP(LAST_NAME) Name,
        UPPER(JOB_ID) "Employee_JOBs."
FROM EMPLOYEES 
WHERE LOWER(LAST_NAME) LIKE '%s' --LOWERó���� ����������
;

/*
��5 ��� ����� ������ ǥ���ϴ� ������ �ۼ��Ϸ��� �Ѵ�. 
  ������ ����� �̸��� ��(Name���� ��Ī), �޿�, ���翩�ο� ���� ������ �����Ͽ� ����Ͻÿ�. 
  ���翩�δ� ������ ������ "Salary + Commission", ������ ������ "Salary only"��� ǥ���ϰ�, 
  ��Ī�� ������ ���̽ÿ�. ���� ��� �� ������ ���� ������ �����Ͻÿ�
*/
SELECT FIRST_NAME||' '||LAST_NAME NAME, SALARY,
        COMMISSION_PCT,
        SALARY*12 AS "����",
        'Salary only' AS COMMISSION_YN
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL
UNION
SELECT FIRST_NAME||' '||LAST_NAME NAME, SALARY,
        COMMISSION_PCT,
        SALARY*(1+COMMISSION_PCT)*12 AS "����", -- 1�� �����ִ� ���� ���� �޾ƾ� �� �� + ����
        'Salary + Commission' AS COMMISSION_YN
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY "����" DESC
;

-- DECODE : IF��ó�� ����� �� ����, ����񱳸� ���� �б� ó��
SELECT FIRST_NAME||' '||LAST_NAME NAME, SALARY,
        COMMISSION_PCT,
        DECODE(COMMISSION_PCT, NULL, 'Salary Only', 'Salary + Commission') AS COMMISSION_YN,
        SALARY * (1 + NVL(COMMISSION_PCT,0))*12 AS SALARY12 
        -- > COMMISSION_PCE�� NULL�� ����� ���ϱ⸦ �ص� NULL�̹Ƿ� ������ �ȵ�
FROM EMPLOYEES
ORDER BY SALARY12 DESC
;




/*
��6 �� ����� �Ҽӵ� �μ����� �޿� �հ�, �޿� ���, �޿� �ִ�, �޿� �ּڰ��� �����ϰ��� �Ѵ�. 
  ���� ��°��� ���� �ڸ��� �� �ڸ� ���б�ȣ, $ǥ�ÿ� �Բ� ���($123,456) 
  ��, �μ��� �Ҽӵ��� ���� ����� ���� ������ �����ϰ�, ��� �� �Ӹ����� ��Ī(alias) ó���Ͻÿ�
*/    
SELECT DEPARTMENT_ID, TO_CHAR(SUM(SALARY),'$999,999') SUM, TO_CHAR(AVG(SALARY),'$999,999') AVG, 
                    TO_CHAR(MAX(SALARY), '$999,999') MAX,  TO_CHAR(MIN(SALARY), '$999,999') MIN
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID
;



/*
��7 ������� ������ ��ü �޿� ����� $10,000���� ū ��츦 ��ȸ�Ͽ� 
    ������ �޿� ����� ����Ͻÿ�. 
  �� ������ CLERK�� ���Ե� ���� �����ϰ� ��ü �޿� ����� ���� ������� ����Ͻÿ�
*/
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES  
WHERE JOB_ID NOT LIKE '%CLERK%'
GROUP BY JOB_ID
HAVING AVG(SALARY)>10000
ORDER BY AVG(SALARY) DESC
;


/*
��8 HR ��Ű���� �����ϴ� Employees, Departments, Locations ���̺��� ������ �ľ��� �� 
  Oxford�� �ٹ��ϴ� ����� �̸��� ��(Name���� ��Ī), ����, �μ��̸�, �����̸��� ����Ͻÿ�. 
  �̶� ù ��° ���� ȸ���̸��� 'HR-Company'�̶�� ������� ��µǵ��� �Ͻÿ�
*/
SELECT 'HR-Company' "C.NAME", E.FIRST_NAME||' '||LAST_NAME NAME, 
                    E.JOB_ID, D.DEPARTMENT_NAME "D.NAME", L.CITY 
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE L.LOCATION_ID = D.LOCATION_ID
AND D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND L.CITY = 'Oxford'
;


/*
��9 HR ��Ű���� �ִ� Employees, Departments ���̺��� ������ �ľ��� �� 
  ������� �ټ� �� �̻��� �μ��� �μ��̸��� ��� ���� ����Ͻÿ�. 
  �̶� ��� ���� ���� ������ �����Ͻÿ�
*/
SELECT D.DEPARTMENT_NAME "�μ���", COUNT(*) "��� ��"
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING COUNT(*)>=5
ORDER BY COUNT(*) DESC
;
-- ( �ǽ� ) ENP_DETAILS_VIEW ����ؼ� ������ ��ȸ
--CREATE VIEW ENP_DETAILS_VIEW
--AS





/*
��10 �� ����� �޿��� ���� �޿� ����� �����Ϸ��� �Ѵ�. 
  �޿� ����� Job_Grades ���̺� ǥ�õȴ�. �ش� ���̺��� ������ ���캻 �� 
  ����� �̸��� ��(Name���� ��Ī), ����, �μ��̸�, �Ի���, �޿�, �޿������ ����Ͻÿ�.
  
********************************/
CREATE TABLE JOB_GRADES (
    GRADE_LEVEL VARCHAR2(3),
    LOWEST_SAL NUMBER,
    HIGHEST_SAL NUMBER
);
INSERT INTO JOB_GRADES VALUES ('A', 1000, 2999);
INSERT INTO JOB_GRADES VALUES ('B', 3000, 5999);
INSERT INTO JOB_GRADES VALUES ('C', 6000, 9999);
INSERT INTO JOB_GRADES VALUES ('D', 10000, 14999);
INSERT INTO JOB_GRADES VALUES ('E', 15000, 24999);
INSERT INTO JOB_GRADES VALUES ('F', 25000, 40000);
COMMIT;
---------
SELECT E.LAST_NAME||' '||FIRST_NAME NAME, E.JOB_ID,D.DEPARTMENT_NAME "�μ���",
       E.HIRE_DATE, E.SALARY, J.GRADE_LEVEL "LEVEL"
FROM JOB_GRADES J, EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.SALARY BETWEEN J.LOWEST_SAL AND J.HIGHEST_SAL
ORDER BY "LEVEL" 
;


