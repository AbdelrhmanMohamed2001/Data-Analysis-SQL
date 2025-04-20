create database Healthcare
use Healthcare

select * from Healthcare

--Total Patients
select
	count(distinct Name) as TotalPatients
	from Healthcare

--Total Doctors
select
	count(distinct Doctor) as TotalDoctors
	from Healthcare

--Total Hospitals
select
	count(distinct Hospital) as TotalHospitals
	from Healthcare

--Number Of Rooms in Each Hospital
select
	Hospital,
	count(Room_Number) as TotalRooms
	from Healthcare
	group by Hospital
	order by count(Room_Number) Desc

--Billing Amount in Each Year
select
	Year(Date_Of_Admission) as Year,
	sum(Billing_Amount) as TotalCost
	from Healthcare
	group by Year(Date_Of_Admission)
	order by sum(Billing_Amount) Desc

----------------------------------🧍‍♂️ Patient Demographics--------------------------------

--Total Patients By Gender
select
	Gender,
	count(*) as Patients
	from Healthcare
	group by Gender

--Average Age Of Patients By Gender
select
	Gender,
	Avg(Age) as AverageAge
	from Healthcare
	group by Gender

--what is the Distribution Of Blood Types Amoung Patients
select 
	Blood_Type,
	count(Blood_Type) as TotalBloodTypes,
	cast(round(count(Blood_Type) *100 /sum((count(Blood_Type))) over()  ,2) as varchar)+ ' %' as Percentage
	from Healthcare
	group By Blood_Type
	order by count(Blood_Type) Desc

--Which Age Group Has The Highest Number Of Hospital Admissions?
select
	AgeGroup,
	count(*) as TotalPatients
	from (
	select
	case
		 when Age between 18 and 30 then 'Group_1 (18-30)'
		 when Age between 31 and 40 then 'Group_2 (31-40)'
		 when Age between 41 and 50 then 'Group_3 (41-50)'
		 when Age between 51 and 60 then 'Group_4 (51-60)'
		 when Age between 61 and 70 then 'Group_5 (61-70)'
		 when Age between 71 and 80 then 'Group_6 (71-80)'
		 else 'Group_7 Bigger than 50'
		 end as AgeGroup
		 from Healthcare
		 ) as AgeGroups
	group by AgeGroup
	order by count(*) Desc

-------------------------------------🩺 Medical Condition & Treatment------------------------------------

--Total Patients By  Medical Condition
select
	Medical_condition,
	count(*) as TotalMedicalConditions
	from Healthcare
	group by Medical_condition
	order by count(*) Desc

--The Most Common Medical Conditions
select Top 1
	Medical_condition,
	count(*) as Count
	from Healthcare
	group by Medical_condition
	order by count(*) Desc

--The Lowest Medical Conditions
select Top 1
	Medical_condition,
	count(*) as Count
	from Healthcare
	group by Medical_condition
	order by count(*) 

--Average Billing Amount By  Medical Condition
select
	Medical_condition,
	Avg(Billing_Amount) as AverageBillingAmount
	from Healthcare
	group by Medical_condition
	order by Avg(Billing_Amount)

--Which Medical Condition Has The Highest Average Billing Amount?
select top 1
	Medical_condition,
	Avg(Billing_Amount) as HighestAverageBillingAmount
	from Healthcare
	group by Medical_condition
	order by Avg(Billing_Amount) Desc

--Which Medical Condition Has The Lowest Average Billing Amount?
select top 1
	Medical_condition,
	Avg(Billing_Amount) as LowestAverageBillingAmount
	from Healthcare
	group by Medical_condition
	order by Avg(Billing_Amount) 


--Medications
select
	Medication,
	count(*) as TotalMedications
	from Healthcare
	group by Medication
	order by count(*) Desc


--What Medications Are Prescribed Most Frequently?
select top 1
	Medication,
	count(*) as TotalMedications
	from Healthcare
	group by Medication
	order by count(*) Desc

--What Medications Are Prescribed Less Frequently?
select top 1
	Medication,
	count(*) as TotalMedications
	from Healthcare
	group by Medication
	order by count(*) 

