create database HR
use HR
select * from HR_Attrition

-- Total Employess
select
	count(*) as TotalEmployees
	from HR_Attrition


--Count Of Each Attrition
select 
	Attrition,
	count(cast(Attrition as int)) as Count
	from HR_Attrition
	group by Attrition

--Min, Max and Average Age of Employess
select 
	Min(Age) as MinAge,
	Max(Age) as MaxAge,
	Avg(Age) as AvgAge
	from HR_Attrition

--Total Employees in Each Department
select 
	Department,
	Sum(EmployeeCount) as CountOfEmployees
	from HR_Attrition
	group by Department
	Order by sum(EmployeeCount) Desc

--Total Employees in Each Education Field
select
	EducationField,
	sum(EmployeeCount) as CountOfEmployees
	from HR_Attrition
	group by EducationField
	Order by sum(EmployeeCount) Desc

--Avg Hourly Rate For Each Gender
select
	Gender, 
	Avg(HourlyRate) as AvgRate
	from HR_Attrition
	group by Gender


--Avg Distance from Home To Work For Each Gender
select 
	Gender,
	Avg(DistanceFromHome) as AvgDistance
	from HR_Attrition
	group by Gender

--Job Satisfaction
select
	case JobSatisfaction
	when 1 then 'Low'
	when 2 then 'Medium'
	when 3 then 'High'
	when 4 then 'Very High'
	Else 'Unknown'
	end as JobSatisfactionLevel,
	count(JobSatisfaction) as CountOfEmployees
	from HR_Attrition
	group by JobSatisfaction
	order by JobSatisfaction 

--Business Travel For Employees
select
	BusinessTravel,
	count(*) as CountOfEmployees
	from HR_Attrition
	group by BusinessTravel
	order by count(*) Desc 

-- Check Performance
select
	PerformanceRating,
	count(PerformanceRating) as CountOfEmployees
	from HR_Attrition
	group by PerformanceRating
	order by PerformanceRating Desc

--Total Attrition by Gender
select
	Gender,
	sum(cast(Attrition as int)) as TotalAttrition
	from HR_Attrition
	group by Gender

--Total Attrition By Business Travel
select
	BusinessTravel,
	sum(cast(Attrition as int)) as TotalAttrition
	from HR_Attrition
	group by BusinessTravel
	order by sum(cast(Attrition as int)) Desc



--Total Attrition By Department
select
	Department,
	sum(cast(Attrition as int)) as TotalAttrition
	from HR_Attrition
	group by Department
	order by sum(cast(Attrition as int)) Desc

--Total Attrition By Education Field
select
	EducationField,
	sum(cast(Attrition as int)) as TotalAttrition
	from HR_Attrition
	group by EducationField
	order by sum(cast(Attrition as int)) Desc


--Total Attrition By Job Role
select
	JobRole,
	sum(cast(Attrition as int)) as TotalAttrition
	from HR_Attrition
	group by JobRole
	order by sum(cast(Attrition as int)) Desc


--Total Attrition By Marital Status
select
	MaritalStatus,
	sum(cast(Attrition as int)) as TotalAttrition
	from HR_Attrition
	group by MaritalStatus
	order by sum(cast(Attrition as int)) Desc

--Summarized Table Ordered By Total Attrition
select
	Gender,
	MaritalStatus,
	JobRole,
	Department,
	EducationField,
	sum(cast(Attrition as int)) as TotalAttrition
	from HR_Attrition
	group by Gender,MaritalStatus, JobRole, Department, EducationField
	order by sum(cast(Attrition as int)) Desc

--Summarized Table Ordered By Features
select
	Gender,
	MaritalStatus,
	JobRole,
	Department,
	EducationField,
	sum(cast(Attrition as int)) as TotalAttrition
	from HR_Attrition
	group by Gender,MaritalStatus, JobRole, Department, EducationField
	order by Gender,MaritalStatus, JobRole, Department, EducationField 