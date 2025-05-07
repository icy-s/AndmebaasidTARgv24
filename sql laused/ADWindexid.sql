35. Indeksid serveris

--Soovime leida kõik töölised, kelle Baserate on vahemikus 10 kuni 20. 
Select * from DimEmployee where BaseRate > 10 and BaseRate < 20
order by BaseRate asc;

--Nüüd loome indeksi, mis aitab päringut: Loome indeksi BaseRate veerule.
create index IX_DimEmployee_BaseRate
on DimEmployee (BaseRate ASC)

--Kui kustutad indeksi, siis täpsusta tabeli nimi
drop index DimEmployee.IX_DimEmployee_BaseRate





36. Klastreeritud ja mitte-klastreeritud indeksid

--klasteeritud ja mitte klasteeritud indeksid
--loome tabeli

create table tblEmployee (
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50));

insert into tblEmployee values(3, 'John', 4500, 'Male', 'New York');
insert into tblEmployee values(1, 'Sam', 2500, 'Male', 'London');
insert into tblEmployee values(4, 'Sara', 5500, 'Female', 'Tokyo');

select * from tblEmployee

--et luua klasterritud indeksi on vaja kustutada PK index
--parem klik tabeli peale-index ja rename---kopeerime index nimi
--PK__tblEmplo__3214EC0719001AF0
--kustutame automaatselt loodud index
drop index tblEmployee.PK__tblEmplo__3214EC0719001AF0

--näitab loodud index
execute sp_helpindex tblEmployee;

--indeksi eemaldamine
drop index tblEmployee.PK__tblEmplo__3214EC072FDB8E6F -- ei tööta, eemaldame indeks gui kaudu

--klasteeritud indeksid
create clustered index
on tblEmployee(Name)

create clustered index IX_tblEmployee_Gender_Salary
on tblEmployee(Gender desc, Salary asc)

--mitteklasteeritud indeks
create nonclustered index IX_tblEmployee_Name
on tblEmployee(Name)





37. Unikaalne ja mitte-unikaalne indeks

--loome uuesti tblEmployee tabel
create table tblEmployee(
id int primary key,
FirstName nvarchar(50),
LastName nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50))

execute sp_helpindex tblEmployee

insert into tblEmployee values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into tblEmployee values(1, 'John', 'Menco', 2500, 'Male', 'London')

--unikaalne mitteklasteeritud indeksi loomine
create unique nonclustered index UIX_tblEmployee_FirstName_LastName
on tblEmployee(FirstName, LastName)

--on vaja teha enne mitteklasteeritude indeksi loomiseks!
delete from tblEmployee

ALTER TABLE tblEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

EXECUTE SP_HELPCONSTRAINT tblEmployee

CREATE UNIQUE INDEX IX_tblEmployee_City
ON tblEmployee(City)
WITH IGNORE_DUP_KEY