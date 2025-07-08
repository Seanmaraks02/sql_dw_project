SELECT  *
INTO    customers
FROM    gold.dim_customers
ORDER BY customer_key;

GO

SELECT  *
INTO    products
FROM    gold.dim_products
ORDER BY product_key
GO 


SELECT  *
INTO    sales
FROM    gold.fact_sales
ORDER BY product_key, customer_key





