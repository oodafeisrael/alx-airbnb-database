-- INNER JOIN: View all bookings and the users who made them
SELECT
  b.booking_id,
  u.first_name || ' ' || u.last_name AS user_name,
  b.start_date,
  b.end_date,
  b.total_price,
  b.status
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id;
ORDER BY b.start_date DESC;


-- LEFT JOIN: View all properties and their reviews (including properties with no reviews)
SELECT
  p.property_id,
  p.name AS property_name,
  p.description,
  p.location,
  p.pricepernight,
  r.review_id,
  r.rating,
  r.comment,
  r.created_at AS review_date
FROM
  properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;
ORDER BY p.name ASC;


-- FULL OUTER JOIN: View all users and bookings even if they don’t match
SELECT 
    u.user_id AS user_id,
    u.first_name || ' ' || u.last_name AS user_name,
    b.booking_id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM users u
FULL OUTER JOIN bookings b
    ON u.user_id = b.user_id;
ORDER BY u.first_name ASC;
