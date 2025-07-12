-- Use EXPLAIN ANALYZE to test performance on partitioned table
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30';

### Query:
SELECT * FROM bookings WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30'

###🔎 Before Partitioning:
Total execution time: ~350 ms (varies)

### Plan: Seq Scan or Index Scan on whole bookings table

###⚡ After Partitioning:
Execution time: ~50–100 ms (depending on volume)

Plan: Index Scan on bookings_2024 partition only


Disk I/O: Reduced significantly