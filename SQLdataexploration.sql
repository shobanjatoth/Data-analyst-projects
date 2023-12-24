
select *from CovidDeaths where continent is not null order by 3,4;
---table1--
select location,date,total_cases,new_cases,total_deaths,population 
from CovidDeaths where continent is not null order by 1,2;

----total deaths vs total cases and deathrate--

select location,total_cases,new_cases,total_deaths,date,population, (total_deaths/total_cases)*100
as 
deatpercnt from CovidDeaths
where location like '%indi%' and 
continent is not null order by 1,2;

--number of people affected by infection

select location,date,total_cases,population,(total_cases/population)*100 as
infected_percent from CovidDeaths
where continent is not null order by 1,2;

-------table for max total_cases ans max percentage of infected population
SELECT Location,population,MAX(total_cases) as HighestInfectionCount ,max((total_cases/population))*100 as
Infectedpercent from CovidDeaths group by Location, Population
order by Infectedpercent desc
;
-------------------show that the percentage of population infected by covid
Select location,date,population,total_cases,(total_cases/population)*100 as InfectedPopulationPercent FROM CovidDeaths
order by 1,2;
---highest death count in country--

SELECT continent ,max(cast(total_deaths as int)) AS Totaldeath from CovidDeaths 
where  continent is not null group by  continent order by
Totaldeath desc;
----------------total table2

Select SUM(new_cases) as total_cases, 
SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100
as DeathPercentage
From CovidDeaths
where continent is not null 
order by 1,2

--- Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) 
as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3
------------

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated

From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

---Using Temp Table to perform Calculation on Partition By in previous query


Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
----
Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated

From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date

	-----------
	Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated
----Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated

From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
---checking view
select *from PercentPopulationVaccinated;
