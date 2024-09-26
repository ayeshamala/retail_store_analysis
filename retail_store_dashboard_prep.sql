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