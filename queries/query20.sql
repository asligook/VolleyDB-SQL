SELECT table2.name, table2.surname, 
CASE 
WHEN table2.user_count > 1 THEN "TRUE"
ELSE "FALSE"
END as more_than_one
FROM(SELECT name, surname, user_count
FROM
(SELECT username , COUNT(username) AS user_count
FROM PlayerPositions
GROUP BY username) AS table1
LEFT JOIN Player ON Player.username = table1.username) AS table2
ORDER BY name;

-- Comments:
-- In table1: The username and the occurrence of each username in PlayerPositions table is found with group by username and COUNT(username).
-- In table2: Player name, surname information is obtained by joining Player and table1 on username columns.
-- Then a new column "more_than_one" is created and its value is obtained by the WHERE conditions.
-- If user_count > 1 then the value will be TRUE, otherwise FALSE.