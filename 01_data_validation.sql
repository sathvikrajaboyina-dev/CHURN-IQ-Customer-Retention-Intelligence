-- CHURN//IQ | 01 - Data validation
-- Run in Supabase SQL Editor against public.telco_churn.

-- Row count and unique customer count (expected: 7043 / 7043)
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT "customerID") AS unique_customers
FROM public.telco_churn;

-- Duplicate customer IDs (expected: no rows)
SELECT
    "customerID",
    COUNT(*) AS row_count
FROM public.telco_churn
GROUP BY "customerID"
HAVING COUNT(*) > 1;

-- Overall churn status counts
SELECT
    "Churn",
    COUNT(DISTINCT "customerID") AS customers
FROM public.telco_churn
GROUP BY "Churn"
ORDER BY "Churn";
