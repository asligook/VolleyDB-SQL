SELECT DISTINCT Player.name, Player.surname 
FROM SessionSquads
LEFT JOIN Position ON Position.position_id = SessionSquads.position_id
LEFT JOIN Player ON Player.username = SessionSquads.played_player_username
WHERE session_id in (
SELECT session_id
FROM MatchSession
WHERE stadium_name LIKE "%GD Voleybol Arena%"
)
AND position_name LIKE "%Libero%";

-- Comments:
-- For this query there are 2 conditions:
-- 1. In order to find the matches that are played in GD Voleybol Arena , the subquery is computed.
-- This condition is checked with WHERE session_id IN clause.
-- 2. Player position is Libero in that match.
-- This condition is checked with position_name LIKE "%Libero%".
-- Finally the name and surname of the players that are satisfying both conditions are found from the joined table.

