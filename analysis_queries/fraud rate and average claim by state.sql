--fraud rate and average claim amount by state
SELECT i.incident_state, COUNT(*) AS total_claims, ROUND(100.0 * AVG(CASE WHEN c.fraud_reported = 'Y' THEN 1 ELSE 0 END), 1) AS fraud_rate_pct, ROUND(AVG(c.total_claim_amount), 2) AS average_claim_amt
FROM claims c
JOIN incidents i ON c.incident_id = i.incident_id
GROUP BY i.incident_state
ORDER BY fraud_rate_pct DESC
