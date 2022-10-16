--DML
SELECT * FROM book;
SELECT bookname, price FROM book;
SELECT publisher FROM book;
--중복피하기 : distinct
SELECT DISTINCT publisher FROM book;
-- 만원 이하
SELECT * FROM book
WHERE price < 10000;

-- Q. 가격이 만원 이상 2만원 이하인 도서 검색
SELECT bookname, price FROM book
WHERE price >= 10000 and price <= 20000;

SELECT bookname, price FROM book
WHERE price BETWEEN 10000 and 20000;

--Q. 출판사가 굿스포츠 혹은 대한미디어인 도서를 검색
SELECT * FROM book
WHERE publisher = '굿스포츠' or publisher = '대한미디어';

SELECT * FROM book
WHERE publisher IN ('굿스포츠','대한미디어');

--Q. 출판사가 굿스포츠 혹은 대한미디어가 아닌 도서를 검색
SELECT * FROM book
WHERE publisher NOT IN ('굿스포츠','대한미디어');

-- 축구로 시작하는 단어가 들어있는 것만 뽑기
SELECT bookname, publisher FROM book
WHERE bookname LIKE '축구%';
-- 축구 가 포함된 것 검색. % : 앞뒤에 뭐가 있다는 뜻 
SELECT bookname, publisher FROM book
WHERE bookname LIKE '%축구%';
--축구의 역사 가 들어간 것 뽑기
SELECT * FROM book
WHERE bookname LIKE '축구의 역사';

--Q. 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서 검색
SELECT bookname, publisher FROM book
WHERE bookname LIKE '_구%';

--Q. 축구에 관한 도서 중 가격이 2만원 이상인 도서 검색
SELECT * FROM book
WHERE bookname LIKE '%축구%' and price >= 20000;

--bookname 정렬. 영&한은 영어가 먼저 나옴
SELECT * FROM book
ORDER BY bookname;
-->Q. 내림차순으로 정렬
SELECT * FROM book
ORDER BY bookname DESC;

--Q. 도서를 가격 순으로 검색하고 가격이 같으면 이름 순으로 검색
SELECT * FROM book
ORDER BY price, bookname;

--Q. 도서를 가격의 내림차순으로 검색하세요. 만약 가격이 같다면 출판사의 오름차순으로 출력
SELECT * FROM book
ORDER BY price DESC, publisher ASC;


SELECT * FROM orders;
--saleprice의 합계
SELECT SUM(saleprice)
FROM orders;

--Q. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하세요.
SELECT * FROM orders;
--saleprice 열을 "총 판매액" 으로 컬럼 변경, 식 계산
SELECT SUM(saleprice) AS "총 판매액" FROM orders
WHERE CUSTID=2;

--Q. saleprice의 합계(TOTAL), 평균(AVG), 최소값(MIN), 최댓값(MAX) 로 출력
SELECT SUM(saleprice) as TOTAL, 
AVG(saleprice) as AVG, MIN(saleprice) as MIN,
MAX(saleprice) as MAX
FROM orders;

--SELECT * FROM orders;
SELECT COUNT(*)
FROM orders;

-- GROUP BY : 같은 속성값끼리 구분. p.159 
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
GROUP BY custid;

--과제09/30 (1) Q. 가격이 8천원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하세요.
--단, 두권 이상 구매한 고객만 구하세요.
--SELECT * FROM orders;
SELECT custid, COUNT(*) FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(*) >=2;

--공통 컬럼으로 테이블 결합
SELECT * FROM customer;
SELECT * FROM orders;

SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid;

--Q. 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 출력
SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid
ORDER BY customer.custid;

--Q. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
SELECT customer.name, orders.saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객별로 정렬
SELECT customer.name, SUM(orders.saleprice)
FROM  customer, orders
WHERE customer.custid = orders.custid
GROUP BY customer.name
ORDER BY customer.name;

--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하세요.
SELECT C.name, B.bookname
FROM customer C, orders O, book B
WHERE C.custid=O.custid AND O.bookid=B.bookid;

--Q. 가격이 2만원인 도서를 주문한 고객의 이름과 도서의 이름을 구하세요.
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid
and orders.bookid = book.bookid and book.price = 20000;

--Q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하세요.
SELECT customer.name, orders.saleprice as 판매가격
FROM customer LEFT JOIN orders on customer.custid=orders.custid;
-- LEFT JOIN : 왼쪽 테이블 기준으로.

SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

--Q. 가장 비싼 도서의 이름을 출력
SELECT bookname
FROM book
WHERE price = (SELECT MAX(price) FROM book);

