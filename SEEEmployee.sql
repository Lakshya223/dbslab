create table employee (
    empname varchar(25),
    street varchar(25),
    city varchar(25),
    primary key(empname)
);
create table works(
   empname varchar(25),
   compname varchar(25),
   salary int ,
   primary key(empname,compname)
);
create table company(
  compname varchar(25),
  city varchar(25),
  primary key(compname)
);
create table manages(
  empname varchar(25),
  managername varchar(25),
  primary key(empname, managername)
);

insert into employee values('emp1','street1','mumbai');
insert into employee values('emp2','street2','mysore');
insert into employee values('emp3','street3','mysore');
insert into employee values('emp4','street4','blore');
insert into employee values('emp5','street5','blore');

insert into works values('emp1','fbc',12000);
insert into works values('emp2','sbc',11500);
insert into works values('emp3','fbc',8000);
insert into works values('emp4','fbc',11000);
insert into works values('emp5','sbc',7000);

insert into company values('fbc','blore');
insert into company values('sbc','mysore');

insert into manages values('emp1','emp2');
insert into manages values('emp2','emp3');
insert into manages values('emp3','emp4');
insert into manages values('emp4','emp5');
insert into manages values('emp5','emp1');

alter table works add foreign key(empname) references employee(empname);
alter table works add foreign key(compname) references company(compname);
alter table manages add foreign key(empname) references employee(empname);

--1. Find the names, street address, and cities of residence for all employees who work for 'First Bank Corporation' and earn more than $10,000.
select * from works where compname='fbc' and salary>10000;

--2. Find the names of all employees in the database who live in the same cities as the companies for which they work.
select e.empname from employee e , works w, company c where e.empname=w.empname and w.compname=c.compname and c.city=e.city;

--3. Find the average salary company wise and display it with the heading “Average Salary”.
select compname,avg(salary) as 'Average Salary' from works group by compname;

--4. Find the names of all employees in the database who live in the same cities and on the same streets as do their managers.
select p.empname from employee r,employee p, manages m where m.managername=r.empname and p.empname=m.empname and p.city=e.city;

--5. Find the names of all employees in the database who do not work for 'First Bank Corporation‘
select empname from works where compname!='fbc';

--6 Find the names of all employees in the database who earn more than every employee of 'Small Bank Corporation'.
--Assume that all people work for at most one company.
select empname from works where salary > all(select salary from works where compname='sbc');

--7 Find the names, street address, and cities of residence for all employees who work for 'First Bank Corporation'
-- and earn more than $10,000 and less than $20,000.
select e.empname from employee e, works w where e.empname = w.empname and w.compname='fbc' and w.salary>10000 and w.salary<20000; 
