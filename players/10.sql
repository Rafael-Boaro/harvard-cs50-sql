SELECT first_name AS "Primeiro Nome", last_name AS "Sobrenome", height AS "Altura"
FROM players
WHERE birth_country = 'USA'
ORDER BY height DESC
LIMIT 5;
