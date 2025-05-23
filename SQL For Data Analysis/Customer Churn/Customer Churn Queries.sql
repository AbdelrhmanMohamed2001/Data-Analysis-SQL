create Database TeleCustomerChurn
use TeleCustomerChurn
select * from Churn

--------------------------------Data Profiling--------------------------------
--Checking Null Values
select 
	'customerID' as ColumnName,
  count(*) as total_rows,
  count(customerID) as non_null_values,
  count(*) - count(customerID) as null_values
from Churn;

select 
	'Gender' as ColumnName,
	count(*) as total_rows,
	count(gender) as non_null_values,
	count(*) - count(gender) as null_values
from Churn

select 
	'SeniorCitizen' as ColumnName,
	count(*) as total_rows,
	count(SeniorCitizen) as non_null_values,
	count(*) - count(SeniorCitizen) as null_values
from Churn

select 
	'Partner' as ColumnName,
	count(*) as total_rows,
	count(Partner) as non_null_values,
	count(*) - count(Partner) as null_values
from Churn

select 
	'Dependents' as ColumnName,
	count(*) as total_rows,
	count(Dependents) as non_null_values,
	count(*) - count(Dependents) as null_values
from Churn

select 
	'tenure' as ColumnName,
	count(*) as total_rows,
	count(tenure) as non_null_values,
	count(*) - count(tenure) as null_values
from Churn

select 
	'PhoneService' as ColumnName,
	count(*) as total_rows,
	count(PhoneService) as non_null_values,
	count(*) - count(PhoneService) as null_values
from Churn

select 
	'MultipleLines' as ColumnName,
	count(*) as total_rows,
	count(MultipleLines) as non_null_values,
	count(*) - count(MultipleLines) as null_values
from Churn

select 
	'InternetService' as ColumnName,
	count(*) as total_rows,
	count(InternetService) as non_null_values,
	count(*) - count(InternetService) as null_values
from Churn

select 
	'OnlineSecurity' as ColumnName,
	count(*) as total_rows,
	count(OnlineSecurity) as non_null_values,
	count(*) - count(OnlineSecurity) as null_values
from Churn

select 
	'OnlineBackup' as ColumnName,
	count(*) as total_rows,
	count(OnlineBackup) as non_null_values,
	count(*) - count(OnlineBackup) as null_values
from Churn

select 
	'DeviceProtection' as ColumnName,
	count(*) as total_rows,
	count(DeviceProtection) as non_null_values,
	count(*) - count(DeviceProtection) as null_values
from Churn

select 
	'TechSupport' as ColumnName,
	count(*) as total_rows,
	count(TechSupport) as non_null_values,
	count(*) - count(TechSupport) as null_values
from Churn

select 
	'StreamingTV' as ColumnName,
	count(*) as total_rows,
	count(StreamingTV) as non_null_values,
	count(*) - count(StreamingTV) as null_values
from Churn

select 
	'StreamingMovies' as ColumnName,
	count(*) as total_rows,
	count(StreamingMovies) as non_null_values,
	count(*) - count(StreamingMovies) as null_values
from Churn

select 
	'Contract' as ColumnName,
	count(*) as total_rows,
	count(Contract) as non_null_values,
	count(*) - count(Contract) as null_values
from Churn

select 
	'PaperlessBilling' as ColumnName,
	count(*) as total_rows,
	count(PaperlessBilling) as non_null_values,
	count(*) - count(PaperlessBilling) as null_values
from Churn

select 
	'PaymentMethod' as ColumnName,
	count(*) as total_rows,
	count(PaymentMethod) as non_null_values,
	count(*) - count(PaymentMethod) as null_values
from Churn

select 
	'MonthlyCharges' as ColumnName,
	count(*) as total_rows,
	count(MonthlyCharges) as non_null_values,
	count(*) - count(MonthlyCharges) as null_values
from Churn

select 
	'TotalCharges' as ColumnName,
	count(*) as total_rows,
	count(TotalCharges) as non_null_values,
	count(*) - count(TotalCharges) as null_values
from Churn

