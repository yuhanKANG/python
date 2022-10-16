SELECT * FROM employees;

-- last name�� first name �÷��� �ٿ� ����
SELECT last_name, 'is a' job_id FROM employees;
-- || (shift \)����ϸ� �ٿ� ���� �� ����
SELECT last_name ||' is a ' ||job_id as EXPLAIN FROM employees;

--DISTINCT : ��ø����
SELECT DISTINCT job_id FROM employees;
-- WHERE ���� �����÷� null�� �ִ°� ����
SELECT * FROM employees WHERE commission_pct is null;
-- WHERE ���� �����÷� null�� ���°� ����
SELECT * FROM employees WHERE commission_pct is not null;

--Q. employees ���̺��� commission_pct�� null�� ������ ���
SELECT count(*) 
FROM employees
WHERE commission_pct IS NULL;

--Q. employees ���̺��� employee_id�� Ȧ���� �͸� ���
-- mod : ������ ���ϴ� ��
SELECT * FROM employees WHERE MOD(employee_id, 2) = 1;

SELECT round(355.95555,2) FROM dual; -- �Ҽ� ��°�ڸ����� �ݿø�
SELECT round(355.95555,-2) FROM dual; -- ��������� �ݿø�
SELECT trunc(45.55551,1) FROM dual; -- �ݿø����� �ʰ� �Ҽ��� ù°�ڸ����� �ڸ�

SELECT * FROM employees;
SELECT last_name, trunc(salary/12,2) ���� FROM employees;

--width_bucket (������, �ּҰ�, �ִ밪, bucket����)
SELECT width_bucket(92,0,100,10) FROM dual;
SELECT width_bucket(38,0,100,50) FROM dual;

SELECT upper('Hello World') FROM dual; -- �빮�ڷ� ��ȯ
SELECT lower('Hello World') FROM dual; -- �ҹ��ڷ� ��ȯ

SELECT last_name, salary FROM employees WHERE last_name='king'; --�ȳ���. ��ҹ��ڱ��ж���
SELECT last_name, salary FROM employees WHERE lower(last_name)='king';

SELECT job_id, length(job_id) ���� FROM employees;
-- Hello�� llo ����ϱ� (substr)
SELECT substr('Hello World',3,3) FROM dual;
-- ���������� 3��
SELECT substr('Hello World',-3,3) FROM dual;

-- lpad(��(L)���) : �ش繮��, ???, �߰��Ҹ�
SELECT lpad('Hello World',20,'#') FROM dual;
-- rpad(��(R)���)
SELECT rpad('Hello World',20,'#') FROM dual;

-- last_name���� A�� ����(��ҹ��ڱ���)
SELECT last_name, trim('A' FROM last_name) A���� FROM employees;
-- �ش� ������ ���ʿ� �ִ� a ����
SELECT ltrim('aaaHello Worldaaa','a') FROM dual; -- rtrim�� �����ʿ� �ִ� ���� ����
SELECT trim('    Hello World    ') FROM dual; -- ���� ����
SELECT ltrim('    Hello World    ') FROM dual;
SELECT rtrim('    Hello World    ') FROM dual;

SELECT sysdate FROM dual;

SELECT * FROM dual;

SELECT * FROM employees;
SELECT last_name, trunc((sysdate-hire_date)/365,0) �ټӿ��� FROM employees;

--���� 10/05 (1) employees ���̺��� ä���Ͽ� 6������ �߰��� ��¥�� last_name�� ���� ���
SELECT * FROM employees;
--6���� ���ϱ�
SELECT last_name, ADD_MONTHS(hire_date, 6)
FROM employees;

--���� 10/05 (2) �̹����� ������ ��ȯ�ϴ� �Լ��� ����Ͽ� ������ ���
--���糯¥ ���� �̹��� ���� ���ϱ� (SYSDATE : ���糯¥)
SELECT LAST_DAY(TO_DATE(SYSDATE)) FROM dual;
--employees ���̺��� hire_date�� ���� ���ϱ�
SELECT LAST_DAY(TO_DATE(hire_date)) "��볯¥ ����" FROM employees;

--���� 10/05 (3) employees ���̺��� ä���ϰ� ����������� �ټӿ����� ���
SELECT last_name �̸�, hire_date �Ի���, trunc(months_between(SYSDATE, hire_date)) �ټӿ���
FROM employees;

--���� 10/05 (4) �Ի��� 6���� �� ù��° �������� last_name���� ���
SELECT * FROM employees;
--�̸�, 6������, 6������ ���ƿ��� ������. NEXT_DAY(��¥, 1(�Ͽ���)~7(�����))
--https://thebook.io/006977/ch04/02/03/03/
SELECT last_name �̸�, ADD_MONTHS(hire_date, 6) "�Ի� 6����", NEXT_DAY(ADD_MONTHS(hire_date, 6),2) "�Ի� 6���� �� ù��° ������"
FROM employees;

