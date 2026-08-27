-- Expand-only: additive audit table, nothing existing is altered or dropped.
CREATE TABLE payout_audit (id INT PRIMARY KEY, bet BIGINT NOT NULL, paid BIGINT NOT NULL);
