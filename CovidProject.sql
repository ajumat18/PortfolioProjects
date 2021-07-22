Select Location,date,total_cases,new_cases,total_deaths,population
FROM [PortfolioProject].[dbo].[CovidDeaths]
Order By 1,2

-- Deaths Percentage for Every Case
Select Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
FROM [PortfolioProject].[dbo].[CovidDeaths]
where Location='United Kingdom'
Order By 1,2

-- Total cases vs population
-- shows what percentage of population has got covid
Select Location,date,population,total_cases,(total_cases/population)*100 as CovidPercentage
FROM [PortfolioProject].[dbo].[CovidDeaths]
where Location='United Kingdom'
Order By 1,2

-- Countries with highest infection rate compared to population
Select Location, population, MAX(total_cases) AS TotalCases, MAX((total_cases/population)*100) as PercentagePopulationInfected
FROM [PortfolioProject].[dbo].[CovidDeaths]
Group By Location,Population
Order By PercentagePopulationInfected desc

-- Showing Countries with the highest death count per population
Select Location, MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM [PortfolioProject].[dbo].[CovidDeaths]
where continent is not null
Group By Location
Order By TotalDeathCount desc

-- Covid Deaths By Continent
Select continent, MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM [PortfolioProject].[dbo].[CovidDeaths]
where continent is not null
Group By continent
Order By TotalDeathCount desc

-- GLOBAL CASES, DEATHS WITH DATES
select date,sum(new_cases) as TotalCases,sum(cast(new_deaths as int)) as TotalDeaths, (sum(cast(new_deaths as int))/sum(new_cases))*100 as DeathPercentage
from [PortfolioProject].[dbo].[CovidDeaths]
where continent is not null
group by date
order by date

-- TOTAL CASES, DEATHS AND PERCENTAGE
select sum(new_cases) as TotalCases,sum(cast(new_deaths as int)) as TotalDeaths, (sum(cast(new_deaths as int))/sum(new_cases))*100 as DeathPercentage
from [PortfolioProject].[dbo].[CovidDeaths]
where continent is not null


-- TOTAL POPULATION VS VACCINATION
Select dea.continent,dea.location, dea.date,dea.population,vac.new_vaccinations
from CovidDeaths dea
JOIN CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3


-- creating view to store data for later visualization
create view ContinentDeath as
Select continent, MAX(cast(total_deaths as int)) AS TotalDeathCount
FROM [PortfolioProject].[dbo].[CovidDeaths]
where continent is not null
Group By continent
--Order By TotalDeathCount desc
