--Data
select * from pizza_sales

--KPI

--total revenue

select sum(total_price) as Total_Revenue
from pizza_sales

--Average order value 
select sum(total_price) / count(distinct order_id) as avg_order_value
from pizza_sales


--Total pizza sold
select sum(quantity) as Total_pizza_sold
from pizza_sales

--Total orders
select count(distinct order_id) as Total_orders
from pizza_sales

--Average pizza per order

select cast(cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Average_pizza_per_order
from pizza_sales

--Daily trends for total orders
select DATENAME(DW,order_date) as Order_Day , COUNT(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(DW,order_date)

--Monthly trends for total orders
select DATENAME(MONTH,order_date) as Month_Name ,COUNT(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(MONTH,order_date)
order by Total_orders DESC


--Average revenue per order by pizza category
select pizza_category,Cast((sum(total_price) / count(distinct order_id) ) as decimal(10,2)) as Avg_revenue_per_order_by_pizza_category
from pizza_sales
group by pizza_category

--Percentage of sales by Pizza category 
select pizza_category, cast(sum(total_price) as decimal(10,2)) as Total_revenue , cast(sum(total_price) *100/ (select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT
from pizza_sales
group by pizza_category
order by PCT desc
--Percentage of sales by Pizza category in january
select pizza_category, cast(sum(total_price) as decimal(10,2)) as Total_revenue , cast(sum(total_price) *100/ (select sum(total_price) from pizza_sales where MONTH(order_date)=1) as decimal(10,2)) AS PCT
from pizza_sales
where MONTH(order_date)=1
group by pizza_category
order by PCT desc
--Percentage of sales by Pizza Size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_revenue , cast(sum(total_price) *100/ (select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT
from pizza_sales
group by pizza_size
order by PCT desc

--Percentage of sales by Pizza Size in first quarter
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_revenue , cast(sum(total_price) *100/ (select sum(total_price) from pizza_sales where DATEPART(quarter,order_date)=1) as decimal(10,2)) as PCT
from pizza_sales
where DATEPART(quarter,order_date)=1
group by pizza_size
order by PCT desc

--Total Pizza solds by pizza category in February
select pizza_category, sum(quantity) as total_quantity_sold 
from pizza_sales
where MONTH(order_date)=2
group by pizza_category
order by total_quantity_sold desc

--Top 5 pizza sold by total revenue
select top 5 with ties pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc

--Top 5 pizza sold by total quantity
select top 5 with ties pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity desc

--Top 5 pizza sold by total orders
select top 5 with ties pizza_name, count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc

--Bottom 5 pizza sold by total revenue
select top 5 with ties pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc

--bottom 5 pizza sold by total quantity
select top 5 with ties pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity asc

--Bottom 5 pizza sold by total orders
select top 5 with ties pizza_name, count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders asc
