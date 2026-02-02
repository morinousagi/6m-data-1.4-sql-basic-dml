SELECT * FROM resale_flat_prices_2017 LIMIT 5

SELECT town, street_name, resale_price
FROM resale_flat_prices_2017
ORDER BY town ASC, resale_price DESC;  -- ASC by default

SELECT town, street_name, flat_type, resale_price 
FROM resale_flat_prices_2017
WHERE town='WOODLANDS' and flat_type='4 ROOM'
ORDER BY resale_price DESC;

SELECT * 
FROM resale_flat_prices_2017
WHERE town='BUKIT MERAH';

SELECT
  street_name,
  resale_price / 1000 AS price_k  -- Use AS to rename the column
FROM
  resale_flat_prices_2017
WHERE
  town = 'PUNGGOL'
  AND resale_price > 500000
ORDER BY
  resale_price DESC;

-- without AGG, can use WHERE
SELECT *
FROM resale_flat_prices_2017
WHERE floor_area_sqm>100 and resale_price BETWEEN 500000 AND 600000
ORDER BY resale_price DESC;

SELECT DISTINCT town  -- unique
FROM resale_flat_prices_2017;

SELECT  *
FROM  resale_flat_prices_2017
WHERE  town IN ('BUKIT MERAH', 'BUKIT TIMAH');

SELECT  *
FROM  resale_flat_prices_2017
WHERE  town LIKE 'B%';  -- e.g. bedok, bukit merah

SELECT
  LOWER(town) AS town_lower,
  CONCAT(block, ' ', street_name) AS address
FROM   resale_flat_prices_2017;

-- SCALAR 
SELECT UPPER(town) AS town_uppercase,
    LOWER(street_name) AS street_lowercase,
    LENGTH(street_name) AS street_length
FROM resale_flat_prices_2017;

-- AGGREGATE
SELECT  COUNT(*) AS total_listings,
FROM  resale_flat_prices_2017;

SELECT COUNT(*) AS total_flats,
    ROUND(AVG(resale_price)) AS avg_price
FROM resale_flat_prices_2017;

SELECT MAX(resale_price) -- find most expensive
FROM resale_flat_prices_2017;

-- GROUP BY with AGG
SELECT town, AVG(resale_price) AS avg_price
FROM resale_flat_prices_2017
WHERE town IN ('YISHUN', 'WOODLANDS')
GROUP BY town;

-- after GROUP BY -> HAVING to filter aggregate values (cannot use WHERE)
SELECT  town,  AVG(resale_price) AS avg_price -- town is not aggregatd col, so need GROUP
FROM  resale_flat_prices_2017
GROUP BY  town
HAVING  avg_price > 600000 -- other sql, must use AVG(resale_price)
ORDER BY  avg_price DESC;

SELECT  AVG(resale_price) FROM resale_flat_prices_2017 -- overall avg resale_price

SELECT  AVG(resale_price), town FROM resale_flat_prices_2017 GROUP BY town -- avg by town

SELECT town,
    COUNT(*) AS total_transactions,
    AVG(resale_price) AS avg_price,
    AVG(floor_area_sqm) AS avg_size
FROM resale_flat_prices_2017
GROUP BY town
ORDER BY total_transactions DESC;

SELECT town, lease_commence_date, AVG(resale_price) AS avg_price
FROM   resale_flat_prices_2017
GROUP BY   town, lease_commence_date
ORDER BY   town, lease_commence_date DESC;

-- CASE (useful for normalising data) example:
SELECT country,
CASE
    WHEN country IN ('SG', 'SINGAPORE') THEN 'Singapore'
    WHEN country IN ('MY', 'MALAYSIA') THEN 'Malaysia'
END AS standardised_country
FROM sales_data;

SELECT  town, resale_price,  -- comma! bcos CASE column is under SELECT
  CASE
    WHEN resale_price > 1000000 THEN 'Million Dollar Club'
    WHEN resale_price > 500000 THEN 'Mid-Range'
    ELSE 'Entry-Level'
  END AS price_category
FROM
  resale_flat_prices_2017;

SELECT town, flat_type,
CASE
    WHEN flat_type IN ('1 ROOM', '2 ROOM', '3 ROOM') THEN 'Small'
    WHEN flat_type = '4 ROOM' THEN 'Medium'
    ELSE 'Large'
END AS flat_size
FROM resale_flat_prices_2017;
    
-- CAST
SELECT  town,  resale_price,
  CAST(resale_price AS INTEGER) AS resale_price_int
FROM  resale_flat_prices_2017;

SELECT 
    month, 
    CONCAT(month, '-01')::DATE AS transaction_date, -- form complete date str '2017-01-01'
    date_part('year', (month || '-01')::DATE) AS sale_year
FROM resale_flat_prices_2017;
-- month is concatenated using CONCAT with "-01" to form a complete date string "2017-01-01"
-- ::DATE converts the string to a date type
-- date_part('year', date) extract the year from the date
-- (month || '-01') is another way to concatenate strings in SQL using || operator
-- Both CONCAT(month, '-01') and (month || '-01') achieve the same result
-- if month is NULL, CONCAT will return NULL while || return -01
-- Alternative EXTRACT(YEAR FROM (month || '-01')::DATE) AS sale_year
-- EXTRACT ANSI SQL standard
-- date_part Postgres/DuckDB specific

-- CAST(column AS target_data_type)
-- e.g. CAST(month AS DATE)

SELECT  *, CONCAT(month, '-01')::DATE AS transaction_date
FROM  resale_flat_prices_2017;



-- Post-class project

SELECT town, AVG(resale_price)
FROM resale_flat_prices_2017
GROUP BY town
HAVING AVG(resale_price) < 450000


SELECT *                            --outer query
FROM resale_flat_prices_2017
WHERE town IN (
    SELECT town                     --inner query
    FROM resale_flat_prices_2017
    GROUP BY town
    HAVING AVG(resale_price)<450000
)
ORDER BY floor_area_sqm DESC LIMIT 5;

SELECT town, AVG(resale_price/floor_area_sqm) AS avg_price_per_sqm
FROM resale_flat_prices_2017
GROUP BY town
ORDER BY avg_price_per_sqm ASC
LIMIT 1;




-- Post-class Q1-4

SELECT 
    MIN(resale_price / floor_area_sqm) AS min_price_persqm, 
    MAX(resale_price / floor_area_sqm) AS max_price_persqm
FROM resale_flat_prices_2017;

SELECT  town, AVG(resale_price/floor_area_sqm) AS avg_price_persqm
FROM resale_flat_prices_2017 
GROUP BY town
ORDER BY avg_price_persqm DESC

SELECT 
    COUNT(*) AS num_transactions,
    CASE
        WHEN resale_price<400000 THEN 'Budget'
        WHEN resale_price BETWEEN 400000 AND 700000 THEN 'Mid_range'
        ELSE 'Premium'
    END AS price_category
FROM resale_flat_prices_2017
GROUP BY price_category;

SELECT town, COUNT(*) AS flats_sold
FROM resale_flat_prices_2017
WHERE month IN ('2017-01', '2017-02', '2017-03')
GROUP BY town
ORDER BY flats_sold DESC;


