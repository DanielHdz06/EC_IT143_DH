----------Simpsons Dataset

------Q1: Can you provide a list of family members along with their job titles and hire dates? Include their names, member IDs, and departments.
------A:
SELECT 
    Member_ID,
    Name,
    Job_Title,
    Hire_Date,
    Department
FROM 
    Family_Data;

------Q2: I want to understand the financial transactions for each family member. Create a summary that shows the total debit and credit amounts for each member, along with transaction descriptions.
------A: 
SELECT 
    fb.Member_Name,
    SUM(fb.Debit) AS total_debit,
    SUM(fb.Credit) AS total_credit
FROM 
    FBS_VIza_Costmo fb
JOIN 
    Family_Data fd ON fb.Member_Name = fd.Name
GROUP BY 
    fb.Member_Name;

------Q3: Generate a report on the Planet Express expenses. I need a monthly breakdown of the total amount spent on each account category, including descriptions and card member details.
------A:
SELECT 
    YEAR(pe.Date) AS year,
    MONTH(pe.Date) AS month,
    pe.Category,
    pe.Card_Member,
    SUM(pe.Amount) AS total_amount
FROM 
    Planet_Express as pe
GROUP BY 
    YEAR(pe.Date), MONTH(pe.Date), pe.Category, pe.Card_Member;

--Q4: Provide a summary that shows the number of hires and terminations by department, along with the relevant dates.
----A:
SELECT 
    Department,
    COUNT(CASE WHEN Termination_Date IS NULL THEN 1 END) AS hires,
    COUNT(CASE WHEN Termination_Date IS NOT NULL THEN 1 END) AS terminations
FROM 
    Family_Data
GROUP BY 
    Department;

----Q5: I need detailed information on the managers of each family member. Include their names, job titles, departments, and hire dates.
----A:
SELECT 
    fd.Manager,
    mgr.Job_Title,
    mgr.Department,
    mgr.Hire_Date
FROM 
    Family_Data fd
JOIN 
    Family_Data mgr ON fd.Manager = mgr.Name;
