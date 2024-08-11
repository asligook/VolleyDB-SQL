SELECT name, surname, diff_coach AS directed_stadium_count
FROM(SELECT coach_username, diff_coach
FROM(SELECT coach_username, COUNT(coach_username) as diff_coach
FROM(SELECT stadium_name, COUNT(stadium_name) AS stad_count, coach_username
FROM Team
JOIN MatchSession ON MatchSession.team_ID = Team.team_ID
JOIN Coach ON Coach.username = Team.coach_username
GROUP BY coach_username, stadium_name) AS table1
GROUP BY coach_username) AS table2
WHERE diff_coach = (SELECT COUNT(DISTINCT stadium_name) FROM MatchSession)) AS table3
LEFT JOIN Coach ON Coach.username = table3.coach_username ;

-- Comments:
-- In table1: Find the number of match_sessions that are played in each stadium that are directed by each coach.
-- We obtained this result by joining Team, MatchSession, Coach tables and grouping by coach_username and stasium_name columns together.
-- In table2: the number of stadiums that each coach directed in are found by COUNT(coach_username) as diff_coach with grouping by coach_username.
-- Then the total number of distinct stadiums in our database is found by SELECT COUNT(DISTINCT stadium_name) FROM MatchSession and this condition is checked by WHERE.
-- In table3: The coach_username mets this condition and the diff_coach are returned.
-- Finally, in order to access Coach name, surname information join Coach and table3 on username and coach_username columns.
