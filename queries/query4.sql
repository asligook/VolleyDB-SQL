SELECT assigned_jury_username, stadium_name
FROM MatchSession
WHERE rating = (
SELECT MAX(rating)
FROM MatchSession)
ORDER BY assigned_jury_username DESC;

-- Comments:
-- Select assigned_jury_username and stadium_name columns from MatchSession table where the session has the maximum rating.
-- The maximum rating in the MatchSession table is found by MAX(rating).
-- Sort by assgined_jury_username in descending order with ORDER BY , DESC.


