-- =====================================================
-- SALES DATA ANALYSIS PROJECT
-- =====================================================

-- =====================================================
-- 1. CREATE DATABASE
-- =====================================================

CREATE DATABASE sales_analysis;

USE sales_analysis;


-- =====================================================
-- 2. CREATE PRODUCTS TABLE
-- =====================================================

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);


-- =====================================================
-- 3. CREATE CUSTOMERS TABLE
-- =====================================================

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);


-- =====================================================
-- 4. CREATE SALES TABLE
-- =====================================================

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    customer_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    unit_price DECIMAL(10,2),
    salesperson VARCHAR(50),
    region VARCHAR(50),
    payment_mode VARCHAR(30),
    total_sales DECIMAL(12,2)
);


-- =====================================================
-- 5. ENABLE LOCAL DATA IMPORT
-- =====================================================

# SET GLOBAL local_infile = 1;

### SHOW GLOBAL VARIABLES LIKE 'local_infile';


-- =====================================================
-- 6. IMPORT SALES CSV FILE
-- =====================================================

LOAD DATA LOCAL INFILE 'C:/Users/Akash/Desktop/project/Sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    sale_id,
    sale_date,
    customer_id,
    product_id,
    quantity,
    unit_price,
    salesperson,
    region,
    payment_mode,
    total_sales
);


-- =====================================================
-- 7. CHECK TABLE DATA
-- =====================================================

SELECT * FROM products;

SELECT * FROM customers;

SELECT * FROM sales;


-- =====================================================
-- 8. CHECK NUMBER OF RECORDS
-- =====================================================

SELECT COUNT(*) AS Total_Products
FROM products;

SELECT COUNT(*) AS Total_Customers
FROM customers;

SELECT COUNT(*) AS Total_Sales
FROM sales;


-- =====================================================
-- 9. VIEW SAMPLE SALES DATA
-- =====================================================

SELECT *
FROM sales
LIMIT 10;


-- =====================================================
-- 10. SALES + CUSTOMER + PRODUCT DETAILS
-- =====================================================

SELECT
    s.sale_id,
    s.sale_date,
    c.customer_name,
    c.city,
    p.product_name,
    p.category,
    s.quantity,
    s.unit_price,
    s.salesperson,
    s.region,
    s.payment_mode,
    s.total_sales
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
JOIN products p
    ON s.product_id = p.product_id;


-- =====================================================
-- 11. TOTAL SALES
-- =====================================================

SELECT
    SUM(total_sales) AS Total_Sales
FROM sales;


-- =====================================================
-- 12. TOTAL QUANTITY SOLD
-- =====================================================

SELECT
    SUM(quantity) AS Total_Quantity
FROM sales;


-- =====================================================
-- 13. TOTAL ORDERS
-- =====================================================

SELECT
    COUNT(*) AS Total_Orders
FROM sales;


-- =====================================================
-- 14. AVERAGE SALE
-- =====================================================

SELECT
    AVG(total_sales) AS Average_Sale
FROM sales;


-- =====================================================
-- 15. CATEGORY-WISE SALES
-- =====================================================

SELECT
    p.category,
    SUM(s.total_sales) AS Total_Sales
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY Total_Sales DESC;


-- =====================================================
-- 16. CATEGORY-WISE SALES AND QUANTITY
-- =====================================================

SELECT
    p.category,
    SUM(s.total_sales) AS Total_Sales,
    SUM(s.quantity) AS Total_Quantity
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY Total_Sales DESC;


-- =====================================================
-- 17. PRODUCT-WISE SALES
-- =====================================================

SELECT
    p.product_name,
    SUM(s.quantity) AS Quantity_Sold,
    SUM(s.total_sales) AS Total_Sales
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Sales DESC
LIMIT 10;


-- =====================================================
-- 18. CITY-WISE SALES
-- =====================================================

SELECT
    c.city,
    SUM(s.total_sales) AS Total_Sales
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
GROUP BY c.city
ORDER BY Total_Sales DESC;


-- =====================================================
-- 19. SALESPERSON-WISE SALES
-- =====================================================

SELECT
    salesperson,
    SUM(total_sales) AS Total_Sales
FROM sales
GROUP BY salesperson
ORDER BY Total_Sales DESC;


-- =====================================================
-- 20. HIGH VALUE SALES
-- =====================================================

SELECT
    s.sale_id,
    s.sale_date,
    c.customer_name,
    p.product_name,
    p.category,
    s.total_sales
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
JOIN products p
    ON s.product_id = p.product_id
WHERE s.total_sales > 5000
ORDER BY s.total_sales DESC;


-- =====================================================
-- 21. FINAL SALES KPI REPORT
-- =====================================================

SELECT
    COUNT(*) AS Total_Orders,
    SUM(quantity) AS Total_Quantity,
    SUM(total_sales) AS Total_Sales,
    AVG(total_sales) AS Average_Sale
FROM sales;