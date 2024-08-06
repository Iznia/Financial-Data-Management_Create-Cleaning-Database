'''
	====================================================================
	Graded Challenge 2

	Nama  : Iznia Azyati
	Batch : RMT-032

	Program ini dibuat untuk membantu divisi Finance membuat database.
	Program ini dilakukan dengan konsep Relational Database dan Pandas.
	====================================================================
'''


	
-- Buat database baru
-- CREATE DATABASE GC2_iznia_azyati;

BEGIN;

-- Buat tabel segment
CREATE TABLE segment (
    segment_id SERIAL PRIMARY KEY,
    segment VARCHAR(255) NOT NULL);

-- Buat tabel country
CREATE TABLE country (
    country_id SERIAL PRIMARY KEY,
    country VARCHAR(255) NOT NULL);

-- Buat tabel product
CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product VARCHAR(255) NOT NULL);
	
-- Buat tabel time
CREATE TABLE Time (
    Time_ID SERIAL PRIMARY KEY,
    Date DATE UNIQUE NOT NULL,
    Month_Number INT NOT NULL,
    Month_Name VARCHAR(255) NOT NULL,
    Year INT NOT NULL);

-- Buat tabel sales
CREATE TABLE sales (
    sales_id SERIAL PRIMARY KEY,
    segment_id INT NOT NULL,
    country_id INT NOT NULL,
    product_id INT NOT NULL,
    time_id INT NOT NULL,
    discount_band VARCHAR(255),
    units_sold FLOAT,
    manufacturing_price FLOAT NOT NULL,
    sale_price FLOAT NOT NULL,
    gross_sales FLOAT,
    discounts FLOAT,
    sales FLOAT,
    cogs FLOAT,
    profit FLOAT,
    FOREIGN KEY (segment_id) REFERENCES segment(segment_id),
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (time_id) REFERENCES time(time_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

COMMIT;


-- Input Data
-- Input Data Tabel Segment
COPY segment(Segment,Segment_ID)
FROM '/tmp/table_segment.csv'
DELIMITER ','
CSV HEADER;

-- Input Data Tabel Country
COPY country(Country,Country_ID)
FROM '/tmp/table_country.csv'
DELIMITER ','
CSV HEADER;

-- Input Data Tabel Product
COPY product(Product,Product_ID)
FROM '/tmp/table_product.csv'
DELIMITER ','
CSV HEADER;

-- Input Data Tabel Time
COPY time(Date,Month_Number,Month_Name,Year,Time_ID)
FROM '/tmp/table_time.csv'
DELIMITER ','
CSV HEADER;

-- Input Data Tabel Sales (Main Table)
COPY sales(Segment_ID,Country_ID,Product_ID,
			Time_ID,Discount_Band,Units_Sold,
			Manufacturing_Price,Sale_Price,
			Gross_Sales,Discounts,Sales,COGS,	
			Profit,Sales_ID)
FROM '/tmp/table_sales_main.csv'
DELIMITER ','
CSV HEADER;



-- PEMBUATAN USER
BEGIN;
-- Buat user dengan username dan password

-- 1. read only user = user yang hanya memiliki akses 'SELECT'
CREATE USER user_1 WITH PASSWORD 'password_readonly';

-- 2. admin user = user yang bisa akses penuh semua query.
CREATE USER user_admin WITH PASSWORD 'password_admin';


-- HAK AKSES USER

-- 1. read only user = user_1 
--    Memberikan akses SELECT ke user_1
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user_1;
--    Blokir akses INSERT, UPDATE, DELETE, dan TRUNCATE ke user_1
REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA public FROM user_1;

-- 2. admin user = user_admin
--    Memberikan semua hak akses ke user_admin
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO user_admin;


-- Make sure akses berjalan ke tabel yang akan dibuat di masa mendatang
-- memastikan user_1 hanya mendapatkan akses SELECT untuk tabel yang akan dibuat nanti.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO user_1;

-- memastikan admin_user mendapatkan semua hak akses untuk tabel yang akan dibuat nanti.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO user_admin;


COMMIT;




-- 5. PENGUJIAN DATABASE --

-- a. Tabel informasi total profit di tiap jenis segmentasi (without diskon)

BEGIN;

SELECT segment.segment, SUM(sales.profit) AS total_profit
FROM sales
JOIN segment ON sales.segment_id = segment.segment_id
WHERE discount_band IS NOT NULL AND sales.discount_band != 'None'
GROUP BY segment.segment
ORDER BY total_profit DESC;

COMMIT;


-- b. Tabel informasi rangkuman statistik (Avg, Min, Max) dari Sales masing-masing Negara
SELECT country.country, 
	AVG(sales.sales) AS average_sales,
	MIN(sales.sales) AS min_sales,
	MAX(sales.sales) AS max_sales
FROM sales
JOIN country ON sales.country_id = country.country_id
GROUP BY country.country;

