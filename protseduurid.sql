--SQL SALVESTATUD PROTSEDUURID-- Funktsioonid - mitu SQL käsku käivitakse järjest
--SQL SERVER

create database procTARgv24;

use procTARgv24;
CREATE TABLE uudised(
uudisID int PRIMARY KEY identity(1,1),
uudiseTeema varchar(50),
kuupaev date,
autor varchar(25),
kirjeldus text
)
select * from uudised

insert into uudised(
uudiseTeema, kuupaev, autor, kirjeldus)
values(
'udune ilm', '2025-02-06', 'postimees', 'Lõunani on udune ilm')

--protseduuri loomine
--sisestab uudised tabelisse ja kohe näitab
create procedure lisaUudis
@uusTeema varchar(50),
@paev date,
@autor varchar(20),
@kirjeldus text
as
begin

insert into uudised(
uudiseTeema, kuupaev, autor, kirjeldus)
values(
@uusTeema, @paev, @autor, @kirjeldus);
select * from uudised;

end;



--kutse
exec lisaUudis 'windows 11', '2025-02-06', 'õpetaja Pant', 'w11 ei tööta multimeedia klassis';

--teine kutse võimalus
exec lisaUudis
@uusTeema='1.märts on juba kevad',
@paev='2025-02-06',
@autor='test',
@kirjeldus='puudub';

--protseduur, mis kustutab tabelist id järgi
create procedure kustutaUudis
@id int
AS
BEGIN
select * from uudised;
DELETE FROM uudised WHERE uudisID=@id;
select * from uudised;
END;

--kutse variantid
exec kustutaUudis 3;
exec kustutaUudis @id=3;

UPDATE uudised
SET kirjeldus='uus kirjeldus'
WHERE kirjeldus like 'puudub'
select * from uudised

--protseduur, mis uuendab andmed tabelis (UPDATE)

create procedure uuendaKirjeldus
@uuskirjeldus text
AS
BEGIN
select * from uudised;
UPDATE uudised
SET kirjeldus=@uuskirjeldus
WHERE kirjeldus like 'puudub';
select * from uudised;
END;

--kutse variantid
exec uuendaKirjeldus 'uus tekst kirjelduses';
exec uuendaKirjeldus @uuskirjeldus='uus tekst kirjelduses';

--protseduur, mis otsib ja näitab uudist esimese tähte järgi

create procedure otsingUudiseTeema
@taht char(1)
AS
BEGIN
select * from uudised
where uudiseTeema like @taht + '%';
END;

--kutse
exec otsingUudiseTeema 'w'


--XAMPP/localhost

CREATE TABLE uudised(
uudisID int PRIMARY KEY AUTO_INCREMENT,
uudiseTeema varchar(50),
kuupaev date,
autor varchar(25),
kirjeldus text
);

insert into uudised(
uudiseTeema, kuupaev, autor, kirjeldus)
values(
'udune ilm', '2025-02-06', 'postimees', 'Lõunani on udune ilm')

call lisaUudis ('windows 11', '2025-02-06', 'õpetaja Pant', 'w11 ei tööta multimeedia klassis'); 
