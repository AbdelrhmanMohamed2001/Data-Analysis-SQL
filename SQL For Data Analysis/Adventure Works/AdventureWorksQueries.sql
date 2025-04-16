use AdventureWorks2022

select * from Person.BusinessEntityContact
select * from Person.ContactType


select 
	Person.ContactType.Name,
	Person.BusinessEntityContact.ContactTypeID,
	count(Person.BusinessEntityContact.ContactTypeID) as NumberOfContacts
	from Person.BusinessEntityContact 
	join Person.ContactType
	on Person.BusinessEntityContact.ContactTypeID = Person.ContactType.ContactTypeID
	group by Person.ContactType.Name, Person.BusinessEntityContact.ContactTypeID
	having count(Person.BusinessEntityContact.ContactTypeID) >=100
	order by count(Person.BusinessEntityContact.ContactTypeID) Desc


select * from HumanResources.EmployeePayHistory
select * from Person.Person
 

select 
	 CONCAT(LastName, ', ', FirstName, ' ', MiddleName) AS FullName,
	RateChangeDate,
	(40*EmployeePayHistory.Rate) as WeeklySalary
	from HumanResources.EmployeePayHistory
	join Person.Person
	on EmployeePayHistory.BusinessEntityID = Person.BusinessEntityID
	where FirstName +' '+ MiddleName+' '+LastName is not null
	order by FullName Asc

select 
	LastName +' '+FirstName+' '+MiddleName as FullName,
	RateChangeDate,
	(Rate*40) as WeeklySalary
	from HumanResources.EmployeePayHistory
	join Person.Person
	on EmployeePayHistory.BusinessEntityID = Person.BusinessEntityID
	where FirstName +' '+ MiddleName+' '+LastName is not null
	order by FullName ASC

select * from Sales.SalesOrderDetail

select
	SalesOrderID,
	ProductID,
	OrderQty,
	sum(OrderQty) over (partition by SalesOrderID) as Sum,
	AVG(OrderQty) over (partition by SalesOrderID) as Avg,
	min(OrderQty) over (partition by SalesOrderID) as Min,
	max(OrderQty) over (partition by SalesOrderID) as Max,
	count(OrderQty) over (partition by SalesOrderID) as Count
	from Sales.SalesOrderDetail
	where SalesOrderID in (43659,43664)

select
	SalesOrderID,
	ProductID,
	OrderQty,
	sum(OrderQty) over (partition by SalesOrderID) as Sum,
	AVG(OrderQty) over (partition by SalesOrderID) as Avg,
	count(OrderQty) over (partition by SalesOrderID) as Count
	from Sales.SalesOrderDetail
	where SalesOrderID in (43659,43664)	and ProductID like '71%'


select 
	SalesOrderID,
	Sum(orderqty*unitprice) as TotalCost
	from Sales.SalesOrderDetail
	group by SalesOrderID
	having Sum(orderqty*unitprice) > 100000
	order by SalesOrderID

select * from Production.Product

select 
	ProductID,
	Name
	from Production.Product
	where Name like('Lock Washer %')
	order by ProductID


select * from Production.Product

select
	ProductID,
	Name,
	Color
	from Production.Product
	order by ListPrice 

select * from HumanResources.Employee
select
	BusinessEntityID,
	JobTitle,
	HireDate
	from HumanResources.Employee
	order by (HireDate)

select * from Person.Person
select LastName, FirstName 
	from Person.Person
	where LastName Like('R%')
	order by FirstName ASC , LastName DESC

select BusinessEntityID, SalariedFlag 
	from HumanResources.Employee
	order by  case SalariedFlag when 'true' then BusinessEntityID End Desc,
	case SalariedFlag when 'false' then BusinessEntityID End ASC

select * from Sales.vSalesPerson
select
	BusinessEntityID,
	LastName,
	TerritoryName,
	CountryRegionName
	from Sales.vSalesPerson
	where TerritoryName is not null
	order by case CountryRegionName when 'United States' then TerritoryName
	else CountryRegionName end;

select * from Person.Person
select * from Sales.SalesPerson
select * from Person.AddressType

