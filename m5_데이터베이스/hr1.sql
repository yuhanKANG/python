SELECT * FROM employees;

-- last name과 first name 컬럼을 붙여 쓰기
SELECT last_name, 'is a' job_id FROM employees;
-- || (shift \)사용하면 붙여 써줄 수 있음
SELECT last_name ||' is a ' ||job_id as EXPLAIN FROM employees;

--DISTINCT : 중첩제거
SELECT DISTINCT job_id FROM employees;
-- WHERE 이하 지정컬럼 null값 있는것 보기
SELECT * FROM employees WHERE commission_pct is null;
-- WHERE 이하 지정컬럼 null값 없는것 보기
SELECT * FROM employees WHERE commission_pct is not null;

--Q. employees 테이블에서 commission_pct의 null값 갯수를 출력
SELECT count(*) 
FROM employees
WHERE commission_pct IS NULL;

--Q. employees 테이블에서 employee_id가 홀수인 것만 출력
-- mod : 나머지 구하는 것
SELECT * FROM employees WHERE MOD(employee_id, 2) = 1;

SELECT round(355.95555,2) FROM dual; -- 소수 둘째자리까지 반올림
SELECT round(355.95555,-2) FROM dual; -- 백단위까지 반올림
SELECT trunc(45.55551,1) FROM dual; -- 반올림하지 않고 소수점 첫째자리까지 자름

SELECT * FROM employees;
SELECT last_name, trunc(salary/12,2) 월급 FROM employees;

--width_bucket (지정값, 최소값, 최대값, bucket갯수)
SELECT width_bucket(92,0,100,10) FROM dual;
SELECT width_bucket(38,0,100,50) FROM dual;

SELECT upper('Hello World') FROM dual; -- 대문자로 전환
SELECT lower('Hello World') FROM dual; -- 소문자로 전환

SELECT last_name, salary FROM employees WHERE last_name='king'; --안나옴. 대소문자구분때문
SELECT last_name, salary FROM employees WHERE lower(last_name)='king';

SELECT job_id, length(job_id) 길이 FROM employees;
-- Hello의 llo 출력하기 (substr)
SELECT substr('Hello World',3,3) FROM dual;
-- 끝에서부터 3개
SELECT substr('Hello World',-3,3) FROM dual;

-- lpad(엘(L)페드) : 해당문자, ???, 추가할말
SELECT lpad('Hello World',20,'#') FROM dual;
-- rpad(알(R)페드)
SELECT rpad('Hello World',20,'#') FROM dual;

-- last_name에서 A만 삭제(대소문자구분)
SELECT last_name, trim('A' FROM last_name) A삭제 FROM employees;
-- 해당 문자의 왼쪽에 있는 a 삭제
SELECT ltrim('aaaHello Worldaaa','a') FROM dual; -- rtrim은 오른쪽에 있는 문자 삭제
SELECT trim('    Hello World    ') FROM dual; -- 공백 제거
SELECT ltrim('    Hello World    ') FROM dual;
SELECT rtrim('    Hello World    ') FROM dual;

SELECT sysdate FROM dual;

SELECT * FROM dual;

SELECT * FROM employees;
SELECT last_name, trunc((sysdate-hire_date)/365,0) 근속연수 FROM employees;

--과제 10/05 (1) employees 테이블에서 채용일에 6개월을 추가한 날짜를 last_name과 같이 출력
SELECT * FROM employees;
--6개월 더하기
SELECT last_name, ADD_MONTHS(hire_date, 6)
FROM employees;

--과제 10/05 (2) 이번달의 말일을 반환하는 함수를 사용하여 말일을 출력
--현재날짜 기준 이번달 말일 구하기 (SYSDATE : 현재날짜)
SELECT LAST_DAY(TO_DATE(SYSDATE)) FROM dual;
--employees 테이블에서 hire_date의 말일 구하기
SELECT LAST_DAY(TO_DATE(hire_date)) "고용날짜 월말" FROM employees;

--과제 10/05 (3) employees 테이블에서 채용일과 현재시점간의 근속월수를 출력
SELECT last_name 이름, hire_date 입사일, trunc(months_between(SYSDATE, hire_date)) 근속월수
FROM employees;

--과제 10/05 (4) 입사일 6개월 후 첫번째 월요일을 last_name별로 출력
SELECT * FROM employees;
--이름, 6개월후, 6개월후 돌아오는 월요일. NEXT_DAY(날짜, 1(일요일)~7(토요일))
--https://thebook.io/006977/ch04/02/03/03/
SELECT last_name 이름, ADD_MONTHS(hire_date, 6) "입사 6개월", NEXT_DAY(ADD_MONTHS(hire_date, 6),2) "입사 6개월 후 첫번째 월요일"
FROM employees;

