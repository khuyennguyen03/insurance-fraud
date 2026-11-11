--Fraud rate by customer occupation 
SELECT cu.insured_occupation, COUNT(*) AS total_claims, ROUND(100.0 * AVG(CASE WHEN c.fraud_reported = 'Y' THEN 1 ELSE 0 END), 1) AS fraud_rate_pct
FROM customers cu
JOIN incidents i ON cu.policy_number = i.policy_number
JOIN claims c ON c.incident_id = i.incident_id
GROUP BY cu.insured_occupation
HAVING COUNT(*) >= 30
ORDER BY fraud_rate_pct DESC
