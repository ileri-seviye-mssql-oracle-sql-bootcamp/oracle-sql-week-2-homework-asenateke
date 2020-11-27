--3 adet tablo create scripti olu�turunuz. Her bir tablonun minimum 5 kolonu olmas� gerekmektedir.
--Tablolar� birbirine ba�layacak primary key ve foreign key tan�mlar�n�n olmas�na dikkat edilmelidir.
--Tablolara minimum 3 sat�r veri insert edecek scriptleri olu�turunuz. 
--Olu�turmu� oldu�unuz tablolar� kaynak olarak alan bir adet synonym, bir adet view scripti olu�turunuz.

alter session set "_ORACLE_SCRIPT"=true;����
CREATE USER HOTEL IDENTIFIED BY hotel123;��
GRANT CREATE SESSION TO HOTEL;��
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

INSERT INTO hotel.locations (location_id, region, city, post_code, address) VALUES ('1','Mediterranean', 'Antalya', '07230',' Kemera�z�, Tesisler Cad. No:402' );
INSERT INTO hotel.details (details_id, pilates, turkish_bath, market, wifi, sauna,  salt_room, balcony, room_service, mini_bar ) VALUES ('1','YES','YES','YES','YES','YES','NO','YES','YES','YES');
INSERT INTO hotel.hotels (hotel_id, hotel_name, hotel_type, accommodation_type, details_id, phone, location_id  ) VALUES ('1','Melas Lara Hotel','Domestic','Ultra All Inclusive','1','+90 242 352 33 66','1');


INSERT INTO hotel.locations (location_id, region, city, post_code, address) VALUES ('2','Egypt', 'South Sinai Governorate', '46628',' Nabq Bay? Qesm Sharm Ash Sheikh' );
INSERT INTO hotel.details (details_id, pilates, turkish_bath, market, wifi, sauna,  salt_room, balcony, room_service, mini_bar ) VALUES ('2','YES','NO','YES','YES','YES','NO','YES','YES','NO');
INSERT INTO hotel.hotels (hotel_id, hotel_name, hotel_type, accommodation_type, details_id, phone, location_id  ) VALUES ('2','Rixos Sharm El Sheikh','Abroad','Ultra All Inclusive','2','+20 69 3710210','2');

INSERT INTO hotel.locations (location_id, region, city, post_code, address) VALUES ('3','Anatolia', 'Afyonkarahisar', '03030',' Demir�evre, Afyon K�tahya Road 13. Km' );
INSERT INTO hotel.details (details_id, pilates, turkish_bath, market, wifi, sauna,  salt_room, balcony, room_service, mini_bar ) VALUES ('3','YES','YES','YES','YES','YES','YES','YES','NO','NO');
INSERT INTO hotel.hotels (hotel_id, hotel_name, hotel_type, accommodation_type, details_id, phone, location_id  ) VALUES ('3','Korel Thermal Resort Clinic & Spa','Domestic','All Inclusive','3','+90272 252 22 22','3');

CREATE VIEW HOTEL.HOTEL_CONNECT�ON
AS (SELECT h.hotel_id, h. hotel_ad,h.phone l.region, l.city l.adress   FROM hotel.hotels AS h
INNER JOIN locations AS l ON h.location_id=l.location_id);




-------------------------------------------------

-- Kotas� limitsiz olan �r�nler hangileridir?
Select  *  from telco.offer
where  descr�pt�on LIKE '%Unli%';

-- Stat�s� 'Initial' olan m��terileri bulunuz.

SELECT * FROM customer
WHERE status = 'INITIAL';

-- �ehir bilgisi 'ISTANBUL' olan adresleri bulunuz.
SELECT * FROM address
WHERE LOWER(city) LIKE '%istan%';

-- Birim fiyat� 150'den b�y�k olan order_itemlar� bulunuz.
SELECT * FROM sales.order_items
WHERE un�t_pr�ce>150;

-- ��e al�m tarihi May�s 2016 olan �al��anlar� bulunuz. 
SELECT * FROM SALES.employees
WHERE h�re_date BETWEEN '01/05/2016' AND '31/05/2016';

