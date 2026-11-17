DROP TABLE IF EXISTS silver.crm_cust_info;
create table silver.crm_cust_info(
	cst_id int,
	cst_key nvarchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_marital_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date date,
	dwh_create_date datetime2 default getdate()
);
DROP TABLE IF EXISTS silver.crm_prd_info;
create table silver.crm_prd_info(
	prd_id int,
	cat_id	nvarchar(50),
	prd_key nvarchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(50),
	prd_start_dt date,
	prd_end_dt date,
	dwh_create_date datetime2 default getdate()

);

DROP TABLE IF EXISTS silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt date,
	sls_ship_dt date,
	sls_due_dt date,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date datetime2 default getdate()

);

----------------------------------------ERP----------------------------------------

DROP TABLE IF EXISTS silver.erp_CUST_AZ12;
create table silver.erp_CUST_AZ12(
	CID nvarchar(50),
	BDATE date,
	GEN nvarchar(5),
	dwh_create_date datetime2 default getdate()
);

DROP TABLE IF EXISTS silver.erp_LOC_A101;
create table silver.erp_LOC_A101(
	CID varchar(50),
	CNTRY varchar(50),
	dwh_create_date datetime2 default getdate()

);

DROP TABLE IF EXISTS silver.erp_PX_CAT_G1V2;
create table silver.erp_PX_CAT_G1V2(
	ID nvarchar(50),
	CAT nvarchar(50),
	SUBCAT nvarchar(50),
	MAINTENANCE nvarchar(50),
	dwh_create_date datetime2 default getdate()

	);