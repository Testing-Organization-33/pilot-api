-- Expand-only baseline. Additive changes are safe to roll code back over.
CREATE TABLE wallet (id INT PRIMARY KEY, balance BIGINT NOT NULL DEFAULT 0);
