# Implementing Indexes for Optimization
The following are the  detailed analysis of high-usage columns in the users, bookings, and properties tables of the Airbnb clone project. The columns most frequently used in JOIN, WHERE, and ORDER BY clauses—making them ideal candidates for indexing to improve performance includes:

 1.  Users Table
Column	Why It’s High-Usage
user_id	Primary key, used for JOINs with bookings, messages, reviews, etc.
email	Often used in login or user search (WHERE)
role	Used for filtering by guest/host/admin (WHERE)

 2. Bookings Table
Column	        Why It’s High-Usage
booking_id	Primary key
user_id	        Used to find bookings by a user (WHERE, JOIN)
property_id	Used to relate bookings to properties (JOIN)
status	        Used in filters (pending, confirmed, canceled)
created_at	Often used in ORDER BY (e.g., recent bookings)

 3. Properties Table
Column	        Why It’s High-Usage
property_id	Primary key
host_id 	Used in JOIN with users table (JOIN)
location	Used in search filters (WHERE)
pricepernight	Used in filtering and sorting (WHERE, ORDER BY)
created_at	Sometimes used to sort new listings (ORDER BY)


### Summary of Index Candidates
Table	        High-Usage Columns to Index
users	        user_id, email, role
bookings	user_id, property_id, status, created_at
properties	host_id, location, pricepernight, created_at
