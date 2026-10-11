-- CHURN//IQ | 09 - Churn by contract and payment method
-- Suppress groups with fewer than 50 customers to avoid overemphasizing tiny segments.

SELECT
    "Contract",
    "PaymentMethod",
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
GROUP BY "Contract", "PaymentMethod"
HAVING COUNT(DISTINCT "customerID") >= 50
ORDER BY churn_rate_pct DESC;
