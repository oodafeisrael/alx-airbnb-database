SQL queries that define the database schema for airbnb clone project.
#  Airbnb Clone – Database Project

##  Overview

This repository contains the database schema and supporting scripts for the backend of an Airbnb Clone project. It is designed to manage users, properties, bookings, payments, messages, and reviews—mimicking the core functionalities of the Airbnb platform.

---

##  Project Objective

To build a robust, normalized relational database in PostgreSQL that supports scalable operations for a property rental platform, focusing on performance, data integrity, and relational design.

---

## ⚙️ Technology Stack

- **PostgreSQL**: Relational database management system
- **SQL**: Used for schema definition and queries
- **pgAdmin / psql**: For managing and testing the database
- **ERD Tool**: [Draw.io](https://draw.io) used for designing the Entity Relationship Diagram (ERD)

---

##  Database Design

### Entities & Attributes

- **User**
  - `user_id` (PK)
  - `first_name`, `last_name`, `email`, `password_hash`
  - `role` (ENUM): guest, host, admin

- **Property**
  - `property_id` (PK)
  - `host_id` (FK → User)
  - `name`, `description`, `location`, `price_per_night`
  - `created_at`, `updated_at`

- **Booking**
  - `booking_id` (PK)
  - `user_id` (FK → User)
  - `property_id` (FK → Property)
  - `start_date`, `end_date`, `total_price`, `status`

- **Payment**
  - `payment_id` (PK)
  - `booking_id` (FK → Booking)
  - `amount`, `payment_date`, `payment_method`

- **Review**
  - `review_id` (PK)
  - `user_id` (FK → User)
  - `property_id` (FK → Property)
  - `rating`, `comment`, `created_at`

- **Message**
  - `message_id` (PK)
  - `sender_id` (FK → User)
  - `recipient_id` (FK → User)
  - `message_body`, `sent_at`

---

##  API Security (For future API integrations)

- **Authentication**: Only registered users can access restricted endpoints.
- **Authorization**: Role-based access to endpoints (e.g., only hosts can create properties).
- **Rate Limiting**: To prevent abuse and ensure fair usage.
- **Data Validation**: Prevents malicious or invalid data inputs.
- **Secure Payments**: Sensitive fields are securely processed.

---

##  CI/CD Pipeline (Planned)

To automate testing and deployment:
- **GitHub Actions**: For automated testing on push
- **Docker**: Containerize the database
- **Heroku / Render / Railway**: Potential cloud deployment

---

##  Normalization Summary

The database schema adheres to **3rd Normal Form (3NF)**:
- No repeating groups (1NF)
- All non-key attributes depend on the full primary key (2NF)
- No transitive dependencies (3NF)

---

##  ER Diagram

The ERD can be found in the `ERD/` directory as a PNG or XML file.

---

##  Project Structure


