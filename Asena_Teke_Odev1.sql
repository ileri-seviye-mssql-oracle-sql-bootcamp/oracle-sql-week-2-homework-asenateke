--3 adet tablo create scripti oluþturunuz. Her bir tablonun minimum 5 kolonu olmasý gerekmektedir.
--Tablolarý birbirine baðlayacak primary key ve foreign key tanýmlarýnýn olmasýna dikkat edilmelidir.
--Tablolara minimum 3 satýr veri insert edecek scriptleri oluþturunuz. 
--Oluþturmuþ olduðunuz tablolarý kaynak olarak alan bir adet synonym, bir adet view scripti oluþturunuz.

alter session set "_ORACLE_SCRIPT"=true;    
CREATE USER HOTEL IDENTIFIED BY hotel123;  
GRANT CREATE SESSION TO HOTEL;  
GRANT CONNECT, RESOURCE, DBA TO HOTEL;

CREATE TABLE hotel.hotels(
hotel_id varchar2(255) PRIMARY KEY,
hotel_name varchar2(250) NOT NULL,
hotel_type varchar2(150) NOT NULL,
accommodation_type varchar2(150) NOT NULL,
details_id varchar2(255),
phone varchar2(55),
location_id varchar2(255), --fk
CONSTRAINT fk_location_hotels FOREIGN KEY(location_id)
    REFERENCES hotel.locations(location_id),
CONSTRAINT fk_details_hotels FOREIGN KEY (details_id)
    REFERENCES hotel.details(details_id)
    );

CREATE TABLE hotel.details(
details_id varchar2(255) PRIMARY KEY,
pilates varchar2(3) NOT NULL,
turkish_bath varchar(3) NOT NULL,
market varchar(3) NOT NULL,
wifi varchar(3) NOT NULL,
sauna varchar(3) NOT NULL,
salt_room varchar(3) NOT NULL,
balcony varchar(3) NOT NULL,
room_service varchar(3) NOT NULL,
mini_bar varchar(3) NOT NULL
);

CREATE TABLE hotel.locations(
location_id varchar2(255) PRIMARY KEY,
region varchar2(250) NOT NULL,
city varchar2(150) NOT NULL,
post_code varchar2(10) NOT NULL,
address varchar2(300) NOT NULL
);

INSERT INTO hotel.locations (location_id, region, city, post_code, address) VALUES ('1','Mediterranean', 'Antalya', '07230',' Kemeraðzý, Tesisler Cad. No:402' );
INSERT INTO hotel.details (details_id, pilates, turkish_bath, market, wifi, sauna,  salt_room, balcony, room_service, mini_bar ) VALUES ('1','YES','YES','YES','YES','YES','NO','YES','YES','YES');
INSERT INTO hotel.hotels (hotel_id, hotel_name, hotel_type, accommodation_type, details_id, phone, location_id  ) VALUES ('1','Melas Lara Hotel','Domestic','Ultra All Inclusive','1','+90 242 352 33 66','1');


INSERT INTO hotel.locations (location_id, region, city, post_code, address) VALUES ('2','Egypt', 'South Sinai Governorate', '46628',' Nabq Bay? Qesm Sharm Ash Sheikh' );
INSERT INTO hotel.details (details_id, pilates, turkish_bath, market, wifi, sauna,  salt_room, balcony, room_service, mini_bar ) VALUES ('2','YES','NO','YES','YES','YES','NO','YES','YES','NO');
INSERT INTO hotel.hotels (hotel_id, hotel_name, hotel_type, accommodation_type, details_id, phone, location_id  ) VALUES ('2','Rixos Sharm El Sheikh','Abroad','Ultra All Inclusive','2','+20 69 3710210','2');

INSERT INTO hotel.locations (location_id, region, city, post_code, address) VALUES ('3','Anatolia', 'Afyonkarahisar', '03030',' Demirçevre, Afyon Kütahya Road 13. Km' );
INSERT INTO hotel.details (details_id, pilates, turkish_bath, market, wifi, sauna,  salt_room, balcony, room_service, mini_bar ) VALUES ('3','YES','YES','YES','YES','YES','YES','YES','NO','NO');
INSERT INTO hotel.hotels (hotel_id, hotel_name, hotel_type, accommodation_type, details_id, phone, location_id  ) VALUES ('3','Korel Thermal Resort Clinic & Spa','Domestic','All Inclusive','3','+90272 252 22 22','3');

CREATE VIEW HOTEL.HOTEL_CONNECTÝON
AS (SELECT h.hotel_id, h. hotel_ad,h.phone l.region, l.city l.adress   FROM hotel.hotels AS h
INNER JOIN locations AS l ON h.location_id=l.location_id);




