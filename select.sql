create table laps(
lapsID int primary key identity (1,1),
nimi varchar(10) not null,
pikkus smallint,
synniaasta smallint,
synnilinn varchar(20)
);

select * from laps;

insert into laps(nimi, pikkus, synniaasta, synnilinn)
values
('Kati', 156, 2001, 'Tallinn'),
('Mati', 166, 2005, 'Tartu'),
('Sati', 176, 2001, 'Tallinn'),
('Tati', 126, 2000, 'Tallinn'),
('Nuti', 125, 2003, 'Tartu');

-- sorteerimine (asc/desc)
select nimi, pikkus
from laps
order by pikkus;

-- mitmed
select nimi, pikkus
from laps
order by pikkus, nimi;

-- lapsed, mis on sündinud peale 2005
select nimi, synniaasta
from laps
where synniaasta >= 2005
order by nimi;

-- distinct (ain. 1 kordus)
select distinct synniaasta
from laps
where synniaasta > 2000;

-- lapsed, mis on sündinud 2000-st 2005-ni
select nimi, synniaasta
from laps
where synniaasta >= 2000 and synniaasta <= 2005;

-- lapsed, mis on sündinud 2000-st 2005-ni (between)
select nimi, synniaasta
from laps
where synniaasta between 2000 and 2005;

-- näita lapsed, kelle nimi algab K (like)
select nimi
from laps
where nimi like 'K%'
-- % kõik võimalikud sümboolid

-- näita lapsed, kelle nimi sisaldab K (like)
select nimi
from laps
where nimi like '%K%'
-- %"% sisaldab täht

-- _ täpsem määratud tähtede arv
select nimi
from laps
where nimi like '_a__';

-- and / or
select nimi, synnilinn
from laps
where nimi like 'K%'
or synnilinn like 'Tartu';

select nimi, synnilinn
from laps
where nimi like 'K%'
and synnilinn like 'Tartu';

-- agregaatfunktsioonid (sum, avg, min, max, count)
select count(nimi) as lasteArv
from laps;

select avg(pikkus) as 'keskmine pikkus'
from laps
where synnilinn = 'Tallinn';

-- keskmine pikkus linnade järgi (group by)
select avg(pikkus) as 'keskmine pikkus', synnilinn
from laps
group by synnilinn

-- laste arv, mis on sündinud konkreetsel synniaastal
select synniaasta, count(*) as lasteArv
from laps
group by synniaasta

-- keskmine pikkus iga synniaasta järgi
select synniaasta, avg(pikkus) as keskmine
from laps
group by synniaasta

-- keskmine pikkus iga synniaasta järgi (having)
select synniaasta, avg(pikkus) as keskmine
from laps
group by synniaasta
having avg(pikkus)>150;
-- having (piirang juba grupeeritud andmete osas)

select synniaasta, avg(pikkus) as keskmine
from laps
where synniaasta=2001
group by synniaasta

select synniaasta, avg(pikkus) as keskmine
from laps
where not synniaasta=2001
group by synniaasta

-- seotud tabel
create table loom(
loomID int primary key identity (1,1),
loomNimi varchar(50),
lapsID int,
foreign key (lapsID) references laps(lapsID)
);

insert into loom(loomNimi, lapsID)
values('kass Kott', 1),
('koer Bobik', 1),
('koer Tuzik', 2),
('kass Tuzik', 3),
('kass Mura', 3),
('kilpkonn', 3);

-- select seotud tabelite põhjal
select * from loom
inner join laps
on loom.lapsID=laps.lapsID;

-- lihtne vaade
select * from loom, laps
where loom.lapsID=laps.lapsID;

select l.loomNimi, la.nimi, la.synniaasta
from loom l, laps la
where l.lapsID=la.lapsID;
