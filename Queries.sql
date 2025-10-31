-- ========================================== 
-- 📊 BigBasket Product & Pricing Data Model
-- File: queries.sql
-- Description: SQL Analytical Queries, Subqueries, and Joins
-- Author: CHANCHAL SATISHCHANDRA PAL
-- ==========================================
USE Bigbasket;

-- ==========================================
-- 🧩 Part 1 — Business Insights & Analytics
-- ==========================================

-- Q1. List all categories with their total number of products.
SELECT 
    C.Category_name, 
    COUNT(P.Product_id) AS total_products
FROM Category AS C
LEFT JOIN Product AS P 
    ON C.Category_id = P.Category_id
GROUP BY C.Category_name
ORDER BY total_products DESC;

-- Q2. Display the top 5 highest-priced products.
SELECT 
    P.Product_name, 
    Pr.Sale_price
FROM Product AS P
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
ORDER BY Pr.Sale_price DESC
LIMIT 5;

-- Q3. Show average sale price per category.
SELECT 
    C.Category_name, 
    ROUND(AVG(Pr.Sale_price), 2) AS avg_price
FROM Category AS C
JOIN Product AS P 
    ON C.Category_id = P.Category_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY C.Category_name;

-- Q4. Find brands founded before the year 2000.
SELECT 
    Brand_name, 
    Founded_year
FROM Brand
WHERE Founded_year < 2000;

-- Q5. List the top 5 products with the highest rating-to-price ratio.
SELECT 
    Pr.Product_id, 
    P.Product_name, 
    Pr.Rating, 
    Pr.Sale_price,
    ROUND((Pr.Rating / Pr.Sale_price), 4) AS rating_price_ratio
FROM Pricing AS Pr
JOIN Product AS P 
    ON Pr.Product_id = P.Product_id
ORDER BY rating_price_ratio DESC
LIMIT 5;

-- Q6. Find the top 5 brands with the highest average product sale price.
SELECT 
    B.Brand_name,
    ROUND(AVG(Pr.Sale_price), 2) AS avg_sale_price
FROM Brand AS B
JOIN Product AS P 
    ON B.Brand_id = P.Brand_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY B.Brand_name
ORDER BY avg_sale_price DESC
LIMIT 5;

-- Q7. Identify the top 3 brands with the highest average discount percentage.
SELECT 
    B.Brand_name, 
    ROUND(AVG((Pr.Market_price - Pr.Sale_price) / Pr.Market_price * 100), 2) AS avg_discount
FROM Brand AS B
JOIN Product AS P
    ON B.Brand_id = P.Brand_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY B.Brand_name
ORDER BY avg_discount DESC
LIMIT 3;

-- Q8. Display subcategories along with the total number of products in each.
SELECT 
    S.Subcategory_name, 
    COUNT(P.Product_id) AS total_products
FROM Subcategory AS S
JOIN Product AS P 
    ON S.Subcategory_id = P.Subcategory_id
GROUP BY S.Subcategory_name
ORDER BY total_products DESC;

-- Q9. Display each brand with total number of products and average sale price.
SELECT 
    B.Brand_name,
    COUNT(P.Product_id) AS total_products,
    ROUND(AVG(Pr.Sale_price), 2) AS avg_price
FROM Brand AS B
JOIN Product AS P 
    ON B.Brand_id = P.Brand_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY B.Brand_name
ORDER BY total_products DESC;

-- Q10. Show total number of brands by country.
SELECT 
    Country_of_Origin, 
    COUNT(*) AS total_brands
FROM Brand
GROUP BY Country_of_Origin;

-- ==========================================
-- 💰 Part 2 — Pricing & Profit Analytics
-- ==========================================

-- Q11. Display each product’s discount percentage and categorize discount level.
SELECT 
    P.Product_name,
    ROUND(((Pr.Market_price - Pr.Sale_price) / Pr.Market_price) * 100, 2) AS discount_percent,
    CASE
        WHEN ((Pr.Market_price - Pr.Sale_price) / Pr.Market_price) * 100 >= 70 THEN 'High Discount'
        WHEN ((Pr.Market_price - Pr.Sale_price) / Pr.Market_price) * 100 >= 35 THEN 'Medium Discount'
        ELSE 'Low Discount'
    END AS discount_level
FROM Product AS P
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
ORDER BY discount_percent DESC;

-- Q12. List the top 5 most profitable products.
SELECT 
    P.Product_name, 
    (Pr.Market_price - Pr.Sale_price) AS profit
FROM Product AS P
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
ORDER BY profit DESC
LIMIT 5;

-- Q13. Display total profit per category.
SELECT 
    C.Category_name, 
    SUM(Pr.Market_price - Pr.Sale_price) AS total_profit
FROM Category AS C
JOIN Product AS P 
    ON C.Category_id = P.Category_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY C.Category_name;

-- Q14. Find top 3 categories with the highest profit margin.
SELECT 
    C.Category_name, 
    ROUND(AVG(Pr.Market_price - Pr.Sale_price), 2) AS avg_margin
FROM Category AS C
JOIN Product AS P 
    ON C.Category_id = P.Category_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY C.Category_name
ORDER BY avg_margin DESC
LIMIT 3;

-- Q15. Find products priced above overall average.
SELECT 
    P.Product_name, 
    Pr.Sale_price
FROM Product AS P
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
WHERE Pr.Sale_price > (SELECT AVG(Sale_price) FROM Pricing);

