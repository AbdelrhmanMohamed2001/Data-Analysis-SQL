create database BankLoan
use BankLoan

select * from BankCustomers

--------------------------DATA CLEANING--------------------------
-- Check Duplicates
select 
	Customer_ID,
	count(*) as Count
	from BankCustomers
	group by Customer_ID
	having count(*) >1


--Check Null Values
select * from BankCustomers where Customer_ID is null


--------------------------QUERIES TO GET INFORMATION--------------------------
--Total Balance
select
	Sum(Balance) as TotalBalance
	from BankCustomers

--Total Customers
select
	count(Customer_ID) as NumberOfCustomers
	from BankCustomers

--Balance By Age
select
	Age,
	sum(Balance) as TotalBalance
	from BankCustomers
	group by Age
	order by sum(Balance) Desc

--Age With Highest Balance
select top 1
	Age
	from BankCustomers
	group by Age
	order by sum(Balance) Desc

--Age With Lowest Balance
select top 1
	Age
	from BankCustomers
	group by Age
	order by sum(Balance) 

--Balance By Gender
select
	Gender,
	sum(Balance) as TotalBalance
	from BankCustomers
	group by Gender

--Which Gender Have Max Total Balance
select top 1
	Gender
	from BankCustomers
	group by Gender
	order by sum(Balance) Desc

--Balance By Age and Gender
select
	Gender,
	Age,
	sum(Balance) as TotalBalance
	from BankCustomers
	group by rollup (Gender, Age)
	order by Gender, Age Desc


--Number of Customers By Age 
select 
	Age,
	count(*) as NumberOfCustomers
	from BankCustomers
	group by rollup (Age)
	order by count(*) Desc

--Number of Customers By Gender
select 
	Gender,
	count(*) as NumberOfCustomers
	from BankCustomers
	group by rollup (Gender)

--Number Of Customers By Age and Gender
select
	Gender,
	Age,
	count(Customer_ID) as NumberOfCustomers
	from BankCustomers
	group by rollup (Gender, Age)
	order by Gender, Age Desc


--All in 2015
select distinct
	year(Date_Joined) as Year
	from BankCustomers

--Balance By Months in 2015
select
	Month(Date_Joined) as Month,
	sum(Balance) as Balance
	from BankCustomers
	group by Month(Date_Joined)
	order by Month(Date_Joined) 

 

--Number of Customers by Region
select
	Region,
	count(*) as NumberOfCustomers
	from BankCustomers
	group by Region
	order by count(*) Desc

--Balance by Region
select
	Region,
	sum(Balance) as TotalBalance
	from BankCustomers
	group by Region
	order by sum(Balance) Desc

--Number of Customers by JobType
select
	Job_Classification,
	count(*) as NumberOfCustomers
	from BankCustomers
	group by Job_Classification
	order by count(*) Desc

--Balance by JobType
select
	Job_Classification,
	sum(Balance) as NumberOfCustomers
	from BankCustomers
	group by Job_Classification
	order by sum(Balance) Desc

--The Best Customer (The Customer Who Have The Maximum Balance)

select top 1
	Customer_ID,
	Name,
	Surname,
	sum(Balance) as MaxBalance
	from BankCustomers
	group by Customer_ID, Name,Surname
	order by sum(Balance) Desc
	

--Customer Who Have The Maximum Balance
select top 1
	Customer_ID,
	Name,
	Surname,
	sum(Balance) as MaxBalance
	from BankCustomers
	group by Customer_ID, Name,Surname
	order by sum(Balance)