-- Ad� Charlie ya da Charlsie olan contactlar� bulunuz.
SELECT * FROM SALES.contacts
WHERE LOWER(f�rst_name) IN ('charlie', 'charlsie');

--Y�l�n 4. aylar�nda en �ok hangi ama�la kredi �ekilmi�tir?  YAPAMADIM
SELECT purpose, COUNT(purpose) AS C_PURPOSE FROM BANKING.loans
WHERE loans.month=4
GROUP BY purpose
ORDER BY purpose DESC;

-- Adet say�s� 10dan b�y�k 50den k���k envanterleri bulunuz.
SELECT * FROM SALES.inventories
WHERE quant�ty BETWEEN 10 AND 50;

-- Birincil ileti�im bilgisi olmayan telefon numaralar�n� bulunuz.
SELECT * FROM telco. contact
WHERE �s_pr�mary = 0;

-- Bir sipari�te toplam 100.0000'den fazla �cret �deyen emirler nedir? 
SELECT * FROM SALES.order_�tems
WHERE quant�ty * un�t_pr�ce >1000000;

-- Bankan�n 50 ve ya 51 ya��nda kad�n m��terilerinden ayn� isme sahip olan m��terisi/m��terileri var m�? Varsa isimleri neler?
SELECT c.first FROM banking.clients c
WHERE SEX = 'Female' AND AGE IN (50,51)
GROUP BY  c.f�rst, c.middle
HAVING COUNT(*) > 1;

-- Hesap �deme �ekli nakit olmayan hesaplar hangileridir?
SELECT id, account_number, account_name FROM telco.account
WHERE payment_type != 'CASH';

-- Stat�s� deaktif olan m��terilerin ba�lant� kesim tarihleri nedir?
SELECT id, customer_num, disconnection_date FROM telco.customer
WHERE status = 'DEACTIVE';

-- Manager'� olmayan �al��anlar hangileridir?
SELECT * FROM SALES.employees
WHERE manager_�d IS NULL;

-- State bilgisi bo� olan lokasyonlar� bulunuz.
SELECT * FROM SALES.locat�ons
WHERE state IS NULL;

-- Hesap kapan�� tarihi dolu olan hesaplar� bulunuz.
SELECT * FROM telco.account
WHERE account_clos�ng_date IS NOT NULL;

-- Elektronik fatura mail adresi (E_bill_email) olan hesaplar hangileridir? 
SELECT id, account_number, account_name FROM telco.account
WHERE e_bill_email IS NOT NULL;

-- Durumu iptal olan ve sat�c�lar� olmayan emirler hangileridir?
SELECT * FROM SALES.orders
WHERE status='Canceled' AND salesman_�d IS NULL;

-- S�zle�me biti� tarihi 1 Ocak 2000'den b�y�k , 1 Ocak 2005'ten k���k olan s�zle�meleri bulunuz.
SELECT * FROM telco.agreement
WHERE commitment_end_date BETWEEN '01/01/2000' AND '01/01/2005' ;

- Ocak 2016 ile Haziran 2016 aras�nda verilen sipari�ler hangileridir? 
SELECT * FROM SALES.orders
WHERE order_date BETWEEN '01/01/2016' AND '30/06/2016';

- 2005 y�l�ndan �nce yap�lan ve hala aktif olan subscriptionlar hangileridir? 
SELECT * FROM telco.subscr�pt�on
WHERE act�vat�on_date < '01/01/2005' AND status = 'ACTIVE';

-- S�zle�me ba�lang�� tarihi Ocak 2010'dan b�y�k olan s�zle�meleri bulunuz
SELECT * FROM telco.agreement
WHERE commitment_start_date > '31/12/2010';

-- �smi E ile ba�layan m��terileri bulunuz.
SELECT * FROM telco.customer
WHERE name LIKE 'E%';

-- Product tipi 'DSL' ile biten �r�nleri bulunuz. 
 SELECT * FROM telco.product
 WHERE product_name LIKE '%DSL';

-- Unvan� 'S' ile ba�lamayan �al��anlar� bulunuz
SELECT * FROM SALES.employees
WHERE LOWER(job_t�tle) LIKE 's%';

-- Herhangi bir �e�it Intel Xeon �r�nler hangileridir? 
SELECT * FROM SALES.products
WHERE product_name LIKE '%Intel Xeon%';

