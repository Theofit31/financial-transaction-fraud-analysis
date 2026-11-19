-- ==========================================
-- CREATE TRANSACTIONS TABLE
-- ==========================================

CREATE TABLE IF NOT EXISTS transactions (
    step SMALLINT,
    type VARCHAR(20),
    amount NUMERIC(20, 2),
    name_orig VARCHAR(32),
    old_balance_org NUMERIC(20, 2),
    new_balance_orig NUMERIC(20, 2),
    name_dest VARCHAR(32),
    old_balance_dest NUMERIC(20, 2),
    new_balance_dest NUMERIC(20, 2),
    is_fraud SMALLINT,
    is_flagged_fraud SMALLINT,
    hour_of_day SMALLINT,
    simulation_day SMALLINT,
    is_transfer_or_cashout SMALLINT,
    amount_log DOUBLE PRECISION
);