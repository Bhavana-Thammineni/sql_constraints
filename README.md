# sql_constraints
create a table using all constraints,and send minmum 5 records into table
#constraints: 1.unique 2.not null 3.check 4.default 5.auto increment 6.primary key 7.secondary key
use bhavana;
create table department(
dept_id int primary key,
dept_name varchar(30) not null unique
);
insert into department values(1,'cse'),(2,'ece'),(3,'eee');
create table student(
stud_id int primary key auto_increment,
stud_code int unique not null,
stud_name varchar(30) not null,
age int check (age >= 18),
gender char(1) check (gender in ('m','f')),
salary decimal(8,2) check (salary >0),
join_date date default (current_date),
dept_id int,
foreign key (dept_id) references department(dept_id)
);
INSERT INTO student
(stud_code, stud_name, age, gender, salary, dept_id)
VALUES
(101, 'Bhavana', 21, 'f', 30000, 1),
(102, 'Anil', 22, 'm', 32000, 2),
(103, 'Sita', 23, 'f', 35000, 3),
(104, 'Ravi', 24, 'm', 40000, 1),
(105, 'Kiran', 22, 'm', 33000, 2);
select*from student;
