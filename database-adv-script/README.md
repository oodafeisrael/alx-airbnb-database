Objective: Master SQL joins by writing complex queries using different types of joins.
-- ENUM types 
CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_type AS ENUM ('credit_card', 'paypal', 'stripe');

-- User table
CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
 -- role ENUM('guest', 'host', 'admin') NOT NULL,
    role user_role NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_email ON users(email);

-- Property table
CREATE TABLE properties (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(150) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 -- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES users(user_id)
);

CREATE INDEX idx_property_host_id ON properties(host_id);

-- Bookings table
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
 -- status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

Instructions:

Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.

Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.


## Objective: Write both correlated and non-correlated subqueries.

### Instructions:

- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

- Write a correlated subquery to find users who have made more than 3 bookings.

## Objective: Use SQL aggregation and window functions to analyze data.

### Instructions:

- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
