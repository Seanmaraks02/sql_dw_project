USE [DataWarehouse]
GO

SELECT [order_number]
      ,[product_key]
      ,[customer_key]
      ,[order_date]
      ,[shipping_date]
      ,[due_date]
      ,[sales_amount]
      ,[quantity]
      ,[price]
  FROM [gold].[fact_sales]

GO

Select category, sum(sales_amount)total_sales
from gold.fact_sales f
left join gold.dim_products p
on f.product_key = p.product_key
group by category


