CREATE TABLE incidents (
	incident_id INTEGER PRIMARY KEY,
	policy_number INT,
	incident_type TEXT,
	incident_date TEXT,
	incident_severity TEXT,
	collision_type TEXT,
	incident_state TEXT,
	incident_city TEXT,
	incident_location TEXT,
	incident_hour_of_the_day INT,
	authorities_contacted TEXT,
	number_of_vehicles_involved INT,
	property_damage TEXT,
	bodily_injuries INT,
	police_report_available TEXT,
	witnesses INT,
	FOREIGN KEY(policy_number) REFERENCES policies(policy_number)
);