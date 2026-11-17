select * from silver.crm_cust_info;

---duplicate check
with data as(
select cst_id,count (*)"id_count" from silver.crm_cust_info group by cst_id)
select * from data where id_count>1 ;

---null check
select count(*) from silver.crm_cust_info where cst_id is null;


---check unwanted whitespace
select cst_firstname ,cst_lastname from silver.crm_cust_info 
where cst_firstname != trim(cst_firstname) or cst_lastname != trim(cst_lastname);

--check marital_status and gender columns
select distinct(cst_marital_status) from silver.crm_cust_info ;

select distinct(cst_gndr) from silver.crm_cust_info ;





select * from silver.crm_prd_info;

---duplicate check prd_id bronze.crm_prd_info
with data_prd as(
select prd_id,count (*)"id_count" from silver.crm_prd_info group by prd_id)
select * from data_prd where id_count>1 ;

---null check prd_id bronze.crm_prd_info
select count(*) from silver.crm_prd_info where prd_id is null;

---check unwanted whitespace silver.crm_prd_info 
select prd_key ,prd_nm from silver.crm_prd_info 
where prd_key != trim(prd_key) or prd_nm != trim(prd_nm);
--check prd cost
select * from  silver.crm_prd_info where prd_cost is null;
--check prd_line
select distinct(prd_line) from silver.crm_prd_info ;
--chek start date and end date
select * from  silver.crm_prd_info where prd_end_dt<prd_start_dt;





select * from silver.crm_sales_details;

--check unwanted whitesqace bronze.crm_sales_details

select sls_ord_num from silver.crm_sales_details where sls_ord_num != trim (sls_ord_num);
select sls_prd_key from silver.crm_sales_details where sls_prd_key != trim (sls_prd_key);
----------------------------------
--check null
select sls_cust_id from silver.crm_sales_details where sls_cust_id is null;
--check int column and convert them to date

select len(sls_order_dt),len(sls_ship_dt),len(sls_due_dt) from silver.crm_sales_details;
select sls_order_dt,sls_ship_dt,sls_due_dt from silver.crm_sales_details  ; 

--check sales

select sls_sales from silver.crm_sales_details where sls_sales <=0 ;

select sls_sales,sls_quantity,sls_price from silver.crm_sales_details where sls_sales<=0 or sls_quantity<=0 or sls_price<=0;





---check cid
select cid from silver.erp_CUST_AZ12 where cid is null;
---check date
select bdate from silver.erp_CUST_AZ12 where bdate>getdate()
--- check Gen col
select distinct(Gen)from silver.erp_CUST_AZ12