--과제 10/05 (5) job_id별로 연봉합계 연봉평균 최고연봉 최저연봉 출력.
              --단, 평균연봉이 5000이상인 경우만 포함하여 내림차순으로 정렬
-- 여기서 salary는 연봉, 내림차순:DESC(오름차순:ASC)
-- https://cloudstudying.kr/lectures/513
-- employees 테이블로만 계산
SELECT job_id, sum(salary) 연봉합계, sum(salary)/count(job_id) 연봉평균, max(salary) 최고연봉, min(salary) 최저연봉
FROM employees
GROUP BY job_id
HAVING sum(salary)/count(job_id) >= 5000
ORDER BY 연봉평균;

SELECT * FROM employees;
SELECT * FROM jobs;

--과제 10/05 (6) 사원번호가 110인 사원의 부서명을 출력
--틀린거 SELECT employee_id 사번, job_id 부서명 FROM employees WHERE employee_id = 110;
SELECT DEPARTMENT_NAME
FROM EMPLOYEES,DEPARTMENTS
WHERE employees.department_id = departments.department_id(+)
AND employees.employee_id=110;




SELECT * FROM employees;
SELECT * FROM jobs;
--과제 10/05 (7) 사번이 120번인 직원의 사번, 이름, 업무(job_id), 업무명(job_title) 출력
SELECT e.employee_id 사번, e.last_name||' '|| e.first_name 이름, e.job_id 업무, j.job_title 업무명
FROM employees e, jobs j
WHERE e.job_id=j.job_id and e.employee_id = 120;
-- WHERE 다중조건은 and사용~~!


SELECT * FROM employees;
--과제 10/05 (8) 사번, 이름, 직급 출력하세요. 단, 직급은 아래 기준에 의함
        --salary > 20000 then '대표이사'
        --salary > 15000 then '이사'
        --salary > 10000 then '과장'
        --salary > 3000 then '대리'
        --나머지 '사원'
        
--파이썬 if문과 비슷한 방식
--CASE WHEN
SELECT employee_id, last_name||' '||first_name 이름, CASE WHEN SALARY > 20000 THEN '대표이사'
    WHEN SALARY > 15000 THEN '이사'
    WHEN SALARY > 10000 THEN '부장'
    WHEN SALARY > 5000 THEN '과장'
    WHEN SALARY > 3000  THEN '대리'
    ELSE '사원' END 직급 
FROM employees;




SELECT * FROM employees;
--과제 10/05 (9) employees 테이블에서 employee_id와 salary만 추출해서 employee_salary 테이블을 생성하여 출력
-- employee_salary 테이블 생성. https://cmelcmel.tistory.com/34 참조

CREATE TABLE employee_salary
AS SELECT employee_id, salary
FROM employees
ORDER BY employee_id;

DESC employee_salary;

SELECT * FROM employee_salary;
SELECT * FROM employees;


--NVL : NULL 값을 지정된 값으로 표기
--SELECT name 이름, NVL(phone, '연락처없음') 전화번호
--과제 10/05 (10) employee_salary 테이블에 first_name, last_name 컬럼을 추가한 후 name으로 변경하여 출력
ALTER TABLE employee_salary ADD FIRST_NAME VARCHAR2(41);
ALTER TABLE employee_salary ADD LAST_NAME VARCHAR2(41);

-- https://coding-factory.tistory.com/291 참조
-- first_name, last_name 컬럼 추가
UPDATE employee_salary s
SET s.first_name = (
SELECT e.first_name
FROM employees e
WHERE s.employee_id=e.employee_id and s.salary=e.salary),
s.last_name = (
SELECT e.last_name
FROM employees e
WHERE s.employee_id=e.employee_id and s.salary=e.salary);

--컬럼추가 확인
SELECT * FROM employee_salary;
-- first_name, last_name을 name으로 변경하여 출력
SELECT employee_id, salary, last_name ||' '|| first_name name
FROM employee_salary;

--과제 10/05 (11) employee_salary 테이블의 employee_id에 기본키를 적용하고 constraint_name을 ES_PK로 지정 후 출력
SELECT * FROM employee_salary;
ALTER TABLE employee_salary add CONSTRAINT KS_PK PRIMARY KEY(employee_id);
--ALTER TABLE newbook ADD PRIMARY KEY(bookid);
desc employee_salary;
--ALTER TABLE employee_salary DROP PRIMARY KEY;
--과제 10/05 (12) employee_salary 테이블의 employee_id에서 constraint_name을 삭제 후 삭제 여부를 확인
ALTER TABLE employee_salary DROP CONSTRAINT KS_PK;
