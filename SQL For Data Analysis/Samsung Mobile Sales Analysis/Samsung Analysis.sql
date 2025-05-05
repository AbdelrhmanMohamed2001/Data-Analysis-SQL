Create Database SamsungData
use SamsungData

select * from Samsung

--Total Units
select
	sum(Units_Sold) as TotalUnits
	from Samsung


--Total Revenue
select
	sum(Revenue) as TotalRevenue
	from Samsung

--Total Units Sold and Revenue by 5G Capability
select
	_5G_Capability,
	sum(Units_Sold) as TotalUnits,
	sum(Revenue) as TotalRevenue
	from Samsung
	group by _5G_Capability


--Total Units Sold and Revenue by Year
select
	Year,
	sum(Units_Sold) as TotalUnits,
	sum(Revenue) as TotalRevenue
	from Samsung
	group by Year
	order by Year


--Total Units Sold and Revenue by Quarter
select
	Quarter,
	sum(Units_Sold) as TotalUnits,
	sum(Revenue) as TotalRevenue
	from Samsung
	group by Quarter
	order by Quarter


--Total Units Of Product Models
select
	Product_Model,
	sum(Units_Sold) as TotalUnits
	from Samsung
	group by Product_Model
	order by sum(Units_Sold) Desc


--Total Revenue By Product Models
select
	Product_Model,
	sum(Revenue) as TotalRevenue
	from Samsung
	group by Product_Model
	order by sum(Revenue) Desc


--Total Units Sold, Total Revenue, and Average Market Share By Region
select
	Region,
	sum(Units_Sold) as TotalUnits,
	sum(Revenue) as TotalRevenue,
	Avg(Market_Share) as AverageMarketShare
	from Samsung
	group by Region






	

