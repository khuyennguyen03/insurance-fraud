INSERT INTO customers(policy_number, months_as_customer, age, insured_sex, insured_education_level, insured_occupation, insured_hobbies, insured_relationship, insured_zip, capital_gains, capital_loss)
SELECT policy_number, months_as_customer, age, insured_sex, insured_education_level, insured_occupation, insured_hobbies, insured_relationship, insured_zip, "capital-gains", "capital-loss"
FROM raw_claims
 WHERE policy_number IS NOT NULL AND policy_number != ''; 