SELECT name, surname, table2.rated_sessions

FROM (SELECT assigned_jury_username, COUNT(assigned_jury_username) AS rated_sessions
FROM MatchSession
GROUP BY assigned_jury_username) AS table2

LEFT JOIN Jury ON Jury.username = table2.assigned_jury_username

WHERE table2.rated_sessions IN 

(SELECT MAX(rated_sessions)
FROM 
(SELECT assigned_jury_username, COUNT(assigned_jury_username) AS rated_sessions
FROM MatchSession
GROUP BY assigned_jury_username) AS table1);

-- Comments:
-- In table1: The number of rated_sessions for each jury is selected from the MatchSession with groupping by assigned_jury_username.
-- Then the maximum number of rated_sessions is found by MAX(rated_sessions) from table1.and
-- After the maximum is found, the corresponding assigned_jury_username is found with WHERE, IN clauses.
-- In this case we have 1 maximum, however there might had been multiple, so checking with IN rather than = is better.
-- After we reached the assigned_jury_username, Jury name , surname information is selected.
-- To reach name and surname info. we need to join the MatchSession and Jury tables on assigned_jury_username and username columns.
