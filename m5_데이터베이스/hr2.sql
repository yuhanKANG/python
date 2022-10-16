SELECT * FROM employees;
-- 보너스 받는 사람들(과장 대리가 전부)
SELECT * FROM employees WHERE commission_pct is not null;
SELECT * FROM employees WHERE commission_pct is not null and assistant_manager='과장';
SELECT * FROM employees WHERE commission_pct is not null and assistant_manager='대리';
-- 보너스 받는 사람들 봉급 평균
SELECT avg(e1.salary)
FROM employees e1
WHERE e1.commission_pct is not null and e1.assistant_manager='과장';
SELECT round(avg(e2.salary))
FROM employees e2
WHERE e2.commission_pct is not null and e2.assistant_manager='대리';
------
-- 보너스 없는 사람들 중 과장 대리 추출하기
SELECT * FROM employees WHERE commission_pct is null;
SELECT * FROM employees WHERE commission_pct is null and assistant_manager='과장';
SELECT * FROM employees WHERE commission_pct is null and assistant_manager='대리';
--보너스 받는 사람들 봉급 평균
SELECT avg(e3.salary)
FROM employees e3
WHERE e3.commission_pct is null and e3.assistant_manager='과장';
SELECT round(avg(e4.salary))
FROM employees e4
WHERE e4.commission_pct is null and e4.assistant_manager='대리';

-- 보너스 유무에 따른 과장 봉급차이
SELECT avg(e1.salary) 보너스지급과장, avg(e3.salary) 보너스미지급과장
FROM employees e1, employees e3
WHERE e1.commission_pct is not null and e1.assistant_manager='과장' and
e3.commission_pct is null and e3.assistant_manager='과장';
-- 보너스 유무에 따른 대리 봉급차이
SELECT round(avg(e2.salary)) 보너스지급대리, round(avg(e4.salary)) 보너스미지급대리
FROM employees e2, employees e4
WHERE e2.commission_pct is not null and e2.assistant_manager='대리' and
e4.commission_pct is null and e4.assistant_manager='대리';


select * from employees;
select count(*) from employees;
--Q. HR employees 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력
select last_name||' '||first_name 이름, salary 연봉, salary*1.1 "인상된 연봉" from employees e;


--Q. HR employees 테이블에서 COMMISSION_PCT의 null값 갯수를 출력
--총개수
SELECT COUNT(*)
FROM EMPLOYEES;
--null개수
SELECT COUNT(*)
FROM EMPLOYEES e 
WHERE COMMISSION_PCT IS NULL;

--과제 10/06 (2) hr 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 2개 이상 작성하세요.(예:부서별 평균 salary 순위)





--DCL. 오라클 학습용 서버에 권한있음
--사용자 생성
CREATE user c##user01
identified by userpass;
--사용자 삭제
select * from all_users;
drop user c##user01;

--grant, revoke
CREATE user c##user01
identified by userpass;
--권한주기
GRANT create session, create table to c##user01;
--권한뺏기
REVOKE create session, create table from c##user01;

--사용자 암호 변경
ALTER user c##user01
identified by passuser;

--삭제. cascade : 해당 사용자와 관련된 모든 것을 삭제할 때 사용
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
--autocommit 확인 및 설정
show autocommit;
-- set autocommit on;
-- set autocommit off;