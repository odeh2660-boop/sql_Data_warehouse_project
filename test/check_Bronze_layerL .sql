select * from bronze.crm_cust_info;

---duplicate check cst_id bronze.crm_cust_info
with data as(
select cst_id,count (*)"id_count" from bronze.crm_cust_info group by cst_id)
select * from data where id_count>1 ;

---null check bronze.crm_cust_info
select count(*) from bronze.crm_cust_info where cst_id is null;


---check unwanted whitespace bronze.crm_cust_info
select cst_firstname ,cst_lastname from bronze.crm_cust_info 
where cst_firstname != trim(cst_firstname) or cst_lastname != trim(cst_lastname);

--check marital_status and gender columns bronze.crm_cust_info
select distinct(cst_marital_status) from bronze.crm_cust_info ;

select distinct(cst_gndr) from bronze.crm_cust_info ;




select * from bronze.crm_prd_info;

---duplicate check prd_id bronze.crm_prd_info
with data_prd as(
select prd_id,count (*)"id_count" from bronze.crm_prd_info group by prd_id)
select * from data_prd where id_count>1 ;

---null check prd_id bronze.crm_prd_info
select count(*) from bronze.crm_prd_info where prd_id is null;

---check unwanted whitespace bronze.crm_prd_info 
select prd_key ,prd_nm from bronze.crm_prd_info 
where prd_key != trim(prd_key) or prd_nm != trim(prd_nm);
--check prd cost
select * from  bronze.crm_prd_info where prd_cost<=0;
--check prd_line
select distinct(prd_line) from bronze.crm_prd_info ;
--chek start date and end date
select * from  bronze.crm_prd_info where prd_end_dt<prd_start_dt;



select * from bronze.crm_sales_details;

--check unwanted whitesqace bronze.crm_sales_details

select sls_ord_num from bronze.crm_sales_details where sls_ord_num != trim (sls_ord_num);
select sls_prd_key from bronze.crm_sales_details where sls_prd_key != trim (sls_prd_key);
----------------------------------
--check null
select sls_cust_id from bronze.crm_sales_details where sls_cust_id is null;
--check int column and convert them to date

select len(sls_order_dt),len(sls_ship_dt),len(sls_due_dt) from bronze.crm_sales_details;
select sls_order_dt,sls_ship_dt,sls_due_dt from bronze.crm_sales_details where len(sls_order_dt)!=8 or len(sls_ship_dt)!=8 or len(sls_due_dt)!=8 ; 

--check sales

select sls_sales from bronze.crm_sales_details where sls_sales <=0 ;

select sls_sales,sls_quantity,sls_price from bronze.crm_sales_details where sls_price*sls_quantity != sls_sales;
select sls_sales,sls_quantity,sls_price from bronze.crm_sales_details where sls_sales<=0 or sls_quantity<=0 or sls_price<=0;
select sls_sales,sls_quantity,sls_price from bronze.crm_sales_details where sls_sales is null or sls_quantity is null or sls_price is null;



select * from bronze.erp_CUST_AZ12 ;

---check cid
select cid from bronze.erp_CUST_AZ12 where cid is null;
---check date
select bdate from bronze.erp_CUST_AZ12 where bdate>getdate()
--- check Gen col
select distinct(Gen)from bronze.erp_CUST_AZ12




select * from bronze.erp_PX_CAT_G1V2 ;
--check id 
select id from bronze.erp_PX_CAT_G1V2 where id is null;

-- checl for unwanted whitespace

select cat ,subcat,maintenance from bronze.crm_cust_info 
where cat != trim(cat) or subcat != trim(subcat)or maintenance !=trim (maintenance);

--Check Data Consistency

select  distinct(cat) from bronze.erp_PX_CAT_G1V2 ;
select distinct(subcat) from bronze.erp_PX_CAT_G1V2 ;
select distinct(maintenance) from bronze.erp_PX_CAT_G1V2 ;