select 
	'Churn' as ColumnName,
	count(*) as total_rows,
	count(Churn) as non_null_values,
	count(*) - count(Churn) as null_values
from Churn

--Check Duplicated Values
select
	'customerID' as ColumnName,
	customerID, count(*) as Total
	from Churn
	group by customerID
	having count(*)>1

select
	'Gender' as ColumnName,
	gender, count(*) as Total
	from Churn
	group by gender
	having count(*)>1

select
	'SeniorCitizen' as ColumnName,
	SeniorCitizen, count(*) as Total
	from Churn
	group by SeniorCitizen
	having count(*)>1

select
	'Partner' as ColumnName,
	Partner, count(*) as Total
	from Churn
	group by Partner
	having count(*)>1

select
	'Dependents' as ColumnName,
	Dependents, count(*) as Total
	from Churn
	group by Dependents
	having count(*)>1

select
	'tenure' as ColumnName,
	tenure, count(*) as Total
	from Churn
	group by tenure
	having count(*)>1

select
	'PhoneService' as ColumnName,
	PhoneService, count(*) as Total
	from Churn
	group by PhoneService
	having count(*)>1

select
	'MultipleLines' as ColumnName,
	MultipleLines, count(*) as Total
	from Churn
	group by MultipleLines
	having count(*)>1

select
	'InternetService' as ColumnName,
	InternetService, count(*) as Total
	from Churn
	group by InternetService
	having count(*)>1

select
	'OnlineSecurity' as ColumnName,
	OnlineSecurity, count(*) as Total
	from Churn
	group by OnlineSecurity
	having count(*)>1

select
	'OnlineBackup' as ColumnName,
	OnlineBackup, count(*) as Total
	from Churn
	group by OnlineBackup
	having count(*)>1

select
	'DeviceProtection' as ColumnName,
	DeviceProtection, count(*) as Total
	from Churn
	group by DeviceProtection
	having count(*)>1

select
	'TechSupport' as ColumnName,
	TechSupport, count(*) as Total
	from Churn
	group by TechSupport
	having count(*)>1

select
	'StreamingTV' as ColumnName,
	StreamingTV, count(*) as Total
	from Churn
	group by StreamingTV
	having count(*)>1

select
	'StreamingMovies' as ColumnName,
	StreamingMovies, count(*) as Total
	from Churn
	group by StreamingMovies
	having count(*)>1

select
	'Contract' as ColumnName,
	Contract, count(*) as Total
	from Churn
	group by Contract
	having count(*)>1

select
	'PaperlessBilling' as ColumnName,
	PaperlessBilling, count(*) as Total
	from Churn
	group by PaperlessBilling
	having count(*)>1

select
	'PaymentMethod' as ColumnName,
	PaymentMethod, count(*) as Total
	from Churn
	group by PaymentMethod
	having count(*)>1

select
	'MonthlyCharges' as ColumnName,
	MonthlyCharges, count(*) as Total
	from Churn
	group by MonthlyCharges
	having count(*)>1

select
	'TotalCharges' as ColumnName,
	TotalCharges, count(*) as Total
	from Churn
	group by TotalCharges
	having count(*)>1

select
	'Churn' as ColumnName,
	Churn, count(*) as Total
	from Churn
	group by Churn
	having count(*)>1

--Get Distinct Values
select
	'customerID' as ColumnName,
	Count(distinct customerID) as Count
	from Churn

select
	'Gender' as ColumnName,
	Count(distinct gender) as Count
	from Churn

select
	'SeniorCitizen' as ColumnName,
	Count(distinct SeniorCitizen) as Count
	from Churn

select
	'Partner' as ColumnName,
	Count(distinct Partner) as Count
	from Churn

select
	'Dependents' as ColumnName,
	Count(distinct Dependents) as Count
	from Churn

select
	'tenure' as ColumnName,
	Count(distinct tenure) as Count
	from Churn

select
	'PhoneService' as ColumnName,
	Count(distinct PhoneService) as Count
	from Churn

select
	'MultipleLines' as ColumnName,
	Count(distinct MultipleLines) as Count
	from Churn

select
	'InternetService' as ColumnName,
	Count(distinct InternetService) as Count
	from Churn

