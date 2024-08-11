SELECT session_ID, name, surname , stadium_name, stadium_country , team_name
FROM (SELECT session_ID, stadium_name, stadium_country ,team_name, coach_username
FROM Team
LEFT JOIN MatchSession ON MatchSession.team_ID = Team.team_ID) AS table1
LEFT JOIN Coach ON Coach.username = table1.coach_username
WHERE name LIKE "%Daniele%" AND surname LIKE "%Santarelli%" AND stadium_country NOT LIKE "%UK%"
ORDER BY session_ID;

-- Comments:
-- In table1 : MatchSession and Team tables are joined on team_ID columns in order to access session, stadium ,team , coach information together.
-- Then, in order to reach Coach name and surname information, Coach and table1 are joined on username, coach_username columns.
-- For this query there are 2 conditions to check:
-- 1. Coach is "Daniele Santarelli" checked by name LIKE "%Daniele%" AND surname LIKE "%Santarelli%"
-- 2. Not played in UK checked by stadium_country NOT LIKE "%UK%"
-- Finally , select rows that are satisfying both conditions and sort by session_ID with ORDER BY (default is ASC)