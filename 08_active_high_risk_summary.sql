-- CHURN//IQ | 08 - Active high-risk customer count and estimated value
-- Cast SUM to numeric so ROUND(value, 2) works with double precision source columns.
-- Observed in this project: 1246 customers and 2167831.20 estimated value.

SELECT
    COUNT(DISTINCT "customerID") AS active_high_risk_customers,
    ROUND(SUM("CLV_Estimate")::numeric, 2) AS active_high_risk_value
FROM public.telco_churn
WHERE "ChurnRiskBand" = 'High'
  AND "Churn" = 'No';
