SELECT final_table.team_name, name , surname, final_table.day_count AS contract_duration
FROM 
(SELECT DISTINCT team_name , NULL AS coach_username, NULL AS day_count
FROM Team
WHERE team_name NOT IN
(SELECT team_name
FROM(SELECT table1.team_name, table1.coach_username, table1.day_count
FROM (SELECT team_name , coach_username , DATEDIFF(STR_TO_DATE(contract_finish, '%d.%m.%Y'),STR_TO_DATE(contract_start, '%d.%m.%Y')) AS day_count
FROM Team) AS table1
HAVING (team_name,day_count) IN
(SELECT team_name, MAX(day_count) AS day_count
FROM (SELECT team_name , coach_username , DATEDIFF(STR_TO_DATE(contract_finish, '%d.%m.%Y'),STR_TO_DATE(contract_start, '%d.%m.%Y')) AS day_count
FROM Team) AS table2
GROUP BY team_name) AND
(team_name , coach_username) IN
(SELECT team_name, coach_username
FROM Team
LEFT JOIN MatchSession ON MatchSession.team_ID = Team.team_ID
WHERE coach_username NOT IN 
(SELECT coach_username
FROM Team
LEFT JOIN MatchSession ON MatchSession.team_ID = Team.team_ID
WHERE rating <= 4.7))) AS semitable)

UNION ALL

SELECT table1.team_name, table1.coach_username, table1.day_count
FROM (SELECT team_name , coach_username , DATEDIFF(STR_TO_DATE(contract_finish, '%d.%m.%Y'),STR_TO_DATE(contract_start, '%d.%m.%Y')) AS day_count
FROM Team) AS table1
HAVING (team_name,day_count) IN
(SELECT team_name, MAX(day_count) AS day_count
FROM (SELECT team_name , coach_username , DATEDIFF(STR_TO_DATE(contract_finish, '%d.%m.%Y'),STR_TO_DATE(contract_start, '%d.%m.%Y')) AS day_count
FROM Team) AS table2
GROUP BY team_name) AND
(team_name , coach_username) IN
(SELECT team_name, coach_username
FROM Team
LEFT JOIN MatchSession ON MatchSession.team_ID = Team.team_ID
WHERE coach_username NOT IN 
(SELECT coach_username
FROM Team
LEFT JOIN MatchSession ON MatchSession.team_ID = Team.team_ID
WHERE rating <= 4.7))) AS final_table
LEFT JOIN Coach ON Coach.username = final_table.coach_username;

-- Comments:
-- For this query we have 2 conditions to check:
-- 1. 
-- Find coaches who have directed the team for the longest time period for each team (note that there can be multiple coaches having the maximum day count)
-- In table1: We have found the table_name , coach_username, day_count from Team table converting dates into date type ,using DATEDIFF.
-- To find the maximum day_count we used the HAVING condition and filter the rows having the maximum day_count.
-- After constructing this table and groupping it by team_name, coach_username we checked the second condition with HAVING .
-- 2. 
-- Coach must have not directed a match session with a rating lower than or equal to 4.7
-- To access team_name,coach_username, rating information at once for this condition, we joined Team and MatchSession tables on team_ID columns.
-- Then , we filtered coach_usernames that are not in this table with WHERE NOT IN and checked the 2nd condition as well.
-- We selected the DISTINCT team_name from Team table to find all teams in the VolleyDB.
-- In the description it says, if there are no coaches satisfying both conditions then the value should be None or Null.
-- So we found teams that are not satisfying 2 conditions at the same time(with NULL columns).
-- Then, we merged these 2 tables with UNION ALL and named as final_table.
-- Finally, in order to access Coach name, surname information we joined Coach and final_table ON username, coach_username columns.
