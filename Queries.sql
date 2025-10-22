-- ==========================================
-- 🛒 BigBasket Product & Pricing Data Model
-- File: queries.sql
-- Description: SQL Analytical Queries, Subqueries, and Joins
-- ==========================================


-- ==========================
-- 🔹SECTION: BASIC SQL QUERIES
-- ==========================

-- 1️⃣ List brands whose names start and end with the same letter, ordered by brand ID.
SELECT brand_id, brand_name
FROM brand
WHERE LOWER(LEFT(brand_name,1)) = LOWER(RIGHT(brand_name,1))
ORDER BY CAST(SUBSTRING(brand_id, 5) AS UNSIGNED) ASC;


-- 2️⃣ Find the average rating of products grouped by price bands (<100, 100–500, >500).
SELECT
  CASE
    WHEN sale_price < 100 THEN '<100'
    WHEN sale_price BETWEEN 100 AND 500 THEN '100–500'
    ELSE '>500'
  END AS price_band,
  AVG(rating) AS avg_rating
FROM pricing
GROUP BY price_band;


-- 3️⃣ List product_id and product_name where the description is longer than 150 characters.
SELECT product_id, product_name, LENGTH(description) AS desc_length
FROM product
WHERE LENGTH(description) > 150
ORDER BY desc_length DESC;


-- 4️⃣ Show all brands where the country_of_origin is either ‘India’ or ‘USA’.
SELECT brand_id, brand_name, country_of_origin
FROM brand
WHERE country_of_origin IN ('India', 'USA')
ORDER BY CAST(SUBSTRING(brand_id, 5) AS UNSIGNED) ASC;


-- 5️⃣ List all products where product_name starts and ends with the letter ‘a’.
SELECT product_id, product_name
FROM product
WHERE product_name LIKE 'a%' AND product_name LIKE '%a'
ORDER BY CAST(SUBSTRING(product_id, 5) AS UNSIGNED) ASC;


-- 6️⃣ Find brands where brand_name starts and ends with the same letter (case-insensitive).
SELECT brand_id, brand_name
FROM brand
WHERE LOWER(LEFT(brand_name,1)) = LOWER(RIGHT(brand_name,1))
ORDER BY CAST(SUBSTRING(brand_id, 5) AS UNSIGNED) ASC;


-- 7️⃣ List all brands where brand_name has more than 8 characters and ends with ‘n’.
SELECT brand_id, brand_name
FROM brand
WHERE LENGTH(brand_name) > 8 AND RIGHT(brand_name,1) = 'n'
ORDER BY CAST(SUBSTRING(brand_id, 5) AS UNSIGNED) ASC;


-- 8️⃣ Find the average sale price of products whose market price is above 500.
SELECT AVG(sale_price) AS avg_high_market
FROM pricing
WHERE market_price > 500;


-- 9️⃣ Find the top 5 most expensive products by sale_price.
SELECT product_id, sale_price
FROM pricing
ORDER BY sale_price DESC
LIMIT 5;


-- 🔟 Find total sale price of products where sale_price is less than market_price.
SELECT SUM(sale_price) AS discounted_sales
FROM pricing
WHERE sale_price < market_price;


-- 1️⃣1️⃣ Show all brands where the brand_name is a palindrome.
SELECT brand_id, brand_name
FROM brand
WHERE LOWER(brand_name) = REVERSE(LOWER(brand_name));


-- ==========================
-- 🔹SECTION: SUBQUERIES
-- ==========================

-- 1️⃣ Find all products with sale_price above the average.
SELECT product_id, sale_price
FROM pricing
WHERE sale_price > (SELECT AVG(sale_price) FROM pricing)
ORDER BY sale_price DESC;


-- 2️⃣ Find products whose sale_price equals the second-highest sale_price.
SELECT product_id, sale_price
FROM pricing
WHERE sale_price = (
  SELECT MAX(sale_price)
  FROM pricing
  WHERE sale_price < (SELECT MAX(sale_price) FROM pricing)
);


-- 3️⃣ Find brands where brand_name length equals the maximum brand_name length.
SELECT brand_id, brand_name
FROM brand
WHERE LENGTH(brand_name) = (SELECT MAX(LENGTH(brand_name)) FROM brand);


-- 4️⃣ Find brand_id and founded_year of the earliest founded brand(s).
SELECT brand_id, founded_year
FROM brand
WHERE founded_year = (SELECT MIN(founded_year) FROM brand)
ORDER BY CAST(SUBSTRING(brand_id, 5) AS UNSIGNED) ASC;


-- 5️⃣ Find products where sale_price is below the minimum market_price or rating below average.
SELECT product_id, sale_price, rating
FROM pricing
WHERE sale_price < (SELECT MIN(market_price) FROM pricing)
   OR rating < (SELECT AVG(rating) FROM pricing)
ORDER BY CAST(SUBSTRING(product_id, 5) AS UNSIGNED) ASC;


-- ==========================
-- 🔹SECTION: JOINS
-- ==========================

-- 1️⃣ List all products with their brand names.
SELECT P.product_id, P.product_name, B.brand_name
FROM product AS P
INNER JOIN brand AS B ON P.brand_id = B.brand_id
ORDER BY CAST(SUBSTRING(P.product_id, 5) AS UNSIGNED) ASC;


-- 2️⃣ List all products with their category names (including uncategorized).
SELECT P.product_id, P.product_name, C.category_name
FROM product AS P
LEFT JOIN category AS C ON P.category_id = C.category_id
ORDER BY CAST(SUBSTRING(P.product_id, 5) AS UNSIGNED) ASC;


-- 3️⃣ Show each category and its product count, sorted by category ID.
SELECT C.category_id, C.category_name, COUNT(P.product_id) AS product_count
FROM product AS P
RIGHT JOIN category AS C ON P.category_id = C.category_id
GROUP BY C.category_id, C.category_name
ORDER BY CAST(SUBSTRING(C.category_id, 5) AS UNSIGNED) ASC;


-- 4️⃣ List all categories and their subcategories where category name starts with ‘B’.
SELECT C.category_id, C.category_name, S.sub_category_id, S.sub_category_name
FROM category AS C
JOIN subcategory AS S ON C.category_id = S.category_id
WHERE C.category_name LIKE 'B%'
ORDER BY CAST(SUBSTRING(C.category_id, 5) AS UNSIGNED) ASC;


-- 5️⃣ For each subcategory, show total and average sale price of its products.
SELECT S.sub_category_id, S.sub_category_name,
       SUM(Pr.sale_price) AS Total_sales,
       AVG(Pr.sale_price) AS Avg_sales
FROM subcategory AS S
JOIN product AS P ON S.sub_category_id = P.sub_category_id
JOIN pricing AS Pr ON P.product_id = Pr.product_id
GROUP BY S.sub_category_id, S.sub_category_name
ORDER BY Total_sales;
