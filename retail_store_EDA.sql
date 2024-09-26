
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