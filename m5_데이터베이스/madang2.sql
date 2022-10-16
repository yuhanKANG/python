-- ��?Dual ���̺��� ����
--?1. ����Ŭ ��ü���� �����Ǵ� ���̺�
--?2. �����ϰ� �Լ��� �̿��ؼ� ��� ������� Ȯ�� �� �� ����ϴ� ���̺�

-- ABS : ����
SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875,1)
FROM dual;

SELECT * FROM orders;
SELECT * FROM customer;
--Q. ���̸��� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���ϼ���. p.212
SELECT C.name, ROUND(avg(O.saleprice),-2)
FROM orders O, customer C 
WHERE C.custid=O.custid   --���� �����͸� �ֹ������Ϳ� ����
GROUP BY C.name;

SELECT * FROM book;
--Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� �������, ������ ��� p.214
-- SELECT �÷� ����. �÷��� �޸��� �������ְ� �÷� ��ĭ��� ���� ������ ������� �÷��� ������
-- SELECT �÷� REPLACE(�÷�, �����ܾ�, ��ü�ܾ�), �÷�, �÷�, ...
SELECT bookid, REPLACE(bookname, '�߱�','��') bookname, publisher, price
FROM book; -- ������ ������ ����

--p.215
SELECT bookname ����, LENGTH(bookname) ���ڼ�,
       LENGTHB(bookname) as ����Ʈ�� -- ����Ʈ���� ���� lengthb, ���⼱ as ��������
FROM book;
--WHERE publisher='�½�����';
DESC customer;
SELECT * FROM customer;
INSERT INTO customer VALUES(5, '�ڼ���', '���ѹα� ����', NULL); --customid 5��, �̸�, �ּ�, ��. �÷��� �°� �־��־����

-- ���� 10/04 (4). ���� ���� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���ϼ���.
-- p.215 SUBSTR : ���ڿ��� Ư�� ��ġ���� �����Ͽ� ������ ���̸�ŭ ���ڿ� ��ȯ
-- SUBSTR(name,1,1) : name�÷� ù��° ���ڿ����� �Ѱ� ��ȯ
SELECT SUBSTR(name,1,1) ��, COUNT(*) �ο�
FROM customer
GROUP BY SUBSTR(name,1,1);

SELECT * FROM orders;
--Q. �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���ϼ���.
--p.217
SELECT orderid �ֹ���ȣ, orderdate �ֹ���, orderdate+10 Ȯ������
FROM orders;

--���� 10/04 (5) 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���
--��, �ֹ����� '2020-07-07 ȭ����' ����. p.217~218
-- https://tysoso.tistory.com/31
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'yyyy-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
-- �Ʒ��� ó���� ��¥���� �ٽ� ����������
FROM orders
WHERE orderdate=TO_DATE('20200707', 'yyyymmdd'); --������>��¥��

-- p.219 DBMS ������ ������ ���� ��¥�� �ð�, ���� Ȯ��
SELECT SYSDATE FROM dual;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') SYSDATE1
FROM dual;

SELECT * FROM customer;
--Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̼���. ��, ��ȭ��ȣ�� ���� ���� '����ó����'���� ǥ��
-- p.222 NVL : NULL ���� ������ ������ ǥ��
SELECT name �̸�, NVL(phone, '����ó����') ��ȭ��ȣ
FROM customer;

--SELECT COALESCE(NULL,NULL,'third value','forth value');
-- ����° ���� NULL�� �ƴ� ù ���̱� ������ ����° ���� ��ȯ
SELECT name �̸�, phone, COALESCE(phone, '����ó����') ��ȭ��ȣ
FROM customer;

-- ROWNUM :  SQL��ȸ ����� ���� ��Ÿ��. �ڷ� �Ϻκ� Ȯ���� �� ����
SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM <=3; --�� ���� ����

--Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ��� p.226
SELECT * FROM customer;
SELECT * FROM orders;

SELECT orderid �ֹ���ȣ, saleprice �ݾ�
FROM orders
WHERE saleprice < (SELECT AVG(saleprice) FROM orders);

--Q. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ��� p.227
SELECT orderid �ֹ���ȣ, custid ����ȣ, saleprice �ݾ�
FROM  orders O1
WHERE saleprice > (SELECT AVG(saleprice) FROM orders O2
                   WHERE O1.custid=O2.custid);


--���� 10/04 (6) ���ѹα��� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ��� p.228
SELECT * FROM orders;
SELECT SUM(saleprice) "�� �Ǹž�"
FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');
--���ѹα��� �������� �ʴ� ��: NOT IN ���� ����

--���� 10/04 (7) 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ��� p.229
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL (SELECT saleprice FROM orders WHERE custid=3);
-- ���� saleprice���� 6000,12000, 13000. ���� ū 13000������ ū �ݾ��� ����� ���

--���� 10/04 (8) ����ȣ�� 2 ������ ���� �Ǹž��� ���(��, ���̸��� ���� �Ǹž� ����) p.234
SELECT cs.name, SUM(od.saleprice) total
FROM (SELECT custid, name FROM customer WHERE custid <=2) cs, orders od
WHERE cs.custid=od.custid
GROUP BY cs.name;


SELECT * FROM customer;
SELECT * FROM orders;


SELECT c.name, SUM(o.saleprice)
FROM orders o, customer c
WHERE c.custid = o.custid(+)   -- + : ���ʰ��� ����
GROUP BY c.name;

--Q. NULL�� 0���� �÷����� ���� �Ǹž����� ����
-- p.222 NVL : NULL ���� ������ ������ ǥ��. �Ʒ��� NVL(�ش��÷��� null����, 0���� ǥ��)
SELECT C.name, NVL(SUM(O.saleprice),0) "���� �Ǹž�"
FROM orders O, customer C
WHERE C.custid = O.custid(+)
GROUP BY C.name;

-- View�� ������ ���̺��̶�� �ϸ� �����ʹ� ���� SQL�� ����Ǿ� �ִ� Object. p.235
-- View�� �⺻ ���̺��̳� �並 �����ϰ� �Ǹ� �ش� �����͸� ���ʷ� �� �ٸ� ����� �ڵ����� �����ǰ� ALTER ����� ����� �� ����.
-- ������ �����ϱ� ���ؼ��� DROP & CREATE�� �ݺ��Ͽ��� �ϸ� ���� �̸����� ������ �� ����. �ǹ������� "vw_"���̻糪 ���λ縦 �ٿ� ���

-- ���� ����
-- CREATE VIEW ���̸�
-- AS SELECT��
CREATE VIEW vw_customer
AS SELECT *
FROM customer
WHERE address LIKE '%���ѹα�%';

SELECT * FROM vw_customer;

--Q. Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��
-- �迬�� ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ��� p.239
CREATE VIEW vw_orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT od.orderid, od.custid, cs.name,
          od.bookid, bk.bookname, od.saleprice, od.orderdate
FROM orders od, customer cs, book bk
WHERE od.custid=cs.custid AND od.bookid=bk.bookid;
--Ȯ���۾�
SELECT orderid, bookname, saleprice
FROM vw_orders
WHERE name='�迬��';

--Q. �ռ� ������ �並 vw_customer�� ���� p.240
DROP VIEW vw_orders;

