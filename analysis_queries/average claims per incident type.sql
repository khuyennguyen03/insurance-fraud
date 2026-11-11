-- Query to find the average claim amount for each incident type
SELECT i.incident_type, ROUND(1.0 * AVG(c.total_claim_amount), 2) AS average_claim 
FROM claims c
JOIN incidents i ON c.incident_id = i.incident_id
GROUP BY i.incident_type
ORDER BY average_claim DESC