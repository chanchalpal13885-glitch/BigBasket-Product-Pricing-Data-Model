# 🛒 BigBasket Product & Pricing Data Model (SQL Project)

## 💡 Project Overview  
The **BigBasket Product & Pricing Data Model** is a SQL-based data analytics project designed to analyze and manage e-commerce product, brand, and pricing data.  
Built using **MySQL**, this project demonstrates the complete process of **database design, data cleaning, data insertion, and business analytics** — transforming raw Kaggle data into actionable insights.  

It focuses on uncovering **product performance**, **pricing patterns**, and **brand profitability**, showcasing practical SQL and database management skills relevant to real-world retail analytics.

---

## 🎯 Project Objectives  
- Design a **relational database** for managing BigBasket product and pricing data.  
- Implement **data normalization (3NF)** to maintain consistency and eliminate redundancy.  
- Apply **analytical SQL queries** to generate meaningful business insights.  
- Utilize **DDL, DML, Joins, and Aggregations** for structured analysis.  
- Enable **data-driven decision-making** through SQL analytics.  

---

## 📊 Dataset Overview  
The dataset was sourced from **Kaggle’s BigBasket dataset (Excel format)** and preprocessed using **Microsoft Excel** before importing into MySQL.  
It contains detailed information about product categories, subcategories, brands, and pricing.  

| Table | Description | Sample Fields |
|--------|-------------|----------------|
| **Category** | Stores all product categories. | Category_ID, Category_Name, Description |
| **Subcategory** | Stores subcategories linked to categories. | Subcategory_ID, Subcategory_Name, Category_ID |
| **Brand** | Contains brand information and origin details. | Brand_ID, Brand_Name, Country_Of_Origin, Founded_Year |
| **Product** | Product details mapped to brand and category. | Product_ID, Product_Name, Category_ID, Brand_ID |
| **Pricing** | Includes price, discount, and rating data. | Pricing_ID, Product_ID, Market_Price, Sale_Price, Rating |

📈 **Normalization Level:** 3NF  
📂 **Total Tables:** 5  
🧮 **Data Source:** Kaggle (Excel Format)

---

## 🧱 Database Design  
The schema is based on a **relational database model** with clearly defined relationships between tables.  
Each table is connected using **Primary Keys** and **Foreign Keys** to ensure data integrity.  

📘 Each **Product** belongs to a specific Category, Subcategory, and Brand.  
📘 Each **Pricing** record corresponds to a single Product (via `Product_ID`).  

📊 **ER Diagram:** [Click Here to View](https://github.com/chanchalpal13885-glitch/BigBasket-Product-Pricing-Data-Model/blob/main/ER_Diagram.png)

---

## ⚙️ Tools & Technologies  
| Tool / Technology | Purpose |
|--------------------|----------|
| **MySQL Workbench** | Database design, query execution, and data analysis |
| **Microsoft Excel** | Data cleaning, formatting, and preprocessing |

---

## 🧠 SQL Concepts & Techniques Used  
- **DDL Commands:** `CREATE`, `DROP`  
- **DML Commands:** `INSERT`  
- **Joins:** `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`  
- **Aggregations:** `SUM()`, `AVG()`, `COUNT()`, `ROUND()`  
- **Window Functions:** `RANK()`, `ROW_NUMBER()`  
- **Conditional Logic:** `CASE WHEN`  
- **String Functions:** `CONCAT()`, `SUBSTRING()`  
- **Date Functions:** `YEAR()`, `MONTHNAME()`  

---

## 🔄 Project Workflow  
### Step 1️⃣ — Database & Table Creation  
Run **`schema.sql`** to create all tables and relationships.  

### Step 2️⃣ — Data Insertion  
Run **`insert_data.sql`** to insert sample records into tables.  

### Step 3️⃣ — Query Execution  
Run **`queries.sql`** to perform advanced analytics such as brand analysis, pricing comparison, and category trends.  

### Step 4️⃣ — Visualization & Reporting  
Use **Excel** or **BI tools (Power BI/Tableau)** to visualize query results and generate insights.  

---

## 📁 Project Structure  
📦 BigBasket-Product-Pricing-Data-Model/
┣ 📜 README.md
┣ 🧩 schema.sql
┣ 🧩 insert_data.sql
┣ 🧩 queries.sql
┣ 📊 ER_Diagram.png
┗ 📄 BigBasket SQL Project.pdf


---

## 🚀 How to Run the Project  
1. Open **MySQL Workbench**.  
2. Create a new database.  
3. Run `schema.sql` → creates all tables.  
4. Run `insert_data.sql` → loads data into tables.  
5. Run `queries.sql` → executes 30+ analytical SQL queries.  
6. *(Optional)* Use **Excel** or **BI tools** for visualization.  

---

## 🏆 Key Highlights  
- Fully normalized **3NF relational database**.  
- Over **30 SQL queries** focused on real-world e-commerce analytics.  
- Clear relationships between Category, Brand, Product, and Pricing.  
- Efficient schema design for scalability and performance.  
- Excel used for initial data preprocessing.  

---

## 🔮 Future Enhancements  
- Create interactive dashboards in **Power BI** or **Tableau**.  
- Automate data imports and transformations using **Python**.  
- Integrate **real-time product API feeds** for live updates.  
- Extend the model with **customer and order data**.  
- Add **stored procedures, triggers, and views** for automation.  

---

## 👩‍💻 Author  
**Name:** *Chanchal Pal*  
🎓 *Advanced Excel & SQL Certified | Data Analyst | BI Enthusiast*  

📂 **GitHub:** [https://github.com/chanchalpal13885-glitch](https://github.com/chanchalpal13885-glitch)  
🌐 **LinkedIn:** [https://www.linkedin.com/in/chanchalpal](https://www.linkedin.com/in/chanchalpal)  
✉️ **Email:** [chanchalpal13885@gmail.com](mailto:chanchalpal13885@gmail.com)

---

## 🏁 Conclusion  
This project demonstrates an **end-to-end SQL analytics workflow** — from database design and data cleaning to analytical querying and reporting.  
It showcases expertise in **data modeling, problem-solving, and business analytics** through SQL.  

⭐ *If you found this project helpful, please give it a star on GitHub!*
