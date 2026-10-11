CHURN//IQ — Customer Retention Intelligence
An end-to-end customer churn analysis project built with Excel/Power Query, PostgreSQL (Supabase), SQL, and Power BI. The project turns customer-level telecom data into an executive overview, churn-driver comparisons, and a prioritized view of active high-risk customers.

Project type: Descriptive analytics and rule-based risk segmentation. This project is not presented as a validated machine-learning churn prediction model.

Business Problem
A telecom business needs to understand where customer churn is concentrated and how to prioritize retention efforts. The analysis examines observed churn across contract type, payment method, internet service, and tenure cohorts, then highlights active customers classified as high risk and ranks them by estimated customer value.

Dashboard
The Power BI report contains three main pages and two supporting pages:

Executive — headline KPIs, churn distribution, churn by contract and tenure cohort, interactive slicers, and a customer economic/risk map.

Churn Drivers — churn-rate comparisons for contract, payment method, internet service, tech support, online security, and paperless billing.

Retention Radar — high-risk customer counts and value, risk-band distribution, customer value by risk band, and a table of high-risk customers who have not churned, sorted by estimated customer value.

Customer Tooltip — contextual customer information when hovering over a point in the economic/risk map.

Customer Detail — customer-level drill-through page.

Tools Used
Excel / Power Query: data inspection, cleaning, transformation, and feature preparation.

PostgreSQL via Supabase: SQL validation, aggregation, segmentation, and retention-target queries.

Power BI Desktop: data model, DAX measures, interactive report pages, slicers, tooltip, and drill-through.

DAX: measures for total customers, churned customers, churn rate, value associated with churned customers, high-risk customer count, and high-risk customer value.

Data Preparation
The project uses the IBM Telco Customer Churn dataset. The prepared Power BI dataset contains 7,043 customer records and 29 columns.

Recorded quality checks and cleaning decisions included:

Checked for duplicate customer IDs and fully duplicated rows; none were found in the reported checks.

Found 11 blank/whitespace-only TotalCharges values.

Converted TotalCharges to numeric and set those 11 values to zero, consistent with the zero-tenure/no-billing interpretation used during preparation.

Trimmed whitespace from text fields and standardized the SeniorCitizen representation while retaining a numeric flag.

Checked categorical values and numeric ranges.

Verified that the final row count remained 7,043 and that the prepared dataset had no remaining nulls in the reported final check.

Additional fields used in the analysis include TenureYears, TenureCohort, CLV_Estimate, AvgMonthlySpend, and ServicesSubscribed. The data also contains ChurnRiskScore and ChurnRiskBand; their original calculation method has not yet been independently verified, so they are treated as existing/source-provided risk-segmentation fields rather than a validated predictive model.

Key Results
The SQL analysis returned the following results:

Overall
Metric	Result
Customers	7,043
Churned customers	1,869
Overall churn rate	26.54%
High-risk customers (risk band = High)	2,665
Active high-risk customers (High risk and Churn = No)	1,246
Estimated customer value for active high-risk customers	2,167,831.20
Estimated CLV associated with churned customers (Revenue at Risk measure)	3.34M (rounded display)
Estimated CLV for all customers in the High risk band	4.78M (rounded display)
Value figures are based on the project's CLV_Estimate field. They should not be interpreted as audited accounting revenue or guaranteed future losses.

Churn by Contract
Contract	Customers	Churned	Churn rate
Month-to-month	3,875	1,655	42.71%
One year	1,473	166	11.27%
Two year	1,695	48	2.83%
Churn by Payment Method
Payment method	Customers	Churned	Churn rate
Electronic check	2,365	1,071	45.29%
Mailed check	1,612	308	19.11%
Bank transfer (automatic)	1,544	258	16.71%
Credit card (automatic)	1,522	232	15.24%
Churn by Internet Service
Internet service	Customers	Churned	Churn rate
Fiber optic	3,096	1,297	41.89%
DSL	2,421	459	18.96%
No internet service	1,526	113	7.40%
Churn by Tenure Cohort
Tenure cohort	Customers	Churned	Churn rate
0–6 months	1,481	784	52.94%
7–12 months	705	253	35.89%
1–2 years	1,024	294	28.71%
2–4 years	1,594	325	20.39%
4–6 years	2,239	213	9.51%
Combined Segment
Among groups with at least 30 customers, the highest churn rate in the Contract × Payment Method × Tenure Cohort query was:

