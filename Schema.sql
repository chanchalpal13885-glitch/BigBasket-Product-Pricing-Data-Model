CREATE DATABASE BigBasket;
USE BigBasket;

CREATE TABLE Category (
  Category_id VARCHAR(8) PRIMARY KEY,
  Category_name VARCHAR(50) NOT NULL,
  Description TEXT,
  Created_at DATE NOT NULL
);

CREATE TABLE Subcategory (
  Sub_Category_id VARCHAR(8) PRIMARY KEY,
  Sub_category_name VARCHAR(50) NOT NULL,
  Category_id VARCHAR(8),
  description TEXT,
  FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE Brand (
  Brand_id VARCHAR(8) PRIMARY KEY,
  Brand_name VARCHAR(50) NOT NULL,
  Country_of_Origin VARCHAR(50),
  Founded_year INT
);

CREATE TABLE Product (
  product_id VARCHAR(8) PRIMARY KEY,
  product_name VARCHAR(100),
  category_id VARCHAR(8),
  sub_category_id VARCHAR(8),
  brand_id VARCHAR(8),
  description TEXT,
  FOREIGN KEY (category_id) REFERENCES category(category_id),
  FOREIGN KEY (sub_category_id) REFERENCES subcategory(sub_category_id),
  FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

CREATE TABLE Pricing (
  product_id VARCHAR(8) PRIMARY KEY,
  sale_price DECIMAL(6,2),
  market_price INT,
  rating DECIMAL(2,1),
  last_updated DATE,
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);
