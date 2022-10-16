--DML
SELECT * FROM book;
SELECT bookname, price FROM book;
SELECT publisher FROM book;
--�ߺ����ϱ� : distinct
SELECT DISTINCT publisher FROM book;
-- ���� ����
SELECT * FROM book
WHERE price < 10000;

-- Q. ������ ���� �̻� 2���� ������ ���� �˻�
SELECT bookname, price FROM book
WHERE price >= 10000 and price <= 20000;

SELECT bookname, price FROM book
WHERE price BETWEEN 10000 and 20000;

--Q. ���ǻ簡 �½����� Ȥ�� ���ѹ̵���� ������ �˻�
SELECT * FROM book
WHERE publisher = '�½�����' or publisher = '���ѹ̵��';

SELECT * FROM book
WHERE publisher IN ('�½�����','���ѹ̵��');

--Q. ���ǻ簡 �½����� Ȥ�� ���ѹ̵� �ƴ� ������ �˻�
SELECT * FROM book
WHERE publisher NOT IN ('�½�����','���ѹ̵��');

-- �౸�� �����ϴ� �ܾ ����ִ� �͸� �̱�
SELECT bookname, publisher FROM book
WHERE bookname LIKE '�౸%';
-- �౸ �� ���Ե� �� �˻�. % : �յڿ� ���� �ִٴ� �� 
SELECT bookname, publisher FROM book
WHERE bookname LIKE '%�౸%';
--�౸�� ���� �� �� �� �̱�
SELECT * FROM book
WHERE bookname LIKE '�౸�� ����';

--Q. �����̸��� ���� �� ��° ��ġ�� '��'��� ���ڿ��� ���� ���� �˻�
SELECT bookname, publisher FROM book
WHERE bookname LIKE '_��%';

--Q. �౸�� ���� ���� �� ������ 2���� �̻��� ���� �˻�
SELECT * FROM book
WHERE bookname LIKE '%�౸%' and price >= 20000;

--bookname ����. ��&���� ��� ���� ����
SELECT * FROM book
ORDER BY bookname;
-->Q. ������������ ����
SELECT * FROM book
ORDER BY bookname DESC;

--Q. ������ ���� ������ �˻��ϰ� ������ ������ �̸� ������ �˻�
SELECT * FROM book
ORDER BY price, bookname;

--Q. ������ ������ ������������ �˻��ϼ���. ���� ������ ���ٸ� ���ǻ��� ������������ ���
SELECT * FROM book
ORDER BY price DESC, publisher ASC;


SELECT * FROM orders;
--saleprice�� �հ�
SELECT SUM(saleprice)
FROM orders;

--Q. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���ϼ���.
SELECT * FROM orders;
--saleprice ���� "�� �Ǹž�" ���� �÷� ����, �� ���
SELECT SUM(saleprice) AS "�� �Ǹž�" FROM orders
WHERE CUSTID=2;

--Q. saleprice�� �հ�(TOTAL), ���(AVG), �ּҰ�(MIN), �ִ�(MAX) �� ���
SELECT SUM(saleprice) as TOTAL, 
AVG(saleprice) as AVG, MIN(saleprice) as MIN,
MAX(saleprice) as MAX
FROM orders;

--SELECT * FROM orders;
SELECT COUNT(*)
FROM orders;

-- GROUP BY : ���� �Ӽ������� ����. p.159 
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
GROUP BY custid;

--����09/30 (1) Q. ������ 8õ�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���ϼ���.
--��, �α� �̻� ������ ���� ���ϼ���.
--SELECT * FROM orders;
SELECT custid, COUNT(*) FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(*) >=2;

--���� �÷����� ���̺� ����
SELECT * FROM customer;
SELECT * FROM orders;

SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid;

--Q. ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���
SELECT *
FROM customer, orders
WHERE customer.custid=orders.custid
ORDER BY customer.custid;

--Q. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
SELECT customer.name, orders.saleprice
FROM customer, orders
WHERE customer.custid=orders.custid;

--Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� ������ ����
SELECT customer.name, SUM(orders.saleprice)
FROM  customer, orders
WHERE customer.custid = orders.custid
GROUP BY customer.name
ORDER BY customer.name;

--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���ϼ���.
SELECT C.name, B.bookname
FROM customer C, orders O, book B
WHERE C.custid=O.custid AND O.bookid=B.bookid;

--Q. ������ 2������ ������ �ֹ��� ���� �̸��� ������ �̸��� ���ϼ���.
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid
and orders.bookid = book.bookid and book.price = 20000;

