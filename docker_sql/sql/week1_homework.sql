-- Question 3: Count records
select  count(1) from yellow_taxi_trips 
where date_trunc('day', tpep_pickup_datetime) = DATE '2021-01-15'

-- Question 4: Largest tip for each day 
select max(tip_amount) from yellow_taxi_trips
where date_trunc('month', tpep_pickup_datetime) = DATE '2021-01-01' 

-- Question 5: Most popular destination

WITH ranked_rides AS (
SELECT 
  "DOLocationID",
  COUNT(1),
  RANK() OVER(ORDER BY COUNT(1) DESC) AS rnk
FROM
  yellow_taxi_trips ytt
  INNER JOIN taxi_zone_lookup tzl
	ON ytt."PULocationID"= tzl."LocationID"
WHERE
  tzl."Zone" = 'Central Park' AND
  date_trunc('day', tpep_pickup_datetime) = DATE '2021-01-14' 
GROUP BY
  "DOLocationID")
SELECT
  tzl."Zone"
FROM
  taxi_zone_lookup tzl
  INNER JOIN ranked_rides rr
    ON tzl."LocationID" = rr."DOLocationID"
WHERE
  rr.rnk = 1


-- Question 6: Most expensive route
SELECT
  tzl_pu."Zone" || ' / ' || tzl_do."Zone",
  MAX(tt.total_amount) AS total_amount
FROM
  yellow_taxi_trips tt
 INNER JOIN taxi_zone_lookup tzl_pu
  ON tt."PULocationID" = tzl_pu."LocationID"
 INNER JOIN taxi_zone_lookup tzl_do
  ON tt."DOLocationID" = tzl_do."LocationID"
GROUP BY
  tzl_pu."Zone" || ' / ' || tzl_do."Zone"
ORDER BY 2 DESC
LIMIT 1;
