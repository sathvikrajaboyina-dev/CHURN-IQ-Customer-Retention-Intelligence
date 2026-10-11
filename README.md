# CHURN//IQ SQL scripts

Run these scripts in the Supabase SQL Editor against `public.telco_churn`.

The imported column names preserve capitalization, so identifiers such as `"customerID"`, `"Churn"`, and `"CLV_Estimate"` are deliberately double-quoted.

1. `01_data_validation.sql` — row count, unique IDs, duplicate IDs, churn counts.
2. `02_overall_churn.sql` — overall churn KPIs.
3. `03_churn_by_contract.sql` — churn by contract.
4. `04_churn_by_payment_method.sql` — churn by payment method.
5. `05_churn_by_internet_service.sql` — churn by internet service.
6. `06_churn_by_tenure_cohort.sql` — churn by tenure cohort in chronological order.
7. `07_top_active_high_risk_customers.sql` — top 100 active high-risk customers by estimated CLV.
8. `08_active_high_risk_summary.sql` — count and estimated value of active high-risk customers.
9. `09_contract_payment_segments.sql` — contract/payment-method combinations with at least 50 customers.
10. `10_contract_payment_tenure_segments.sql` — contract/payment/tenure segments with at least 30 customers.

These queries describe observed associations; they do not establish causation. `ChurnRiskScore` should not be described as a validated ML prediction unless its original methodology is verified.
