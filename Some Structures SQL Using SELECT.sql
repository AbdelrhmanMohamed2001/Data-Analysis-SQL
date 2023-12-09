SELECT 1+1; 
SELECT 1 + /* this can also be an in-line comment */ 1;


SELECT 'Hello, SQL'; -- single quotes for strings
SELECT 'My', 'name', 'is', 'Ahmed'; -- select multiple values
SELECT 1, 'Test'; -- select different data types
SELECT 'Hello, SQL' AS greeting; -- alias





-- arithmetic
SELECT 1 + 2;
SELECT 5 % 2;
SELECT 5 / 2;
SELECT 5 * 2;


SELECT ABS(-5); -- absolute values
SELECT ASCII('a'), ASCII('ä');--get ascii code of character
SELECT ASCII('ab');
SELECT CHAR(57); --get character of ascii
SELECT CHAR(ASCII('d')); --both

-- date and time functions
SELECT DATEADD(day,24,'2022-12-08');
SELECT 
    DATEADD(day,24,'2022-12-08') as DATE_ADD,
    DAY('2022-12-08') as the_day,
    DATENAME(year,'2022-12-08') as theYear,
	DATENAME(MONTH,'2022-12-08') as THEmonth,
	DATENAME(day,'2022-12-08') as THEDAY,
    MONTH('2022-12-08') as the_month;
SELECT CURRENT_TIMESTAMP as CurrentDate;
SELECT DATEADD(year, 1, '2017/08/25') AS DateAdd;

-- string functions
SELECT CONCAT('my', 'name', 'is', 'prince');
SELECT CONCAT_WS(' ', 'my', 'name', 'is', 'prince');
SELECT LEN('ahmed');
SELECT LEN(CONCAT_WS(' ', 'my', 'name', 'is', 'prince'));
SELECT LOWER('AHMED');
SELECT LEFT('This is the a text', 10);
SELECT RIGHT('This is the a text', 10);
SELECT SUBSTRING('This is a long text', 6, 10);
SELECT TRIM('  bar   ');
SELECT TRIM(LEADING 'xb' FROM 'xbarx');  --delete characters from starting
SELECT TRIM(TRAILING 'x' FROM 'xbarx');  --delete characters from ending
SELECT TRIM(BOTH 'x' FROM 'xbarx');      --delete characters from both sides


--Variables Declration/ Intialization
declare @var5 as int = 5;
declare @vara as varchar(1)= 'a';


