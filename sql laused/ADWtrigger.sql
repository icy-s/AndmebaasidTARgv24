92. DDL Trigger SQL serveris

create trigger trMyFirstTrigger
on Database
for CREATE_TABLE
as
begin
print 'New table created'
end

create table Test (Id int)


alter trigger trMyFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
print 'A table has just been created, modified or deleted'
end

drop table test


alter trigger trMyFirstTrigger
on Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
rollback --tegevusi peatamine
print 'You cannot create, alter or drop a table'
end

create table Test (Id int)

disable trigger trMyFirstTrigger on database
enable trigger trMyFirstTrigger on database

create trigger trRenameTable
on database
for RENAME
as
begin
print 'You just renamed something'
end

sp_rename 'Test', 'NewTest'
select * from NewTest

--column name changed from Id to NewId in table NewTest
sp_rename 'NewTest.Id', 'NewId', 'column'





93. Server-Scoped DDL triggerid

create trigger tr_DatabaseScopeTrigger
on database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
rollback
print 'You cannot create, alter or drop a table in the current database'
end




create trigger tr_ServerScopeTrigger
on all server
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
rollback
print 'You cannot create, alter or drop a table in any database on the server'
end




disable trigger tr_ServerScopeTrigger on all server
enable trigger tr_ServerScopeTrigger on all server

drop trigger tr_ServerScopeTrigger on all server

disable trigger tr_DatabaseScopeTrigger on database

create table test (id int)