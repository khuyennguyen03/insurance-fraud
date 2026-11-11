 INSERT INTO policies (policy_number, policy_state, policy_csl, policy_deductable, policy_annual_premium, policy_bind_date, umbrella_limit)
 SELECT policy_number, policy_state, policy_csl, policy_deductable, policy_annual_premium, policy_bind_date, umbrella_limit
 FROM raw_claims
 WHERE policy_number IS NOT NULL AND policy_number != '';