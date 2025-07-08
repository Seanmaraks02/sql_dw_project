# SQL Data Warehouse ETL Pipeline

# Overview
This project implements a three-layer ETL (Extract, Transform, Load) pipeline for a data warehouse using SQL Server. The pipeline processes CRM and ERP data through Bronze (raw data), Silver (cleaned and transformed data), and Gold (business-ready views) layers. The project demonstrates data ingestion, cleaning, normalization, and integration for analytics.

# Pipeline Structure
- Bronze Layer: Ingests raw CSV data into SQL tables using `BULK INSERT`.
- Silver Layer: Cleans and transforms data, normalizing values and handling inconsistencies.
- Gold Layer: Creates views for business reporting, integrating data from multiple sources.

# Prerequisites
- SQL Server: SQL Server 2016 or later.
- SQL Server Management Studio (SSMS) or another SQL client.
- Sample Data: CSV files for CRM and ERP data (e.g., `cust_info.csv`, `prd_info.csv`, etc.).
- Permissions: Write access to a SQL Server database with `bronze`, `silver`, and `gold` schemas.

# Setup
Place CSV files in a directory accessible to the SQL Server (e.g., `C:\datasets`). Update file paths in `scripts/bronze/bronze_layer.sql` to match your environment.

Create Tables:
- Execute `scripts/bronze/bronze_tables.sql` to create Bronze layer tables.
- Execute `scripts/silver/silver_tables.sql` to create Silver layer tables.

Clone the Repository:
```bash
git clone https://github.com/your-username/sql-data-warehouse-pipeline.git
cd sql-data-warehouse-pipeline

Prepare the Database:
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;

Usage
Load Bronze Layer:Run the stored procedure to load raw data from CSVs:
EXEC bronze.load_bronze;

This truncates and populates Bronze tables (crm_cust_info, crm_prd_info, crm_sales_details, erp_cust_az12, erp_loc_a101, erp_px_cat_g1v2).
Load Silver Layer:Run the stored procedure to transform and load data into Silver tables:
EXEC silver.load_silver;

This cleans and normalizes data from Bronze tables.
Create Gold Layer Views:Execute scripts/gold/gold_layer.sql to create views (dim_customers, dim_products, fact_sales). Optionally, run scripts/gold/gold_layer_extraction.sql to extract views into tables (customers, products, sales).
Query Gold Layer:Query the views for business insights:
SELECT * FROM gold.dim_customers;
SELECT * FROM gold.dim_products;
SELECT * FROM gold.fact_sales;

Project Structure
sql-data-warehouse-pipeline/
├── datasets/
│   ├── source_crm/
│   │   ├── cust_info.csv
│   │   ├── prd_info.csv
│   │   ├── sales_details.csv
│   ├── source_erp/
│   │   ├── CUST_AZ12.csv
│   │   ├── LOC_A101.csv
│   │   ├── PX_CAT_G1V2.csv
├── scripts/
│   ├── bronze/
│   │   ├── bronze_layer.sql # Stored procedure for Bronze layer loading
│   │   └── bronze_tables.sql # Table definitions for Bronze layer
│   ├── silver/
│   │   ├── silver_layer.sql # Stored procedure for Silver layer transformation
│   │   └── silver_tables.sql # Table definitions for Silver layer
│   └── gold/
│       ├── gold_layer.sql # View definitions for Gold layer
│       └── gold_layer_extraction.sql # Scripts to extract Gold views to tables
├── README.md # Project documentation
├── .gitignore # Git ignore file
└── LICENSE # License file (e.g., MIT)

Notes

File Paths: Update hardcoded file paths in scripts/bronze/bronze_layer.sql to match your environment.
Data Quality: The pipeline assumes well-formed CSV files. Validate data before loading.
Performance: Truncating and reloading tables may not be suitable for large datasets. Consider incremental loading for production.
Error Handling: Both Bronze and Silver procedures include TRY-CATCH blocks for error logging.
Typo Fix: The table silver.erp_px_cat_g1v in silver_tables.sql should be silver.erp_px_cat_g1v2.

Future Improvements

Implement incremental loading to improve performance.
Add data validation before BULK INSERT.
Use configuration tables for file paths to enhance portability.
Create a pipeline diagram to visualize the ETL flow.

License
This project is licensed under the MIT License. See the LICENSE file for details.```