select
	FirstName,
	LastName,
	ROW_NUMBER() over (order by PostalCode) as RowNumber ,
	RANK() over (order by PostalCode) as Rank,
	DENSE_RANK() over (order by PostalCode) as DenseRank,
	NTILE(1) over (order by PostalCode) as Quartile,
	SalesYTD,
	PostalCode
	from Person.Person
	join Sales.SalesPerson 
	on Person.BusinessEntityID = SalesPerson.BusinessEntityID
	join Person.Address
	on Person.BusinessEntityID = Address.AddressID
	where TerritoryID is not null and SalesYTD>0

select
	DepartmentID,
	Name,
	GroupName
	from HumanResources.Department
	order by DepartmentID offset 10 rows

select 
	DepartmentID,
	Name,
	GroupName
	From HumanResources.Department
	order by DepartmentID 
	offset 5 rows fetch next 5 rows only ;


select 
	Name,
	Color,
	ListPrice
	from Production.Product
	where Color in ('Red','Blue')
	order by ListPrice

select * from Sales.SalesOrderDetail
select * from Production.Product

select
		Name,
		SalesOrderID
		from Production.Product
		full join Sales.SalesOrderDetail
		on SalesOrderDetail.ProductID = Product.ProductID
		order by Name

select
	Name,
	SalesOrderID
	from Production.Product
	left join Sales.SalesOrderDetail
	on Product.ProductID = SalesOrderDetail.ProductID
	order by Name

select
	Name,
	SalesOrderID
	from Sales.SalesOrderDetail
	join Production.Product
	on Product.ProductID = SalesOrderDetail.ProductID
	order by Name

select * from Sales.SalesPerson
select * from Sales.SalesTerritory

select
	Name,
	BusinessEntityID
	from Sales.SalesPerson
	left join Sales.SalesTerritory
	on SalesPerson.TerritoryID = SalesTerritory.TerritoryID

select * from Person.Person
select * from Person.Address
select * from HumanResources.Employee
select * from Person.BusinessEntityAddress

select
	CONCAT(LastName,' ',FirstName) as Name,
	city
	from Person.Person
	join HumanResources.Employee
	on Person.BusinessEntityID = Employee.BusinessEntityID
	join Person.BusinessEntityAddress
	on Person.BusinessEntityID = BusinessEntityAddress.BusinessEntityID
	join Person.Address
	on Address.AddressID = BusinessEntityAddress.AddressID
	order by name


select 
	BusinessEntityID,
	FirstName,
	LastName
	from Person.Person
	where PersonType= 'IN' and LastName= 'Adams'
	order by FirstName ASC

select
	BusinessEntityID,
	FirstName,
	LastName
	from Person.Person
	where BusinessEntityID<1500 and FirstName Like'M%' and LastName Like 'Al%'
	order by BusinessEntityID

select * from Production.Product
select
	ProductID,
	Name,
	Color
	from Production.Product
	where Name in ('Blade', 'Crown Race','AWC Logo Cap')

select * from Sales.SalesOrderHeader
select 
	SalesPersonID,
	count(SalesOrderID) as TotalSales,
	Year(OrderDate) as SalesYear
	from Sales.SalesOrderHeader
	group by SalesPersonID, Year(OrderDate)
	having SalesPersonID is not null
	order by SalesPersonID, Year(OrderDate)

select distinct
	SalesPersonID,
	count(SalesOrderID) over(partition by SalesPersonID, Year(OrderDate) ) as TotalSales,
	Year(OrderDate) as SalesYear
	from Sales.SalesOrderHeader
	where SalesPersonID is not null
	order by SalesPersonID , Year(OrderDate) ASC

with CTE as(
	select 
	count(SalesOrderID) as TotalSales
	from Sales.SalesOrderHeader
	where SalesPersonID is not null
	group by SalesPersonID
	)
	select AVG(TotalSales) as Average from CTE;

with newTable as(
select
count(SalesOrderID) as total from Sales.SalesOrderHeader
where SalesPersonID is not null
group by SalesPersonID
)
select AVG(total) from newTable;
	

select * from Production.ProductPhoto
select * from Production.ProductPhoto where LargePhotoFileName like('%green_%')

select * from Person.Address
select * from Person.StateProvince

select 
	AddressLine1,
	AddressLine2,
	PostalCode,
	CountryRegionCode, 
	City
	from Person.Address
	join Person.StateProvince
	on Address.StateProvinceID = StateProvince.StateProvinceID
	where CountryRegionCode <> 'US' and City Like ('Pa%')

select * from HumanResources.Employee
select top 20
	JobTitle,
	HireDate
	from HumanResources.Employee
	order by HireDate DESC

