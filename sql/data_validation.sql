-- ============================================================
-- Project : Ecommerce Business Analytics
-- File    : 02_data_validation.sql
-- Purpose : Validate all imports
-- ============================================================

--Row count
 
SELECT COUNT(*) AS customers FROM olist_customers_dataset;

SELECT COUNT(*) AS orders FROM olist_orders_dataset;

SELECT COUNT(*) AS order_items FROM olist_order_items_dataset;

SELECT COUNT(*) AS products FROM olist_products_dataset;

SELECT COUNT(*) AS sellers FROM olist_sellers_dataset;

SELECT COUNT(*) AS geolocations FROM olist_geolocation_dataset;

SELECT COUNT(*) AS payments FROM olist_order_payments_dataset;

SELECT COUNT(*) AS reviews FROM olist_order_reviews_dataset;

SELECT COUNT(*) AS category_translation
FROM product_category_name_translation;

--Check for duplicate orders

SELECT order_id, COUNT(*)FROM olist_orders_dataset
 GROUP BY order_id
 HAVING COUNT(*) > 1;

 --Check for missing customer_id

 select count(*) from olist_customers_dataset where customer_id is NULL;