CREATE TABLE customers(
	policy_number INTEGER PRIMARY KEY,
	months_as_customer INTEGER,
	age INTEGER,
	insured_sex TEXT,
	insured_education_level TEXT,
	insured_relationship TEXT,
	insured_zip TEXT,
	insured_occupation TEXT,
	insured_hobbies TEXT,
	capital_gains INT,
	capital_loss INT,
	FOREIGN KEY (policy_number) REFERENCES policies(policy_number)
);