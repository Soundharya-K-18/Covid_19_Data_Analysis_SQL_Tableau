# Covid_19_Data_Analysis_SQL_Tableau
COVID data analysis using SQL and Tableau dashboard 
📊 COVID-19 Data Analysis & Dashboard (SQL + Tableau)

📌 Project Overview

This project analyzes COVID-19 data (2020–2021) using SQL (MySQL) and visualizes insights using Tableau Dashboard.

The goal is to extract meaningful insights such as:

- Total cases and deaths
- Death percentage
- Infection rate by country
- Vaccination progress

---

🗂️ Dataset Used

Two datasets were used:

- "covid_deaths.csv"
- "covid_vaccinations.csv"

---

🛠️ Tools & Technologies

- MySQL Workbench (SQL Queries)
- Microsoft Excel (Data Export & Cleaning)
- Tableau (Dashboard Visualization)

---

🧠 Key SQL Operations Performed

1. Total Cases, Total Deaths & Death Percentage

SELECT 
    SUM(new_cases) AS TotalCases,
    SUM(CAST(new_deaths AS SIGNED)) AS TotalDeaths,
    (SUM(CAST(new_deaths AS SIGNED)) / SUM(new_cases)) * 100 AS DeathPercentage
FROM covid_deaths_csv
WHERE continent IS NOT NULL;

---

2. Highest Infection Rate by Country

SELECT 
    location,
    population,
    MAX(total_cases) AS HighestInfectionCount,
    MAX((total_cases / population)) * 100 AS PercentPopulationInfected
FROM covid_deaths_csv
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

---

3. Total Death Count by Country

SELECT 
    location,
    SUM(CAST(new_deaths AS SIGNED)) AS TotalDeathCount
FROM covid_deaths_csv
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

---

4. Vaccination Progress Analysis

SELECT 
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS SIGNED)) 
        OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM covid_deaths_csv dea
JOIN covid_vaccinations_csv vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

---

📊 Dashboard Features (Tableau)

The Tableau dashboard includes:

- 🌍 Global total cases, deaths, and death %
- 📈 Infection rate by country
- 🗺️ World map showing affected regions
- 📊 Death count comparison
- 📉 Trend analysis over time

---

📁 Project Structure

covid-data-analysis/
│
├── datasets/
│   ├── covid_deaths.csv
│   └── covid_vaccinations.csv
│
├── sql_queries/
│   └── queries.sql
│
├── outputs/
│   └── covid_analysis.xlsx
│
├── dashboard/
│   └── tableau_dashboard.twbx
│
└── README.md

---

🚀 Steps to Run the Project

1. Import CSV files into MySQL
2. Run SQL queries from "queries.sql"
3. Export results to Excel
4. Load Excel into Tableau
5. Create visualizations and dashboard

---

📌 Key Insights

- Identified countries with highest infection rates
- Calculated global death percentage (~2.2%)
- Analyzed vaccination trends over time
- Compared death counts across regions

---

💡 Conclusion

This project demonstrates:

- Strong SQL skills (joins, aggregations, window functions)
- Data cleaning and transformation
- Data visualization using Tableau

---

👩‍💻 Author

Soundharya K
Aspiring Data Analyst | SQL | Tableau | Excel
