create database project1;
use project1;
SELECT AGE FROM ATHLETE_EVENTS;
CREATE TABLE ATHLETE_EVENTS(
id int,
name varchar(60),
sex varchar(10),
age varchar(10),
height varchar(10),
weight varchar(10),
team varchar(40),
noc varchar(30),
games varchar(60),
year int,
season varchar(30),
city varchar(30),
sport varchar(30),
event varchar(100),
medal varchar(20)
);
select * from athlete_events;


create table noc_regions(
noc varchar(20),
region varchar(30),
notes varchar(40)
);
select * from noc_regions;

UPDATE ATHLETE_EVENTS SET MEDAL = NULL WHERE MEDAL="NA";
UPDATE ATHLETE_EVENTS SET HEIGHT=NULL WHERE HEIGHT="NA";
UPDATE ATHLETE_EVENTS SET WEIGHT=NULL WHERE WEIGHT="NA";
UPDATE ATHLETE_EVENTS SET AGE=NULL WHERE AGE="NA";
SET SQL_SAFE_UPDATES=0;

#1.Get the number of medals by country
select team,count(medal) as total_medals from athlete_events
where medal is not null
group by team
order by total_medals desc;

#2.count of total events 
select count(event)from athlete_events;

#3.list all distinct sports 
select distinct sport from athlete_events;

#4.list all olympic games edition 
select distinct year,season,city from athlete_events
order by year;

#5.count athletes per team
select team,count(name)as athletes from athlete_events
group by team order by athletes desc;

#6. Gold medals by country
select team,medal,count(medal)as count_of_Goldmedal from athlete_events
where medal="Gold"
group by team
order by count_of_Goldmedal desc;

#7.Total medals by athlete
select name,count(medal)as medal_count from athlete_events
group by name
order by medal_count desc;

#8.top 5 medalist in swimming
select count(medal)as Count_of_medals,team,name from athlete_events where sport="swimming" and medal is not null
group by name,team
order by count(medal)desc
limit 5 ;

#9.Youngest medalist
select name,age,team,sport,medal from athlete_events
where medal IS NOT NULL and age is not null
order by age asc limit 1;

#10.Gender participation over the years
select year,sex,count(name)as athlete_count
from athlete_events
group by sex,year
order by year asc;

#11.All medal winners from india
select name,team,city,year,medal from athlete_events
where team="India"and medal IS NOT NULL;

#12.Top 10 teams by gold medal percentage

SELECT Team,
COUNT(CASE WHEN Medal = 'Gold' THEN 1 END) * 100.0 / COUNT(*) AS gold_percentage
FROM athlete_events
WHERE Medal IS NOT NULL
GROUP BY Team
HAVING COUNT(*) >= 10
ORDER BY gold_percentage DESC
LIMIT 10;

#13.Join athletes with region names
SELECT a.Name, a.Sex, a.Team, n.region
FROM athlete_events a
LEFT JOIN noc_regions n ON a.NOC = n.NOC;

#14.Total medals by region
select count(a.medal)as total_medal,n.region from athlete_events a
left join noc_regions n on a.noc=n.noc
where a.medal IS NOT NULL
group by n.region
order by total_medal desc;

#15.Tallest gold medalist
select name AS Tallest_gold_medalist,max(height)as height,medal,year from athlete_events
where medal IS NOT NULL and height IS NOT NULL
group by name,medal,year
order by height desc limit 1;

#16.Top countries in Winter Olympics
select noc.region,count(a.medal)as medal_count,a.season  from athlete_events a 
join noc_regions noc on a.noc=noc.noc
where medal is not null and season="Winter"
group by noc.region,a.season
order by medal_count desc
limit 10;

#17.First medal won by each country
Select min(year)as year,medal,team,sport from athlete_events
where medal is not null and year is not null
group by medal,team,year,sport
order by year;

#18.Year with the most medals awarded
select year, medal,count(medal) as count_medal from athlete_events
where medal is not null 
group by year,medal
order by count_medal desc
limit 1;

#19.Countries that have never won a medal
select team,medal,noc from athlete_events
where medal is null
group by team,medal,noc
order by team;

#20. Distribution of medals by individual vs team events 
select medal,event, count(distinct id)as no_of_athletes from athlete_events
where medal is not null
group by event,medal
order by count(distinct id) desc;