SELECT table2.session_ID , name, surname
FROM
(SELECT *
FROM (SELECT session_ID, coach_username, SUBSTRING_INDEX(SUBSTRING_INDEX(date, '.', -1), '.', 1) AS year
FROM MatchSession
LEFT JOIN Team ON Team.team_ID = MatchSession.team_ID) AS table1
WHERE table1.year > "2023" ) AS table2
LEFT JOIN Coach ON Coach.username = table2.coach_username
WHERE name NOT LIKE "%Ferhat%" AND surname NOT LIKE "%Akbas%";

-- Comments:
-- In table1: Select session_ID, coach_username and year columns from the joined table(Join Team and Match on team_ID column).
-- In table2: Filter rows that are satisfying "played after 2023" condition with WHERE .
-- In order to reach Coach name and surname information, join Coach and table2 on username and coach_username_columns.
-- Finally select session_ID , name , surname columns met "not directed by Ferhat Akbas" condition with WHERE.

