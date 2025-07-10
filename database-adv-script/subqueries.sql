-- SQL non-correlated Query: Properties with Average Rating > 4.0
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    avg_ratings.avg_rating
FROM properties p
JOIN (
    SELECT 
        property_id,
        AVG(rating) AS avg_rating
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
) AS avg_ratings ON p.property_id = avg_ratings.property_id
ORDER BY avg_ratings.avg_rating DESC;


-- Correlated subquery to find users who have made more than 3 bookings:
SELECT 
    u.user_id,
    u.first_name || ' ' || u.last_name AS full_name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY full_name;
