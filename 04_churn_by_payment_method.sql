-- CHURN//IQ | 04 - Churn by payment method

SELECT
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
GROUP BY "PaymentMethod"
ORDER BY churn_rate_pct DESC;
