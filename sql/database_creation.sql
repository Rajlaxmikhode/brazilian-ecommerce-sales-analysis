--=================================================================================
 -- Project name: Ecommerce Business Analytics
 --File: 01 database_creation.sql
 -- Purpose create all database tables
--==================================================================================

create database olist_analytics;
use olist_analytics;

--- Customer Table

CREATE TABLE olist_customers_dataset (
    customer_id varchar(50) primary key,
    customer_unique_id varchar(50),
    customer_zip_code_prefix int,
    customer_city varchar(50),
    customer_state varchar(2)
);

---Seller Table

CREATE TABLE olist_sellers_dataset (
    seller_id varchar(50) primary key,
    seller_zip_code_prefix int,
    seller_city varchar(60),
    seller_state varchar(10)
);

---Products Table

CREATE TABLE olist_products_dataset(
    product_id varchar(50) primary key,
    product_category_name varchar(50),
    product_name_length int,
    product_description_length int,
    product_photos_qty int,
    product_weight_g int,
    product_length_cm int,
    product_height_cm int,
    product_width_cm int
);

---orders Table

CREATE TABLE olist_orders_dataset (
    order_id varchar(50) primary key,
    customer_id varchar(50) , foreign key(customer_id) references olist_customers_dataset(customer_id),
    order_status varchar(40),
    order_purchase_timestamp timestamp,
    order_approved_at timestamp,
    order_delivered_carrier_date timestamp,
    order_delivered_customer_date timestamp,
    order_estimated_delivery_date timestamp
);

---Order items Table

CREATE TABLE olist_order_items_dataset (
    order_id varchar(50), 
    order_item_id int,
    product_id varchar(50),foreign key(product_id) references olist_products_dataset(product_id), 
    seller_id varchar(50),foreign key(seller_id) references olist_sellers_dataset(seller_id),
    shipping_limit_date timestamp,
    price decimal(10,2),
    freight_value decimal(10,2),
    primary key(order_id, order_item_id),
    foreign key (order_id) references olist_orders_dataset(order_id)
);

---Payments Table

CREATE TABLE olist_order_payments_dataset (
    order_id varchar(50),foreign key(order_id) references olist_orders_dataset(order_id),
    payment_sequential int,
    payment_type varchar(30),
    payment_installments int,
    payment_value decimal(10,2),

    foreign key (order_id)
    references olist_orders_dataset(order_id)
);

--- Reviews Table

CREATE TABLE olist_order_reviews_dataset (
    review_id varchar(50) primary key,
    order_id varchar(50),
    review_score int,
    review_comment_title varchar(50) null,
    review_comment_message text null,
    review_creation_date timestamp null,
    review_answer_timestamp timestamp null,

    CONSTRAint fk_order
        foreign key (order_id)
        references olist_orders_dataset(order_id)
);

--- Geolocation Table

CREATE TABLE olist_geolocation_dataset (
    geolocation_zip_code_prefix int,
    geolocation_lat decimal(10,7),
    geolocation_lng decimal(10,7),
    geolocation_city varchar(50),
    geolocation_state varchar(20)
);

--Translation Table

CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);