32. Mitme avaldisega tabeliväärtusega funktsioonid

--Tabelisiseväärtusega funktsioon e Inline Table Valued function (ILTVF) koodinäide:
create function fn_ILTVF_GetEmployees()
returns table
as
return (select EmployeeKey, FirstName, cast(BirthDate as date) as DOB
from dbo.DimEmployee);

select * from fn_ILTVF_GetEmployees()

--Mitme avaldisega tabeliväärtusega funktsioonid e
--multi-statement table valued function (MSTVF)

create function fn_MSTVF_GetEmployees()
returns @Table table (
EmployeeKey int,
FirstName nvarchar(50),
DOB date)
as
begin
insert into @Table
select EmployeeKey, FirstName, cast(BirthDate as date) as DOB
from dbo.DimEmployee
return
end

select * from fn_MSTVF_GetEmployees()
select * from fn_ILTVF_GetEmployees()

--uuendame nimi kus EmployeeKey=1 funktsiooni kaudu
update fn_ILTVF_GetEmployees() set FirstName='testtest' where EmployeeKey=1;





33. Funktsiooniga seotud tähtsad kontseptsioonid

--Skaleeritav funktsioon ilma krüpteerimata:
create function fn_GetEmployeeNameById (@Id int)
returns nvarchar(20)
as
begin
return (select FirstName from DimEmployee where EmployeeKey = @Id)
end

--Nüüd muudame funktsiooni ja krüpteerime selle ära:
alter function fn_GetEmployeeNameById (@Id int)
returns nvarchar(20)
with encryption
as
begin
return (select FirstName from DimEmployee where EmployeeKey = @Id)
end

sp_helptext fn_GetEmployeeNameById

--Loome funktsiooni WITH SCHEMABINDING valikuga:
alter function fn_GetEmployeeNameById (@Id int)
returns nvarchar(20)
with schemabinding
as
begin
return (select FirstName from dbo.DimEmployee where EmployeeKey = @Id)
end

drop table DimEmployee