-------------------------------------------------

-- Kotasý limitsiz olan ürünler hangileridir?
Select  *  from telco.offer
where  descrýptýon LIKE '%Unli%';

-- Statüsü 'Initial' olan müþterileri bulunuz.

SELECT * FROM customer
WHERE status = 'INITIAL';

-- Þehir bilgisi 'ISTANBUL' olan adresleri bulunuz.
SELECT * FROM address
WHERE LOWER(city) LIKE '%istan%';

-- Birim fiyatý 150'den büyük olan order_itemlarý bulunuz.
SELECT * FROM sales.order_items
WHERE unýt_prýce>150;

-- Ýþe alým tarihi Mayýs 2016 olan çalýþanlarý bulunuz. 
SELECT * FROM SALES.employees
WHERE hýre_date BETWEEN '01/05/2016' AND '31/05/2016';

-- Adý Charlie ya da Charlsie olan contactlarý bulunuz.
SELECT * FROM SALES.contacts
WHERE LOWER(fýrst_name) IN ('charlie', 'charlsie');

--Yýlýn 4. aylarýnda en çok hangi amaçla kredi çekilmiþtir?  YAPAMADIM
SELECT purpose, COUNT(purpose) AS C_PURPOSE FROM BANKING.loans
WHERE loans.month=4
GROUP BY purpose
ORDER BY purpose DESC;

-- Adet sayýsý 10dan büyük 50den küçük envanterleri bulunuz.
SELECT * FROM SALES.inventories
WHERE quantýty BETWEEN 10 AND 50;

-- Birincil iletiþim bilgisi olmayan telefon numaralarýný bulunuz.
SELECT * FROM telco. contact
WHERE ýs_prýmary = 0;

-- Bir sipariþte toplam 100.0000'den fazla ücret ödeyen emirler nedir? 
SELECT * FROM SALES.order_ýtems
WHERE quantýty * unýt_prýce >1000000;

-- Bankanýn 50 ve ya 51 yaþýnda kadýn müþterilerinden ayný isme sahip olan müþterisi/müþterileri var mý? Varsa isimleri neler?
SELECT c.first FROM banking.clients c
WHERE SEX = 'Female' AND AGE IN (50,51)
GROUP BY  c.fýrst, c.middle
HAVING COUNT(*) > 1;

-- Hesap ödeme þekli nakit olmayan hesaplar hangileridir?
SELECT id, account_number, account_name FROM telco.account
WHERE payment_type != 'CASH';

-- Statüsü deaktif olan müþterilerin baðlantý kesim tarihleri nedir?
SELECT id, customer_num, disconnection_date FROM telco.customer
WHERE status = 'DEACTIVE';

-- Manager'ý olmayan çalýþanlar hangileridir?
SELECT * FROM SALES.employees
WHERE manager_ýd IS NULL;

-- State bilgisi boþ olan lokasyonlarý bulunuz.
SELECT * FROM SALES.locatýons
WHERE state IS NULL;

-- Hesap kapanýþ tarihi dolu olan hesaplarý bulunuz.
SELECT * FROM telco.account
WHERE account_closýng_date IS NOT NULL;

-- Elektronik fatura mail adresi (E_bill_email) olan hesaplar hangileridir? 
SELECT id, account_number, account_name FROM telco.account
WHERE e_bill_email IS NOT NULL;

-- Durumu iptal olan ve satýcýlarý olmayan emirler hangileridir?
SELECT * FROM SALES.orders
WHERE status='Canceled' AND salesman_ýd IS NULL;

-- Sözleþme bitiþ tarihi 1 Ocak 2000'den büyük , 1 Ocak 2005'ten küçük olan sözleþmeleri bulunuz.
SELECT * FROM telco.agreement
WHERE commitment_end_date BETWEEN '01/01/2000' AND '01/01/2005' ;

- Ocak 2016 ile Haziran 2016 arasýnda verilen sipariþler hangileridir? 
SELECT * FROM SALES.orders
WHERE order_date BETWEEN '01/01/2016' AND '30/06/2016';

- 2005 yýlýndan önce yapýlan ve hala aktif olan subscriptionlar hangileridir? 
SELECT * FROM telco.subscrýptýon
WHERE actývatýon_date < '01/01/2005' AND status = 'ACTIVE';

-- Sözleþme baþlangýç tarihi Ocak 2010'dan büyük olan sözleþmeleri bulunuz
SELECT * FROM telco.agreement
WHERE commitment_start_date > '31/12/2010';

-- Ýsmi E ile baþlayan müþterileri bulunuz.
SELECT * FROM telco.customer
WHERE name LIKE 'E%';

