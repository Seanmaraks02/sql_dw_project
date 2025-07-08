--CUSTOMER INFO
--checking for duplicates or nulls
SELECT cst_id, COUNT (*) AS id_count
FROM bronze.crm_cust_info
GROUP BY cst_id 
HAVING COUNT (*) > 1 or cst_id IS NULL;

--check for unwanted spaces
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname) ;

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname !=TRIM(cst_lastname);


--PRODUCT INFO
--checking for duplicates or nulls
SELECT prd_id, COUNT (*) AS id_count
FROM bronze.crm_prd_info
GROUP BY prd_id 
HAVING COUNT (*) > 1 or prd_id IS NULL;

--check for unwanted spaces
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm) ;

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--Standardtization
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

--SALES DETAILS
SELECT DISTINCT 

CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
	 THEN sls_quantity * ABS(sls_price)
	 ELSE sls_sales
END AS sls_sales,

sls_quantity,

CASE WHEN sls_price IS NULL OR sls_price <=0
	 THEN sls_sales / NULLIF(sls_quantity, 0)
	 ELSE sls_price
END AS sls_price
FROM bronze.crm_sales_details

--checking for invalid dates
SELECT sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <=0 
	  OR len(sls_order_dt)!= 8

SELECT sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <=0 
	  OR len(sls_ship_dt)!= 8

--check for sales,quatities and price consistencies
SELECT DISTINCT sls_sales ,	
sls_quantity ,	
sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity*sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales<=0 OR sls_quantity<=0 OR sls_price<=0
ORDER BY sls_sales,sls_quantity,sls_price;


--check for out of range dates on CUST_AZ12
SELECT DISTINCT bdate
FROM silver.erp_cust_az12
WHERE bdate > GETDATE();

--check for standardiztion and consistency on CUST_AZ12
SELECT DISTINCT gen
FROM silver.erp_cust_az12

--check conuntry data consistency onLOC_A101
SELECT DISTINCT cntry
FROM bronze.erp_loc_a101
ORDER BY cntry

--check for consistencty on PX_CAT_G1V2
SELECT DISTINCT cat
FROM bronze.erp_px_cat_g1v2;

SELECT DISTINCT subcat
FROM bronze.erp_px_cat_g1v2;
