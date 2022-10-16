SELECT * FROM employees;
-- ���ʽ� �޴� �����(���� �븮�� ����)
SELECT * FROM employees WHERE commission_pct is not null;
SELECT * FROM employees WHERE commission_pct is not null and assistant_manager='����';
SELECT * FROM employees WHERE commission_pct is not null and assistant_manager='�븮';
-- ���ʽ� �޴� ����� ���� ���
SELECT avg(e1.salary)
FROM employees e1
WHERE e1.commission_pct is not null and e1.assistant_manager='����';
SELECT round(avg(e2.salary))
FROM employees e2
WHERE e2.commission_pct is not null and e2.assistant_manager='�븮';
------
-- ���ʽ� ���� ����� �� ���� �븮 �����ϱ�
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is null and assistant_manager='����';
SELECT * FROM employees WHERE commission_pct is null and assistant_manager='�븮';
--���ʽ� �޴� ����� ���� ���
SELECT avg(e3.salary)
FROM employees e3
WHERE e3.commission_pct is null and e3.assistant_manager='����';
SELECT round(avg(e4.salary))
FROM employees e4
WHERE e4.commission_pct is null and e4.assistant_manager='�븮';

-- ���ʽ� ������ ���� ���� ��������
SELECT avg(e1.salary) ���ʽ����ް���, avg(e3.salary) ���ʽ������ް���
FROM employees e1, employees e3
WHERE e1.commission_pct is not null and e1.assistant_manager='����' and
e3.commission_pct is null and e3.assistant_manager='����';
-- ���ʽ� ������ ���� �븮 ��������
SELECT round(avg(e2.salary)) ���ʽ����޴븮, round(avg(e4.salary)) ���ʽ������޴븮
FROM employees e2, employees e4
WHERE e2.commission_pct is not null and e2.assistant_manager='�븮' and
e4.commission_pct is null and e4.assistant_manager='�븮';


select * from employees;
select count(*) from employees;
--Q. HR employees ���̺��� �̸�, ����, 10% �λ�� ������ ���
select last_name||' '||first_name �̸�, salary ����, salary*1.1 "�λ�� ����" from employees e;


--Q. HR employees ���̺��� COMMISSION_PCT�� null�� ������ ���
--�Ѱ���
SELECT COUNT(*)
FROM EMPLOYEES;
--null����
SELECT COUNT(*)
FROM EMPLOYEES e 
WHERE COMMISSION_PCT IS NULL;

--���� 10/06 (2) hr ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� 2�� �̻� �ۼ��ϼ���.(��:�μ��� ��� salary ����)





--DCL. ����Ŭ �н��� ������ ��������
--����� ����
CREATE user c##user01
identified by userpass;
--����� ����
select * from all_users;
drop user c##user01;

--grant, revoke
CREATE user c##user01
identified by userpass;
--�����ֱ�
GRANT create session, create table to c##user01;
--���ѻ���
REVOKE create session, create table from c##user01;

--����� ��ȣ ����
ALTER user c##user01
identified by passuser;

--����. cascade : �ش� ����ڿ� ���õ� ��� ���� ������ �� ���
DROP user c##user01 CASCADE;

CREATE TABLE users(
id number,
name varchar2(20),
age number);

INSERT into users values(1, 'hong gildong', 30);
INSERT into users values(2, 'hong gilgun', 30);

delete from users where id=1;

select * from users;
--rollback;

commit;
--autocommit Ȯ�� �� ����
show autocommit;
-- set autocommit on;
-- set autocommit off;