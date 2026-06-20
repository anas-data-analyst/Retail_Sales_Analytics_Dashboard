create database order_data;
use order_data;
show tables ;
select count(*) from orderd_data;
## // step 1 data check and column
select * from orderd_data limit 10;
select count(*) as totaL_rows from orderd_data;
##\\
##// step 2  find high level business number(find KPI)
-- Total Sales, Total Profit and Total Quantity Sold
 select 
 round(sum(sales),2) as total_sales,
 round(sum(profit),2)as total_profit,
 sum(quantity) as total_quantity_sold
 from orderd_data;
 --  find Profit Margin (%)  
 -- review the overall percentage margin in overall business 
 
 select 
 round((sum(profit)/ sum(sales)) * 100,2) as profit_margin_percentage
 from orderd_data;
 ##\\
 
 #// step 3  query for business insight
 
 -- 1) which category give the more sales and profit(line chart /pie chart )
 select 
       category,
       round(sum(sales),2) as category_sales,
       round(sum(profit),2 )as category_profit,
       sum(Quantity) as total_Qty
 from orderd_data
 group by category
 order by category_sales desc;
 -- 2) Top 5 cities where the sles is more
 
 select
      city,
      round(sum(sales) , 2) as total_sales,
      count(distinct order_id) as total_orders
      from orderd_data
      group by city 
      order by total_sales desc
      limit 5 ;
 -- 3 month -on month trend
 -- which month business performance is good and which month is bad
select 
	year,
	month,
	round(sum(sales), 2)as monthly_sales,
	round(sum(profit),2) as monthly_profit
from orderd_data
group by year, month
order by year , monthly_sales desc;
#\\

-- step 4 SQL VIEWS 
-- view 1 Sales Performance view
create view v_sales_performance as 
select
     order_id,
     order_date,
     month,
     year,
     city,
     category,
     product,
     sales,
     Quantity,
     profit
from orderd_data;

-- view 2 City Summary view 
create view v_city_summary as 
select
city,
round(sum(sales), 2) as total_sales,
round(sum(profit),2 ) as total_profit,
sum(Quantity) as total_Quantity
from orderd_data
group by city;
 