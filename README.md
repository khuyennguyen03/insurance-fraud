# insurance-fraud SQL Project 

## Overview
In this project, I took a raw auto insurance claims dataset (1,000 claims) and normalized it into five linked tables in SQLite: policies, customers, vehicles, incidents, and claims. I then wrote SQL queries to analyze claim size and fraud rates by incident type, state, customer age, education, and occupation, and documented the data-quality checks I ran along the way.

## Data
The data is the [Insurance Fraud Detection dataset](https://www.kaggle.com/datasets/arpan129/insurance-fraud-detection) on Kaggle, posted by arpan129. It contains 1,000 auto insurance claims, with details about the policy, the customer, the vehicle, the incident, and the claim amounts, plus a flag for whether the claim was reported as fraud. All cleaning was done in SQL. The data belongs to its original authors, so I haven't included it in this repo. To run the project yourself, download it from the Kaggle link above.

## Database Design
The raw CSV was a single wide table. I split it into five tables, each describing one thing:

- **policies**: one row per policy (state, coverage limit, deductible, annual premium, bind date, umbrella limit). Primary key: `policy_number`.
- **customers**: the insured person (age, sex, education, occupation, hobbies, zip code, capital gains and losses). Primary key: `policy_number`.
- **vehicles**: the insured car (make, model, year). Primary key: `policy_number`.
- **incidents**: what happened (type, date, severity, collision type, location, injuries, witnesses, police report). Primary key: `incident_id`.
- **claims**: the payout (total, injury, property, and vehicle amounts, plus the fraud flag). Primary key: `claim_id`.

**How they connect:** `customers`, `vehicles`, and `incidents` each link to `policies` through `policy_number`, and `claims` links to `incidents` through `incident_id`. To connect a claim to its customer, a query joins `claims → incidents → customers`.

**Design notes:** In this dataset, every policy has exactly one customer, one vehicle, and one incident, so `policy_number` works as both the primary key and a foreign key in `customers` and `vehicles`. The raw data had no ID for incidents or claims, so I generated `incident_id` and `claim_id`.

## Files
- `create_tables/`: SQL that creates the five tables
- `load_data/`: SQL that loads each table from the raw data
- `analysis_queries/`: the analysis queries
- `data_cleaning/`: data-quality checks and recoding

## Data Cleaning
- **Claim totals:** I checked that every `total_claim_amount` equals the sum of its injury, property, and vehicle amounts. All 1,000 rows matched, and none of the amounts were NULL.
- **Placeholder values:** The raw data used `?` for missing values. In `collision_type`, these were theft and parked-car incidents, where no collision occurred, so I recoded them as "Not Applicable." In `property_damage` and `police_report_available`, the information simply wasn't recorded, so I converted them to NULL.
- **Blank row:** The CSV import included one empty trailing row, which I excluded when loading the tables.

## Key Findings

**Collision claims are both larger and more likely to be flagged as fraud.** Single vehicle collisions averaged $64,445 per claim with a 29.0% fraud rate, and multi-vehicle collisions averaged $61,637 with 27.2%. Vehicle theft and parked car claims averaged only about $5,300 to $5,500, with fraud rates under 10%. Collision claims were more than 10 times larger and about 3 times as likely to be flagged.

**Incident type drives claim size far more than state does.** In the five states with enough data (NC, NY, SC, VA, WV), collision claims averaged $58,800 to $66,000, while vehicle theft and parked car claims averaged only about $4,800 to $6,300. Single vehicle collisions ranked first in each of those states, though in West Virginia the gap over multi-vehicle collisions was only about $500. Theft and parked car groups were small (10 to 28 claims per state), so their ordering shouldn't be over-analyzed. Incident types with fewer than 10 claims in a state were excluded.

**Fraud rates were nearly the same across age groups and education levels.** By age, fraud rates ranged only from 24.0% (ages 30-45, 622 claims) to 26.0% (over 45, 223 claims), with 25.8% for under 30 (155 claims). By education level, they ranged from 22.4% (Masters) to 26.4% (PhD, MD) across groups of 122 to 161 claims, with no consistent trend by level. Average claim size was about $52,000 for customers under 45, and somewhat higher at about $55,900 for those over 45.

**Fraud rates varied widely by occupation, but with no clear pattern.** Rates ranged from 16.9% (private household service, other service, and administrative-clerical, tied) to 36.8% (executive-managerial, 76 claims), against an overall rate of about 24.7%. This is exploratory, not a basis for screening or pricing by occupation.

**Claim cost relative to premium was nearly identical across the three policy states.** Average claims were about 42 times the average annual premium in Indiana (42.2x) and Illinois (42.2x), and 41.6x in Ohio, with average premiums within about $7 of each other ($1,253 to $1,260) and 310 to 352 policies per state. The dataset only includes these three policy states. The ratio is inflated because every policy in this dataset has exactly one claim, so it's a rough proxy for a loss ratio, and only the comparison between states is meaningful.
