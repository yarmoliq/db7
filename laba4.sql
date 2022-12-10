
declare @temp table
(
	column1 varchar(30),
	column2 int,
	column3 varchar(30),
	column4 int
)

insert into @temp values
('first row', 11, 'second varchar', 69),
('second row', 12, 'second varchar', 420),
('third row', 13, 'yet another varchar', 666),
('fourth row', 14, 'still varchar', 2022)

declare @counter int = 0

while @counter < 5
begin
	insert into @temp values
	('inserted usign while', @counter, '-', 0)

	set @counter = @counter + 1
end

declare @odd bit = 0

if @odd = 1
	select * from @temp
	where column2 % 2 = 1
else
	select * from @temp
	where column2 % 2 = 0

create function sum_all_salaries
(
	@ceiling money = 100000000,
	@floor money = 0
)
returns money as
begin
	declare @summ money
	select @summ = sum(baseSalary) from positions
	where baseSalary >= @floor and baseSalary <= @ceiling
	return @summ
end

select
	dbo.sum_all_salaries(default, 100000) as 'over 100 000',
	dbo.sum_all_salaries(default, 10000000) as 'over 10 000 000',
	dbo.sum_all_salaries(100000, default) as 'below 100 000'

---

create function salaries_over
(
	@floor money = 10000
)
returns table as return
	select baseSalary from positions
	where baseSalary >= @floor

select
	dbo.sum_all_salaries(default, 100000) as 'over 100 000',
	dbo.sum_all_salaries(default, 10000000) as 'over 10 000 000',
	dbo.sum_all_salaries(100000, default) as 'below 100 000'

select * from salaries_over(10000)


alter PROCEDURE stored1
	@over int = 0
AS
	select * from salaries_over(@over)

	declare @summ money
	select @summ = dbo.sum_all_salaries(default, 100000)

	return @summ

DECLARE	@ret money
exec @ret = stored1
	@over = 10000
SELECT	'Return Value' = @ret