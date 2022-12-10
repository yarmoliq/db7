-- PART 1

-- create database simubd3
use simubd3

create table departments (
	id int identity(1,1) primary key,
	[name] varchar(20),
	numberOfCounters int,
	numberOfCashiers int
)

insert into departments values
('Tools', 2, 1),
('Food', 5, 2),
('Household', 2, 1),
('Construction', 3, 2),
('Toys', 2, 2)


create table positions (
	id int identity(1,1) primary key,
	[name] varchar(20),
	baseSalary money
)

insert into positions values
('CEO', 3000000),
('Manager', 500000),
('Vice Manager', 100000),
('Manager Assistant', 30000),
('Sales person', 6000)


create table products (
	id int identity(1,1) primary key,
	[name] varchar(20),
	department int not null,
	countryOfManufacturer varchar(20),
	storageConditions varchar(100),
	expirationDate datetime,
	constraint FK_DepartmentProduct foreign key (department) references departments(id)
)

insert into products values
('Grechka', 2, 'Rus', 'Daje dver otkrita', getdate()),
('Voda', 2, 'Rus', 'Daje dver otkrita', getdate()),
('Laptop', 5, 'China', 'Daje dver otkrita', getdate()),
('BuzLighter', 5, 'China', 'Daje dver otkrita', getdate()),
('Shovel', 4, 'Germany', 'Daje dver otkrita', getdate())


create table workers (
	id int identity(1,1) primary key,
	firstName varchar(20),
	lastName varchar(20),
	department int,
	dateOfBirth date,
	acceptedOn date,
	position int,
	gender varchar(20),
	[address] varchar(80),
	phoneNumber varchar(8)
		check (phoneNumber like '[1-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
	constraint FK_DepartmentWorker foreign key (department) references departments(id),
	constraint FK_PositionWorker foreign key (position) references positions(id),
)

insert into workers values
('Alesha', 'Popovich', 1, '1203-12-21', '1221-4-21', 5, 'M', 'izba 5', '10-00-00'),
('Dobryna', 'Nikitich', 3, '1203-12-21', '1221-4-21', 5, 'M', 'izba 7', '99-99-96'),
('Baba', 'Yaga', null, '1203-12-21', '1221-4-21', 3, 'F', 'movable izba', '99-99-97'),
('Tugarin', 'Zmei', null, '1203-12-21', '1221-4-21', 2, 'M', 'movable palatka', '99-99-98'),
('Solovei', 'Razboinik', null, '1203-12-21', '1221-4-21', 1, 'M', 'everywhere', '99-99-99')

update workers
set acceptedOn = '2022-2-29'
where firstName = 'Alesha'

create table sales (
	id int identity(1,1) primary key,
	worker int not null,
	product int not null,
	[datetime] datetime not null,
	volume float,
	price money,
	constraint FK_WorkerSale foreign key (worker) references workers(id),
	constraint FK_ProductSale foreign key (product) references products(id)
)

insert into sales values
(1, 1, getdate(), 5, 3.4),
(1, 2, getdate(), 2, 0.7),
(1, 3, getdate(), 1, 100),
(2, 4, getdate(), 1, 5),
(2, 5, getdate(), 1, 7)

/*
select * from workers
select * from products

create table students (
	id int IDENTITY(1,1) PRIMARY KEY,
	firstName varchar(50) not null,
	lastName varchar(50) not null,
	scholarship money check (scholarship >= 0 and scholarship < 500),
	course int check (course >= 1 and course <= 4),
	city varchar(50),
	birthday datetime,
	groupNumber varchar(10),
	kafedra int,
	constraint FK_KafedraStudent foreign key (kafedra) references kafedri(id)
)

create table teachers (
	id int identity(1,1) primary key,
	kafedra int,
	[name] varchar(50),
	position varchar(50)
		check (position like 'профессор'
			or position like 'доцент'
			or position like 'старший преподаватель'
			or position like 'ассистент')
		default 'ассистент',
	[rank] varchar(50)
		check ([rank] like 'к.т.н.'
			or [rank] like 'к.г.у'
			or [rank] like 'к.с.н.'
			or [rank] like 'к.ф.м.н.'
			or [rank] like 'д.т.н.'
			or [rank] like 'д.г.у.'
			or [rank] like 'д.с.н.'
			or [rank] like 'д.ф.м.н.'
			or [rank] like 'нет')
		default 'нет',
	salary money not null default 1000,
	raise money not null,
	hired datetime not null,
	sex char check (sex like 'м' or sex like 'ж'),
	phoneNumber varchar(8)
		check (phoneNumber like '[1-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
	constraint FK_KafedraTeacher foreign key (kafedra) references kafedri(id)
)
*/

use simubd3
-- PART 2

select * from positions
where baseSalary > 10000

select * from positions
where baseSalary between 10000 and 1000000


select * from workers
where position = 1 or (position = 5 and department = 3)

select
	firstName + ' ' + lastName as [name],
	datediff(year, acceptedOn, getdate()) as experience
from workers

select * from workers
where firstName in ('Alesha', 'Baba')

select * from workers
where [address] like '%izba%'

select * from workers
where department is null

-- PART 3

select
	t1.firstName as [1],
	t2.[name] as [2]
from workers t1
cross join positions t2

select
	workers.firstName + ' ' + workers.lastName as [name],
	positions.[name]
from workers
join positions on workers.position = positions.id
where workers.position != 5

select
	workers.firstName + ' ' + workers.lastName as [name],
	sales.id,
	products.[name]
from workers
join sales on sales.worker = workers.id
join products on sales.product = products.id

select
	workers.firstName + ' ' + workers.lastName as [name],
	positions.[name]
from workers
full join positions on workers.position = positions.id

select
	positions.[name],
	workers.firstName + ' ' + workers.lastName as [name]
from positions
left join workers on workers.position = positions.id

select
	workers.firstName + ' ' + workers.lastName as [name],
	positions.[name]
from workers
right join positions on workers.position = positions.id

select
	workers.firstName + ' ' + workers.lastName as [name],
	departments.[name]
from workers
inner join departments on workers.department = departments.id


-- PART 4

select sum(baseSalary) from positions

select * from workers
where lower(gender) like 'f'

select gender, count(1) from workers
group by gender

select department, gender, count(1) from workers
group by department, gender

select department, gender, count(1) from workers
group by department, gender
having department is not null

select sum(baseSalary) from positions
having sum(baseSalary) > 10

select * from workers
order by firstName

update workers
set [address] = phoneNumber
where firstName = 'Tugarin'

update workers
set acceptedOn = '1221-04-20'
where firstName = 'Alesha'
















declare @word varchar(50) = 'tESTJDKLASJ'
select upper(substring(@word, 1, 1)) + lower(substring(@word, 2, len(@word)-1))
