
----------------------------------------------------------------------
---create gold.dim_customer view
----------------------------------------------------------------------

create view gold.dim_customer as
select 
		row_number() over(order by ci.cst_create_date)as Customer_Number,
		ci.cst_id as Customer_id,
		ci.cst_key as Customer_Key,
		ci.cst_firstname as First_Name,
		ci.cst_lastname as Last_Name,
		ci.cst_marital_status as Marital_Status,
		case when ci.cst_gndr is null then se.gen
			else ci.cst_gndr 
		end as 'Gender',
		se.bdate as Birth_Date,
		el.cntry as Country,
		ci.cst_create_date as Create_Date
from silver.crm_cust_info ci left join silver.erp_CUST_AZ12 se
		on ci.cst_key=se.cid left join silver.erp_LOC_A101 el
		on ci.cst_key=el.cid;

----------------------------------------------------------------------
--create gold.dim_product view
----------------------------------------------------------------------
create view gold.dim_product as 
select 
	ROW_NUMBER()over (order by prd_start_dt)as product_Surrogate_Key,
	sp.prd_id as Product_Id,
	sp.prd_key as Product_Key,
	sp.prd_nm as Product_Number,
	sp.cat_id as Category_Id,
	ep.CAT as Category,
	ep.SUBCAT as SubCatogory,
	sp.prd_cost as Product_Cost,
	sp.prd_line as Product_Line,
	sp.prd_start_dt as Start_Date,
	ep.MAINTENANCE
	from  silver.crm_prd_info sp left join silver.erp_PX_CAT_G1V2 ep
	on sp.cat_id=ep.id
	where prd_end_dt is null--filter our the historical data;

----------------------------------------------------------------------
--create gold.fact_sales view
----------------------------------------------------------------------

create view gold.fact_sales as
SELECT
	sd.sls_ord_num as Order_Number,
	dp.product_Surrogate_Key as Product_Key,
	dc.Customer_Number as Customer_id,
	sd.sls_order_dt as Order_Date,
	sd.sls_ship_dt as Shipping_Date,
	sd.sls_due_dt as Due_Date,
	sd.sls_sales as Sales_Amount,
	sd.sls_quantity as Quantity,
	sd.sls_price as price
	from silver.crm_sales_details sd left join gold.dim_product dp
	on sd.sls_prd_key=dp.Product_Key left join gold.dim_customer dc
	on sd.sls_cust_id=dc.Customer_id;