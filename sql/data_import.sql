-- ============================================================
-- Project : Ecommerce Business Analytics
-- File    : 02_data_import.sql
-- Purpose : Import all CSV files into MySQL tables
-- ============================================================

use olist_analytics;
--==============================================================
--Customer dataset

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE olist_customers_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

--Orders dataset

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE olist_orders_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    order_id,
    customer_id,
    order_status,
    @order_purchase_timestamp,
    @order_approved_at,
    @order_delivered_carrier_date,
    @order_delivered_customer_date,
    @order_estimated_delivery_date
)
SET
    order_purchase_timestamp = NULLIF(@order_purchase_timestamp, ''),
    order_approved_at = NULLIF(@order_approved_at, ''),
    order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),
    order_estimated_delivery_date = NULLIF(@order_estimated_delivery_date, '');

--Order Items  dataset

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE olist_order_items_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

--Products dataset

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE olist_products_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    product_id,
    product_category_name,
    @product_name_length,
    @product_description_length,
    @product_photos_qty,
    @product_weight_g,
    @product_length_cm,
    @product_height_cm,
    @product_width_cm
)
SET
    product_name_length = NULLIF(@product_name_length, ''),
    product_description_length = NULLIF(@product_description_length, ''),
    product_photos_qty = NULLIF(@product_photos_qty, ''),
    product_weight_g = NULLIF(@product_weight_g, ''),
    product_length_cm = NULLIF(@product_length_cm, ''),
    product_height_cm = NULLIF(@product_height_cm, ''),
    product_width_cm = NULLIF(@product_width_cm, '');

    -- Sellers Dataset

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv'
INTO TABLE olist_sellers_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

--Geolocation dataset

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_geolocation_dataset.csv'
INTO TABLE olist_geolocation_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
);

--Payments dataset

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv'
INTO TABLE olist_order_payments_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Order Reviews dataset

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE olist_order_reviews_dataset
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    @review_creation_date,
    @review_answer_timestamp
)
SET
    review_creation_date = NULLIF(@review_creation_date, ''),
    review_answer_timestamp = NULLIF(@review_answer_timestamp, '');

    --Product category translation dataset

    LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_category_name_translation.csv'
INTO TABLE product_category_name_translation
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


  
