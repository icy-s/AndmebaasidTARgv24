Create Table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1,'Mike')
insert into #PersonDetails values(2,'John')
insert into #PersonDetails values(3,'Todd')

select * from #PersonDetails

--tempdb
select name from tempdb..sysobjects
where name like '#PersonDetails%'

--local table
create procedure spCreateLocalTempTable
as
begin
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1,'Mike')
insert into #PersonDetails values(2,'John')
insert into #PersonDetails values(3,'Todd')

select * from #PersonDetails
end

--global temp table
create table ##EmployeeDetails(Id int, Name nvarchar(20))