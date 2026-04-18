CREATE TABLE uber (
    request_id INT,
    pickup_point VARCHAR(50),
    driver_id INT,
    status VARCHAR(50),
    request_timestamp DATETIME,
    drop_timestamp DATETIME,
    hour INT,
    time_slot VARCHAR(50)
);
LOAD DATA LOCAL INFILE 'C:/Users/YourName/Downloads/cleaned_uber_data.csv'
INTO TABLE uber
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(request_id, pickup_point, driver_id, status, request_timestamp, drop_timestamp, hour, time_slot);
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:/data.csv'
INTO TABLE uber
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(request_id, pickup_point, driver_id, status, request_timestamp, drop_timestamp, hour, time_slot);

SELECT * FROM uber LIMIT 10;
SELECT * FROM uber_data LIMIT 10;
SELECT status, COUNT(*) AS total
FROM uber_data
GROUP BY status;
SELECT hour, COUNT(*) AS total_requests
FROM uber_data
GROUP BY hour
ORDER BY hour;
ALTER TABLE uber_data ADD COLUMN hour INT;
UPDATE uber_data
SET hour = HOUR(STR_TO_DATE(request_timestamp, '%d-%m-%Y %H:%i'));
UPDATE uber_data
SET hour = HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i'));
SET SQL_SAFE_UPDATES = 0;
UPDATE uber_data
SET hour = HOUR(STR_TO_DATE(`Request timestamp`, '%d-%m-%Y %H:%i'));
SELECT hour, COUNT(*) 
FROM uber_data 
GROUP BY hour
ORDER BY hour;
SELECT time_slot, COUNT(*) AS total
FROM uber_data
GROUP BY time_slot;
ALTER TABLE uber_data ADD COLUMN time_slot VARCHAR(50);
UPDATE uber_data
SET time_slot = 
CASE 
    WHEN hour BETWEEN 0 AND 4 THEN 'Late Night'
    WHEN hour BETWEEN 5 AND 9 THEN 'Early Morning'
    WHEN hour BETWEEN 10 AND 16 THEN 'Day'
    WHEN hour BETWEEN 17 AND 20 THEN 'Evening'

    ELSE 'Night'
END;
SELECT time_slot, COUNT(*) AS total
FROM uber_data
GROUP BY time_slot;
SELECT time_slot, status, COUNT(*) AS total
FROM uber_data
GROUP BY time_slot, status
ORDER BY time_slot;
SELECT pickup_point, COUNT(*) AS total
FROM uber_data
GROUP BY pickup_point;
SELECT `Pickup point`, COUNT(*) 
FROM uber_data
GROUP BY `Pickup point`;
SELECT pickup_point, status, COUNT(*) AS total
FROM uber_data
GROUP BY pickup_point, status;
SELECT `Pickup point`, status, COUNT(*) AS total
FROM uber_data
GROUP BY `Pickup point`, status;
SELECT hour, COUNT(*) AS cancellations
FROM uber_data
WHERE status = 'Cancelled'
GROUP BY hour
ORDER BY hour;
SELECT hour, COUNT(*) AS cancellations
FROM uber_data
WHERE LOWER(TRIM(status)) = 'cancelled'
GROUP BY hour
ORDER BY hour;
SELECT hour, COUNT(*) AS cancellations
FROM uber_data
WHERE LOWER(TRIM(status)) = 'cancelled'
GROUP BY hour
ORDER BY hour;
SELECT hour, COUNT(*) AS cancellations
FROM uber_data
WHERE LOWER(TRIM(`Status`)) = 'cancelled'
GROUP BY hour
ORDER BY hour;
SELECT `Pickup point`, `Status`, COUNT(*) 
FROM uber_data
GROUP BY `Pickup point`, `Status`;
SELECT COUNT(*) 
FROM uber_data
WHERE `Status` = 'Cancelled';
SELECT COUNT(*) FROM uber_data WHERE `Status` = 'Cancelled';
SELECT COUNT(*) FROM uber_data WHERE hour IS NULL;
SELECT DISTINCT `Status` FROM uber_data;
SELECT hour, COUNT(*) AS cancellations
FROM uber_data
WHERE LOWER(TRIM(`Status`)) = 'cancelled'
GROUP BY hour
ORDER BY hour;
SELECT `Status`, LENGTH(`Status`) 
FROM uber_data;
UPDATE uber_data
SET `Status` = TRIM(`Status`);
SELECT DISTINCT `Status` FROM uber_data;
SELECT hour, COUNT(*) AS cancellations
FROM uber_data
WHERE `Status` = 'Cancelled'
GROUP BY hour
ORDER BY hour;
SELECT hour, COUNT(*) AS no_cars
FROM uber_data
WHERE status = 'No Cars Available'
GROUP BY hour
ORDER BY hour;
SELECT time_slot,
SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancellations,
SUM(CASE WHEN status = 'No Cars Available' THEN 1 ELSE 0 END) AS no_cars
FROM uber_data
GROUP BY time_slot;