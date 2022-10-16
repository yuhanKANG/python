-- ▶?Dual 테이블의 정의
--?1. 오라클 자체에서 제공되는 테이블
--?2. 간단하게 함수를 이용해서 계산 결과값을 확인 할 때 사용하는 테이블

-- ABS : 절댓값
SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875,1)
FROM dual;

SELECT * FROM orders;
SELECT * FROM customer;
--Q. 고객이름별 평균 주문 금액을 백원 단위로 반올림한 값을 구하세요. p.212
SELECT C.name, ROUND(avg(O.saleprice),-2)
FROM orders O, customer C 
WHERE C.custid=O.custid   --고객별 데이터를 주문데이터에 결합
GROUP BY C.name;

SELECT * FROM book;
--Q. 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서목록, 가격을 출력 p.214
-- SELECT 컬럼 나열. 컬럼은 콤마로 구분해주고 컬럼 한칸띄고 뭔갈 적으면 적은대로 컬럼명 재정의
-- SELECT 컬럼 REPLACE(컬럼, 기존단어, 대체단어), 컬럼, 컬럼, ...
SELECT bookid, REPLACE(bookname, '야구','농구') bookname, publisher, price
FROM book; -- 원본은 변하지 않음

--p.215
SELECT bookname 제목, LENGTH(bookname) 글자수,
       LENGTHB(bookname) as 바이트수 -- 바이트수로 셀땐 lengthb, 여기선 as 생략가능
FROM book;
--WHERE publisher='굿스포츠';
DESC customer;
SELECT * FROM customer;
INSERT INTO customer VALUES(5, '박세리', '대한민국 대전', NULL); --customid 5번, 이름, 주소, 폰. 컬럼에 맞게 넣어주어야함

-- 과제 10/04 (4). 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하세요.
-- p.215 SUBSTR : 문자열의 특정 위치에서 시작하여 지정된 길이만큼 문자열 반환
-- SUBSTR(name,1,1) : name컬럼 첫번째 문자열에서 한개 반환
SELECT SUBSTR(name,1,1) 성, COUNT(*) 인원
FROM customer
GROUP BY SUBSTR(name,1,1);

SELECT * FROM orders;
--Q. 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하세요.
--p.217
SELECT orderid 주문번호, orderdate 주문일, orderdate+10 확정일자
FROM orders;

--과제 10/04 (5) 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 출력
--단, 주문일은 '2020-07-07 화요일' 포맷. p.217~218
-- https://tysoso.tistory.com/31
SELECT orderid 주문번호, TO_CHAR(orderdate, 'yyyy-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
-- 아래서 처리한 날짜형을 다시 문자형으로
FROM orders
WHERE orderdate=TO_DATE('20200707', 'yyyymmdd'); --문자형>날짜형

-- p.219 DBMS 서버에 설정된 현재 날짜와 시간, 요일 확인
SELECT SYSDATE FROM dual;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

SELECT * FROM customer;
--Q. 이름, 전화번호가 포함된 고객목록을 보이세요. 단, 전화번호가 없는 고객은 '연락처없음'으로 표기
-- p.222 NVL : NULL 값을 지정된 값으로 표기
SELECT name 이름, NVL(phone, '연락처없음') 전화번호
FROM customer;

--SELECT COALESCE(NULL,NULL,'third value','forth value');
-- 세번째 값이 NULL이 아닌 첫 값이기 때문에 세번째 값을 반환
SELECT name 이름, phone, COALESCE(phone, '연락처없음') 전화번호
FROM customer;

-- ROWNUM :  SQL조회 결과의 순번 나타냄. 자료 일부분 확인할 때 유용
SELECT ROWNUM 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE ROWNUM <=3; --행 개수 조절

--Q. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 출력 p.226
SELECT * FROM customer;
SELECT * FROM orders;

SELECT orderid 주문번호, saleprice 금액
FROM orders
WHERE saleprice < (SELECT AVG(saleprice) FROM orders);

--Q. 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 출력 p.227
SELECT orderid 주문번호, custid 고객번호, saleprice 금액
FROM  orders O1
WHERE saleprice > (SELECT AVG(saleprice) FROM orders O2
                   WHERE O1.custid=O2.custid);


--과제 10/04 (6) 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 출력 p.228
SELECT * FROM orders;
SELECT SUM(saleprice) "총 판매액"
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%대한민국%');
--대한민국에 거주하지 않는 고객: NOT IN 으로 변경

--과제 10/04 (7) 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 출력 p.229
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL (SELECT saleprice FROM orders WHERE custid=3);
-- 여기 saleprice값은 6000,12000, 13000. 가장 큰 13000원보다 큰 금액을 결과로 출력

--과제 10/04 (8) 고객번호가 2 이하인 고객의 판매액을 출력(단, 고객이름과 고객별 판매액 포함) p.234
SELECT cs.name, SUM(od.saleprice) total
FROM (SELECT custid, name FROM customer WHERE custid <=2) cs, orders od
WHERE cs.custid=od.custid
GROUP BY cs.name;


SELECT * FROM customer;
SELECT * FROM orders;


SELECT c.name, SUM(o.saleprice)
FROM orders o, customer c
WHERE c.custid = o.custid(+)   -- + : 왼쪽것이 기준
GROUP BY c.name;

--Q. NULL을 0으로 컬럼명을 고객별 판매액으로 수정
-- p.222 NVL : NULL 값을 지정된 값으로 표기. 아래는 NVL(해당컬럼의 null값을, 0으로 표기)
SELECT C.name, NVL(SUM(O.saleprice),0) "고객별 판매액"
FROM orders O, customer C
WHERE C.custid = O.custid(+)
GROUP BY C.name;

-- View는 가상의 테이블이라고 하며 데이터는 없고 SQL만 저장되어 있는 Object. p.235
-- View는 기본 테이블이나 뷰를 삭제하게 되면 해당 데이터를 기초로 한 다른 뷰들이 자동으로 삭제되고 ALTER 명령을 사용할 수 없다.
-- 내용을 수정하기 위해서는 DROP & CREATE를 반복하여야 하며 원본 이름으로 생성할 수 없다. 실무에서는 "vw_"접미사나 접두사를 붙여 사용

-- 뷰의 생성
-- CREATE VIEW 뷰이름
-- AS SELECT문
CREATE VIEW vw_customer
AS SELECT *
FROM customer
WHERE address LIKE '%대한민국%';

SELECT * FROM vw_customer;

--Q. Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후
-- 김연아 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 출력 p.239
CREATE VIEW vw_orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT od.orderid, od.custid, cs.name,
          od.bookid, bk.bookname, od.saleprice, od.orderdate
FROM orders od, customer cs, book bk
WHERE od.custid=cs.custid AND od.bookid=bk.bookid;
--확인작업
SELECT orderid, bookname, saleprice
FROM vw_orders
WHERE name='김연아';

--Q. 앞서 생성한 뷰를 vw_customer를 삭제 p.240
DROP VIEW vw_orders;

