-- CHURN//IQ | 07 - Top active high-risk customers by estimated CLV
-- These customers have not churned and are candidates for retention attention.

SELECT
    "customerID",
    "Contract",
    "TenureCohort",
    "MonthlyCharges",
    "CLV_Estimate",
    "ChurnRiskScore",
    "ChurnRiskBand",
    "Churn"
FROM public.telco_churn
WHERE "ChurnRiskBand" = 'High'
  AND "Churn" = 'No'
ORDER BY "CLV_Estimate" DESC
LIMIT 100;
