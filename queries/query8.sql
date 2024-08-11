SELECT name, surname
FROM Coach
WHERE Coach.username IN
(SELECT coach_username
FROM MatchSession
LEFT JOIN Team ON Team.team_ID = MatchSession.team_ID
GROUP BY coach_username
HAVING COUNT(coach_username) >= 2)
ORDER BY surname DESC;

-- Comments :
-- In order to find the coach_usernames of the coaches who have directed more than or equal to 2 match sessions:
-- 1. Team and MatchSession tables are joined on the team_ID columns (foreign key).
-- 2. Then, we groupped by coach_surname, and filter the coaches who have directed more than or equal to 2 match sessions with
-- 3. HAVING COUNT(coach_username) >= 2 condition in the subquery.
-- Finally names and surnames of coaches are selected from Coach table whose coach_username in the ouput of the subquery.
-- This condition is checked with WHERE , IN keywords.
-- The output is sorted by surname in descending order with ORDER BY , DESC.

