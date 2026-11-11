-- What is the percentage of fraud reported per incident type
SELECT i.incident_type, COUNT(*) AS total_claims, ROUND(100.0 * AVG(CASE WHEN c.fraud_reported = 'Y' THEN 1 ELSE 0 END), 1) AS fraud_rate_pct
FROM claims c
JOIN incidents i ON c.incident_id = i.incident_id
GROUP BY i.incident_type
ORDER BY fraud_rate_pct DESC