CREATE DATABASE RetailSales;

-- --------------------------------------------------------------------------------
-- ----------------------------TABLE CREATION -------------------------------------

CREATE TABLE order_details (
    order_id INT NOT NULL,
    order_date VARCHAR(10) NOT NULL,
    property_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id)
);
-- ----------------------------------------------------------------------------------
-- change order_date column format from VARCHAR to DATE
UPDATE order_details 
SET 
    order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

ALTER TABLE order_details MODIFY COLUMN order_date DATE NOT NULL;

-- --------------------------------------------------------------------------------

CREATE TABLE products (
    product_id INT NOT NULL,
    product_name TEXT NOT NULL,
    product_category TEXT NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    PRIMARY KEY (product_id)
);

-- --------------------------------------------------------------------------------

CREATE TABLE property_info (
    prop_id INT NOT NULL,
    prop_city TEXT NOT NULL,
    prop_state TEXT NOT NULL,
    PRIMARY KEY (prop_id)
);

-- ------------------------------------------------------------------------
-- ---------------------- FEATURE ENGINEERING -----------------------------

ALTER TABLE property_info CHANGE prop_id property_id INT;

-- save year in new separate column in order_details
ALTER TABLE order_details ADD COLUMN year VARCHAR(10);

UPDATE order_details 
SET 
    year = LEFT(order_date, 4);

-- save month (first 3 letters) in new separate column in order_details
ALTER TABLE order_details ADD COLUMN month VARCHAR(10);

UPDATE order_details 
SET 
    month = LEFT(MONTHNAME(order_date), 3);

-- save date in new separate column in order_details
ALTER TABLE order_details ADD COLUMN date VARCHAR(10);

UPDATE order_details 
SET 
    date = RIGHT(order_date, 2);

-- save day in new separate column in order_details
ALTER TABLE order_details ADD COLUMN day VARCHAR(10);

UPDATE order_details 
SET 
    day = LEFT(DAYNAME(order_date), 3);

-- save revenue of the products sold in order_details

ALTER TABLE order_details ADD COLUMN revenue DECIMAL (10, 2) NOT NULL;

UPDATE order_details
        JOIN
    products ON order_details.product_id = products.product_id 
SET 
    revenue = order_details.quantity * products.price;

ALTER TABLE order_details MODIFY COLUMN revenue DECIMAL (10, 2) AFTER quantity;

-- --------------------------------------------------------------------------------
-- ------------------- Exploratory Data Analysis (EDA) ----------------------------

SELECT 
    CONCAT(year, '-', month) AS per_month,
    SUM(revenue) AS monthly_revenue
FROM
    order_details
GROUP BY per_month;

-- ------ QUARTERLY --------
SELECT 
    CONCAT(year, '-Q', QUARTER(order_date)) AS quarter,
    SUM(revenue) AS quarterly_revenue
FROM
    order_details
GROUP BY quarter;

-- ------ YEARLY --------
SELECT 
    year, SUM(revenue)
FROM
    order_details
GROUP BY year;

-- Seasonal variations in sales 
SELECT 
    year,
    (CASE
        WHEN month IN ('Dec' , 'Jan', 'Feb') THEN 'Winter'
        WHEN month IN ('Mar' , 'Apr', 'May') THEN 'Spring'
        WHEN month IN ('Jun' , 'Jul', 'Aug') THEN 'Summer'
        WHEN month IN ('Sep' , 'Oct', 'Nov') THEN 'Fall'
    END) AS season,
    SUM(revenue) AS monthly_revenue
FROM
    order_details
GROUP BY year , season;

-- Which seasons have the highest sales volumes?
SELECT 
    CONCAT(year, '-Q', QUARTER(order_date)) AS quarter,
    SUM(revenue) AS quarterly_revenue
FROM
    order_details
GROUP BY quarter
ORDER BY quarterly_revenue DESC
LIMIT 4;

-- quarterly sales trends for different product categories
SELECT 
    product_category,
    CONCAT(year, '-Q', QUARTER(order_date)) AS quarter,
    SUM(revenue) AS quarterly_revenue
FROM
    products
        JOIN
    order_details ON products.product_id = order_details.product_id
GROUP BY product_category , quarter;

-- yearly sales trends for different product categories
SELECT 
    product_category, year, SUM(revenue) AS yearly_revenue
FROM
    products
        JOIN
    order_details ON products.product_id = order_details.product_id
GROUP BY product_category , year;

-- monthly sales trends for different product categories
SELECT 
    product_category,
    LEFT(order_date, 7) AS per_month,
    SUM(revenue) AS monthly_revenue
FROM
    products
        JOIN
    order_details ON products.product_id = order_details.product_id
GROUP BY product_category , per_month;

-- Identifying the most popular products
SELECT 
    product_name,
    product_category,
    SUM(quantity) AS total_sold
FROM
    products
        JOIN
    order_details ON products.product_id = order_details.product_id
GROUP BY product_name , product_category
ORDER BY total_sold DESC
LIMIT 3;

-- Regional sales distribution
SELECT 
    prop_city, prop_state, SUM(revenue) AS total_revenue
FROM
    property_info
        JOIN
    order_details ON property_info.property_id = order_details.property_id
GROUP BY prop_city , prop_state
ORDER BY total_revenue DESC;

-- Comparing sales performance in different regions
SELECT 
    prop_city,
    prop_state,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(revenue), 2) AS avg_revenue_per_order
FROM
    property_info
        JOIN
    order_details ON property_info.property_id = order_details.property_id
GROUP BY prop_city , prop_state
ORDER BY total_revenue DESC;

-- Analyzing the quantity distribution for products
SELECT 
    product_name,
    product_category,
    SUM(quantity) AS total_quantity
FROM
    products
        JOIN
    order_details ON products.product_id = order_details.product_id
GROUP BY product_name , product_category;

-- Price sensitivity analysis
SELECT 
    product_name, 
    price,
    COUNT(order_id) AS total_orders,
    SUM(quantity) AS total_sold,
    SUM(revenue) AS total_revenue
FROM
    products
        JOIN
    order_details ON products.product_id = order_details.product_id
GROUP BY product_name, price
ORDER BY total_sold DESC;


