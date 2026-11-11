INSERT INTO vehicles(policy_number, auto_make, auto_model, auto_year)
SELECT policy_number, auto_make, auto_model, auto_year
FROM raw_claims
WHERE policy_number IS NOT NULL AND policy_number != ''; 