/*
================================================================================================
Stored Procedure : Load Bronze Layer (Source -> Bronze)
================================================================================================
Script Purpose : 
       This stored procedure loads data into the 'bronze' schema from CSV files .
       It performs the following actions:
       - Truncate the bronze tables before losding data .
       - Uses the 'BULK INSERT' command to load data from CSV Files to bronze tables .

Parameters:
    None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
      EXEC bronze.load_bronze ;
================================================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME ,@end_time DATETIME , @start_layer DATETIME ,@end_layer DATETIME
	BEGIN TRY
	SET @start_layer = GETDATE();
		PRINT'===================================================================================';
		PRINT'Loading Bronze Layer';
		PRINT'===================================================================================';

		PRINT'-----------------------------------------------------------------------------------';
		PRINT'Loading CRM Tables';
		PRINT'-----------------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT'>> Inserting the Data Into : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\study\DA\tools\DWH\sql-data-warehouse-project\datasets\source_crm\cust_info.CSV'
		WITH(
			 FIRSTROW=2,
			 FIELDTERMINATOR=',',
			 TABLOCK
		); 
		SET @end_time=GETDATE() ;
		PRINT'>> Load Duration : '+CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR ) +' seconds';
		PRINT'-----------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT'>> Inserting the Data Into : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\study\DA\tools\DWH\sql-data-warehouse-project\datasets\source_crm\prd_info.CSV'
		WITH(
			 FIRSTROW=2,
			 FIELDTERMINATOR=',',
			 TABLOCK
		);
		SET @end_time=GETDATE() ;
		PRINT'>> Load Duration : '+CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR ) +' seconds';
		PRINT'-----------------------------';

		PRINT '>> Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		SET @start_time= GETDATE();
		PRINT'>> Inserting the Data Into : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\study\DA\tools\DWH\sql-data-warehouse-project\datasets\source_crm\sales_details.CSV'
		WITH(
			 FIRSTROW=2,
			 FIELDTERMINATOR=',',
			 TABLOCK
		);
		SET @end_time=GETDATE() ;
		PRINT'>> Load Duration : '+CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR ) +' seconds';
		PRINT'-----------------------------';

		PRINT'-----------------------------------------------------------------------------------';
		PRINT'Loading ERP Tables';
		PRINT'-----------------------------------------------------------------------------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT'>> Inserting the Data Into : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\study\DA\tools\DWH\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.CSV'
		WITH(
			 FIRSTROW=2,
			 FIELDTERMINATOR=',',
			 TABLOCK
		);
		SET @end_time=GETDATE() ;
		PRINT'>> Load Duration : '+CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR ) +' seconds';
		PRINT'-----------------------------';

		SET @start_time=GETDATE() ;
		PRINT '>> Truncating Table : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT'>> Inserting the Data Into : bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\study\DA\tools\DWH\sql-data-warehouse-project\datasets\source_erp\LOC_A101.CSV'
		WITH(
			 FIRSTROW=2,
			 FIELDTERMINATOR=',',
			 TABLOCK
		);
		SET @end_time=GETDATE() ;
		PRINT'>> Load Duration : '+CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR ) +' seconds';
		PRINT'-----------------------------';

		SET @start_time=GETDATE();
		PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT'>> Inserting the Data Into : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\study\DA\tools\DWH\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.CSV'
		WITH(
			 FIRSTROW=2,
			 FIELDTERMINATOR=',',
			 TABLOCK
		);
		SET @end_time=GETDATE() ;
		PRINT'>> Load Duration : '+CAST(DATEDIFF(SECOND ,@start_time,@end_time) AS NVARCHAR ) +' seconds';
		PRINT'-----------------------------';
	END TRY
	BEGIN CATCH
		PRINT'===================================================================================';
		PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT'Error Message' + ERROR_MESSAGE();
		PRINT'Error Message' + CAST(ERROR_NUMBER()AS NVARCHAR);
		PRINT'Error Message' + CAST(ERROR_STATE()AS NVARCHAR);
		PRINT'===================================================================================';
	END CATCH
	SET @end_layer=GETDATE()
	PRINT'>> -- LOAD FULL BRONZE LAYER : '+CAST(DATEDIFF(SECOND ,@start_layer,@end_layer) AS NVARCHAR ) +' SECONDS';
	PRINT'-----------------------------';
END
