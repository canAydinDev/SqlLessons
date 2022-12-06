/*
bir tabloda bir tane primary key olur ama
constraint ile atama yaparsak composite primary key yapabiliriz
*/

--odev
--ankarada calisani olan markalarin id lerini ve calisan sayilarini listeleyiniz
select * from markalar;
select * from calisanlar2;

select marka_id as ankarada_calisan_id, calisan_sayisi from markalar 
where marka_isim in (select isyeri from calisanlar2 where sehir='Ankara');

--exists olunca iki tablo ayni
--update guncelleme islerinde uptdate tabloAdi set ...

--ALIASES--
--AS kullanilarak isim verip
--|| ile concatination yapilir

CREATE TABLE calisanlar (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO calisanlar VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO calisanlar VALUES(345678901, 'Mine Bulut', 'Izmir');

--eger iki sutunun verilerini birlestirelim
select * from calisanlar;
select calisan_id as id, 
calisan_isim ||' '|| calisan_dogdugu_sehir as calisan_bilgisi 
from calisanlar;

--2. yol
select calisan_id as id, 
concat(calisan_isim,calisan_dogdugu_sehir) as calisan_bilgisi 
from calisanlar;

--IS NULL CONDITION--
--is null/is not null
--veriler arasinda null deger varsa ve bunlari cagirmak istiyorsak
--is null i kullaniyoruz...
drop table if exists insanlar;
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

--name sutununda null olan degerleri listeleyin
select name from insanlar where name is null;

--insanlar tablosunda null olmayan degerleri getir


--insanlar tablosunda null deger almis verileri no name olarak degistiriniz
update insanlar
set name='no name' where name is null;

select name from insanlar;

--ORDER BY--
--sadece select ile kullanilir
--istenen field'i natural order olarak siralar
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

--insanlar tablosundaki datalari adrese gore(Ascend x Descend) siralayin
select * from insanlar order by adres;
select * from insanlar where isim='Mine' order by ssn;

--order by komutu sonrasi field name yerine field numarasi da kullanilabilir
select * from insanlar where soyisim='Bulut' order by 2;

--buyukten kucuge gore sirala
select * from insanlar order by ssn desc;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, 
--Soyisimler ters sirali olarak listeleyin
select * from insanlar order by isim asc, soyisim desc;

--length--
--isim ve soyisim degerlerini soyisim kelime uzunluguna gore siralayiniz
select isim, soyisim from insanlar order by length (soyisim) desc;

--tum isim ve soyisim degerlerini ayni sutunda cagirip 
--her sutun degerini uzunluguna gore siralayin
select isim ||' '||soyisim as isim_soyisim from insanlar order by length(isim||soyisim);
select isim ||' '||soyisim as isim_soyisim from insanlar order by length(concat(isim,soyisim));


--GROUP BY CLAUSE
/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

--isme gore alinan urunleri bulun ve bu urunleri buyukten kucuge siralayin
select isim, sum(urun_miktar) as alinan_toplam_urun from manav
group by isim order by alinan_toplam_urun desc;


--urun ismine gore urunu alan toplam kisi sayisini listele
select urun_adi, count(isim )as toplam_kisi from manav
group by urun_adi;


