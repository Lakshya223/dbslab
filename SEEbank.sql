create table BRANCH (branch_name VARCHAR(20), branch_city VARCHAR(20) , assets VARCHAR(20), PRIMARY KEY(branch_name));
create table CUSTOMER (customer_name VARCHAR(20), customer_street VARCHAR(20), customer_city VARCHAR(20), PRIMARY KEY(customer_name)) ;
create table ACCOUNT (account_number INT, branch_name VARCHAR(20), balance INT, PRIMARY KEY(account_number));
create table LOAN (loan_number INT, branch_name VARCHAR(20), amount INT, PRIMARY KEY(loan_number));
create table DEPOSITOR (customer_name VARCHAR(20), account_number INT, PRIMARY KEY(customer_name, account_number));
create table BORROWER (customer_name VARCHAR(20), loan_number INT, PRIMARY KEY(customer_name, loan_number));
create table EMPLOYEE (employee_name VARCHAR(20), branch_name VARCHAR(20), salary INT, PRIMARY KEY(employee_name, branch_name));

insert into BRANCH values("Malleshwaram","Bangalore","Savings account"),
  ("Rajajinagar","Bangalore","Current"),("Biddi","Mysore","savings"),
  ("Hoskere","Davanagere","current"),
  ("Mathikere","Bangalore","savings");

insert into CUSTOMER values("Bharath","15th Cross","Bangalore"),
  ("Manoj","8th cross","Mysore"),
  ("Pradyumna","5th cross","Mysore"),
  ("Karthik","1st Cross","Davanagere"),
  ("Divya","13th Cross","Bangalore");

insert into account values(12345,"Mathikere",35),
  (78965,"Malleshwaram",1000),
  (45689,"Rajajinagar",5000),
  (45876,"Biddi",700),
  (12457,"Hoskere",520);

  insert into loan values(55555,"Mathikere",50000),
    (66666,"Malleshwaram",100000),
    (77777,"Rajajinagar",150000),
    (88888,"Biddi",70000),
    (99999,"Hoskere",52000);

  insert into depositor values("Bharath",12345),
    ("Manoj",78965),
    ("Pradyumna",45689),
    ("Karthik",45876),
    ("Divya",12457);

  insert into borrower values("Bharath",55555),
    ("Manoj",66666),
    ("Pradyumna",77777),
    ("Karthik",88888),
    ("Divya",99999);
  insert into employee values("ABC","Mathikere",50000),
    ("XYZ","Malleshwaram",10000),
    ("PQR","Rajajinagar",15000),
    ("KLM","Biddi",7000),
    ("MNO","Hoskere",5200);

alter table depositor add foreign key(customer_name) references customer(customer_name);
alter table depositor add foreign key(account_number) references account(account_number);
alter table borrower add foreign key(customer_name) references customer(customer_name);
alter table borrower add foreign key(loan_number) references loan(loan_number);
alter table employee add foreign key(branch_name) references branch(branch_name);

--1. Find the names of all customers whose balance is less than 500.
select d.customer_name from DEPOSITOR d, ACCOUNT a where a.account_number=d.account_number and a.balance<500;
--2. Find all employees whose salary is greater than 1400 and working branch is not ‘Downtown’
select employee_name from EMPLOYEE where branch_name!='Biddi' and salary>9000;

--3. Calculate the average salary of all employees and display the average salary as “Avg_Salary”
select avg(salary) as 'Avg_Salary' from EMPLOYEE ;
--4. Find the names of all customers whose city is not Brooklyn.
select customer_name from CUSTOMER where customer_city!='Brooklyn';

--5 .Find the names of all customers who have taken loans
select customer_name from BORROWER;

--6.Display all account numbers, branch name and corresponding branch city
select a.account_number , b.branch_name ,b.branch_city from BRANCH b, ACCOUNT a where a.branch_name=b.branch_name;

--7. Find the names of all customers who have not taken loans.
 select customer_name from CUSTOMER where customer_name not in (select customer_name from BORROWER );

-- 8. Display all loan numbers sorted by branch
 select loan_number from loan order by branch_name;

 --9 Display the names of Employees who earn the maximum salary.
  select employee_name from EMPLOYEE where salary=(select max(salary) from employee);
