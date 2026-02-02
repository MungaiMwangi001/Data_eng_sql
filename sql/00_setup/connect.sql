DROP TABLE IF EXISTS test_health;

-- create a simple table 
CREATE TABLE  test_health (
    id  SERIAL PRIMARY KEY,
    status TEXT,
    created_at TIMESTAMP  DEFAULT NOW()
);

--insert sample data

INSERT INTO test_health (status) VALUES 
('OK'),('FAIL'),('UNKNOWN');

-- verify data insertion
SELECT * FROM  test_health;