select
	'OnlineSecurity' as ColumnName,
	Count(distinct OnlineSecurity) as Count
	from Churn

select
	'OnlineBackup' as ColumnName,
	Count(distinct OnlineBackup) as Count
	from Churn

select
	'DeviceProtection' as ColumnName,
	Count(distinct DeviceProtection) as Count
	from Churn

select
	'TechSupport' as ColumnName,
	Count(distinct TechSupport) as Count
	from Churn

select
	'StreamingTV' as ColumnName,
	Count(distinct StreamingTV) as Count
	from Churn

select
	'StreamingMovies' as ColumnName,
	Count(distinct StreamingMovies) as Count
	from Churn

select
	'Contract' as ColumnName,
	Count(distinct Contract) as Count
	from Churn

select
	'PaperlessBilling' as ColumnName,
	Count(distinct PaperlessBilling) as Count
	from Churn

select
	'PaymentMethod' as ColumnName,
	Count(distinct PaymentMethod) as Count
	from Churn

select
	'MonthlyCharges' as ColumnName,
	Count(distinct MonthlyCharges) as Count
	from Churn

select
	'TotalCharges' as ColumnName,
	Count(distinct TotalCharges) as Count
	from Churn

select
	'Churn' as ColumnName,
	Count(distinct Churn) as Count
	from Churn



--Check Outliers
select
	tenure
	from Churn
	where tenure > (
		select 
			AVG(tenure) + 3* STDEV(tenure)
			from Churn
			)


select
	MonthlyCharges
	from Churn
	where MonthlyCharges > (
		select 
			AVG(MonthlyCharges) + 3* STDEV(MonthlyCharges)
			from Churn
			)


select
	TotalCharges
	from Churn
	where TotalCharges > (
		select 
			AVG(TotalCharges) + 3* STDEV(TotalCharges)
			from Churn
			)

--Statistical Analysis
select
	'tenure' as ColumnName,
	Count(tenure) as TotalRecords,
	Sum(tenure) as Summation,
	Min(tenure) as MinValue,
	Max(tenure) as MaxValue,
	AVG(tenure) as Average,
	STDEV(tenure) as StandardDeviation
	from Churn


select
	'MonthlyCharges' as ColumnName,
	Count(MonthlyCharges) as TotalRecords,
	Sum(MonthlyCharges) as Summation,
	Min(MonthlyCharges) as MinValue,
	Max(MonthlyCharges) as MaxValue,
	AVG(MonthlyCharges) as Average,
	STDEV(MonthlyCharges) as StandardDeviation
	from Churn


select
	'TotalCharges' as ColumnName,
	Count(TotalCharges) as TotalRecords,
	Sum(TotalCharges) as Summation,
	Min(TotalCharges) as MinValue,
	Max(TotalCharges) as MaxValue,
	AVG(TotalCharges) as Average,
	STDEV(TotalCharges) as StandardDeviation
	from Churn

----------------------------------------------Analysis---------------------------------------------
Select * from Churn


--Total Customers
select count(distinct customerID) as TotalCustomers from Churn

