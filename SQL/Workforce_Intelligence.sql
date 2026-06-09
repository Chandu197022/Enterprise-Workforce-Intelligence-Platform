/*=========================================================
  Enterprise Workforce Intelligence Platform
  HR Analytics SQL Script
=========================================================*/

USE Workforce_Intelligence;

/*=========================================================
  Executive KPI View
=========================================================*/

CREATE VIEW vw_Executive_KPIs
AS

SELECT

    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition='Yes' THEN 1
            ELSE 0
        END
    ) AS AttritionCount,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition='Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS AttritionRate,

    AVG(MonthlyIncome) AS AvgSalary,

    AVG(Age) AS AvgAge,

    AVG(YearsAtCompany) AS AvgTenure

FROM HR_Analytics;

/*=========================================================
  Department Attrition View
=========================================================*/

CREATE VIEW vw_Department_Attrition
AS

SELECT

    Department,

    COUNT(*) AS Employees,

    SUM(
        CASE
            WHEN Attrition='Yes' THEN 1
            ELSE 0
        END
    ) AS AttritionCount,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN Attrition='Yes' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS AttritionRate

FROM HR_Analytics

GROUP BY Department;

/*=========================================================
  Job Role Risk View
=========================================================*/

CREATE VIEW vw_JobRole_Risk
AS

SELECT

    JobRole,

    RiskCategory,

    COUNT(*) AS Employees

FROM HR_Analytics

GROUP BY
    JobRole,
    RiskCategory;

/*=========================================================
  Salary Analysis View
=========================================================*/

CREATE VIEW vw_Salary_Analysis
AS

SELECT

    Department,

    AVG(MonthlyIncome) AS AvgSalary,

    MIN(MonthlyIncome) AS MinSalary,

    MAX(MonthlyIncome) AS MaxSalary

FROM HR_Analytics

GROUP BY Department;

/*=========================================================
  Employee Experience View
=========================================================*/

CREATE VIEW vw_Employee_Experience
AS

SELECT

    Department,

    AVG(JobSatisfaction) AS JobSatisfaction,

    AVG(EnvironmentSatisfaction) AS EnvironmentSatisfaction,

    AVG(RelationshipSatisfaction) AS RelationshipSatisfaction,

    AVG(WorkLifeBalance) AS WorkLifeBalance,

    AVG(EmployeeExperienceIndex) AS ExperienceIndex

FROM HR_Analytics

GROUP BY Department;

/*=========================================================
  Retention Risk View
=========================================================*/

CREATE VIEW vw_Retention_Risk
AS

SELECT

    RiskCategory,

    COUNT(*) AS Employees,

    AVG(AttritionProbability) AS AvgProbability

FROM HR_Analytics

GROUP BY RiskCategory;

/*=========================================================
  Top Attrition Drivers Query
=========================================================*/

SELECT

    JobRole,

    COUNT(*) AS AttritionCases

FROM HR_Analytics

WHERE Attrition = 'Yes'

GROUP BY JobRole

ORDER BY AttritionCases DESC

LIMIT 10;

/*=========================================================
  Executive KPI Query
=========================================================*/

SELECT *
FROM vw_Executive_KPIs;

/*=========================================================
  Department Attrition Query
=========================================================*/

SELECT *
FROM vw_Department_Attrition;

/*=========================================================
  Job Role Risk Query
=========================================================*/

SELECT *
FROM vw_JobRole_Risk;

/*=========================================================
  Salary Analysis Query
=========================================================*/

SELECT *
FROM vw_Salary_Analysis;

/*=========================================================
  Employee Experience Query
=========================================================*/

SELECT *
FROM vw_Employee_Experience;

/*=========================================================
  Retention Risk Query
=========================================================*/

SELECT *
FROM vw_Retention_Risk;