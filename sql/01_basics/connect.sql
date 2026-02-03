--  Select everything from test_health
SELECT * FROM test_health;

-- 2️ Select only status column
SELECT status FROM test_health;

-- 3️ Add a simple expression
SELECT status, id*10 AS id_times_10 FROM test_health;

-- 4️ Filter using WHERE
SELECT * FROM test_health WHERE status = 'OK';

--5  filter using  NOT
SELECT * FROM test_health WHERE  status <> 'FAIL';

--6 filter using  LIKE 
SELECT * FROM test_health WHERE status LIKE 'U%';

--7 order  bt created_at  desceding 

SELECT * FROM  test_health ORDER BY created_at ASC;

--8 limit  results 
SELECT * FROM test_health  ORDER BY  created_at DESC LIMIT 2;

--9  handle all nulls
ALTER TABLE  test_health  ADD  COLUMN comment TEXT;
INSERT  INTO  test_health(status) VALUES ('PENDING');


SELECT * , COALESCE(comment, 'No comment') AS comment_text FROM test_health;

--10  usinfg aliases 

SELECT status AS current_status, created_at AS timestamp  FROM test_health;

