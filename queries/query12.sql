SELECT name, surname, table4.year, table4.average_rating
FROM(SELECT coach_username, year, AVG(rating) AS average_rating
FROM (SELECT team_name, rating, coach_username, SUBSTRING_INDEX(SUBSTRING_INDEX(date, '.', -1), '.', 1) AS year 
FROM MatchSession 
LEFT JOIN Team ON Team.team_ID = MatchSession.team_ID) AS table1

GROUP BY year, coach_username
HAVING AVG(rating) = (SELECT MAX(avg_rating) FROM (SELECT AVG(rating) AS avg_rating
FROM (SELECT team_name, rating, coach_username, SUBSTRING_INDEX(SUBSTRING_INDEX(date, '.', -1), '.', 1) AS year 
FROM MatchSession 
LEFT JOIN Team ON Team.team_ID = MatchSession.team_ID) AS table2

WHERE year = table1.year
GROUP BY team_name) AS table3)) AS table4

LEFT JOIN Coach ON Coach.username = table4.coach_username

ORDER BY year;

-- Comments:
-- In table1 : team_name, rating , coach_username, year information is selected from the joined table 
-- where Team and MatchSession tables were joined on team_ID columns.
-- Then the average rating of each team in a year is found by AVG(rating) in the inner subquery(table 2 ) and maximum of them is found by MAX(avg_rating)
-- in an outer subquery(table3)
-- Then the condition is checked with HAVING keyword, then this table is named as table4.
-- Finally, in order to reach the Coach name and surname information, Coach and table4 are joined on username and coach_username columns.
-- Required columns are selected from this joined table and sorted by year in ascending order with ORDER BY (default is ASC). 