-- �sminde ya da soyisminde '�' harfi ge�en m��teriler hangileridir?
 SELECT * FROM telco.customer
 WHERE LOWER(name)  LIKE '%�%' OR LOWER(surname) LIKE '%�%';
 
 -- �smi 'C' ile ba�layan kontaklar hangileridir? Soyad�na g�re alfabetik s�ra ile s�ralayal�m.
SELECT * FROM SALES.contacts
WHERE f�rst_name LIKE 'C%' ORDER BY LAST_NAME ASC;

-- �r�n ad� 'Asus' ile ba�layan ve liste fiyat� standart �cretinden k���k olan �r�nleri bulunuz
SELECT * FROM SALES.products
WHERE product_name LIKE 'Asus%' AND l�st_pr�ce <standard_cost;

-- �lke kodu UK ve AU olan adresleri bulunuz.
SELECT * FROM telco.address
WHERE country_cd IN ('UK', 'AU');

-- 1,2,4,5 id'li kategorilerin bilgilerini bulunuz. 
SELECT * FROM SALES.product_categor�es
WHERE category_�d IN (1,2,4,5);

-- Taahh�t s�resi 240 ve 120 ay olan b�t�n s�zle�meleri bulmak istiyoruz.
SELECT * FROM telco.agreement
WHERE comm�tment_durat�on IN ('240 MONTHS', '120 MONTHS');

-- Sipari� durumu 'Shipped'den farkl� olan m��terilerin bilgilerini bulunuz. 
SELECT c.customer_�d, c.name, c.address, c.webs�te, c.cred�t_l�m�t  FROM SALES.orders o
INNER JOIN SALES.customers  c
ON o.customer_�d = c.customer_�d
WHERE o.status != 'Shipped';


-- Adet say�s� 100e e�it olan envanterlerin product bilgisini bulunuz.
SELECT pr.product_�d, pr.product_name, pr.descr�pt�on, pr.standard_cost, pr.l�st_pr�ce, pr.category_�d FROM SALES.�nventor�es inv
INNER JOIN SALES.products pr
ON inv.product_�d = pr.product_�d
WHERE inv.quant�ty =100;

-- S�zle�me alt tipi MAIN olan ka� tane s�zle�me vard�r?

SELECT COUNT(*) AS C_Subtype_Main FROM telco.agreement
WHERE subtype = 'MAIN';

-- Deaktif m��terilerin say�s�n� bulunuz.
SELECT COUNT(*) c_Customer_deactive FROM telco.customer
WHERE status =  'DEACTIVE';

-- Beijing (8 numaral� warehouse)'da ka� farkl� envanter vard�r? 
SELECT COUNT(DISTINCT(inv.product_id) )FROM SALES.warehouses wh
INNER JOIN SALES.�nventor�es inv
ON wh.warehouse_�d = inv.warehouse_�d
WHERE wh.warehouse_�d = 8;

-- �leti�im tipi olarak email ve statusu kullan�mda olan ka� m��teri var?
SELECT COUNT(*) AS C_EMAIL_USED FROM telco.customer 
INNER JOIN telco.ontact
ON customer.id = contact.customer_�d
WHERE contact.cnt_type ='EMAIL' AND contact.status = 'USED';


-- Liste fiyati 1000 ile 3000 arasinda olan ka� product var?----Sales �emas� i�in
SELECT * FROM SALES.products
WHERE l�st_pr�ce BETWEEN 1000 AND 3000;


--Hangi y�llarda ka� hesap a��lm��t�r?
SELECT year, COUNT(*) FROM banking.accounts
GROUP BY year;

-- ��lemlerin tiplerine g�re toplam say�lar�n�n b�y�kten k����e s�ralamas� nedir?
SELECT type, Count(*) AS C_Type  FROM banking.transactions
GROUP BY type
ORDER BY C_TYPE DESC;

-- ��lemlerin tiplerine g�re toplam tutarlar�n�n b�y�kten k����e s�ralamas� nedir?
SELECT type, SUM(amount) AS SUM_AMOUNT  FROM banking.transactions
GROUP BY type
ORDER BY SUM_AMOUNT DESC;








































































