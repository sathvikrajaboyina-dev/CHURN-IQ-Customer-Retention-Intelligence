-- CHURN//IQ | 06 - Churn by tenure cohort, explicitly ordered chronologically

SELECT
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
GROUP BY "TenureCohort"
ORDER BY CASE "TenureCohort"
    WHEN '0-6 mo' THEN 1
    WHEN '7-12 mo' THEN 2
    WHEN '1-2 yr' THEN 3
    WHEN '2-4 yr' THEN 4
    WHEN '4-6 yr' THEN 5
    ELSE 99
END;
