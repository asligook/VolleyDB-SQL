SELECT name,surname,channel_name, contract_start, contract_finish
FROM Team
LEFT JOIN Coach ON Coach.username = Team.coach_username
WHERE STR_TO_DATE(contract_start, '%d.%m.%Y') <= STR_TO_DATE("02.09.2024", '%d.%m.%Y') 
AND STR_TO_DATE(contract_finish, '%d.%m.%Y') >= STR_TO_DATE("31.12.2025", '%d.%m.%Y') 
AND channel_name LIKE "%Digiturk%"
ORDER BY name;

-- Comments:
-- Firstly, join Coach and Team tables ON username and coach_username columns to access contract_start/finish, channel information together.
-- Check the contract duration condition with WHERE clause.
-- First check the given beginning date then the finish date.
-- Since contract_start and contract_finish columns' types are string, transform them into date format DD.MM.YYYY and check.
-- Then check the condition for the channel_name with LIKE "%Digiturk%".
-- Sort by name in ascending order with ORDER BY name (default is ASC)