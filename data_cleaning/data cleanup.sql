--Checking claim total
SELECT claim_id, total_claim_amount, injury_claim + property_claim + vehicle_claim AS expected_claim_amt
FROM claims
WHERE total_claim_amount != expected_claim_amt;

--Checking for NULLS in claim amounts
SELECT COUNT(*) AS rows_with_null
FROM claims
WHERE total_claim_amount IS NULL OR injury_claim IS NULL OR property_claim IS NULL OR vehicle_claim IS NULL;

--Checking which incident types have '?' for collison_type
--Returned only parked car and vehicle theft
SELECT incident_type, COUNT(*)
FROM incidents
WHERE collision_type = '?'
GROUP BY incident_type;

--Recoding the '?' placeholders
UPDATE incidents SET collision_type = 'Not Applicable' WHERE collision_type IS NULL OR collision_type = '';
UPDATE incidents SET property_damage = NULL WHERE property_damage = '?';
UPDATE incidents SET police_report_available = NULL WHERE police_report_available = '?';