#  Performance Report: Table Partitioning on `bookings` Table
## Background:
- The original bookings table contained a large volume of data, which led to slow query performance, especially for queries filtering on the start_date column. To address this, the table was refactored using range partitioning based on start_date.
##  Objective
To optimize query performance on a large `bookings` table using table partitioning by the `start_date` column.

##  Test Query
```sql
SELECT * FROM bookings WHERE start_date BETWEEN '2025-01-01' AND '2025-12-31';
## Tools Used
PostgreSQL's EXPLAIN ANALYZE

Range partitioning strategy on start_date

## Results
Table Type	Execution Time	Notes
Non-partitioned	2.656 ms	Full table scan
Partitioned	0.119 ms	Only relevant partition scanned

## Implementation Summary:
The original bookings table was renamed to bookings_old.

A new partitioned bookings table was created using PostgreSQL table partitioning by start_date.

Partitions were defined for specific yearly ranges (e.g., 2023, 2024, 2025).
 ## Observed Improvements:
-  Faster Query Execution: Queries targeting specific date ranges now execute significantly faster due to partition pruning, which avoids scanning irrelevant partitions.

- Improved Query Planning: EXPLAIN ANALYZE reports fewer rows scanned and more efficient index usage.

- Better Maintainability: New data can be inserted into the correct partition automatically, and old partitions can be archived or dropped with minimal impact.

## Conclusion
- Table partitioning is an excellent optimization technique for 
large tables with predictable filter columns such as dates. It 
enhances query efficiency and system scalability.

