SELECT * FROM bronze.crm_cust_info


/* CLEANING OF crm_cust_info COLUMN
1. CHECK THAT PRIMARY KEY (cst_id) IS UNIQUE AND NOT NULL
2. CHECK THAT STRINGS HAVEN'T EXTRA SPACES
3. CHECK STANDARIZATION AND CONSISTENCT OF GENDER AND MARITAL STATUS 
*/

SELECT 
	cst_id,
	COUNT(*)
	FROM bronze.crm_cust_info
	GROUP BY cst_id
	HAVING COUNT(*) >1 OR cst_id IS NULL    --RESULT IS NOT UNIQUE AND INCLUDE NULLS


--SOLUTION
SELECT * FROM bronze.crm_cust_info WHERE cst_id =29466

SELECT * FROM (
	SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS RN
		FROM bronze.crm_cust_info)RANKED
		WHERE RN=1 AND cst_id =29466



--STRINGS
--IF cst_firstname NOT EQUAL cst_firstname AFTER TRIMING THEN cst_firstname CONTAINS EXTRA SPACES
SELECT
	cst_firstname
	FROM bronze.crm_cust_info
	WHERE cst_firstname !=TRIM(cst_firstname)

--IF cst_lastname NOT EQUAL cst_lastname AFTER TRIMING THEN cst_lastname CONTAINS EXTRA SPACES

SELECT
	cst_lastname
	FROM bronze.crm_cust_info
	WHERE cst_lastname !=TRIM(cst_lastname)


--GENDER COLUMN CONTAINS (F, M, NULL) MUST REPLACED AND TRIM 
SELECT DISTINCT
	cst_gndr
	FROM bronze.crm_cust_info
--MARITAL STATUS COLUMN CONTAINS (S, M, NULL) MUST REPLACED AND TRIM 
SELECT DISTINCT
	cst_marital_status
	FROM bronze.crm_cust_info


----------------------------------------------------------------------------------------------------------------------------------------------------------

/*CLEANING OF crm_prd_info
1. CHECK THAT PRIMARY KEY (prd_id) AND (prd_key) IS UNIQUE AND NOT NULL
2. CHECK THAT prd_cost NOT NULL AND NOT NEGATIVE
3. CHECK STANDARIZATION AND CONSISTENCT OF prd_line 

*/
SELECT * FROM bronze.crm_prd_info
SELECT 
	prd_id,
	COUNT(*)
	FROM bronze.crm_prd_info
	GROUP BY prd_id
	HAVING COUNT(*) > 1 OR prd_id IS NULL


SELECT 
	prd_key,
	COUNT(*)
	FROM bronze.crm_prd_info
	GROUP BY prd_key
	HAVING COUNT(*) > 1 AND prd_key IS NULL



SELECT 
	prd_cost
	FROM bronze.crm_prd_info
	WHERE prd_cost <0 OR prd_cost IS NULL


SELECT DISTINCT 
	prd_line 
	FROM bronze.crm_prd_info
----------------------------------------------------------------------------------------------------------------------------------------------------------
/*CLEANING OF crm_sales_details
1. FIRST 3 COLUMNS ARE CORRECT
2. CHECK THAT DATES NOT CONTAINS 0 OR LENGTH !=8
3. CHECK THAT sls_order_dt < sls_ship_dt < sls_due_dt
4. CHECK THAT SALES, QUANTITY, PRICE <=0
5. CHECK THAT SALES= QUANTITY * PRICE

*/
SELECT * FROM bronze.crm_sales_details

SELECT 
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt
	FROM bronze.crm_sales_details
	WHERE
		sls_order_dt =0 OR LEN(sls_order_dt)!=8 OR
		sls_ship_dt =0 OR LEN(sls_ship_dt)!=8 OR
		sls_due_dt =0 OR LEN(sls_due_dt)!=8


SELECT 
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt
	FROM bronze.crm_sales_details
	WHERE
		sls_order_dt>sls_ship_dt OR
		sls_order_dt>sls_due_dt OR
		sls_ship_dt>sls_due_dt


