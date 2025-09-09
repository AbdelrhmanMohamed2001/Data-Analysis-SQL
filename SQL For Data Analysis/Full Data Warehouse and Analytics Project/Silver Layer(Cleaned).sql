EXEC silver.load_silver;

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	PRINT'WELCOME THO SILVER LAYER'
	PRINT'======================================================================='
	PRINT'TRUNCATING TABLE crm_cust_info IN SILVER LAYER'
	PRINT'-----------------------------------------------------------------------'
	--INSERT CLEANING DATA TO SILVER LAYER FOR TABLE silver.crm_cust_info
	TRUNCATE TABLE silver.crm_cust_info
	PRINT'INSERT CLEANING DATA TO SILVER LAYER FOR TABLE silver.crm_cust_info'
	PRINT'-----------------------------------------------------------------------'
	INSERT INTO silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date)

	SELECT 
		cst_id,
		cst_key,
		TRIM(cst_firstname) AS cst_firstname,
		TRIM(cst_lastname) AS cst_lastname,
		CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			 WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			 ELSE 'n/a'
		END cst_marital_status,
		CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			 WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			 ELSE 'n/a'
		END cst_gndr,
		cst_create_date

		FROM (
			SELECT
				*,
				ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS RN
				FROM bronze.crm_cust_info)RANKED
				WHERE cst_id IS NOT NULL AND RN=1


	----------------------------------------------------------------------------------------------------------------------------------------------------------
	--INSERT CLEANING DATA TO SILVER LAYER FOR TABLE silver.crm_prd_info
	PRINT'======================================================================='
	PRINT'TRUNCATING TABLE crm_prd_info IN SILVER LAYER'
	PRINT'-----------------------------------------------------------------------'
	TRUNCATE TABLE silver.crm_prd_info
	PRINT'INSERT CLEANING DATA TO SILVER LAYER FOR TABLE silver.crm_prd_info'
	PRINT'-----------------------------------------------------------------------'
	INSERT INTO silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
	)

	SELECT
		prd_id,
		REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,  --TO BE SAME AS ID IN erp_PX_CAT_G1V2 TABLE
		SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,       --TO BE SAME AS sls_prd_key IN crm_sales_details TABLE
		TRIM(prd_nm) AS prd_nm,
		ISNULL(prd_cost, 0) AS prd_cost,   --REPLACE NULL WITH 0
		CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
			 WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
			 WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
			 WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
			 ELSE'n/a'
		END AS prd_line,
		prd_start_dt,
		DATEADD(DAY, -1, LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_end_dt
		FROM bronze.crm_prd_info


	----------------------------------------------------------------------------------------------------------------------------------------------------------
	PRINT'======================================================================='
	PRINT'TRUNCATING TABLE crm_sales_details IN SILVER LAYER'
	PRINT'-----------------------------------------------------------------------'
	TRUNCATE TABLE silver.crm_sales_details
	PRINT'INSERT CLEANING DATA TO SILVER LAYER FOR TABLE silver.crm_sales_details'
	PRINT'-----------------------------------------------------------------------'
	INSERT INTO silver.crm_sales_details(
	sls_ord_num ,
	sls_prd_key ,
	sls_cust_id ,
	sls_order_dt ,
	sls_ship_dt ,
	sls_due_dt ,
	sls_sales ,
	sls_quantity ,
	sls_price
	)
	SELECT
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		CASE WHEN sls_order_dt =0 OR LEN(sls_order_dt)!=8 THEN NULL
			 ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)    --TO CAST FROM INT TO DATE MUST INT-->VARCHAR-->DATE
		END AS sls_order_dt,

		CASE WHEN sls_ship_dt =0 OR LEN(sls_ship_dt)!=8 THEN NULL
			 ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
		END AS sls_ship_dt,

		CASE WHEN sls_due_dt =0 OR LEN(sls_due_dt)!=8 THEN NULL
			 ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
		END AS sls_due_dt,

		CASE WHEN sls_sales IS NULL OR sls_sales<=0 OR sls_sales!=ABS(sls_quantity)* ABS(sls_price)
			THEN ABS(sls_quantity) * ABS(sls_price)
			ELSE sls_sales
		END AS sls_sales,

		sls_quantity,

		CASE WHEN sls_price IS NULL OR sls_price <=0
			 THEN ABS(sls_sales) / NULLIF(sls_quantity,0)  --TO AVOID DIVISION BY 0
			 ELSE sls_price
		END AS sls_price

		FROM bronze.crm_sales_details

	----------------------------------------------------------------------------------------------------------------------------------------------------------
	PRINT'======================================================================='
	PRINT'TRUNCATING TABLE erp_CUST_AZ12 IN SILVER LAYER'
	PRINT'-----------------------------------------------------------------------'
	TRUNCATE TABLE silver.erp_CUST_AZ12
	PRINT'INSERT CLEANING DATA TO SILVER LAYER FOR TABLE silver.erp_CUST_AZ12'
	PRINT'-----------------------------------------------------------------------'
	INSERT INTO silver.erp_CUST_AZ12(
	CID,
	BDATE,
	GEN
	)
	SELECT 
		CASE WHEN CID LIKE'NAS%' THEN SUBSTRING(CID,4,LEN(CID))
			 ELSE CID
		END AS CID,

		CASE WHEN BDATE>=GETDATE() THEN NULL
			 ELSE BDATE
		END AS BDATE,

		CASE WHEN UPPER(TRIM(GEN)) = 'F' THEN 'Female'
			 WHEN UPPER(TRIM(GEN)) = 'M' THEN 'Male'
			 WHEN TRIM(GEN) = '' OR TRIM(GEN) IS NULL THEN 'n/a'
			 ELSE TRIM(GEN)
		END AS GEN
		FROM bronze.erp_CUST_AZ12


	----------------------------------------------------------------------------------------------------------------------------------------------------------
	PRINT'======================================================================='
	PRINT'TRUNCATING TABLE erp_LOC_A101 IN SILVER LAYER'
	PRINT'-----------------------------------------------------------------------'
	TRUNCATE TABLE silver.erp_LOC_A101
	PRINT'INSERT CLEANING DATA TO SILVER LAYER FOR TABLE silver.erp_LOC_A101'
	PRINT'-----------------------------------------------------------------------'
	INSERT INTO silver.erp_LOC_A101(CID,CNTRY)
	SELECT
		REPLACE(CID,'-','') AS CID,
		CASE WHEN UPPER(TRIM(CNTRY)) IN('USA','US') THEN 'United States'
			 WHEN TRIM(CNTRY)='DE' THEN 'Germany'
			 WHEN UPPER(TRIM(CNTRY)) IS NULL OR TRIM(CNTRY)='' THEN 'n/a'
			 ELSE TRIM(CNTRY)
		END AS CNTRY
		FROM bronze.erp_LOC_A101



	----------------------------------------------------------------------------------------------------------------------------------------------------------
	PRINT'======================================================================='
	PRINT'TRUNCATING TABLE erp_PX_CAT_G1V2 IN SILVER LAYER'
	PRINT'-----------------------------------------------------------------------'
	TRUNCATE TABLE silver.erp_PX_CAT_G1V2
	PRINT'INSERT CLEANING DATA TO SILVER LAYER FOR TABLE silver.erp_PX_CAT_G1V2'
	PRINT'-----------------------------------------------------------------------'
	INSERT INTO silver.erp_PX_CAT_G1V2(ID, CAT, SUBCAT,MAINTENANCE)
	SELECT 
		ID,
		TRIM(CAT) AS CAT,
		TRIM(SUBCAT) AS SUBCAT,
		TRIM(MAINTENANCE) AS MAINTENANCE

		FROM bronze.erp_PX_CAT_G1V2
	----------------------------------------------------------------------------------------------------------------------------------------------------------
	
	PRINT'DONE...LETS GO TO GOLD LAYER'
	END