--What is The Most Common Medication Used For Each Medical Condition?
with RankedTable as(
select
	Medical_Condition,
	Medication,
	count(*) as MedicationCount,
	Rank() over(partition by Medical_Condition order by Count(*) Desc) as Rank
	from Healthcare
	group by Medical_Condition, Medication
	)select
		Medical_Condition,
		Medication,
		MedicationCount
		from RankedTable
		where Rank=1;

--Medical Condition And Test Results?

select
	Medical_Condition,
	Test_Results,
	count(*) ResultsCount
	from Healthcare
	group by  Medical_Condition, Test_Results
	order by count(*) Desc

--------------------------------------------💰 Billing & Insurance------------------------------------
--Average Billing Amount For Each Insurance Provider?
select
	Insurance_Provider,
	Avg(Billing_Amount) as AverageBillingAmount
	from Healthcare
	group by Insurance_Provider
	order by Avg(Billing_Amount) Desc

--Which Patients Have The Highest Billing Amounts?
select Top 1
	Name,
	sum(Billing_Amount) as HighestBillingAmount
	from Healthcare
	group by Name
	order by sum(Billing_Amount) Desc

--Which Patients Have The Lowest Billing Amounts?
select Top 1
	Name,
	sum(Billing_Amount) as HighestBillingAmount
	from Healthcare
	group by Name
	order by sum(Billing_Amount)

--How Does Billing Differ Between Elective And Emergency Admissions?
select distinct
	Admission_Type,
	Billing_Amount
	from Healthcare

--What is The Total Billing Amount fFor Each Hospital?
select
	Hospital,
	Sum(Billing_Amount) as TotalBillingAmount
	from Healthcare
	group by Hospital
	order by sum(Billing_Amount) Desc

----------------------------------🏥 Hospital & Doctor Performance------------------------------------
--Which Hospital Handled The Most Patients?
select Top 1
	Hospital,
	count(*) as NumberOfPatients
	from Healthcare
	group by Hospital
	order by count(*) Desc

--Which Doctor Admitted The Most Patients?
select Top 1
	Doctor,
	count(*) as NumberOfPatients
	from Healthcare
	group by Doctor
	order by count(*) Desc

--What is The Average Billing Amount Per Doctor?
select
	Doctor,
	Avg(Billing_Amount) as AverageBillingAmount
	from Healthcare
	group by Doctor
	order by Avg(Billing_Amount) Desc

-------------------------------------------📅 Admission & Discharge Trends---------------------------------------
--What is The Average Length Of Stay?
select
	Avg(DATEDIFF(Day, Date_Of_Admission, Discharge_Date)) as AverageRecoveryPeriod
	from Healthcare

--Which Months Had The Highest Number Of Admissions?
select top 1
	Month(Date_Of_Admission) as MonthOfHighestAdmissions,
	count(*) as TotalAdmissions
	from Healthcare
	group by Month(Date_Of_Admission)
	order by count(*) Desc


--Are There Seasonal Trends In Patient Admissions?
select
	Season,
	count(*) as TotalAdmissions
	from(
	select
	case
		when Month(Date_Of_Admission) in (12,1,2) then 'Winter'
		when Month(Date_Of_Admission) in (3,4,5) then 'Spring'
		when Month(Date_Of_Admission) in (6,7,8) then 'Summer'
		when Month(Date_Of_Admission) in (9,10,11) then 'Fall'
		end as Season
		from Healthcare) as Seasons
		group by Season
		order by count(*) Desc
		

------------------------------------🧪 Test Results & Medication-------------------------------------

--Which Medications Are Most Often Associated With Abnormal Test Results?
select
	Medication,
	count(Medication)  as CountWithAbnormalTestResult
	from Healthcare
	where Test_Results = 'Abnormal'
	group by Medication
	order by count(Medication) Desc

--How Do Test Results Vary By Blood Type?
select 
	Blood_Type,
	Test_Results,
	count(*) as ResultsOfBloodTypes
	from Healthcare
	group by Blood_Type, Test_Results
	order by count(*)

--Do Younger Or Older Patients Have More "Inconclusive" Test Results?
select
	AgeGroup,
	count(*) as TotalPatients
	from (
	select
	case
		 when Age between 18 and 40 then 'Younger (18-40)'
		 else 'Older'
		 end as AgeGroup,
		 Test_Results
		 from Healthcare
		 ) as AgeGroups
		 where Test_Results = 'Inconclusive'
		 group by AgeGroup
		 order by count(*) Desc
