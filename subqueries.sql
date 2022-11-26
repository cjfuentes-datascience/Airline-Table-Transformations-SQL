-- Select ten rows from the flights table.
SELECT * 
FROM flights
LIMIT 10;

-- Find flight information about flights where the origin elevation is less than 2000 feet.
SELECT * 
FROM flights 
WHERE origin in (
    SELECT code 
    FROM airports 
    WHERE elevation < 2000);

-- Find flight information about flights where the Federal Aviation Administration region (faa_region) is the Southern region (ASO).
SELECT * 
FROM flights 
WHERE origin in (
    SELECT code 
    FROM airports 
    WHERE faa_region = 'ASO');
    
-- Using a subquery, find the average total distance flown for each day of the week in each month.
SELECT a.dep_month,
       a.dep_day_of_week,
       AVG(a.flight_distance) AS average_distance
FROM (
        SELECT dep_month,
              dep_day_of_week,
               dep_date,
               sum(distance) AS flight_distance
          FROM flights
         GROUP BY 1,2,3
       ) a
 GROUP BY 1,2
 ORDER BY 1,2;
 
 -- Find the id of the flights whose distance is below average for their carrier.
SELECT id
FROM flights AS f
WHERE distance < (
 SELECT AVG(distance)
 FROM flights
 WHERE carrier = f.carrier);
 
 -- Write a query to view flights by origin, flight id, and sequence number.
SELECT origin, id,
    (SELECT COUNT(*)
FROM flights f
WHERE f.id < flights.id
AND f.origin=flights.origin) + 1
 AS flight_sequence_number
FROM flights;
