-- ==========================================
-- 1. OVERALL FRAUD STATISTICS
-- ==========================================

SELECT
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE is_fraud = 1) AS fraud_transactions,
    COUNT(*) FILTER (WHERE is_fraud = 0) AS normal_transactions,

    ROUND(
        100.0 * COUNT(*) FILTER (WHERE is_fraud = 1)
        / NULLIF(COUNT(*), 0),
        4
    ) AS fraud_rate_pct,

    SUM(amount) AS total_transaction_amount,

    SUM(amount) FILTER (
        WHERE is_fraud = 1
    ) AS total_fraud_amount

FROM transactions;


-- ==========================================
-- 2. FRAUD RATE BY TRANSACTION TYPE
-- ==========================================

SELECT
    type,
    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraud_transactions,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE is_fraud = 1
        ) / NULLIF(COUNT(*), 0),
        4
    ) AS fraud_rate_pct

FROM transactions
GROUP BY type
ORDER BY fraud_rate_pct DESC;


-- ==========================================
-- 3. FRAUD AMOUNT ANALYSIS
-- ==========================================

SELECT
    type,
    COUNT(*) AS fraud_transactions,
    SUM(amount) AS total_fraud_amount,

    ROUND(AVG(amount), 2) AS average_fraud_amount,
    MIN(amount) AS minimum_fraud_amount,
    MAX(amount) AS maximum_fraud_amount

FROM transactions
WHERE is_fraud = 1
GROUP BY type
ORDER BY total_fraud_amount DESC;


-- ==========================================
-- 4. FRAUD TRENDS BY HOUR
-- ==========================================

SELECT
    hour_of_day,
    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraud_transactions,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE is_fraud = 1
        ) / NULLIF(COUNT(*), 0),
        4
    ) AS fraud_rate_pct

FROM transactions
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- ==========================================
-- 5. DAILY TRANSACTION MONITORING
-- ==========================================

SELECT
    simulation_day,
    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraud_transactions,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE is_fraud = 1
        ) / NULLIF(COUNT(*), 0),
        4
    ) AS fraud_rate_pct

FROM transactions
GROUP BY simulation_day
HAVING COUNT(*) >= 10000
ORDER BY simulation_day;
