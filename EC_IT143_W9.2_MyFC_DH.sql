--------MyFC Dataset
--------Q1: Can you provide a list of players along with their current salary as of the latest available date? Include player names, player numbers, team codes, and positions.
--------A:
SELECT 
    pd.pl_name,
    pd.pl_num,
    td.t_code,
    pos.p_name,
    pf.mtd_salary
FROM 
    tblPlayerDim pd
JOIN 
    tblPlayerFact pf ON pd.pl_id = pf.pl_id
JOIN 
    tblTeamDim td ON pd.t_id = td.t_id
JOIN 
    tblPositionDim pos ON pd.p_id = pos.p_id
WHERE 
    pf.as_of_date = (SELECT MAX(as_of_date) FROM tblPlayerFact);

--------Q2: Can you create a summary that shows the average monthly salary for each player by their team and position?
--------A:
SELECT 
    pd.pl_name,
    pd.pl_num,
    td.t_code,
    pos.p_name,
    AVG(pf.mtd_salary) AS avg_monthly_salary
FROM 
    tblPlayerDim pd
JOIN 
    tblPlayerFact pf ON pd.pl_id = pf.pl_id
JOIN 
    tblTeamDim td ON pd.t_id = td.t_id
JOIN 
    tblPositionDim pos ON pd.p_id = pos.p_id
GROUP BY 
    pd.pl_name, pd.pl_num, td.t_code, pos.p_name;

--------Q3: Please generate a report on the players' positions. I want to see each position's target value and how many players are assigned to each position across different teams.
--------A:
SELECT 
    pos.p_name,
    pos.p_target,
    COUNT(pd.pl_id) AS player_count,
    td.t_code
FROM 
    tblPositionDim pos
JOIN 
    tblPlayerDim pd ON pos.p_id = pd.p_id
JOIN 
    tblTeamDim td ON pd.t_id = td.t_id
GROUP BY 
    pos.p_name, pos.p_target, td.t_code;

--------Q4: Provide a breakdown of the total monthly salary expenditure for each team and include the number of players per team.
--------A:
SELECT 
    td.t_code,
    SUM(pf.mtd_salary) AS total_salary_expenditure,
    COUNT(pd.pl_id) AS player_count
FROM 
    tblTeamDim td
JOIN 
    tblPlayerDim pd ON td.t_id = pd.t_id
JOIN 
    tblPlayerFact pf ON pd.pl_id = pf.pl_id
GROUP BY 
    td.t_code;

--------Q5: Find detailed information on the top three highest-paid players. Include their names, player numbers, team codes, positions, and monthly salaries.
--------A:
SELECT 
    pd.pl_name,
    pd.pl_num,
    td.t_code,
    pos.p_name,
    pf.mtd_salary
FROM 
    tblPlayerDim AS pd
JOIN 
    tblPlayerFact pf ON pd.pl_id = pf.pl_id
JOIN 
    tblTeamDim td ON pd.t_id = td.t_id
JOIN 
    tblPositionDim pos ON pd.p_id = pos.p_id
ORDER BY 
    pf.mtd_salary DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

