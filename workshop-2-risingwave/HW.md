Question 0: What are the dropoff taxi zones at the latest dropoff times?
CREATE MATERIALIZED VIEW latest_pickup_time AS 
WITH latest AS (SELECT MAX(tpep_dropoff_datetime) AS latest_dropoff FROM trip_data)
SELECT taxi_zone.zone, latest_dropoff
FROM latest, trip_data
JOIN taxi_zone ON trip_data.dolocationid = taxi_zone.location_id
WHERE trip_data.tpep_dropoff_datetime = latest.latest_dropoff;

Question 1: Find the pair of taxi zones with the highest average trip time.
CREATE MATERIALIZED VIEW avg_trip_time AS 
WITH time AS (SELECT (tpep_dropoff_datetime - tpep_pickup_datetime) AS ride_time, pulocationid, dolocationid FROM trip_data)
SELECT pulocationid, taxi_zone.zone AS PUZone, dolocationid, AVG(ride_time) AS avg_ride_time, MIN(ride_time) AS min_ride_time, MAX(ride_time) AS max_ride_time
FROM time
JOIN taxi_zone ON time.pulocationid = taxi_zone.location_id
GROUP BY pulocationid, PUZone, dolocationid
ORDER BY avg_ride_time DESC;

Question 2: Recreate the MV(s) in question 1, to also find the number of trips for the pair of taxi zones with the highest average trip time.
CREATE MATERIALIZED VIEW trip_counts AS 
WITH time AS (SELECT (tpep_dropoff_datetime - tpep_pickup_datetime) AS ride_time, pulocationid, dolocationid FROM trip_data)
SELECT pulocationid, taxi_zone.zone AS PUZone, dolocationid, AVG(ride_time) AS avg_ride_time, MIN(ride_time) AS min_ride_time, MAX(ride_time) AS max_ride_time, COUNT(ride_time)AS number_of_trips
FROM time
JOIN taxi_zone ON time.pulocationid = taxi_zone.location_id
GROUP BY pulocationid, PUZone, dolocationid
ORDER BY avg_ride_time DESC;

Question 3: From the latest pickup time to 17 hours before, what are the top 3 busiest zones in terms of number of pickups?
WITH last_17 AS(
SELECT * FROM trip_data 
WHERE tpep_pickup_datetime > ((SELECT latest_dropoff FROM latest_pickup_time) - INTERVAL '17 hours') LIMIT 10)
SELECT pulocationid, zone, COUNT(pulocationid) AS number_pu
FROM last_17
JOIN taxi_zone ON last_17.pulocationid = taxi_zone.location_id
GROUP BY pulocationid, zone;
