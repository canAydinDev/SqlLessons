CREATE TABLE ogrenciler5
(
ogrenci_no char(7),--uzunlugunu bildigimiz stringler icin
isim varchar(20),
soyisim varchar(25),
not_ort real,-- Ondalıklı sayılar için kullanılır(Double gibi)
kayit_tarih date    
);
create table notlar as select isim, not_ort from ogrenciler5;
insert into notlar values ('ahmet',75.5);
select * from notlar;
insert into notlar values('can',74);
insert into notlar(isim) values ('metin');
select isim from notlar;