--���� 10/05 (5) job_id���� �����հ� ������� �ְ��� �������� ���.
              --��, ��տ����� 5000�̻��� ��츸 �����Ͽ� ������������ ����
-- ���⼭ salary�� ����, ��������:DESC(��������:ASC)
-- https://cloudstudying.kr/lectures/513
-- employees ���̺�θ� ���
SELECT job_id, sum(salary) �����հ�, sum(salary)/count(job_id) �������, max(salary) �ְ���, min(salary) ��������
FROM employees
GROUP BY job_id
HAVING sum(salary)/count(job_id) >= 5000
ORDER BY �������;

SELECT * FROM employees;
SELECT * FROM jobs;

--���� 10/05 (6) �����ȣ�� 110�� ����� �μ����� ���
--Ʋ���� SELECT employee_id ���, job_id �μ��� FROM employees WHERE employee_id = 110;
SELECT DEPARTMENT_NAME
FROM EMPLOYEES,DEPARTMENTS
WHERE employees.department_id = departments.department_id(+)
AND employees.employee_id=110;




SELECT * FROM employees;
SELECT * FROM jobs;
--���� 10/05 (7) ����� 120���� ������ ���, �̸�, ����(job_id), ������(job_title) ���
SELECT e.employee_id ���, e.last_name||' '|| e.first_name �̸�, e.job_id ����, j.job_title ������
FROM employees e, jobs j
WHERE e.job_id=j.job_id and e.employee_id = 120;
-- WHERE ���������� and���~~!


SELECT * FROM employees;
--���� 10/05 (8) ���, �̸�, ���� ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
        --salary > 20000 then '��ǥ�̻�'
        --salary > 15000 then '�̻�'
        --salary > 10000 then '����'
        --salary > 3000 then '�븮'
        --������ '���'
        
--���̽� if���� ����� ���
--CASE WHEN
SELECT employee_id, last_name||' '||first_name �̸�, CASE WHEN SALARY > 20000 THEN '��ǥ�̻�'
    WHEN SALARY > 15000 THEN '�̻�'
    WHEN SALARY > 10000 THEN '����'
    WHEN SALARY > 5000 THEN '����'
    WHEN SALARY > 3000  THEN '�븮'
    ELSE '���' END ���� 
FROM employees;




SELECT * FROM employees;
--���� 10/05 (9) employees ���̺��� employee_id�� salary�� �����ؼ� employee_salary ���̺��� �����Ͽ� ���
-- employee_salary ���̺� ����. https://cmelcmel.tistory.com/34 ����

CREATE TABLE employee_salary
AS SELECT employee_id, salary
FROM employees
ORDER BY employee_id;

DESC employee_salary;

SELECT * FROM employee_salary;
SELECT * FROM employees;


--NVL : NULL ���� ������ ������ ǥ��
--SELECT name �̸�, NVL(phone, '����ó����') ��ȭ��ȣ
--���� 10/05 (10) employee_salary ���̺� first_name, last_name �÷��� �߰��� �� name���� �����Ͽ� ���
ALTER TABLE employee_salary ADD FIRST_NAME VARCHAR2(41);
ALTER TABLE employee_salary ADD LAST_NAME VARCHAR2(41);

-- https://coding-factory.tistory.com/291 ����
-- first_name, last_name �÷� �߰�
UPDATE employee_salary s
SET s.first_name = (
SELECT e.first_name
FROM employees e
WHERE s.employee_id=e.employee_id and s.salary=e.salary),
s.last_name = (
SELECT e.last_name
FROM employees e
WHERE s.employee_id=e.employee_id and s.salary=e.salary);

--�÷��߰� Ȯ��
SELECT * FROM employee_salary;
-- first_name, last_name�� name���� �����Ͽ� ���
SELECT employee_id, salary, last_name ||' '|| first_name name
FROM employee_salary;

--���� 10/05 (11) employee_salary ���̺��� employee_id�� �⺻Ű�� �����ϰ� constraint_name�� ES_PK�� ���� �� ���
SELECT * FROM employee_salary;
ALTER TABLE employee_salary add CONSTRAINT KS_PK PRIMARY KEY(employee_id);
--ALTER TABLE newbook ADD PRIMARY KEY(bookid);
desc employee_salary;
--ALTER TABLE employee_salary DROP PRIMARY KEY;
--���� 10/05 (12) employee_salary ���̺��� employee_id���� constraint_name�� ���� �� ���� ���θ� Ȯ��
ALTER TABLE employee_salary DROP CONSTRAINT KS_PK;
