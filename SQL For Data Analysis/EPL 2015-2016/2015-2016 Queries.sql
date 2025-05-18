use EPL

select * from Goals
select * from RefStd
select * from Results
--Result Column Like (02:00:00.0000000) --> Must Fix
UPDATE Results
SET Result = CONCAT(HomeGoals, ':', AwayGoals);



--Number of Matches in Season   
--Total Matches Per Team Home and Away
select
	count(*) / (select count(distinct Home_team) from Results) *2
	as Total_Matches
	from RefStd
	


--Total Of Own Goals & Players Scored Own Goals
select
	isnull(GoalScorer, 'Total Own Goals') as GoalScorer,
	sum(cast(OG as int)) as Total_OG
	from Goals
	group by GoalScorer with rollup
	having sum(cast(OG as int)) > 0
	order by sum(cast(OG as int)) Desc

--Total Assists Most Player Make Assits
select
	isnull(Assist, 'Total Assist') as Player,
	count(Assist) as Count
	from Goals
	group by Assist with rollup
	order by count(Assist) Desc


--Total Penallties and Players
select
	isnull(GoalScorer, 'Total Penalties') as GoalScorer,
	sum(cast(Penalty as int)) as PenaltyScored
	from Goals
	group by GoalScorer with rollup
	order by sum(cast(Penalty as int)) Desc

--Most Goals Get From Which Assist Type?
select 
	isnull(AssistType,'Total Assists') as AssistType,
	Count(AssistType) as Count
	from Goals
	group by AssistType with rollup
	order by Count(AssistType) Desc

--Top Scorer
select 
	isnull(GoalScorer,'Total Goals') as GoalScorer,
	Count(GoalScorer) as Total
	from Goals
	group by GoalScorer with rollup
	order by Count(GoalScorer) Desc




--Players Scored Hat-tricks
select
	GoalScorer,
	count(*) as NunberOfGoals,
	CONCAT(Home_team, '  -  ', Away_team) as Teams,
	CONCAT(HomeGoals,':', AwayGoals) AS Result
	from Goals join Results
	on Goals.match_id = Results.match_id
	group by  GoalScorer,
			CONCAT(Home_team, '  -  ', Away_team),
			CONCAT(HomeGoals,':', AwayGoals)
	having count(*) > 2;
	

-------------------------------------------------REFREES AND STADUIMS-------------------------------------------
select * from RefStd

--Most Worked Refrees
select
	isnull(Referee, 'Total Matches') as Referee,
	count(Referee) as TotalMatches
	from RefStd
	group by Referee with rollup
	order by count(Referee) Desc

--Most Used Stadium
select
	isnull(Stadium, 'Total Matches') as Stadium,
	count(Stadium) as TotalMatchesPlayed
	from RefStd
	group by Stadium with rollup
	order by count(Stadium) Desc

-------------------------------------------------RESULTS-------------------------------------------
select * from Results

--Total Teams
select
	count(distinct Home_team)  as TotalTeams
	from Results

--Total Weeks in League
select
	count(distinct GameWeek) as TotalWeeks
	from Results

--Total Goals in League
select
	sum(HomeGoals) + Sum(AwayGoals) as TotalGoals
	from Results


--Time Preferred
select
	Time,
	Count(Time) as TotalMatches
	from Results
	group by Time
	order by Count(Time) Desc

--Matches Per Day in 2015
select
	Date,
	count(Date) as TotalMatchesPerDay
	from Results
	where Year(Date) = 2015
	group by Date with rollup
	order by Date 

--Matches Per Day in 2016
select
	Date,
	count(Date) as TotalMatchesPerDay
	from Results
	where Year(Date) = 2016
	group by Date with rollup
	order by Date 

--Day Preferred in EPL
select
	isnull(Day,'Total Matches') as Day,
	count(Day) as TotalMatches
	from Results
	group by Day with rollup
	order by count(Day) Desc


--Teams with Most Goals
select
	Home_team as Team,	
	sum(HomeGoals) as TotalGoals
	from Results
	group by Home_team
	
	union all

	select
	Away_team as Team,	
	sum(AwayGoals) as TotalGoals
	from Results
	group by Away_team
	order by Team 

--Teams Performance
with TeamPerformance as(
select
	Home_team as Team,
	case
		when Status='HomeWin' then 'HomeWin'
		when Status='Draw' then 'Draw'
		end as Status,
		count(*) as Count
		from Results
		where Status in ('HomeWin', 'Draw', 'Lose')
		group by Home_team, Status

		union all

select
	Away_team as Team,
	case
		when Status='AwayWin' then 'AwayWin'
		when Status='Draw' then 'Draw'
		end as Status,
		count(*) as Count
		from Results
		where Status in ('AwayWin', 'Draw')
		group by Away_team, Status
		)
		select
			isnull(Team, 'Total') as Team,
			isnull(Status, 'Lose') as Status,
			case
				when Team is not null and Status is null then 34 - isnull(sum(Count), 0)
				else sum(Count)
			end as TotalMatches,
			sum(
				case 
					when Status like '%Win' then Count * 3
					when Status like 'Draw' then Count * 1
					when Status like 'Lose' then Count * 0
					else 0
				end
			) as TotalPoints
		from TeamPerformance
		where Team is not null
		group by rollup (Team, Status)
		order by Team;

				
--Teams Played in Stadium more than 2
select
	Home_team,
	Stadium,
	count(*) as count
	from RefStd join Results
	on RefStd.match_id = Results.match_id
	group by Home_team, Stadium
	having count(*)>2
	order by Home_team



