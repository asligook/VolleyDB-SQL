SELECT *
FROM MatchSession
WHERE rating = (
    SELECT MIN(rating)
    FROM MatchSession);

-- Comments:
-- Select all columns from MatchSession table where the session has the minimum rating.
-- Minimum rating is found with MIN(rating) from MatchSession table.




