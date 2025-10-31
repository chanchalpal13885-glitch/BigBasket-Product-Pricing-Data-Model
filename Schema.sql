-- ==========================================
-- 🏗️ BigBasket Product & Pricing Data Model
-- File: schema.sql
-- Description: Database and Table Creation Script
-- ==========================================

-- Step 1️⃣ — Create Database
CREATE DATABASE Bigbasket;
USE Bigbasket;

-- ==========================================
-- 📂 Step 2️⃣ — Create Tables
-- ==========================================

-- 1️⃣ Category Table
CREATE TABLE Category (
    Category_id VARCHAR(8) PRIMARY KEY, 
    Category_name VARCHAR(50) NOT NULL, 
    Description TEXT NOT NULL,
    Created_at DATE NOT NULL
);

-- 2️⃣ Subcategory Table
CREATE TABLE Subcategory (
    Subcategory_id VARCHAR(8) PRIMARY KEY, 
    Subcategory_name VARCHAR(50) NOT NULL, 
    Category_id VARCHAR(8) NOT NULL,
    Description TEXT NOT NULL,
    FOREIGN KEY (Category_id) REFERENCES Category(Category_id)
);

-- 3️⃣ Brand Table
CREATE TABLE Brand (
    Brand_id VARCHAR(8) PRIMARY KEY,
    Brand_name VARCHAR(50) NOT NULL, 
    Country_of_Origin VARCHAR(50) NOT NULL, 
    Founded_year INT NOT NULL
);

-- 4️⃣ Product Table
CREATE TABLE Product (
    Product_id VARCHAR(8) PRIMARY KEY, 
    Product_name VARCHAR(100) NOT NULL, 
    Category_id VARCHAR(8) NOT NULL, 
    Subcategory_id VARCHAR(8) NOT NULL,
    Brand_id VARCHAR(8) NOT NULL, 
    Description TEXT NOT NULL,
    FOREIGN KEY (Category_id) REFERENCES Category(Category_id),
    FOREIGN KEY (Subcategory_id) REFERENCES Subcategory(Subcategory_id), 
    FOREIGN KEY (Brand_id) REFERENCES Brand(Brand_id)
);

-- 5️⃣ Pricing Table
CREATE TABLE Pricing (
    Pricing_id VARCHAR(8) PRIMARY KEY,
    Product_id VARCHAR(8) NOT NULL, 
    Sale_price DECIMAL(6,2) NOT NULL,
    Market_price INT NOT NULL,  
    Rating DECIMAL(2,1) NOT NULL,
    Last_updated DATE NOT NULL,
    FOREIGN KEY (Product_id) REFERENCES Product(Product_id)
);

-- ==========================================
-- ✅ End of schema.sql
-- ==========================================
