--Fraud rate and average claim amount per age group (30-45, 45+, and under 30)
SELECT  CASE WHEN cu.age < 30 THEN 'Under 30' WHEN cu.age <= 45 THEN '30-45' ELSE 'Over 45' END AS age_group, ROUND(AVG(c.total_claim_amount), 2) AS average_claim_amt, COUNT(*) AS total_claims, ROUND(100.0 * AVG(CASE WHEN c.fraud_reported = 'Y' THEN 1 ELSE 0 END), 1) AS fraud_rate_pct
FROM customers cu
JOIN incidents i ON cu.policy_number = i.policy_number
JOIN claims c ON c.incident_id = i.incident_id
GROUP BY age_group
ORDER BY fraud_rate_pct DESC