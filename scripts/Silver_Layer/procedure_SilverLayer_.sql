create or alter procedure silver.load_silver as
begin
	---silver.crm_cust_info
	truncate table silver.crm_cust_info;
	insert into silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,cst_create_date

	)
	select cst_id,cst_key,
	trim(cst_firstname)as 'cst_firstname',trim(cst_lastname)as'cst_lastname', 
	upper(Isnull(cst_marital_status,'NAN'))as'cst_marital_status',
	upper(Isnull(cst_gndr,'NAN'))as'cst_gndr',
	cst_create_date
	from(
	select *,ROW_NUMBER()over(partition by cst_id order by cst_create_date)"duplicate_Rank" 
	from bronze.crm_cust_info where cst_id is not null)t
	where duplicate_Rank=1 ;



	---silver.crm_prd_info

	truncate table silver.crm_prd_info;
	insert into silver.crm_prd_info(
		prd_id,
		cat_id,
		prd_key,
		prd_nm,
		prd_cost,
		prd_line,
		prd_start_dt,
		prd_end_dt)
	select  
		prd_id,
		--derived new columns
		replace(substring(prd_key,1,5),'-','_')as cat_id,
		substring(prd_key,7,len(prd_key)) as prd_key,
		prd_nm,
		isnull(prd_cost,0)as prd_cost,
		case upper(trim(prd_line))
			when 'M' then 'Mountain'
			when 'R' then 'Road'
			when 'S' then 'Other sales'
			when 'T' then 'Touring'
		else'NAN'
		end 'prd_line',
		cast (prd_start_dt as date),
		dateadd(day,-1,lead (prd_start_dt)over (partition by prd_key order by prd_start_dt)) as 'test end date'
		from bronze.crm_prd_info;



	-------silver.crm_sales_details
	truncate table silver.crm_sales_details;
	insert into silver.crm_sales_details(
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
	select sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		 case when sls_order_dt = 0 or len(sls_order_dt)!=8 then NULL
			else cast(cast(sls_order_dt as varchar) as date)
			end,
		case when sls_ship_dt =0 or len(sls_ship_dt)!=8 then NULL
			else cast(cast(sls_ship_dt as varchar) as date)
			end,
		case when sls_due_dt =0 or len(sls_due_dt)!=8 then NULL
			else cast(cast(sls_due_dt as varchar) as date)
			end,
		case when sls_sales <=0 or abs(sls_price)*sls_quantity != sls_sales 
				then abs(sls_price)*sls_quantity
			else sls_sales
			end,
		abs(isnull(sls_quantity,sls_sales/nullif(sls_price,0))),
		abs(isnull(sls_price,sls_sales*sls_quantity))
		from bronze.crm_sales_details;


	----silver.erp_CUST_AZ12
	truncate table silver.erp_CUST_AZ12;
	insert into silver.erp_CUST_AZ12
	(
		CID,
		BDATE,
		GEN
	)
	select 
		case when cid like 'NAS%' then substring(cid,4,len(cid))
		else cid
		end ,
		case when bdate>getdate() then null
		else bdate
		end,
		case when upper(trim(GEN)) in('MALE','M')then'M'
			when upper(trim(GEN)) in('FEMALE','F')then'F'
			else 'NAN'
			end
		from bronze.erp_CUST_AZ12



	----silver.erp_LOC_A101
	truncate table  silver.erp_LOC_A101;
	insert into silver.erp_LOC_A101(
		CID,
		CNTRY
	)
	select 
		replace(cid,'-',''),
		CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
			WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
			WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'NAN'
			ELSE TRIM(cntry)
			end
			from bronze.erp_LOC_A101


	---silver.erp_PX_CAT_G1V2
	truncate table silver.erp_PX_CAT_G1V2;
	insert into silver.erp_PX_CAT_G1V2(
		ID,
		CAT ,
		SUBCAT ,
		MAINTENANCE 
	)
	select 	ID,
		CAT ,
		SUBCAT ,
		MAINTENANCE from bronze.erp_PX_CAT_G1V2
end

