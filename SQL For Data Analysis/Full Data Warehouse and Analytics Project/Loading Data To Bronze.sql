EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	PRINT '====================================================';
	PRINT 'LOADING BRONZE LAYER';
	PRINT '====================================================';
	PRINT 'LOADING CRM TABLES';
	PRINT '------------------------------------------------------------';
	PRINT 'TRUNCATING TABLE: bronze.crm_cust_info';
	PRINT '------------------------------------------------------------';

	TRUNCATE TABLE bronze.crm_cust_info;
--MAKE BULK INSERT TO EXTRACT ALL ROWS FROM TABLE IN MY PC TO TABLE IN DATABASE
	BULK INSERT bronze.crm_cust_info
	FROM 'D:\Data Analysis\Data Warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.CSV'
	WITH (
		FIRSTROW =2, --START FROM SECOND ROW IN THE FILE IN PS BECAUSE FIRST ROW IS THE DATA HEADER
		FIELDTERMINATOR = ',',  --DELIMETER BETWEEN VALUES IN THE FILE IN PC
		TABLOCK --LOCK TABLE AFTER EXTRACT VALUES
	);

	PRINT 'TRUNCATING TABLE: bronze.crm_prd_info';
	PRINT '------------------------------------------------------------';
	BULK INSERT bronze.crm_prd_info
	FROM 'D:\Data Analysis\Data Warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.CSV'
	WITH(
		FIRSTROW=2,
		FIELDTERMINATOR= ',',
		TABLOCK
	);

	PRINT 'TRUNCATING TABLE: bronze.crm_sales_details';
	PRINT '------------------------------------------------------------';
	BULK INSERT bronze.crm_sales_details
	FROM 'D:\Data Analysis\Data Warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.CSV'
	WITH(
		FIRSTROW=2,
		FIELDTERMINATOR= ',',
		TABLOCK
	);

	PRINT 'LOADING ERP TABLES';
	PRINT '------------------------------------------------------------';
	PRINT 'TRUNCATING TABLE: bronze.erp_CUST_AZ12';
	PRINT '------------------------------------------------------------';
	BULK INSERT bronze.erp_CUST_AZ12
	FROM 'D:\Data Analysis\Data Warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.CSV'
	WITH(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
	);

	PRINT 'TRUNCATING TABLE: bronze.erp_LOC_A101';
	PRINT '------------------------------------------------------------';
	BULK INSERT bronze.erp_LOC_A101
	FROM 'D:\Data Analysis\Data Warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.CSV'
	WITH(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
	);

	PRINT 'TRUNCATING TABLE: bronze.erp_PX_CAT_G1V2';
	PRINT '------------------------------------------------------------';
	BULK INSERT bronze.erp_PX_CAT_G1V2
	FROM 'D:\Data Analysis\Data Warehouse\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.CSV'
	WITH(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
	);

END;