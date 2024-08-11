SELECT name, surname, average_rating
FROM
(SELECT table1.coach_username, AVG(rating) AS average_rating
FROM(SELECT coach_username, rating
FROM MatchSession
LEFT JOIN Team ON Team.team_ID = MatchSession.team_ID
LEFT JOIN Coach ON Coach.username = Team.coach_username) AS table1
GROUP BY coach_username
ORDER BY average_rating DESC) AS table2
LEFT JOIN Coach ON Coach.username = table2.coach_username
ORDER BY name DESC;

-- Comments:
-- In table1: Select coach_username , rating columns from joined table.
-- Coach_username information is stored in Team and Coach tables, rating information is stored in MatchSession table.
-- So, join these 3 tables to access both.
-- In table2: Find average rating with AVG(rating) and group by coach_username to find the average rating of match sessions that are directed by each coach. 
-- Finally, in order to access Coach name, surname information join Coach and table2 on username and coach_username columns.
-- Sort by name in descending order with ORDER BY DESC.




