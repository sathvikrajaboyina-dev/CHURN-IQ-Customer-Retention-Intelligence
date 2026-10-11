-- CHURN//IQ | 10 - Churn by contract, payment method, and tenure cohort
-- Groups with fewer than 30 customers are excluded from this segment comparison.

SELECT
    "Contract",
    "PaymentMethod",
    "TenureCohort",
    COUNT(DISTINCT "customerID") AS customers,
    COUNT(DISTINCT CASE
        WHEN "Churn" = 'Yes' THEN "customerID"
    END) AS churned,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN "Churn" = 'Yes' THEN "customerID"
        END)
        / NULLIF(COUNT(DISTINCT "customerID"), 0),
        2
    ) AS churn_rate_pct
FROM public.telco_churn
GROUP BY "Contract", "PaymentMethod", "TenureCohort"
HAVING COUNT(DISTINCT "customerID") >= 30
ORDER BY churn_rate_pct DESC;
