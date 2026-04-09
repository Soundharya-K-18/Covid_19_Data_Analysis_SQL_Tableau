use covid;

desc covid_deaths_csv;
desc covid_vaccinations_csv;
select * from covid_deaths_csv;

select * from covid_vaccinations_csv;

select location, date,total_cases, new_cases, total_deaths, population 
from covid_deaths_csv 
where continent is not null;

-- Looking at Total _cases vs Total_deaths

select location, date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage
from covid_deaths_csv
where continent is not null;
-- where location like '%Albania%';

-- Looking Total_cases va Population
select location, date, population, total_cases, (total_cases/population)*100 as CasesPercentage
from covid_deaths_csv
where continent is not null;
-- where location like '%Albania%';

-- Looking at countries vs High_cases vs populations

select location, population, max(total_cases) as HighCases, max((total_cases/population))*100 as CasesPercentage
from covid_deaths_csv
group by location, population
order by CasesPercentage desc;

-- Looking at Countries with hihdeaths vs population

select location, max(cast(total_deaths as signed ) ) as HighDeaths
from covid_deaths_csv
where continent is not null
group by location
order by Highdeaths desc;

-- Looking at Continents with hihdeaths vs population

select continent, max(cast(total_deaths as signed ) ) as HighDeaths
from covid_deaths_csv
where continent is not null
group by continent
order by Highdeaths desc;

-- Gobal Deathscases
select date, sum(new_cases) as Totalcases ,sum(cast(new_deaths as signed)) as Totaldeaths, (sum(cast(new_deaths as signed))/sum(new_cases))*100 as Deathpercentage
from covid_deaths_csv
where continent is not null
group by date
order by Deathpercentage desc;

-- Total Deathpercentage

select  sum(new_cases) as Totalcases ,sum(cast(new_deaths as signed)) as Totaldeaths, (sum(cast(new_deaths as signed))/sum(new_cases))*100 as Deathpercentage
from covid_deaths_csv
where continent is not null
-- group by date
order by Deathpercentage desc;


-- Vaccinations

select * from covid_vaccinations_csv;

-- Looking at Total Population vs Total Vaccinations

select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by dea.location, dea.date) as Totalvacc
from covid_deaths_csv dea 
join covid_vaccinations_csv vac
  on dea.location=vac.location
  and dea.date=vac.date
where dea.continent is not null;

-- Use CTE
with popvsvcc( continent,location,date,population,new_vaccination,Totalvacc) as
(select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by dea.location, dea.date) as Totalvacc
from covid_deaths_csv dea 
join covid_vaccinations_csv vac
  on dea.location=vac.location
  and dea.date=vac.date
where dea.continent is not null) 

select *,(Totalvacc/population)*100 as vaccpercentage from popvsvcc ;
-- Temp Table
drop table vacvsperc;
 CREATE TABLE Vacvsperc (
continent TEXT,
location TEXT,
date DATETIME,
population BIGINT,
new_vaccination DECIMAL(12,3),
Totalvacc DECIMAL(15,3)
);
 
 INSERT INTO Vacvsperc
SELECT 
dea.continent,
dea.location,
STR_TO_DATE(dea.date,'%m/%d/%Y'),
dea.population,
CAST(NULLIF(vac.new_vaccinations,'') AS DECIMAL(12,3)),
SUM(CAST(NULLIF(vac.new_vaccinations,'') AS DECIMAL(12,3)))
OVER (PARTITION BY dea.location ORDER BY STR_TO_DATE(dea.date,'%m/%d/%Y')) AS Totalvacc
FROM covid_deaths_csv dea
JOIN covid_vaccinations_csv vac
ON dea.location = vac.location
AND dea.date = vac.date;

Select * from Vacvsperc;

-- View

Create view percentpoluationvacc as
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by dea.location, dea.date) as Totalvacc
from covid_deaths_csv dea 
join covid_vaccinations_csv vac
  on dea.location=vac.location
  and dea.date=vac.date
where dea.continent is not null;

select * from percentpoluationvacc;
