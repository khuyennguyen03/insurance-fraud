--Claim cost relative to annual premium by policy state
SELECT p.policy_state, COUNT(*) AS total_claims, ROUND(AVG(p.policy_annual_premium), 2) AS avg_premium, ROUND(AVG(c.total_claim_amount), 2) AS avg_claim_amt, 
	ROUND(1.0 * SUM(c.total_claim_amount)/SUM(p.policy_annual_premium), 1) AS claim_to_premium_ratio
FROM policies p
JOIN incidents i ON p.policy_number = i.policy_number
JOIN claims c ON c.incident_id = i.incident_id
GROUP BY p.policy_state
ORDER BY claim_to_premium_ratio DESC