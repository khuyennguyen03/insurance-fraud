INSERT INTO claims (incident_id, total_claim_amount, injury_claim, property_claim, vehicle_claim, fraud_reported)
SELECT i.incident_id, r.total_claim_amount, r.injury_claim, r.property_claim, r.vehicle_claim, r.fraud_reported
FROM raw_claims r
JOIN incidents i ON r.policy_number = i.policy_number;