--Q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���ϼ���.
SELECT customer.name, orders.saleprice as �ǸŰ���
FROM customer LEFT JOIN orders on customer.custid=orders.custid;
-- LEFT JOIN : ���� ���̺� ��������.

SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

--Q. ���� ��� ������ �̸��� ���
SELECT bookname
FROM book
WHERE price = (SELECT MAX(price) FROM book);

--���� 09/30 (2) ������ ������ ���� �ִ� ���� �̸��� �˻� p.172
SELECT name FROM customer
WHERE custid IN (SELECT custid FROM orders);

--���� 09/30 (3) ���ѹ̵��� ������ ������ ������ ���� �̸��� ���
SELECT name FROM customer
WHERE custid IN (SELECT custid
                 FROM orders
                 WHERE bookid IN(SELECT bookid
                                 FROM book
                                 WHERE publisher='���ѹ̵��'));
--�Ʒ����� �о����. (�μ����Ǹ� ó���ϰ� ��ü����)
--ù��° : 2. bookid�÷��� ���� // (book�̶� ���̺���) // 1. publisher�� '���ѹ̵��' �� ������
--�ι��� : 2. custid�÷� ���� // (orders ���̺���) // 1. ù��°�� �ش��ϴ� bookid����
--����° : 2. name�÷� ���� // customer���� // 1. �ι�°�� �ش��ϴ� custid����


--���� 09/30 (4) ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ��� p.175
SELECT b1.bookname FROM book b1    --���� �μ����ǿ� ���� book ���̺��� b1�� ��Ī
WHERE b1.price > (SELECT  avg(b2.price)   --���� �μ����ǿ� ���� book ���̺��� b2�� ��Ī
                  FROM    book b2
                  WHERE   b2.publisher=b1.publisher);
-- ���� ���� : �� ���̺��� SQL���� �� �� ���� �� ȥ���� ���Ϸ��� ��Ī�� �ٿ� ���
                  
                  
--���� 09/30 (5) ������ �ֹ����� ���� ���� �̸��� ���
SELECT name FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

--�ٸ� Ǯ��
SELECT C.name
FROM orders O, customer C
WHERE C.custid NOT IN (SELECT custid FROM orders)
GROUP BY C.name;
--�ٸ� Ǯ��2
SELECT C.name, O.orderid FROM customer C, orders O WHERE C.custid = O.custid(+) and O.custid IS NULL;


--���� 09/30 (6) �ֹ��� �ִ� ���� �̸��� �ּҸ� ��� p.177
SELECT name, address FROM customer cs
WHERE EXISTS (SELECT *
              FROM   orders od
              WHERE  cs.custid=od.custid);

--�ٸ� Ǯ��
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
--p.184. newbook���̺� VARCHAR2(15)�� �ڷ����� ���� isbn �Ӽ� �߰�
ALTER TABLE newbook ADD isbn VARCHAR2(15);
--p.185
--���� 10/04 (1) newbook ���̺��� isbn �Ӽ��� �����ϼ���.
ALTER TABLE newbook DROP COLUMN isbn;
DESC newbook;

--���� 10/04 (2) newbook ���̺��� �⺻Ű�� ������ �� �ٽ� bookid �Ӽ��� �⺻Ű�� �����ϼ���.
-- 1. PK(primary key)����
ALTER TABLE newbook DROP PRIMARY KEY;
-- 2. bookid �⺻Ű�� ����
ALTER TABLE newbook ADD PRIMARY KEY(bookid);

--���� 10/04 (3) newbook ���̺��� �����ϼ���.
DROP TABLE newbook;

--p.190
SELECT * FROM customer;
--Q. CUSTOMER ���̺��� ����ȣ�� 5�� ���� �ּҸ� "���ѹα� �λ�"���� ����.
-- UPDATE ���̺��̸� SET �Ӽ��̸�1=��1[, �Ӽ��̸�2=��2...] [WHERE <�˻�����>];
UPDATE customer    --�����͸� ������Ʈ �ϴ� ��.
SET address = '���ѹα� �λ�'
WHERE custid =5;

--Q. CUSTOMER ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� ����
UPDATE customer
SET address =(SELECT address FROM customer WHERE name='�迬��')
WHERE name='�ڼ���';

--Q. CUSTOMER ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ��
--p.191 DELETE ��
DELETE customer
WHERE custid=5;
SELECT * FROM customer;