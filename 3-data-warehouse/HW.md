Question 1: What is count of records for the 2022 Green Taxi Data??
SELECT COUNT(*) FROM `zoomcamp-2024-412121.ny_taxi.green_taxi_data_external`
840,402

Question 2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?
SELECT COUNT(DISTINCT(PULocationID)) FROM `zoomcamp-2024-412121.ny_taxi.green_taxi_external` 0 MB
SELECT COUNT(DISTINCT(PULocationID)) FROM `zoomcamp-2024-412121.ny_taxi.green_taxi_internal` 6.41 MB

Question 3: How many records have a fare_amount of 0?
SELECT COUNT(fare_amount)
FROM `zoomcamp-2024-412121.ny_taxi.green_taxi_internal` 
WHERE fare_amount = 0
1622

Question 4: 
What is the best strategy to make an optimized table in Big Query if your query will always order the results by PUlocationID and filter based on lpep_pickup_datetime?
Partition by lpep_pickup_datetime Cluster on PUlocationID
CREATE OR REPLACE TABLE `zoomcamp-2024-412121.ny_taxi.green_taxi_partitioned`
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PULocationID AS (
  SELECT * FROM `zoomcamp-2024-412121.ny_taxi.green_taxi_external`
)

Question 5: 
Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 4 and note the estimated bytes processed. What are these values?

SELECT DISTINCT(PULocationID)
FROM `zoomcamp-2024-412121.ny_taxi.green_taxi_internal`
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';
12.82MB 

SELECT DISTINCT(PULocationID)
FROM `zoomcamp-2024-412121.ny_taxi.green_taxi_partitioned`
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';
1.12MB 

Question 6: Where is the data stored in the External Table you created?
GCP Bucket

Question 7: It is best practice in Big Query to always cluster your data:
False

Question 8: Write a SELECT count(*) query FROM the materialized table you created. How many bytes does it estimate will be read? Why?
SELECT * FROM `zoomcamp-2024-412121.ny_taxi.green_taxi_internal`
114.11 MB. This is due to the fact that we are selecting everything from the table. SELECT * reads lots of data which is why we should typically avoid it. 