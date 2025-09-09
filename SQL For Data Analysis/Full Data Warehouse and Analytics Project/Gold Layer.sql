IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO
CREATE VIEW gold.dim_customers AS

	SELECT DISTINCT
		ci.cst_id as customer_id,
		ci.cst_key as customer_number,
		ci.cst_firstname as first_name,
		ci.cst_lastname as last_name,
		ci.cst_marital_status as marital_status,
		CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr  --PRIORITY TO CHOICE THE GENDER FROM CRM(ITS THE MASTER)
			 ELSE COALESCE(ca.GEN,'n/a')
		END AS gender,
		ci.cst_create_date as create_date,
		ca.BDATE as birth_date,
		la.CNTRY as country
	
		FROM silver.crm_cust_info AS ci
		LEFT JOIN silver.erp_CUST_AZ12 AS ca
		ON ci.cst_key = ca.CID
		LEFT JOIN silver.erp_LOC_A101 AS la
		ON ci.cst_key=la.CID


IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS

	SELECT  DISTINCT
		pin.prd_id as product_id,
		pin.cat_id as category_id,
		pin.prd_key as product_key,
		pin.prd_nm as product_number,
		pin.prd_cost as product_cost,
		pin.prd_line as product_line,
		pin.prd_start_dt as product_start_date,
		pc.CAT as category,
		pc.SUBCAT as sub_category,
		pc.MAINTENANCE as maintenance

		FROM silver.crm_prd_info as pin
		LEFT JOIN silver.erp_PX_CAT_G1V2 as pc
		ON pin.cat_id = pc.ID
		WHERE pin.prd_end_dt IS NULL  --FILTER OUT THE HISTORICAL DATA
	



IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
	SELECT
		sls_ord_num as order_number,
		sls_prd_key as sales_product_key,
		sls_cust_id as sales_customer_id,
		sls_order_dt as order_date,
		sls_ship_dt as ship_date,
		sls_due_dt as delivery_date,
		sls_sales as sales,
		sls_quantity as quantity,
		sls_price as price
		
	FROM silver.crm_sales_details

--CHECK VIEWS
SELECT * FROM gold.dim_customers
SELECT * FROM gold.dim_products
SELECT * FROM gold.fact_sales

--CHECK THAT ALL DIMENSIONS TABLES CONNECTED SUCCESFULLY WITH FACT TABLE
SELECT *
	FROM gold.fact_sales S
	LEFT JOIN gold.dim_products P
	ON S.sales_product_key=P.product_key
		WHERE P.product_key IS NULL


SELECT *
	FROM gold.fact_sales S
	LEFT JOIN gold.dim_customers C
	ON S.sales_customer_id=C.customer_id
		WHERE C.customer_id IS NULL