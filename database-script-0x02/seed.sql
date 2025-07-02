-- Insert users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  (gen_random_uuid(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_pass1', '08012345678', 'guest'),
  (gen_random_uuid(), 'Bob', 'Smith', 'bob@example.com', 'hashed_pass2', '08087654321', 'host'),
  (gen_random_uuid(), 'Eve', 'Williams', 'eve@example.com', 'hashed_pass3', '08011223344', 'admin');

-- Insert properties
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES
  (gen_random_uuid(), (SELECT user_id FROM users WHERE email = 'bob@example.com'), 'Sea Breeze Villa', 'Beachside villa with sea view.', 'Lagos, Nigeria', 250.00),
  (gen_random_uuid(), (SELECT user_id FROM users WHERE email = 'bob@example.com'), 'City Loft', 'Modern loft in city center.', 'Abuja, Nigeria', 150.00);

-- Insert bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  (
    gen_random_uuid(),
    (SELECT property_id FROM properties WHERE name = 'Sea Breeze Villa'),
    (SELECT user_id FROM users WHERE email = 'alice@example.com'),
    '2025-08-01',
    '2025-08-05',
    1000.00,
    'confirmed'
  ),
  (
    gen_random_uuid(),
    (SELECT property_id FROM properties WHERE name = 'City Loft'),
    (SELECT user_id FROM users WHERE email = 'alice@example.com'),
    '2025-08-10',
    '2025-08-12',
    300.00,
    'pending'
  );

-- Insert payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
  (
    gen_random_uuid(),
    (SELECT booking_id FROM bookings WHERE total_price = 1000.00),
    1000.00,
    'credit_card'
  ),
  (
    gen_random_uuid(),
    (SELECT booking_id FROM bookings WHERE total_price = 300.00),
    300.00,
    'paypal'
  );

-- Insert reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
  (
    gen_random_uuid(),
    (SELECT property_id FROM properties WHERE name = 'Sea Breeze Villa'),
    (SELECT user_id FROM users WHERE email = 'alice@example.com'),
    5,
    'Amazing stay! Highly recommend!'
  ),
  (
    gen_random_uuid(),
    (SELECT property_id FROM properties WHERE name = 'City Loft'),
    (SELECT user_id FROM users WHERE email = 'alice@example.com'),
    4,
    'Great location, a bit noisy at night.'
  );

-- Insert messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
  (
    gen_random_uuid(),
    (SELECT user_id FROM users WHERE email = 'alice@example.com'),
    (SELECT user_id FROM users WHERE email = 'bob@example.com'),
    'Hello, I have a question about the check-in time.'
  ),
  (
    gen_random_uuid(),
    (SELECT user_id FROM users WHERE email = 'bob@example.com'),
    (SELECT user_id FROM users WHERE email = 'alice@example.com'),
    'Check-in is from 2 PM. Let me know if you have any concerns.'
  );

