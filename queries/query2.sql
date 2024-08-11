SELECT session_ID, assigned_jury_username, rating, DATE_FORMAT(STR_TO_DATE(date, '%d.%m.%Y'), '%d/%m/%Y') AS date
FROM MatchSession
WHERE STR_TO_DATE(date, '%d.%m.%Y') < '2024-01-01'
ORDER BY STR_TO_DATE(date, '%d.%m.%Y') ASC;

-- Comments:
-- Select the required columns from the MatchSession table.
-- Transform the string date into date format
-- Add the condition of 'before 2024' with WHERE.
-- Sort in ascending order according to date with ORDER BY.
-- Finally, change the DD.YY.MMMM date format to DD/YY/MMMM according to the output.
