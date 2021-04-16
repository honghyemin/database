/* STUDENT ���̺� ����
�������� ���� �÷��� �߰�
*/
CREATE TABLE STUDENT(
    ID VARCHAR2(20),
    NAME VARCHAR2(30),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MATH NUMBER(3),
    TOT NUMBER(3),
    AVG NUMBER(5,2)
);
-------------------------------------------
-- CRUD : INSERT(�Է�), SELECT, UPDATE(����), DELETE(����)
SELECT * FROM STUDENT; --��ü ������ �˻�
SELECT ID, NAME FROM STUDENT; -- ID�� NAME�� �˻�

-- ������ �߰�(�Է�) : INSERT INTO
INSERT INTO STUDENT 
        (ID, NAME, KOR, ENG, MATH)
VALUES ('1111', 'ȫ�浿', 100, 90, 80); -- ������ ��Ȯ�� 1:1�� ��Ī�Ǿ�� �� 
COMMIT; -- �������� �۾� ����� DB�� �ݿ�. ������� ������ �Ŀ� ROCK�� �ɸ��� ���� ��Ȳ�� �߻��� �� ����.
ROLLBACK; -- �۾����(INSERT, UPDATE, DELETE �۾�)

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2222', '������', 90, 80, 70); -- ���������� ���� ������ �ٽ� ��������� �� �Ȱ��� ������ ���̺� �߰���.
COMMIT; 
------------------------------------------
-- ���� : �����͸� ���� -UPDATE (SET)
UPDATE  STUDENT
SET ENG = 88, MATH = 77 -- �ٲ� �����͸� �������� ������ ��ü �����Ͱ� �ٲ�.
WHERE NAME = '������';
COMMIT;
SELECT * FROM STUDENT WHERE NAME = '������'; -- ���ϴ� �����͸� �˻�
SELECT * FROM STUDENT WHERE NAME = 'ȫ�浿';
------------------------------------------
-- ���� : �����͸� ���� -DELETE FROM
SELECT * FROM STUDENT WHERE ID = '2222';
DELETE FROM STUDENT WHERE ID = '2222'; -- DELETE FROM STUDENT �� ����� ��� ��ü �����Ͱ� �� ������
DELETE FROM STUDENT WHERE NAME = '������';
SELECT * FROM STUDENT WHERE NAME = '������';
COMMIT;
-- ===============================================
INSERT INTO STUDENT (ID)VALUES('3333'); -- ID�÷� �ϳ��� ����. -> ID�� ������ ��� �׸��� �� NULL ��