select * from AdidasSales

--Retailers
select distinct Retailer  from AdidasSales

--Locations
	--Regions
	select 
		count(distinct Region) as RegionsCount
		from AdidasSales
	select distinct Region from AdidasSales
	

		--Cities
		select 
			count(distinct City) as CitiesCount
			from AdidasSales
		select distinct City from AdidasSales

			--States
			select 
				count(distinct State) as StatesCount
				from AdidasSales
			select distinct State from AdidasSales


--Products
select
	count(distinct Product) as ProductsCount
	from AdidasSales
select distinct Product from AdidasSales


--Total Sold Units
select
	sum(Units_Sold) as Sold_Units 
	from AdidasSales

--Total Sales
select
	sum(Total_Sales) as TotalSales
	from AdidasSales

--Total Profit
select
	sum(Operating_Profit) as Total_Profit
	from AdidasSales


--Total Sales, Units By Retailer
select
	Retailer,
	sum(Units_sold) as SoldUnits,
	sum(Total_Sales) as RatailerSales
	from AdidasSales
	group by Retailer
	order by sum(Total_Sales) Desc




--Total Sales, Units By Products
select
	Product,
	sum(Units_sold) as SoldUnits,
	sum(Total_Sales) as ProductSales
	from AdidasSales
	group by Product
	order by sum(Total_Sales) Desc


--Total Sales, Units By Regions
select
	Region,
	sum(Units_sold) as SoldUnits,
	sum(Total_Sales) as RegionSales
	from AdidasSales
	group by Region
	order by sum(Total_Sales) Desc 


--Total Sales, Units By States
select
	State,
	sum(Units_sold) as SoldUnits,
	sum(Total_Sales) as StateSales
	from AdidasSales
	group by State
	order by sum(Total_Sales) Desc 


--Total Sales, Units By Cities
select
	City,
	sum(Units_sold) as SoldUnits,
	sum(Total_Sales) as CitiesSales
	from AdidasSales
	group by City
	order by sum(Total_Sales) Desc 


--Total Sales By Sales Methods
select 
	Sales_Method,
	sum(Total_Sales) as TotalSales,
	round(sum((Total_Sales)*100) / sum(sum(Total_Sales))over(), 2) as percentage
	from AdidasSales
	group by Sales_Method
	order by sum(Total_Sales) Desc


--Total Sales By Year and Month
select * from AdidasSales

select 
	Year(Invoice_Date) as Year,
	Month(Invoice_Date) as Month,
	sum(Total_Sales) as TotalSales
	from AdidasSales
	group by Year(Invoice_Date) , Month(Invoice_Date) 
	order by Year(Invoice_Date) , Month(Invoice_Date)

--Total Sales By Regions, States and Cities (Tree Map)
select
	Region,
	State,
	City,
	sum(Total_Sales) as TotalSales
	from AdidasSales
	group by Region, State, City
	order by Region, State, City
