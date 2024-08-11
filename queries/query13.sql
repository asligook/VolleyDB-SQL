SELECT stadium_name, name, surname, table4.directed_count
FROM 

(SELECT *
FROM
(SELECT table5.coach_username, COUNT(coach_username) AS directed_count, stadium_name
FROM
(SELECT coach_username, stadium_name
FROM MatchSession

LEFT JOIN Team ON Team.team_ID = MatchSession.team_ID) AS table5

GROUP BY coach_username, stadium_name) AS table2

HAVING (directed_count, stadium_name) IN
(SELECT MAX(directed_count) AS max_count, stadium_name
FROM
(SELECT table1.coach_username, COUNT(coach_username) AS directed_count, stadium_name
FROM
(SELECT coach_username, stadium_name
FROM MatchSession

LEFT JOIN Team ON Team.team_ID = MatchSession.team_ID) AS table1

GROUP BY coach_username, stadium_name) AS table3
GROUP BY stadium_name)) AS table4

LEFT JOIN Coach ON Coach.username = table4.coach_username;

-- Comments:
-- In table1: The coach and the played stadium_name of each match is found by joining Team and MatchSession tables on team_ID columns.
-- In table3: coach_username, directed_count and stadium_name columns are selected to find:
-- the number of matches that are directed by each coach at each stadium is found by groupping by coach_username and stadium_name.
-- Then the highest number of matches in each stadium is found and this output table is turned into a condition with HAVING,IN.
-- Since there can be multiple maximums, IN is used rather than =.
-- In table2: coach_username and stadium_name colums are obtained from the joined table.
-- In table5 : Filter rows that are satisfying the condition in HAVING clause, grop by stadium_name and name this new table as table4.
-- Finally, in order to get the Coach name and surname information, join Coach table with table4 on username and coach_username columns.


