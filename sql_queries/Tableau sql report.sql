use covid;
-- Table1
select  sum(new_cases) as Totalcases ,sum(cast(new_deaths as signed)) as Totaldeaths, (sum(cast(new_deaths as signed))/sum(new_cases))*100 as Deathpercentage
from covid_deaths_csv
where continent is not null
-- group by date
order by Deathpercentage desc;

-- Table 2

Select location, SUM(cast(new_deaths as signed)) as TotalDeathCount
From covid_deaths_csv 
Where continent is not null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc;

-- Table 3
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid_deaths_csv
Group by Location, Population
order by PercentPopulationInfected desc;

-- Table 4
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid_deaths_csv
Group by Location, Population, date
order by PercentPopulationInfected desc;
