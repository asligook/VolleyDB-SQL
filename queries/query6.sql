SELECT team_name, name AS coach_name, surname AS coach_surname, table1.player_count
FROM (SELECT team_name, coach_username, COUNT(team) AS player_count
FROM Team
LEFT JOIN PlayerTeams ON PlayerTeams.team = Team.team_ID
GROUP BY team_ID) AS table1

LEFT JOIN Coach ON Coach.username = table1.coach_username;

-- Comments:
-- In table1 (subquery) team_name, coach_username and the player count of each team is found.
-- Team and PlayerTeams are joined on the team_ID and team columns because of the foreign key.
-- Then this table is groupped by the team_ID to find the player_count of each team.
-- Then we had a table with 3 columns(team_name, coach_username, player_count) as the output (table1).
-- Coach names and surnames are found by joining table1 and Coach tables on username and coach_username columns.
-- Columns are named as they are wanted in the provided results.








