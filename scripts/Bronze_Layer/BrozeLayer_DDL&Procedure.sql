/*
=========================================================
   Load Bronze Layer
=========================================================
Purpose:
    Load raw data from CRM and ERP source system into Bronze tables.

Source:
    CSV files from the CRM and ERM source system.

Actions:
    1. Create Bronze tables.
    2. Import raw data using BULK INSERT.
    3. Preserve source data without applying transformations.
    4. Verify loaded data.

Tables:
    - crm_cust_info
    - crm_prd_info
    - crm_sales_details
    - erp_CUST_AZ12
    - erp_LOC_A101
    - erp_PX_CAT_G1V2
=========================================================
*/


create or alter procedure bronze.load_bronze as 
begin
	Declare @startTime datetime,@endTime datetime;
	print'------------------------------------------------------------------';
	print'Loading Bronze Layer';
	print'------------------------------------------------------------------';
	set @startTime=GETDATE();
	print'Loading CRM tables';
	print'==========================';
	DROP TABLE IF EXISTS bronze.crm_cust_info;
	create table bronze.crm_cust_info(
		cst_id int,
		cst_key nvarchar(50),
		cst_firstname nvarchar(50),
		cst_lastname nvarchar(50),
		cst_marital_status nvarchar(50),
		cst_gndr nvarchar(50),
		cst_create_date date
	);

	bulk insert bronze.crm_cust_info
	from 'C:\Users\odaha\OneDrive\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_crm\cust_info.csv'
	with(
		firstrow=2,
		fieldterminator=','
	)


--------------------------------------------------------------------------------

	DROP TABLE IF EXISTS bronze.crm_prd_info;
	create table bronze.crm_prd_info(
		prd_id int,
		prd_key nvarchar(50),
		prd_nm nvarchar(50),
		prd_cost int,
		prd_line nvarchar(50),
		prd_start_dt date,
		prd_end_dt date

	);

	bulk insert bronze.crm_prd_info 
	from 'C:\Users\odaha\OneDrive\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_crm\prd_info.csv'
	with (
		firstrow=2,
		fieldterminator=','
	)


--------------------------------------------------------------------------------

	DROP TABLE IF EXISTS bronze.crm_sales_details;
	CREATE TABLE bronze.crm_sales_details(
		sls_ord_num NVARCHAR(50),
		sls_prd_key NVARCHAR(50),
		sls_cust_id INT,
		sls_order_dt INT,
		sls_ship_dt INT,
		sls_due_dt INT,
		sls_sales INT,
		sls_quantity INT,
		sls_price INT
	);


	bulk insert bronze.crm_sales_details 
	from 'C:\Users\odaha\OneDrive\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_crm\sales_details.csv'
	with (
		firstrow=2,
		fieldterminator=','
	)

	set @endTime=GETDATE();

	print'>> load Duration : '+ cast (datediff(second,@startTime,@endTime)as varchar(50))+' Seconde';

--------------------------------------------------------------------------------
	print'==========================';
	print'Loading ERP tables';
	print'==========================';
	set @startTime=GETDATE();
	DROP TABLE IF EXISTS bronze.erp_CUST_AZ12;
	create table bronze.erp_CUST_AZ12(
		CID nvarchar(50),
		BDATE date,
		GEN nvarchar
	);

	alter table  bronze.erp_CUST_AZ12 alter column GEN nvarchar(50);

	bulk insert bronze.erp_CUST_AZ12
	from 'C:\Users\odaha\OneDrive\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_erp\CUST_AZ12.csv'
	with (
	firstrow=2,
	fieldterminator=','
	)


--------------------------------------------------------------------------------


	DROP TABLE IF EXISTS bronze.erp_LOC_A101;
	create table bronze.erp_LOC_A101(
		CID varchar(50),
		CNTRY varchar(50)

	);
	bulk insert bronze.erp_LOC_A101
	from 'C:\Users\odaha\OneDrive\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_erp\LOC_A101.csv'
	with (
	firstrow=2,
	fieldterminator=','
	)


--------------------------------------------------------------------------------


	DROP TABLE IF EXISTS bronze.erp_PX_CAT_G1V2;
	create table bronze.erp_PX_CAT_G1V2(
		ID nvarchar(50),
		CAT nvarchar(50),
		SUBCAT nvarchar(50),
		MAINTENANCE nvarchar(50)

	);

	bulk insert bronze.erp_PX_CAT_G1V2
	from 'C:\Users\odaha\OneDrive\Desktop\sql-data-warehouse-project-main\sql-data-warehouse-project-main\01_datasets\source_erp\PX_CAT_G1V2.csv'
	with (
	firstrow=2,
	fieldterminator=','
	)
	set @endTime=GETDATE();
	print'>> load Duration : '+ cast (datediff(second,@startTime,@endTime)as varchar(50))+' Seconde';

end;