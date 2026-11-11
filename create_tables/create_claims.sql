CREATE TABLE claims(
	claim_id INTEGER PRIMARY KEY,
	incident_id INT,
	total_claim_amount INT,
	injury_claim INT,
	property_claim INT,
	vehicle_claim INT,
	fraud_reported TEXT,
	FOREIGN KEY(incident_id) REFERENCES incidents(incident_id)
);