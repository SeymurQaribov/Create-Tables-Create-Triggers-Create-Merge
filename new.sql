create table mallar3(
id int primary key not null,
ad varchar(50),
kod int,
barkod int,
olcu_vahidi int,
tipi_id int,
qrup_id int,
satis_qiymeti int,
alis_qiymeti int,
qeyd varchar(20)
);


create table satis_mallar3(
mal_id int not null,
miqdar int ,
satis_qiymeti int,
satis_meblegi int,
sened_nomre int primary key not null,
foreign key(mal_id) references mallar3(
id) on update cascade);
update satis_mallar3 
set miqdar = 5
where mal_id = 3
select *from satis_mallar3;

alter table satis_mallar3
add  [Məhsul Adı]  nvarchar(30);
update satis_mallar3
set [Məhsul Adı] = 'defter'
where mal_id =3;

drop table if exists satis_senedi;
create table satis_senedi(
musteri_id int primary key not null,
[Müştəri Adı] varchar(30),
tarix date,
sened_nomresi int,
qeyd varchar(40),
[Müştəri Meyili] varchar(30)
foreign key (sened_nomresi) references satis_mallar3(sened_nomre)
)
insert into satis_senedi values(1,'Seymur','6-10-22',1,'ela','custmer@logix.az'),
(2,'Veli','10-10-22',2,'yaxsi','custmer@logix.az'),
(3,'valeh','12-10-22',3,'pis','custmer@logix.az')
alter table satis_senedi 
add Ünvan nvarchar(30);
update satis_senedi 
set Ünvan = N'Gənclik'
where musteri_id = 1;
select * from satis_senedi;
insert into mallar3(id,satis_qiymeti,alis_qiymeti) values( 1,  10, 9)
insert into satis_mallar3(mal_id,satis_qiymeti,satis_meblegi,sened_nomre) values( 1, 10, 20,1)
insert into mallar3(id,satis_qiymeti,alis_qiymeti) values(2,  12, 11)
insert into satis_mallar3(mal_id,satis_qiymeti,satis_meblegi,sened_nomre) values(2, 13, 12,2)
insert into mallar3(id,satis_qiymeti,alis_qiymeti) values( 3, 13, 1)
insert into satis_mallar3(mal_id,satis_qiymeti,satis_meblegi,sened_nomre) values(3, 14, 13,3)




update mallar3 set alis_qiymeti = 40,
satis_qiymeti = 50
where id = 1;
select *from satis_mallar3;


create table musteri(
ad varchar(30),
telefon int,
unvan varchar(30),
email varchar(40))

create table anbar(
id int primary key,
ad varchar(40),
kod int)

drop table if exists dbo.notifaction_table3;

create table notifaction_table3(
id int  not null,
time_stamp date,
kohne_qiymet int null,
yeni_qiymet int null)

insert into notifaction_table3(id,kohne_qiymet,yeni_qiymet) values (1,0,0),(2,0,0),(3,0,0)


MERGE dbo.notifaction_table3 AS SourceTbl
USING dbo.mallar3 AS TargetTbl ON (SourceTbl.id = TargetTbl.id)
WHEN MATCHED
 and SourceTbl.yeni_qiymet <> TargetTbl.satis_qiymeti
 
 THEN UPDATE SET SourceTbl.kohne_qiymet = TargetTbl.satis_qiymeti
WHEN NOT MATCHED
 THEN INSERT (yeni_qiymet)
 VALUES (TargetTbl.satis_qiymeti)
WHEN NOT MATCHED BY SOURCE
 THEN DELETE
OUTPUT $action, INSERTED.*, DELETED.*;

select * from notifaction_table3; 


update mallar3 
set satis_qiymeti = 55
where id = 2;
select * from satis_mallar3;