-- Product tipi 'DSL' ile biten ürünleri bulunuz. 
 SELECT * FROM telco.product
 WHERE product_name LIKE '%DSL';

-- Unvaný 'S' ile baþlamayan çalýþanlarý bulunuz
SELECT * FROM SALES.employees
WHERE LOWER(job_týtle) LIKE 's%';

-- Herhangi bir çeþit Intel Xeon ürünler hangileridir? 
SELECT * FROM SALES.products
WHERE product_name LIKE '%Intel Xeon%';

-- Ýsminde ya da soyisminde 'ü' harfi geçen müþteriler hangileridir?
 SELECT * FROM telco.customer
 WHERE LOWER(name)  LIKE '%ü%' OR LOWER(surname) LIKE '%ü%';
 
 -- Ýsmi 'C' ile baþlayan kontaklar hangileridir? Soyadýna göre alfabetik sýra ile sýralayalým.
SELECT * FROM SALES.contacts
WHERE fýrst_name LIKE 'C%' ORDER BY LAST_NAME ASC;

-- Ürün adý 'Asus' ile baþlayan ve liste fiyatý standart ücretinden küçük olan ürünleri bulunuz
SELECT * FROM SALES.products
WHERE product_name LIKE 'Asus%' AND lýst_prýce <standard_cost;

-- Ülke kodu UK ve AU olan adresleri bulunuz.
SELECT * FROM telco.address
WHERE country_cd IN ('UK', 'AU');

-- 1,2,4,5 id'li kategorilerin bilgilerini bulunuz. 
SELECT * FROM SALES.product_categorýes
WHERE category_ýd IN (1,2,4,5);

-- Taahhüt süresi 240 ve 120 ay olan bütün sözleþmeleri bulmak istiyoruz.
SELECT * FROM telco.agreement
WHERE commýtment_duratýon IN ('240 MONTHS', '120 MONTHS');

-- Sipariþ durumu 'Shipped'den farklý olan müþterilerin bilgilerini bulunuz. 
SELECT c.customer_ýd, c.name, c.address, c.websýte, c.credýt_lýmýt  FROM SALES.orders o
INNER JOIN SALES.customers  c
ON o.customer_ýd = c.customer_ýd
WHERE o.status != 'Shipped';


-- Adet sayýsý 100e eþit olan envanterlerin product bilgisini bulunuz.
SELECT pr.product_ýd, pr.product_name, pr.descrýptýon, pr.standard_cost, pr.lýst_prýce, pr.category_ýd FROM SALES.ýnventorýes inv
INNER JOIN SALES.products pr
ON inv.product_ýd = pr.product_ýd
WHERE inv.quantýty =100;

-- Sözleþme alt tipi MAIN olan kaç tane sözleþme vardýr?

SELECT COUNT(*) AS C_Subtype_Main FROM telco.agreement
WHERE subtype = 'MAIN';

-- Deaktif müþterilerin sayýsýný bulunuz.
SELECT COUNT(*) c_Customer_deactive FROM telco.customer
WHERE status =  'DEACTIVE';

-- Beijing (8 numaralý warehouse)'da kaç farklý envanter vardýr? 
SELECT COUNT(DISTINCT(inv.product_id) )FROM SALES.warehouses wh
INNER JOIN SALES.ýnventorýes inv
ON wh.warehouse_ýd = inv.warehouse_ýd
WHERE wh.warehouse_ýd = 8;

-- Ýletiþim tipi olarak email ve statusu kullanýmda olan kaç müþteri var?
SELECT COUNT(*) AS C_EMAIL_USED FROM telco.customer 
INNER JOIN telco.ontact
ON customer.id = contact.customer_ýd
WHERE contact.cnt_type ='EMAIL' AND contact.status = 'USED';


-- Liste fiyati 1000 ile 3000 arasinda olan kaç product var?----Sales þemasý için
SELECT * FROM SALES.products
WHERE lýst_prýce BETWEEN 1000 AND 3000;


--Hangi yýllarda kaç hesap açýlmýþtýr?
SELECT year, COUNT(*) FROM banking.accounts
GROUP BY year;

-- Ýþlemlerin tiplerine göre toplam sayýlarýnýn büyükten küçüðe sýralamasý nedir?
SELECT type, Count(*) AS C_Type  FROM banking.transactions
GROUP BY type
ORDER BY C_TYPE DESC;

-- Ýþlemlerin tiplerine göre toplam tutarlarýnýn büyükten küçüðe sýralamasý nedir?
SELECT type, SUM(amount) AS SUM_AMOUNT  FROM banking.transactions
GROUP BY type
ORDER BY SUM_AMOUNT DESC;








































