--Categorical Columns
select 
	gender,
	count(gender) as Count,
	ROUND(100.0*count(gender)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by gender

select 
	SeniorCitizen,
	count(SeniorCitizen) as Count,
	ROUND(100.0*count(SeniorCitizen)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by SeniorCitizen

select 
	Partner,
	count(Partner) as Count,
	ROUND(100.0*count(Partner)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by Partner

select 
	Dependents,
	count(Dependents) as Count,
	ROUND(100.0*count(Dependents)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by Dependents

select 
	PhoneService,
	count(PhoneService) as Count,
	ROUND(100.0*count(PhoneService)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by PhoneService

select 
	MultipleLines,
	count(MultipleLines) as Count,
	ROUND(100.0*count(MultipleLines)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by MultipleLines

select 
	InternetService,
	count(InternetService) as Count,
	ROUND(100.0*count(InternetService)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by InternetService

select 
	OnlineSecurity,
	count(OnlineSecurity) as Count,
	ROUND(100.0*count(OnlineSecurity)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by OnlineSecurity

select 
	OnlineBackup,
	count(OnlineBackup) as Count,
	ROUND(100.0*count(OnlineBackup)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by OnlineBackup

select 
	DeviceProtection,
	count(DeviceProtection) as Count,
	ROUND(100.0*count(DeviceProtection)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by DeviceProtection

select 
	TechSupport,
	count(TechSupport) as Count,
	ROUND(100.0*count(TechSupport)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by TechSupport

select 
	StreamingTV,
	count(StreamingTV) as Count,
	ROUND(100.0*count(StreamingTV)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by StreamingTV

select 
	StreamingMovies,
	count(StreamingMovies) as Count,
	ROUND(100.0*count(StreamingMovies)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by StreamingMovies

select 
	Contract,
	count(Contract) as Count,
	ROUND(100.0*count(Contract)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by Contract

select 
	PaperlessBilling,
	count(PaperlessBilling) as Count,
	ROUND(100.0*count(PaperlessBilling)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by PaperlessBilling

select 
	PaymentMethod,
	count(PaymentMethod) as Count,
	ROUND(100.0*count(PaymentMethod)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by PaymentMethod


select 
	Churn,
	count(Churn) as Count,
	ROUND(100.0*count(Churn)/(select count(*) from Churn),2) as Percentage
	from Churn
	group by Churn


--How does churn rate vary over time or tenure?
select
	Contract,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by Contract


--Does senior citizen status affect churn likelihood?
select
	SeniorCitizen,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by SeniorCitizen


--	Does gender influence churn?
select
	gender,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by gender

--	Which services (Internet, Phone, Streaming) have higher churn rates?
select
	InternetService,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by InternetService

select
	PhoneService,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by PhoneService

select
	StreamingTV,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by StreamingTV

select
	StreamingMovies,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by StreamingMovies;


--	How does churn differ by contract type (Month-to-month, One year, Two year)?
select
	Contract,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by Contract;


--	Which payment methods are associated with higher churn?
select
	PaymentMethod,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by PaymentMethod
	order by Churned_Customers Desc;


-- How do MonthlyCharges relate to churn?

select
	
	Case
		when MonthlyCharges < 40 then 'Low'
		when MonthlyCharges < 80 then 'Meduim'
		else 'High'
		end as MonthlyCharges_Status,
		Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by Case
		when MonthlyCharges < 40 then 'Low'
		when MonthlyCharges < 80 then 'Meduim'
		else 'High'
		end


-- How do TotalCharges relate to churn?

select
	
	Case
		when TotalCharges < 2900 then 'Low'
		when TotalCharges < 5800 then 'Meduim'
		else 'High'
		end as TotalCharges_Status,
		Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by Case
		when TotalCharges < 2900 then 'Low'
		when TotalCharges < 5800 then 'Meduim'
		else 'High'
		end



--Do customers with higher monthly bills churn more?
select
	
	Case
		when MonthlyCharges < 40 then 'Low'
		when MonthlyCharges < 80 then 'Meduim'
		else 'High'
		end as MonthlyCharges_Status,
		Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by Case
		when MonthlyCharges < 40 then 'Low'
		when MonthlyCharges < 80 then 'Meduim'
		else 'High'
		end

	order by round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) Desc


--	How does customer tenure impact the likelihood of churn?
select
	
	Case
		when tenure < 30 then 'Low'
		when tenure < 60 then 'Meduim'
		else 'High'
		end as tenure_Stage,
		Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by Case
		when tenure < 30 then 'Low'
		when tenure < 60 then 'Meduim'
		else 'High'
		end

--	Does having tech support affect churn?
select
	TechSupport,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by TechSupport;


--Does having online security affect churn?

select
	OnlineSecurity,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	group by OnlineSecurity;


--	Are customers without support services more likely to churn?
select
	TechSupport,
	Count(Churn) Total_Customers,
	sum(
		case when Churn = 'Yes' then 1 else 0 end
	) as Churned_Customers,
	round(100.0*
	sum(
		case when Churn = 'Yes' then 1 else 0 end) / (count(*))
		, 2) as Percentage
	from Churn
	where TechSupport = 'No'
	group by TechSupport;


