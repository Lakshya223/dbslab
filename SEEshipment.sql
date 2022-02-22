create table Customer( custno INT, cname VARCHAR(20), city VARCHAR(20), PRIMARY KEY(custno) );
create table Order1(orderno INT, odate VARCHAR(20), custno INT, ordamt INT, PRIMARY KEY(orderno) );
create table Order_Item(orderno INT, itemno INT, qty INT, PRIMARY KEY(orderno,itemno) );
create table Item(itemno INT, unit_price INT, PRIMARY KEY(itemno) );
create table Shipment(orderno INT, warehouseno INT,shipdate VARCHAR(20), PRIMARY KEY(orderno,warehouseno));
create table Warehouse(warehouseno INT,city VARCHAR(20), PRIMARY KEY(warehouseno));

INSERT INTO Customer VALUES (1,'Archie','Bangalore');
INSERT INTO Customer VALUES (2,'Veronica','Bangalore');
INSERT INTO Customer VALUES (3,'Betty','Mysore');
INSERT INTO Customer VALUES (4,'Jughead','Bangalore');
INSERT INTO Customer VALUES (5,'Cheryl','Mysore');
INSERT INTO Customer VALUES (6,'Jason','Mangalore');

INSERT INTO Order1 VALUES (1, '01-Jun-2016',1,1000);
INSERT INTO Order1 VALUES (2, '03-Jun-2016',1,2000);
INSERT INTO Order1 VALUES (3, '03-Jun-2016',3,3000);
INSERT INTO Order1 VALUES (4, '05-Jun-2016',4,4000);
INSERT INTO Order1 VALUES (5, '06-Jun-2017',5,5000);

INSERT INTO Order_Item VALUES(1,1,2);
INSERT INTO Order_Item VALUES(1,2,1);
INSERT INTO Order_Item VALUES(2,3,2);
INSERT INTO Order_Item VALUES(3,4,3);
INSERT INTO Order_Item VALUES(4,3,1);
INSERT INTO Order_Item VALUES(5,2,1);

INSERT INTO Item VALUES(1,100);
INSERT INTO Item VALUES(2,200);
INSERT INTO Item VALUES(3,300);
INSERT INTO Item VALUES(4,400);
INSERT INTO Item VALUES(5,500);

INSERT INTO Shipment VALUES(1,1,'03-Jun-2016');
INSERT INTO Shipment VALUES(2,1,'03-Jun-2016');
INSERT INTO Shipment VALUES(3,2,'05-Jun-2016');
INSERT INTO Shipment VALUES(4,3,'05-Jun-2016');
INSERT INTO Shipment VALUES(5,4,'06-Jun-2016');

INSERT INTO Warehouse VALUES(1,'Bangalore');
INSERT INTO Warehouse VALUES(2,'Mysore');
INSERT INTO Warehouse VALUES(3,'Bangalore');
INSERT INTO Warehouse VALUES(4,'Mysore');

alter table Order1 add foreign key (custno) references Customer(custno);
alter table Order_Item add foreign key (orderno) references Order1(orderno);
alter table Order_Item add foreign key (itemno) references Item(itemno);
alter table Shipment add foreign key (orderno) references Order1(orderno);
alter table Shipment add foreign key (warehouseno) references Warehouse(warehouseno);

--1. List the no. of order placed by customer no. 5.
select count(orderno) from Order1 where custno=5;

--2. List customer details who have the largest order amount.
select c.custno ,c.cname, c.city from Customer c, Order1 o where c.custno=o.custno and o.ordamt=(select max(o.ordamt) from Order1 o);

--3. List the names of customers who have ordered at least 10 items.
select cname from CUSTOMER where custno in(
select o.custno from Order1 o inner join Order_Item oi on o.orderno=oi.orderno group by custno having count(itemno)>=1);
select cname from CUSTOMER where custno in(
select o.custno from Order1 o ,Order_Item oi where  o.orderno=oi.orderno group by custno having count(itemno)>=1);


--4. List the number of orders placed by each customer.
select custno,count(orderno) as 'no of orders' from Order1 group by custno;

--5. List the customer names who have not ordered for item no. 10

select o.custno from Order1 c where o.custno not in (select o.custno from Order1 o, Order_Item oi where o.orderno=oi.orderno and itemno=3);
select c.cname from Customer c where c.custno not in (select o.custno from Order1 o, Order_Item oi where o.orderno=oi.orderno and itemno=3);

--6 List item numbers and their quantity for order number 5.
select itemno,quantity from Order_Item where orderno=5;

--7 Display the average order amount for day wise orders
select avg(ordamt) from Order1 group by odate;

--8 List the number of orders placed by each customer.
select custno ,count(*) from Order1 group by custno;

--9 Find the total order amount for each day.
select sum(ordamt) from Order1 group by odate;
