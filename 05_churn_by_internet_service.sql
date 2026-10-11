-- CHURN//IQ | 05 - Churn by internet service

SELECT
    "InternetService",
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
GROUP BY "InternetService"
ORDER BY churn_rate_pct DESC;
