create database Uber
use Uber

select * from TripDetails
select * from Location


--Total Bookings
select 
	count(Trip_ID) as TotalBookings
	from TripDetails

--Total Bookings Value
select
	sum(fare_amount) + sum(Surge_Fee)  as TotalBookingsValue
	from TripDetails

--Average Bookings Value
select
	Avg(fare_amount) + Avg(Surge_Fee)  as AverageBookingsValue
	from TripDetails

--Total Trip Distance
select
	sum(trip_distance) as TotalTripDistance
	from TripDetails

--Average Trip Distance
select
	Avg(trip_distance) as AveragelTripDistance
	from TripDetails

--Average Trip Time
select
	Avg(DATEDIFF(SECOND,Pickup_Time,Drop_Off_Time))/60 as AverageTripTime
	from TripDetails

--Total Bookings By Payment Type
select
	Payment_type,
	count(Trip_ID) as Total,
	cast(round((count(Trip_ID)*100)/sum(count(Trip_ID)) over(), 2)as varchar) +' %' as Percentage
	from TripDetails
	group by Payment_type
	order by count(Trip_ID) Desc

--Total Bookings By Time (Day or Night)
with TimeStatus as(
select 
	Trip_ID,
	case when
	cast(Pickup_Time as time) between '06:00:00' and '17:59:59' 
	then 'Day'
	else 
	'Night'
	end as TimeStatus
	from TripDetails

) select
	TimeStatus,
	count(Trip_ID) as TotalBookingsByTime,
	cast(round((count(Trip_ID)*100)/sum(count(Trip_ID)) over(),2)as varchar) +' %'  as Percentage
	from TimeStatus
	group by TimeStatus;
	
----------------------Vehicle Analysis------------------------
--Total Bookings, Total Booking Value, Average Booking Value, Total Trip Distance For Each Vehicle

select
	Vehicle,
	Count(*) as TotalBookings,
	sum(fare_amount) + sum(Surge_Fee) as TotalBookingsvalue,
	Avg(fare_amount) + Avg(Surge_Fee) as AveragelBookingsvalue,
	sum(trip_distance) as TotalTripDistance
	from TripDetails
	group by Vehicle


--Total Bookings By Day
select 
	Day(convert(Date, Pickup_Time)) as Day ,
	count(Trip_ID) as TotalBookings
	from TripDetails
	group by rollup (Day(convert(Date, Pickup_Time)))
	order by Day(convert(Date, Pickup_Time))


--Total Bookings Value By Day
select 
	Day(convert(Date, Pickup_Time)) as Day ,
	sum(fare_amount) + sum(Surge_Fee) as Total
	from TripDetails
	group by rollup (Day(convert(Date, Pickup_Time)))
	order by Day(convert(Date, Pickup_Time))

--Best Vehicle --> Many distance in short time
select
	Vehicle,
	sum(trip_distance) as TotalDistance,
	sum(DATEDIFF(SECOND, Pickup_Time, Drop_Off_Time)) as TotalTime_Sec
	from TripDetails
	group by Vehicle
	order by sum(trip_distance) Desc 


--Total Bookings By Location
select
	Location,
	count(Trip_ID) as TotalBookings
	from Location
	join TripDetails
	on LocationID=PULocationID
	group by Location
	order by count(Trip_ID) Desc


