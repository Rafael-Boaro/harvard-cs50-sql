SELECT english_title AS "Título em Inglês", entropy AS "Complexidade"
FROM views
WHERE artist = 'Hokusai'
ORDER BY entropy DESC
LIMIT 5;
