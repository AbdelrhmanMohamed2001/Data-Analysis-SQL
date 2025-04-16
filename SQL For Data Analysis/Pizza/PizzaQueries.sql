use [Pizza DB]

select * from pizza_sales


--Total Revenue = 817860.05083847
select 
	sum(total_price) as Total_Revenue 
	from pizza_sales  

--Average Order Value = 38.3072623343546
select 
	sum(total_price) / count(distinct order_id)  as Average_Order_Value 
	from pizza_sales 

--Total Pizzas Sold = 49574
select 
	sum(quantity) 
	from pizza_sales as Total_Pizzas_Sold

--Total Orders = 21350
select 
	count(distinct order_id) 
	from pizza_sales as Total_Orders

--Average Pizza Per Order = 2
select 
	sum(quantity)/count(distinct order_id) 
	from pizza_sales as Average_Pizza_Per_Order

--How Many Pizzas Sold Each Day?

select 
	distinct order_date, 
	sum(quantity) 
	over(partition by order_date ) as Pizzas_Sold_Each_Day 
	from pizza_sales order_date 
	order by order_date



--Daily Trend for Total Orders (convert date into days) 
SELECT 
    DATENAME(WEEKDAY, order_date) AS Day, 
    COUNT(DISTINCT order_id) AS Daily_Orders 
FROM pizza_sales 
GROUP BY DATENAME(WEEKDAY, order_date), DATEPART(WEEKDAY, order_date)
ORDER BY DATEPART(WEEKDAY, order_date);

	

--which day contains max orders
with Max_Daily_Orders as(
select
	DATENAME(DW, order_date) as Day,
	count(distinct order_id) as Daily_Orders
		from pizza_sales 
		group by DATENAME(DW, order_date))
select Day , Daily_Orders as Max_Daily_Orders from Max_Daily_Orders where Daily_Orders =(select Max(Daily_Orders) from Max_Daily_Orders
);


--which day contains min orders
with Min_Daily_Orders as(
select 
	DATENAME(DW, order_date) as Day,
	count(distinct order_id) as Daily_Orders
	from pizza_sales
	group by DATENAME(Dw, order_date))

	select Day, Daily_Orders as Min_Daily_Orders
	from Min_Daily_Orders
	where Daily_Orders= (select Min(Daily_Orders) from Min_Daily_Orders
);

--Monthly Trend for Total Orders (convert date into Month Names) 
select 
	DATENAME(Month, order_date) as Month, 
	count(distinct order_id) as Monthly_Orders 
	from pizza_sales 
	group by DATENAME(month, order_date), month(order_date)
	order by month(order_date)

--which month contains max orders
with Max_Monthly_Orders as (
select
	DATENAME(month, order_date) as Month, 
	count(distinct order_id) as Monthly_Orders
	from pizza_sales
	group by  DATENAME(month, order_date))

select Month, Monthly_Orders as Max_Monthly_Orders
	from Max_Monthly_Orders
	where Monthly_Orders= (select Max(Monthly_Orders)  
	from Max_Monthly_Orders
);


--which month contains min orders
with Min_Monthly_Orders as(
select
	DATENAME(month, order_date) as Month,
	count(distinct order_id) as Monthly_Ordres
	from pizza_sales
	group by DATENAME(month, order_date))

select Month, Monthly_Ordres as Min_Monthly_Orders
	from Min_Monthly_Orders
	where Monthly_Ordres= (select min(Monthly_Ordres) from Min_Monthly_Orders
);


--Percentage of Sales By Pizza Category
select 
	pizza_category,
	sum(total_price) as Total_Sales,
	sum(total_price)*100 / (select sum(total_price) from pizza_sales) as Percentage
	from pizza_sales
	group by pizza_category


--Percentage of Sales By Pizza Size
select
	pizza_size,
	sum(total_price) as Total_Sales,
	sum(total_price)*100 / (select sum(total_price) from pizza_sales)
	from pizza_sales
	group by pizza_size
	order by pizza_size

--Total Pizzas Sold by Pizza Category
select
	pizza_category, 
	sum(quantity) as Quantity
	from pizza_sales
	group by pizza_category
	order by pizza_category


--Sales Of Each Pizza Name
select 
	 pizza_name,
	 sum(total_price) as Total_Sales
	 from pizza_sales
	 group by pizza_name
	 order by Total_Sales Desc


--Top 5 Pizzas by Revenue
select top 5
	pizza_name,
	sum(total_price) as Total_Sales
	from pizza_sales
	group by pizza_name
	order by Total_Sales Desc

--Bottom 5 Pizzas by Revenue
select top 5
	pizza_name,
	sum(total_price) as Total_Sales
	from pizza_sales
	group by pizza_name
	order by Total_Sales Asc

--Top 5 Pizzas by Quantity
select top 5
	pizza_name,
	sum(quantity) as Quantity
	from pizza_sales
	group by pizza_name
	order by Quantity Desc

--Bottom 5 Pizzas by Quantity
select top 5
	pizza_name,
	sum(quantity) as Quantity
	from pizza_sales
	group by pizza_name
	order by Quantity Asc

--Top 5 Pizzas by Total Orders
select top 5
	pizza_name,
	count(distinct order_id) as Total_Orders
	from pizza_sales
	group by pizza_name
	order by Total_Orders Desc

--Borrom 5 Pizzas by Total Orders
select top 5
	pizza_name,
	count(distinct order_id) as Total_Orders
	from pizza_sales
	group by pizza_name
	order by Total_Orders Asc