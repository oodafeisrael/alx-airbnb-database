-- Indexes for users table
CREATE INDEX idx_users_user_id ON users(user_id);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- Indexes for bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- Indexes for properties table
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_pricepernight ON properties(pricepernight);
CREATE INDEX idx_properties_created_at ON properties(created_at);

-- 🔍 EXPLAIN ANALYZE before creating indexes

-- 1. Query to find bookings by user_id
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = '1090fee8-2ea0-4d81-96b1-aecfae6989f1';

-- 2. Query to get properties by host_id
EXPLAIN ANALYZE
SELECT * FROM properties WHERE host_id = 'bd5b140a-7435-462c-b6f7-05f1f32fb13a';

-- 3. Query to find users by email
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'user@example.com';

-- ✅ CREATE INDEX on high-usage columns

-- Index on user_id in bookings
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON bookings(user_id);

-- Index on host_id in properties
CREATE INDEX IF NOT EXISTS idx_property_host_id ON properties(host_id);

-- Index on email in users
CREATE INDEX IF NOT EXISTS idx_user_email ON users(email);

-- 🔍 EXPLAIN ANALYZE after creating indexes

-- 1. Re-test: Bookings by user_id
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = '1090fee8-2ea0-4d81-96b1-aecfae6989f1';

-- 2. Re-test: Properties by host_id
EXPLAIN ANALYZE
SELECT * FROM properties WHERE host_id = 'bd5b140a-7435-462c-b6f7-05f1f32fb13a';

-- 3. Re-test: Users by email
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'user@example.com';
