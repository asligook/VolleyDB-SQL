SELECT name, surname
FROM Player
WHERE SUBSTRING_INDEX(SUBSTRING_INDEX(date_of_birth, '/', -1), '/', 1) =
(SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(date_of_birth, '/', -1), '/', 1) 
FROM Player
WHERE name LIKE "%Ebrar%" AND surname LIKE "%Karakurt%") 
AND height >
(SELECT height
FROM Player
WHERE name LIKE "%Ebrar%" AND surname LIKE "%Karakurt%") 
ORDER BY surname ;

-- Comments:
-- In order to find names and surnames of players who were born in the same year as “Ebrar Karakurt” and who are taller than her:
-- We have 2 conditions to check within the subqueries with WHERE clauses.
-- 1. Find Ebrar Karakurt's year of birth in the first subquery.
-- Year is found by selecting the year from the date column (DD/MM/YYYY) WHERE name LIKE "%Ebrar%" AND surname LIKE "%Karakurt%" from Player table.
-- 2. Find Ebrar Karakurt's height in the second subquery.
-- Height is found by selecting height WHERE name LIKE "%Ebrar%" AND surname LIKE "%Karakurt%" from Player table.
-- Sort the output by surname in ascending order with ORDER BY (default is ASC).