-- Q16. Rank categories by total profit using a window function.
SELECT 
    C.Category_name, 
    SUM(Pr.Market_price - Pr.Sale_price) AS total_profit,
    RANK() OVER (ORDER BY SUM(Pr.Market_price - Pr.Sale_price) DESC) AS rank_no
FROM Category AS C
JOIN Product AS P 
    ON C.Category_id = P.Category_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY C.Category_name;

-- Q17. Find products whose sale price ≥ category average.
SELECT 
    C.Category_name, 
    P.Product_name, 
    Pr.Sale_price
FROM Product AS P
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
JOIN Category AS C 
    ON P.Category_id = C.Category_id
WHERE Pr.Sale_price >= (
    SELECT AVG(Pr2.Sale_price)
    FROM Pricing AS Pr2
    JOIN Product AS P2 ON Pr2.Product_id = P2.Product_id
    WHERE P2.Category_id = P.Category_id
);

-- Q18. Calculate percentage difference between market and sale price.
SELECT 
    P.Product_name,
    ROUND(((Pr.Market_price - Pr.Sale_price) / Pr.Market_price) * 100, 2) AS discount_percent
FROM Product AS P
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id;

-- Q19. Display average market price by brand and category.
SELECT 
    B.Brand_name, 
    C.Category_name, 
    ROUND(AVG(Pr.Market_price), 2) AS avg_price
FROM Brand AS B
JOIN Product AS P 
    ON B.Brand_id = P.Brand_id
JOIN Category AS C 
    ON P.Category_id = C.Category_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY B.Brand_name, C.Category_name;

-- Q20. Display all product categories along with their total sales, sorted to identify the highest-selling category.
SELECT 
    C.Category_name, 
    SUM(Pr.Sale_price) AS total_sales
FROM Category AS C
JOIN Product AS P 
    ON C.Category_id = P.Category_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY C.Category_name
ORDER BY total_sales DESC;

-- ==========================================
-- ⭐ Part 3 — Rating, Performance & Trend Analysis
-- ==========================================

-- Q21. Show the top 5 highest-rated products.
SELECT 
    P.Product_name, 
    Pr.Rating
FROM Product AS P
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
ORDER BY Pr.Rating DESC
LIMIT 5;

-- Q22. Find average rating per brand.
SELECT 
    B.Brand_name, 
    ROUND(AVG(Pr.Rating), 2) AS avg_rating
FROM Brand AS B
JOIN Product AS P 
    ON B.Brand_id = P.Brand_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY B.Brand_name;

-- Q23. Display all categories whose average rating > 4.
SELECT 
    C.Category_name, 
    ROUND(AVG(Pr.Rating), 2) AS avg_rating
FROM Category AS C
JOIN Product AS P 
    ON C.Category_id = P.Category_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY C.Category_name
HAVING AVG(Pr.Rating) > 4;

-- Q24. Categorize each product based on its rating.
SELECT 
    P.Product_name,
    CASE 
        WHEN Pr.Rating >= 4.5 THEN 'Excellent'
        WHEN Pr.Rating >= 3 THEN 'Good'
        ELSE 'Average'
    END AS rating_status
FROM Product AS P
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id;

-- Q25. Find total sale value and average rating per brand.
SELECT 
    B.Brand_name,
    ROUND(SUM(Pr.Sale_price), 2) AS total_sales,
    ROUND(AVG(Pr.Rating), 2) AS avg_rating
FROM Brand AS B
JOIN Product AS P 
    ON B.Brand_id = P.Brand_id
JOIN Pricing AS Pr 
    ON P.Product_id = Pr.Product_id
GROUP BY B.Brand_name;

-- ==========================================
-- 🧠 Part 4 — String, Date & Advanced SQL Functions
-- ==========================================

-- Q26. Display all products whose names contain 'Pack' or 'Bottle'.
SELECT 
    Product_name
FROM Product
WHERE Product_name LIKE '%Pack%' 
   OR Product_name LIKE '%Bottle%';

-- Q27. Classify each brand as ‘Old’ or ‘Modern’ depending on its founded year.
SELECT 
    Brand_name,
    CASE 
        WHEN Founded_year < 1990 THEN 'Old'
        ELSE 'Modern'
    END AS brand_type
FROM Brand;

-- Q28. Identify top 5 months (with year) having the highest number of price updates.
SELECT 
    YEAR(Last_updated) AS update_year,
    MONTHNAME(Last_updated) AS update_month,
    COUNT(*) AS total_updates
FROM Pricing
GROUP BY YEAR(Last_updated), MONTHNAME(Last_updated)
ORDER BY total_updates DESC
LIMIT 5;

-- Q29. Calculate total new categories per month and rank the months.
SELECT 
    MONTHNAME(Created_at) AS month_name,
    COUNT(Category_id) AS total_categories,
    RANK() OVER (ORDER BY COUNT(Category_id) DESC) AS month_rank
FROM Category
GROUP BY YEAR(Created_at), MONTHNAME(Created_at);

-- Q30. Categorize brands by country and create a formatted brand label.
SELECT 
    Brand_name,
    Country_of_Origin,
    CONCAT(
        Brand_name, ' - ',
        CASE 
            WHEN Country_of_Origin = 'India' THEN 'Domestic Brand'
            ELSE 'Global Brand'
        END
    ) AS Brand_Label
FROM Brand;

-- ==========================================
-- ✅ END OF FILE
-- ==========================================
