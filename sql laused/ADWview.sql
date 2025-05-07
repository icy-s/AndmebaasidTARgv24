39. View SQL serveris

create table tblEmployee(
Id int primary key,
Name nvarchar(30),
Salary int,
Gender nvarchar(10),
DepartmendId int)

create table tblDepartment(
DeptId int primary key,
DeptName nvarchar(20))




insert into tblDepartment values(1,'IT')
insert into tblDepartment values(2,'Payroll')
insert into tblDepartment values(3,'HR')
insert into tblDepartment values(4,'Admin')

insert into tblEmployee values(1, 'John', 5000, 'Male', 3);
insert into tblEmployee values(2, 'Mike', 3400, 'Male', 2);
insert into tblEmployee values(3, 'Pam', 6000, 'Female', 1);
insert into tblEmployee values(4, 'Todd', 4800, 'Male', 4);
insert into tblEmployee values(5, 'Sara', 3200, 'Female', 1);
insert into tblEmployee values(6, 'Ben', 4800, 'Male', 3);

select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmendId = tblDepartment.DeptId

create view vWEmployeesByDepartment
as
select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmendId = tblDepartment.DeptId

select * from vWEmployeesByDepartment




-- IT department töötajad view

create view vWITDepartment_Employees
as
select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmendId = tblDepartment.DeptId
where tblDepartment.DeptName = 'IT'


-- töötajate info ilma palgata

create view vWEmployeesNonConfidentialData
as
select Id, Name, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmendId = tblDepartment.DeptId


-- nimi kogus iga DeptName-is

create view vWEmployeesCountByDepartment
as
select DeptName, count(Id) as TotalEmployees
from tblEmployee
join tblDepartment
on tblEmployee.DepartmendId = tblDepartment.DeptId
group by DeptName

select * from vWEmployeesCountByDepartment


sp_helptext vWEmployeesCountByDepartment






40. View uuendused





create view vWEmployeesDataExceptSalary
as
select Id, Name, Gender, DepartmendId
from tblEmployee

select * from vWEmployeesDataExceptSalary
select * from tblEmployee

-- muutub nimi id järgi view kaudu
-- muutused on ka tblEmployee tabelis
update vWEmployeesDataExceptSalary
set name = 'Mikey' where Id = 2


--eemaldamine view kaudu
delete from vWEmployeesDataExceptSalary where Id = 2

--lisamine view kaudu
insert into vWEmployeesDataExceptSalary values (2, 'Mikey', 'Male', 2)



create view vWEmployeeDetailsByDepartment
as
select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.DepartmendId = tblDepartment.DeptId

select * from vWEmployeeDetailsByDepartment



--dept tabelis uuendus view kaudu (vigane uuendus)
update vWEmployeeDetailsByDepartment
set DeptName='IT' where Name = 'John'

select * from tblEmployee
select * from tblDepartment