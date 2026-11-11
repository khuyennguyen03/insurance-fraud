--Rank incident types by average claim within each incident state
SELECT i.incident_state, i.incident_type, COUNT(*) AS total_claims, ROUND(AVG(c.total_claim_amount), 2) AS avg_claim, 
	RANK() OVER (PARTITION BY i.incident_state ORDER BY AVG(c.total_claim_amount) DESC) AS rank_in_state
FROM claims c
JOIN incidents i ON c.incident_id = i.incident_id
GROUP BY i.incident_state, i.incident_type
HAVING COUNT(*) >= 10
