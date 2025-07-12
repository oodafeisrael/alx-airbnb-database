-- Step 1: Rename the original bookings table for backup
ALTER TABLE bookings RENAME TO bookings_old;

-- Step 2: Create the new partitioned bookings table
CREATE TABLE bookings (
    booking_id UUID NOT NULL,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date),
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) PARTITION BY RANGE (start_date);
-- Create partitions (example: quarterly)
CREATE TABLE bookings_2024_q1 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE bookings_2024_q2 PARTITION OF bookings
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE bookings_2024_q3 PARTITION OF bookings
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE bookings_2024_q4 PARTITION OF bookings
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- Step 3: Create partitions (yearly range)
-- CREATE TABLE bookings_2024 PARTITION OF bookings
   -- FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- CREATE TABLE bookings_2025 PARTITION OF bookings
  -- FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 4: Migrate data from old bookings table into new partitioned table
INSERT INTO bookings
SELECT * FROM bookings_old;

-- Step 5: Recreate indexes (if needed)
CREATE INDEX idx_booking_property_id ON bookings(property_id);
CREATE INDEX idx_booking_user_id ON bookings(user_id);

-- Optional: Drop the old bookings table if everything works
-- DROP TABLE bookings_old;

-- Sample insert (add more if needed)
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
    (gen_random_uuid(), gen_random_uuid(), gen_random_uuid(), '2024-03-01', '2024-03-05', 500.00, 'confirmed'),
    (gen_random_uuid(), gen_random_uuid(), gen_random_uuid(), '2024-06-15', '2024-06-20', 750.00, 'confirmed'),
    (gen_random_uuid(), gen_random_uuid(), gen_random_uuid(), '2024-09-10', '2024-09-12', 300.00, 'pending');

-- Test query performance
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30';