SELECT 
	sls_sales,
	sls_quantity,
	sls_price
	FROM bronze.crm_sales_details
	WHERE sls_sales<=0  OR sls_sales IS NULL

SELECT 
	sls_sales,
	sls_quantity,
	sls_price
	FROM bronze.crm_sales_details
	WHERE sls_quantity<=0 OR sls_quantity IS NULL

SELECT 
	sls_sales,
	sls_quantity,
	sls_price
	FROM bronze.crm_sales_details
	WHERE sls_price<=0 OR sls_price IS NULL
		  

SELECT 
	sls_sales,
	sls_quantity,
	sls_price
	FROM bronze.crm_sales_details
	WHERE sls_sales!= sls_quantity * sls_price 

----------------------------------------------------------------------------------------------------------------------------------------------------------
/*CLEANING OF erp_CUST_AZ12
1. CID COLUMN CONTAINS 'NASAW00011000' WE MUST DELETE 'NAS' 
TO MAKE IT 'AW00011000' SAME VALUE IN crm_cust_info TO CONNECT THE 2 TABLE THROUGH THIS COLUMN
2. CHECK THAT CID COLUMN IS UNIQUE AND NOT NULL
3. CHECK BDATE INCLUDE NULL OR NOT OR HAVE DATES IN THE FUTURE
4. CHECK GENDER COLUMN (STANDARIZATION AND CONSISTENCY)
*/
SELECT 
	CID, COUNT(*)
	FROM bronze.erp_CUST_AZ12
	GROUP BY CID
	HAVING COUNT(*) >1 OR CID IS NULL

SELECT SUBSTRING(CID,4,LEN(CID)) AS CID FROM bronze.erp_CUST_AZ12 WHERE CID LIKE'NAS%'
SELECT CID FROM silver.erp_CUST_AZ12 WHERE CID NOT IN (SELECT cst_key FROM silver.crm_cust_info)


SELECT * FROM bronze.erp_CUST_AZ12
WHERE BDATE IS NULL OR LEN(BDATE)!=10 OR BDATE>GETDATE()

SELECT DISTINCT GEN FROM bronze.erp_CUST_AZ12

----------------------------------------------------------------------------------------------------------------------------------------------------------
/*CLEANING OF erp_LOC_A101
1. CHECH QUALITY OF CID TO MATCH cst_key COLUMN IN crm_cust_info
2. CHECK QUALITY OF CNTRY COLUMN (STANDARIZATION AND CONSISTENCY)

*/
SELECT * FROM bronze.erp_LOC_A101
SELECT 
	CID, COUNT(*)
	FROM bronze.erp_LOC_A101
	GROUP BY CID
	HAVING COUNT(*) >1 OR CID IS NULL OR LEN(CID) !=11


SELECT * FROM bronze.erp_LOC_A101

SELECT 
	CNTRY
	FROM silver.erp_LOC_A101 


SELECT DISTINCT CNTRY,
	CASE WHEN UPPER(TRIM(CNTRY)) IN('USA','US') THEN 'United States'
		 WHEN TRIM(CNTRY)='DE' THEN 'Germany'
		 WHEN UPPER(TRIM(CNTRY)) IS NULL OR TRIM(CNTRY)='' THEN 'n/a'
		 ELSE TRIM(CNTRY)
	END AS CNTRY
	FROM bronze.erp_LOC_A101
----------------------------------------------------------------------------------------------------------------------------------------------------------
/*CLEANING OF erp_PX_CAT_G1V2
1. ID COLUMN IS SAME AS cat_id IN crm_prd_info
2. CHECK CAT COLUMN
3. CHECK SUBCAT COLUMN
4. CHECK MAINTENANCE COLUMN
*/
SELECT * FROM bronze.erp_PX_CAT_G1V2

SELECT DISTINCT TRIM(CAT) FROM bronze.erp_PX_CAT_G1V2

SELECT DISTINCT SUBCAT FROM bronze.erp_PX_CAT_G1V2

SELECT DISTINCT MAINTENANCE FROM bronze.erp_PX_CAT_G1V2


