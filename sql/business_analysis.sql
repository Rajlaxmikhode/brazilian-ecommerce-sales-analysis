---============================================================
--project:Ecommerce Business Analytics
--file: 04_business_analytics
--purpose: Business KPI Analysis
--=============================================================

use olist_analytics;

-- ============================================================
-- KPI 1: Total Revenue
-- Business QuestiON:
-- How much total revenue has the business generated from customer payments?
-- ============================================================

select round(SUM(payment_value),2)
as total_revenue 
from olist_order_payments_dataset;
-- ============================================================
-- KPI 2: Total orders
-- Business QuestiON:
-- How many orders has the business received?
-- ============================================================

select count(order_id)
    as total_orders 
from olist_orders_dataset;

-- ============================================================
-- KPI 3: Total Customers
-- Business QuestiON:
-- How many unique customers have placed orders?
-- ============================================================

select COUNT(distinct customer_unique_id) as total_customers
from olist_customers_dataset;

-- ============================================================
-- KPI 4: Average order Value
-- Business QuestiON:
-- What is the average amount spent per order?
-- ============================================================

select
    round(avg(payment_value), 2) 
        as average_order_value
from olist_order_payments_dataset;

-- ============================================================
-- KPI 5: Average Delivery Time
-- Business QuestiON:
-- What is the average number of days taken to deliver an order?
-- ============================================================

select
    round(
        avg(
            datediff(
                order_delivered_customer_date,
                order_purchase_timestamp
            )
        ),
        2
    ) as avg_delivery_days
from olist_orders_dataset
where order_delivered_customer_date IS not null;



--===============================================================
--Product Analysis
--==============================================================

-- Clean trailing carriage return characters from translated category names
update product_category_name_translation
set product_category_name_english =
    trim(TRAILING '\r' from product_category_name_english);

-- Top 10 Product Categories
select
    pct.product_category_name_english as category,
    COUNT(*) as total_orders
from olist_order_items_dataset oi
join olist_products_dataset p
    ON oi.product_id = p.product_id
join product_category_name_translation pct
    ON p.product_category_name = pct.product_category_name
group by category
order by total_orders DESC
limit 10;

--Top 10 sellers
select 
    seller_id, count(*) 
    as items_sold
from olist_order_items_dataset
group by seller_id
order by items_sold desc
    limit 10;

--Monthly order  trend

select year(order_purchase_timestamp) as year, month(order_purchase_timestamp) 
    as month ,count(*) as total_orders 
from olist_orders_dataset 
group by 
    year(order_purchase_timestamp),month(order_purchase_timestamp) 
order by 
    year, month;

--Product Category Analysis

select pct.product_category_name_english 
    as category, round(sum(oi.price),2) as revenue 
from olist_order_items_dataset oi 
join olist_products_dataset p 
    on p.product_id=oi.product_id 
join product_category_name_translation pct 
    on p.product_category_name=pct.product_category_name
group by category 
order by revenue desc limit 10;

--===============================================================
--Customer Analysis
--==============================================================
--Top 10 states 

select c.customer_state, count(*) 
from olist_orders_dataset o 
join olist_customers_dataset c 
    ON c.customer_id=o.customer_id group by c.customer_state
order by c.customer_state
    limit 10;

--Top 10 Customers by Spending

select c.customer_unique_id, round(sum(p.payment_value),2) 
    as total_spent
from olist_customers_dataset c 
join olist_orders_dataset o
    on o.customer_id=c.customer_id 
join olist_order_payments_dataset p 
    on p.order_id=o.order_id 
group by customer_unique_id 
order by total_spent desc limit 10;

--===============================================================
--Sales Analysis
--==============================================================

--monthly Revenue Trend

select
    year(o.order_purchase_timestamp) as year,
    month(o.order_purchase_timestamp) as month,
    round(SUM(p.payment_value),2) as revenue
from olist_orders_dataset o
join olist_order_payments_dataset p
    ON o.order_id = p.order_id
group by
    year(o.order_purchase_timestamp),
    month(o.order_purchase_timestamp)
order by
    year(o.order_purchase_timestamp),
    month(o.order_purchase_timestamp);

--Seller Revenue
select
    seller_id,
    ROUND(SUM(price),2) as revenue
from olist_order_items_dataset
group by seller_id
order by revenue desc
limit 10;

--order status DistributiON

select order_status, count(*)
    as total_orders
from olist_orders_dataset
group by order_status
order by total_orders desc;

-- ============================================================
--Payment Analysis
-- ============================================================

select
    payment_type,
    count(*) as total_payments
from olist_order_payments_dataset
group by payment_type
order by total_payments desc;

--Revenue by state

select
    c.customer_state,
    round(SUM(p.payment_value),2) as revenue
from olist_orders_dataset o
join olist_customers_dataset c
    ON c.customer_id = o.customer_id
join olist_order_payments_dataset p
    ON o.order_id = p.order_id
group by c.customer_state
order by revenue DESC limit 10;

-- ============================================================
--Review score Analysis
-- ============================================================

--Average Review

select
    round(avg(review_score),2) as average_review
from olist_order_reviews_dataset;

--Average Review Score by Product Category

select pct.product_category_name_english 
    as category, round(sum(oi.price),2) as revenue
from olist_order_items_dataset oi 
join olist_products_dataset p 
    on p.product_id=oi.product_id 
join product_category_name_translation pct 
    on p.product_category_name=pct.product_category_name 
group by category 
order by revenue desc limit 10;