Month-to-month + Electronic check + 0–6 months: 680 customers, 460 churned, 67.65% churn rate.

This is a descriptive segment result, not evidence that any one factor causes churn.

Business Recommendations
Prioritize early-tenure onboarding. The 0–6 month cohort had a 52.94% observed churn rate; test welcome journeys, setup assistance, and early check-ins.

Review month-to-month retention journeys. This segment had a 42.71% churn rate; test suitable plan education or longer-term offers without assuming that contract type alone explains churn.

Investigate the electronic-check segment. Its observed churn rate was 45.29%; review billing experience and payment-related friction before changing payment policy.

Create targeted interventions for combined high-churn segments. The month-to-month + electronic-check + 0–6 month cohort had a 67.65% rate, based on 680 customers.

Prioritize active high-risk customers by estimated value. The SQL results identified 1,246 active customers in the High risk band with a combined CLV_Estimate of 2,167,831.20.

These recommendations should be tested through appropriate business experiments; the observational analysis alone does not establish causation.

Example SQL Analysis
The SQL work includes row-count and unique-customer validation, overall churn calculation, churn-rate analysis by contract/payment method/internet service/tenure cohort, a query for active high-risk customers ranked by CLV_Estimate, and segment analysis using multiple dimensions.

Example — overall churn:

SELECT
    COUNT(DISTINCT "customerID") AS total_customers,
    COUNT(DISTINCT CASE WHEN "Churn" = 'Yes' THEN "customerID" END) AS churned_customers,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN "Churn" = 'Yes' THEN "customerID" END)
        / COUNT(DISTINCT "customerID"),
        2
    ) AS churn_rate_pct
FROM public.telco_churn;
Example — active high-risk customers:

SELECT
    COUNT(DISTINCT "customerID") AS active_high_risk_customers,
    ROUND(SUM("CLV_Estimate")::numeric, 2) AS active_high_risk_value
FROM public.telco_churn
WHERE "ChurnRiskBand" = 'High'
  AND "Churn" = 'No';
Limitations
The data is observational; segment differences are associations, not proof of causation.

CLV_Estimate is an estimated-value field and is not audited revenue or a guarantee of future loss.

The provenance and formula for ChurnRiskScore / ChurnRiskBand have not been independently verified. This project therefore does not claim a validated AI/ML prediction model.

The tenure value used in the customer map is derived from a tenure-cohort midpoint, so it is an approximation rather than exact individual tenure.

A future extension could train and validate a true churn-prediction model using only features available before the churn outcome, then evaluate it with a held-out test set and suitable classification metrics.

Suggested Repository Structure
CHURN-IQ/
├── README.md
├── sql/
│   ├── 01_data_validation.sql
│   ├── 02_overall_churn.sql
│   ├── 03_churn_by_contract.sql
│   ├── 04_churn_by_payment_method.sql
│   ├── 05_churn_by_internet_service.sql
│   ├── 06_churn_by_tenure_cohort.sql
│   ├── 07_active_high_risk_customers.sql
│   └── 08_segment_analysis.sql
├── powerbi/
│   └── CHURN_IQ_Final.pbix
└── screenshots/
    ├── executive.png
    ├── churn-drivers.png
    └── retention-radar.png
The structure above is a suggested organization; add only files that you actually include in the repository. Do not commit database passwords, Supabase secret keys, or other credentials.

Project Summary
CHURN//IQ combines data-quality work, SQL analysis, DAX measures, and a three-page Power BI report to move from understanding churn to identifying customer segments and prioritizing active high-risk customer value. The project focuses on transparent descriptive analysis and actionable retention prioritization rather than making unsupported predictive claims.

