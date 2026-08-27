SELECT schools.name, graduation_rates.graduated
FROM schools
JOIN graduation_rates ON schools.id = graduation_rates.school_id
ORDER BY graduation_rates.graduated ASC
LIMIT 10;
