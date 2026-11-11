CREATE TABLE vehicles (
	policy_number INTEGER PRIMARY KEY,
	auto_make TEXT,
	auto_model TEXT,
	auto_year INTEGER,
	FOREIGN KEY (policy_number) REFERENCES policies(policy_number)
);