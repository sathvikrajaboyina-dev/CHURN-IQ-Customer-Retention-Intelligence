-- CHURN//IQ | 02 - Overall churn KPIs
-- Expected: 7043 total customers, 1869 churned, 26.54% churn rate.

SELECT
    COUNT(DISTINCT "customerID") AS total_customers,
    COUNT(DISTINCT CASE
        WHEN "Churn" = 'Yes' THEN "customerID"
    END) AS churned_customers,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN "Churn" = 'Yes' THEN "customerID"
        END)
        / NULLIF(COUNT(DISTINCT "customerID"), 0),
        2
    ) AS churn_rate_pct
FROM public.telco_churn;
