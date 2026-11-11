 CREATE TABLE policies (
	policy_number INTEGER PRIMARY KEY,
	policy_state TEXT,
	policy_csl TEXT,
	policy_deductable INTEGER,
	policy_annual_premium REAL,
	policy_bind_date TEXT,
	umbrella_limit INTEGER
);