--과제 09/30 (2) 도서를 구매한 적이 있는 고객의 이름을 검색 p.172
SELECT name FROM customer
WHERE custid IN (SELECT custid FROM orders);

--과제 09/30 (3) 대한미디어에서 출판한 도서를 구매한 고객의 이름을 출력
SELECT name FROM customer
WHERE custid IN (SELECT custid
                 FROM orders
                 WHERE bookid IN(SELECT bookid
                                 FROM book
                                 WHERE publisher='대한미디어'));
--아래부터 읽어야함. (부속질의를 처리하고 전체질의)
--첫번째 : 2. bookid컬럼을 선택 // (book이란 테이블에서) // 1. publisher가 '대한미디어' 인 곳에서
--두번쨰 : 2. custid컬럼 선택 // (orders 테이블에서) // 1. 첫번째에 해당하는 bookid에서
--세번째 : 2. name컬럼 선택 // customer에서 // 1. 두번째에 해당하는 custid에서


--과제 09/30 (4) 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 출력 p.175
SELECT b1.bookname FROM book b1    --상위 부속질의에 사용된 book 테이블을 b1로 별칭
WHERE b1.price > (SELECT  avg(b2.price)   --하위 부속질의에 사용된 book 테이블을 b2로 별칭
                  FROM    book b2
                  WHERE   b2.publisher=b1.publisher);
-- 투플 변수 : 한 테이블이 SQL문에 두 번 사용될 때 혼란을 피하려고 별칭을 붙여 사용
                  
                  
--과제 09/30 (5) 도서를 주문하지 않은 고객의 이름을 출력
SELECT name FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--다른 풀이
SELECT C.name
FROM orders O, customer C
WHERE C.custid NOT IN (SELECT custid FROM orders)
GROUP BY C.name;
--다른 풀이2
SELECT C.name, O.orderid FROM customer C, orders O WHERE C.custid = O.custid(+) and O.custid IS NULL;


--과제 09/30 (6) 주문이 있는 고객의 이름과 주소를 출력 p.177
SELECT name, address FROM customer cs
WHERE EXISTS (SELECT *
              FROM   orders od
              WHERE  cs.custid=od.custid);

--다른 풀이
SELECT name, address FROM customer
WHERE custid IN (SELECT custid FROM orders);

--DDL
CREATE TABLE newbook(
bookid       NUMBER,
bookname     VARCHAR2(20) NOT NULL,
publisher    VARCHAR2(20) UNIQUE,
price        NUMBER DEFAULT 10000 CHECK(price>1000),
PRIMARY KEY (bookid));

SELECT * FROM newbook;
DESC newbook;

DROP TABLE newbook;
------22.10.04
-- p.182
CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));

DESC newcustomer;
DESC orders;

CREATE TABLE neworders(
orderid NUMBER,
custid NUMBER NOT NULL,
bookid NUMBER NOT NULL,
saleprice NUMBER,
orderdate DATE,
PRIMARY KEY(orderid),
FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE);

DESC neworders;

CREATE TABLE newbook(
bookid NUMBER PRIMARY KEY,
bookname VARCHAR2(20) NOT NULL,
publisher VARCHAR2(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK(price>1000));

DESC newbook;
--p.184. newbook테이블에 VARCHAR2(15)의 자료형을 가진 isbn 속성 추가
ALTER TABLE newbook ADD isbn VARCHAR2(15);
--p.185
--과제 10/04 (1) newbook 테이블의 isbn 속성을 삭제하세요.
ALTER TABLE newbook DROP COLUMN isbn;
DESC newbook;

--과제 10/04 (2) newbook 테이블의 기본키를 삭제한 후 다시 bookid 속성을 기본키로 변경하세요.
-- 1. PK(primary key)삭제
ALTER TABLE newbook DROP PRIMARY KEY;
-- 2. bookid 기본키로 변경
ALTER TABLE newbook ADD PRIMARY KEY(bookid);

--과제 10/04 (3) newbook 테이블을 삭제하세요.
DROP TABLE newbook;

--p.190
SELECT * FROM customer;
--Q. CUSTOMER 테이블에서 고객번호가 5인 고객의 주소를 "대한민국 부산"으로 변경.
-- UPDATE 테이블이름 SET 속성이름1=값1[, 속성이름2=값2...] [WHERE <검색조건>];
UPDATE customer    --데이터를 업데이트 하는 것.
SET address = '대한민국 부산'
WHERE custid =5;

--Q. CUSTOMER 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경
UPDATE customer
SET address =(SELECT address FROM customer WHERE name='김연아')
WHERE name='박세리';

--Q. CUSTOMER 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인
--p.191 DELETE 문
DELETE customer
WHERE custid=5;
SELECT * FROM customer;