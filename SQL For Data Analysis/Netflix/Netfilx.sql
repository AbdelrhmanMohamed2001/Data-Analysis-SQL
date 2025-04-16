select * from netflix_titles

ALTER TABLE netflix_titles 
ALTER COLUMN show_id VARCHAR(255);

ALTER TABLE netflix_titles 
ALTER COLUMN type VARCHAR(255);

ALTER TABLE netflix_titles 
ALTER COLUMN title VARCHAR(255);

ALTER TABLE netflix_titles 
ALTER COLUMN director VARCHAR(255);

ALTER TABLE netflix_titles 
ALTER COLUMN cast VARCHAR(Max);

ALTER TABLE netflix_titles 
ALTER COLUMN country VARCHAR(255);

ALTER TABLE netflix_titles 
ALTER COLUMN date_added date;

ALTER TABLE netflix_titles 
ALTER COLUMN release_year int;

ALTER TABLE netflix_titles 
ALTER COLUMN rating VARCHAR(255);

ALTER TABLE netflix_titles 
ALTER COLUMN duration VARCHAR(255);

ALTER TABLE netflix_titles 
ALTER COLUMN listed_in VARCHAR(255);

ALTER TABLE netflix_titles 
ALTER COLUMN description VARCHAR(255);

EXEC sp_rename 'netflix_titles.show_id', 'ShowID', 'COLUMN';
EXEC sp_rename 'netflix_titles.country', 'Country', 'COLUMN';
EXEC sp_rename 'netflix_titles.type', 'Type', 'COLUMN';
EXEC sp_rename 'netflix_titles.title', 'Title', 'COLUMN';
EXEC sp_rename 'netflix_titles.director', 'Director', 'COLUMN';
EXEC sp_rename 'netflix_titles.cast', 'Casting', 'COLUMN';
EXEC sp_rename 'netflix_titles.date_added', 'DateAdded', 'COLUMN';
EXEC sp_rename 'netflix_titles.release_year', 'ReleaseYear', 'COLUMN';
EXEC sp_rename 'netflix_titles.rating', 'Rating', 'COLUMN';
EXEC sp_rename 'netflix_titles.duration', 'Duration', 'COLUMN';
EXEC sp_rename 'netflix_titles.listed_in', 'ListedIn', 'COLUMN';
EXEC sp_rename 'netflix_titles.description', 'Description', 'COLUMN';




select * from netflix_titles

-- 1. Count the number of Movies vs TV Shows
select 
	Type,
	count(Type) as Count
	from netflix_titles
	group by Type

-- 2. Find the most common rating for movies and TV shows
with Sorted as(
select
	Type,
	Rating,
	count(Rating) as Count,
	rank() over(partition by Type order by count(Rating)Desc) as Rank
	from netflix_titles
	group by type, Rating
	)
	select
		Type,
		Rating,
		Count
		from Sorted
		where rank = 1;
	


	
	
-- 3. List all movies released in a specific year (e.g., 2020)
select *
	from netflix_titles
	where ReleaseYear = 2020

-- 4. Find the top 5 countries with the most content on Netflix
select top 5
	value as TheCountry,
	Count(ShowId) as Count
	from netflix_titles
	cross apply string_split(Country, ',')
	group by value
	order by count(ShowID) Desc

-- 5. Identify the longest movie 
select * from netflix_titles
select
	* 
	from netflix_titles
	where Type= 'Movie'
	and 
	Duration= (select Max (Duration) from netflix_titles)

--6. Find content added in the last 5 years
select 
	*
	from netflix_titles
	where Year(DateAdded) between 2017 and 2021 and Year(DateAdded) is not null  
	order by Year(DateAdded) Desc

-- Find all the movies/TV shows by director 'Rajiv Chilaka'!
select 
	*
	from netflix_titles
	where Director= 'Rajiv Chilaka'

--8. List all TV shows with more than 5 seasons
select 
	*
	from netflix_titles
	where Type = 'TV Show'
	and Duration not in ('1 Season','2 Seasons','3 Seasons','4 Seasons','5 Seasons')

	 --------------OR------------------

select 
	*
	from netflix_titles
	where Type= 'TV Show'
	and TRY_CAST(LEFT(Duration, CHARINDEX(' ', Duration) - 1) AS INT) > 5


-- 9. Count the number of content items in each genre
select distinct
	Type,
	value as Genre,
	count(ShowID) as Count
	from netflix_titles
	cross apply string_split(ListedIN, ',')
	group by Type,value
	order by Type, Genre

--10. List all movies that are documentaries
select 
	*
	from netflix_titles
	where ListedIn like('%Documentaries%')

--Find all content without a director
select 
	*
	from netflix_titles
	where Director is null

--Find how many movies actor 'Salman Khan' appeared in last 10 years!
select 
	*,
	count(*) over() as Count
	from netflix_titles
	where Casting Like ('%Salman Khan%') and ReleaseYear > 2014

--Find the top 10 actors who have appeared in the highest number of movies produced in India.
select top 10
	value as Actors,
	count(*)   as Count
	from netflix_titles
	cross apply string_split(Casting, ',')
	where Country= 'India' 
	group by value
	order by count(*) Desc


	

	


