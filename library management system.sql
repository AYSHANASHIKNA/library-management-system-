create database library;
use library;
CREATE TABLE branch (
    branch_no INT ,
    manager_id VARCHAR(50) ,
    branch_address VARCHAR(50) ,
    contact_no INT
);
ALTER TABLE branch ADD PRIMARY KEY (branch_no);

INSERT INTO branch (branch_no,manager_id,branch_address,contact_no)
VALUES
    (1,'m1','branch_address1',123456789),
    (2,'m2','branch_address2',234567891),
    (3,'m3','branch_address3',345678912);
select * from branch;


CREATE TABLE employee (
 emp_id VARCHAR(50),
 emp_name VARCHAR(50),
 position VARCHAR(50),
 salary INT,
 branch_no INT
);
ALTER TABLE employee ADD PRIMARY KEY (emp_id);
ALTER TABLE employee ADD CONSTRAINT Fk_branch
foreign key(branch_no) references  branch (branch_no);


INSERT INTO employee (emp_id,emp_name,position,salary,branch_no)
VALUES
    ('e1','employee1','manager',70000,1),
    ('e2','employee2','assistant',60000,1),
    ('e3','employee3','worker',50000,1),
	('e4','employee4','clerk',30000,1),
    ('e5','employee5','technician',20000,1),
    ('e6','employee6','aide',10000,1),
    ('e7','employee7','manager',80000,2),
	('e8','employee8','assistant',60000,2),
    ('e9','employee9','manager',50000,3),
    ('e10','employee10','assistant',40000,3);
   
select * from employee;
   


CREATE TABLE customer (
    customer_id VARCHAR(50),
    customer_name VARCHAR(50),
    customer_address VARCHAR(50)
);
ALTER TABLE customer ADD PRIMARY KEY (customer_id);

INSERT INTO customer (customer_id,customer_name,customer_address)
VALUES
   ('c1','customer1','cust_address1'),
   ('c2','customer2','cust_address2'),
   ('c3','customer3','cust_address3'),
   ('c4','customer4','cust_address4'),
   ('c5','customer5','cust_address5');
 select * from customer; 


CREATE TABLE issuestatus (
    issue_id VARCHAR(5),
    issued_cust VARCHAR(50),
    issued_book_name VARCHAR(50),
    issue_date DATE,
    isbn_book INT
);

ALTER TABLE issuestatus ADD PRIMARY KEY (issue_id);
ALTER TABLE issuestatus ADD CONSTRAINT fk_customer
foreign key(issued_cust) references customer(customer_id);
ALTER TABLE issuestatus ADD CONSTRAINT fk_books 
foreign key(isbn_book) references books(isbn);


INSERT INTO issuestatus (issue_id,issued_cust,issued_book_name,issue_date,isbn_book)
VALUES
('i1','c1','dune','2023-06-01',1001),
('i2','c2','macbeth','2022-12-05',1002),
('i3','c3','NOT ISSUED','2021-11-10',1003),
('i4','c4','goldfinger','2020-10-12',1004),
('i5','c5','NOT ISSUED','2021-10-15',1005);
select * from issuestatus;

CREATE TABLE returnstatus (
    return_id VARCHAR(5),
    return_cust VARCHAR(50),
    returnbook_name VARCHAR(50),
    return_date DATE,
    isbn_book2 INT
);

ALTER TABLE returnstatus ADD PRIMARY KEY (return_id);
ALTER TABLE returnstatus ADD CONSTRAINT fk_books2
foreign key(isbn_book2) references books(isbn);

INSERT INTO returnstatus(return_id,return_cust,returnbook_name,return_date,isbn_book2)
VALUES
 ('r1','c1','dune','2024-01-05',1001),
 ('r2','c2','macbeth','2023-12-10',1002),
 ('r3','c3','jaws','2023-11-20',1003),
 ('r4','c4','goldfinger','2023-10-17',1004),
 ('r5','c5','mockingjay','2023-10-20',1005);
 select * from returnstatus;
 
CREATE TABLE books (
    isbn INT,
    book_title VARCHAR(50),
    category VARCHAR(50),
    rental_price INT,
	statuss  VARCHAR(50),
    author VARCHAR(50),
    publisher VARCHAR(50)
);
ALTER TABLE books ADD PRIMARY KEY (isbn);

INSERT INTO books(isbn,book_title,category,rental_price,statuss,author,publisher)
VALUES
(1001,'dune','novel',500,'available','frank herbert','chilton books'),
(1002,'macbeth','drama',600,'available','william shakespear','folger edition'),
(1003,'jaws','history',450,'not available','peter benchley','doubleday'),
(1004,'goldfinger','classic',300,'not available','lan fleming','jonathan'),
(1005,'mockingjay','history',250,'available','suzanne collins','scholastic press');
select *from books;

show tables;

# 1. retrieve the book title,category and rental price of all available books?
select book_title,category,rental_price from books where statuss='available';


# 2. list the employee names and their respective salaries in descending order of salary?
select emp_name,salary from employee  order by salary desc; 


# 3. retrieve the book titles and the corresponding customers who have issued those books?
select issued_book_name,issued_cust from issuestatus;


# 4. display the total counts of book in each category?
select category,count(*)as book_count from books
group by category;

# 5. retrieve the employee names and their positions for the employees whose salaries are above rs.50,000?
select  emp_name,position from employee where salary > '50000';


# 6. list the customer names who registered before 2022-01-01 and have not issued any books yet?
select  issued_cust from issuestatus where issue_date < '2022-01-01' and issued_book_name = 'NOT ISSUED';


# 7. display the branch numbers and total number of employees in each branch?
select branch_no,count(*)as employee_count from employee
group by branch_no; 


# 8. display the names of customer who have issued  books in the month of june 2023?
select issued_cust from issuestatus where issue_date='2023-06-01';


# 9. retrieve book_title from books table containing history?
select book_title from books where category='history';


# 10. retrieve the branch no along with the count of employees for branches having more than 5 employees? 
select branch_no,count(*)as employee_count from employee 
group by branch_no having employee_count>5;
