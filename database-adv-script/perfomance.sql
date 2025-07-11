-- Initial query to retrieve all bookings with related user, property, and payment data

SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_date,

    -- User details
    u.user_id,
    u.first_name || ' ' || u.last_name AS user_name,
    u.email,
    u.phone_number,
    u.role,

    -- Property details
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,

    -- Payment details
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date

FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed'
  AND b.start_date >= CURRENT_DATE
ORDER BY b.created_at DESC;


-- Performance Analysis
EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method,
    pay.payment_date
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON pay.booking_id = b.booking_id;


-- REFRACTORED: Use only necessary columns and indexed fields
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.first_name || ' ' || u.last_name AS customer_name,
    p.name AS property_name,
    pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON pay.booking_id = b.booking_id
ORDER BY b.created_at DESC;

