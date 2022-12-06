CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
delete from personel;
select * from personel;

--GROUP BY--
--isme gore toplam maaslari bulun
select isim, sum(maas) as toplam_maas from personel
group by isim order by toplam_maas desc;

--sehre gore personel sayisini listeleyin
select sehir, count(isim) as calisan_sayisi from personel
group by sehir;

--sirketlere gore maasi 5000 den fazla olan personel sayisini sirket ile listeleyin
select sirket, count(*) from personel where maas>5000 
group by sirket;

--HAVING CLAUSE--
--having sadece group by ile kullanilir
--Having; aggregate function'lar ile birlikte kullanilan filtreleme komutudur.

--her sirketin min maasini eger 4000den buyukse listele
select sirket,min(maas) as en_az_maas from personel
group by sirket
having min(maas)>4000;

--normalde min maas tek deger getirir o yuzden group by ile kullandik
--ama bize sart da koydugu icin haveing ile sarti sagladik

--ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla olan 
--isim ve toplam maasi gosteren sorgu
select isim, sum(maas) as toplam_maas from personel
group by isim
having sum(maas)>10000;

-- Eger bir sehirde calisan personel sayisi 1’den coksa
--sehir ismini ve personel sayisini veren sorgu yaziniz
select sehir, count(isim) as toplam_personel from personel
group by sehir
having count(isim)>1;

-- Eger bir sehirde alinan MAX maas 5000’den dusukse
-- sehir ismini ve MAX maasi veren sorgu yaziniz
select sehir,max(maas) as toplam_maas from personel
group by sehir
having max(maas) <5000;

--UNION OPERATOR--
--iki farkli sorgunun sonucunu birlestirir
--secilen field sayisi ve data type'i ayni olmalidir

-- 1) Maasi 4000’den cok olan isci isimlerini ve maaslarini ve 5000 liradan fazla maas alinan
-- sehirleri ve maaslarini gosteren sorguyu yaziniz
select isim as isim_sehirler ,maas from personel where maas>4000
union
select sehir ,maas from personel where maas>5000;

-- 2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz
select isim ,maas from personel where isim='Mehmet Ozturk'
union
select sehir, maas from personel where sehir='Istanbul'
order by maas;

drop table  if exists personel;
CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id))
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

drop table if exists personel_bilgi;
CREATE TABLE personel_bilgi  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel(id)
);
INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

--id’si 123456789 olan personelin Personel tablosundan sehir ve maasini,
--personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin
select sehir as sehir_tel, maas as maas_cocuk from personel where id=123456789
union
select tel,cocuk_sayisi from personel_bilgi where id=123456789;
/*
UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icinkullanilir,
Ayni kayit birden fazla olursa, sadece bir tanesinialir.
UNION ALL ise tekrarli elemanlari, tekrar sayisincayazar.
NOT : UNION ALL ile birlestirmelerdede
1)Her 2 QUERY’den elde edeceginiz tablolarin sutun sayilari esit olmali
2)Alt alta gelecek sutunlarin data type’lari ayni olmali
*/

--Personel tablosunda da maasi 5000’den az olan tum isimleri ve maaslari bulunuz
select isim ,maas from personel where maas<5000
union all
select isim ,maas from personel where maas<5000;

--INTERSECT--
--iki kumenin kesisimini verir

--Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
--Iki sorguyu INTERSECT ile birlestirin
select id from personel where sehir in('Istanbul','Ankara')
intersect
select id from personel_bilgi where cocuk_sayisi in(2,3);

--Maasi 4800’den az olanlar veya 5000’den cok olanlarin id’lerini listeleyin
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
--Iki sorguyu INTERSECT ile birlestirin
SELECT id
FROM personel
WHERE maas NOT BETWEEN 4800 AND 5500
intersect
SELECT id
FROM personel_bilgi
WHERE cocuk_sayisi IN(2,3);

--Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
select isim from personel where sirket='Honda'
intersect
select isim from personel where sirket='Ford'
intersect
select isim from personel where sirket='Tofas';

--EXCEPT OPERATOR--
--mysql de minus kullaniliyor ama postsql except kullaniyor

--5000’den az maas alip Honda’da calismayanlari yazdirin
select isim,sirket from personel where maas<5000
except
select isim,sirket from personel where sirket='Honda';

--Ismi Mehmet Ozturk olup Istanbul’da calismayanlarin isimlerini ve sehirlerini listeleyin
select isim, sehir from personel where isim='Mehmet Ozturk'
except
select isim,sehir from personel where sehir='Istanbul';
