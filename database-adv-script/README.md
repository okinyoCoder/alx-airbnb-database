# 🏡 Property Booking System – Database Schema & Queries

This project defines a relational database schema for a property booking platform similar to Airbnb. The schema supports user roles, property listings, location mapping, booking management, payments, reviews, and direct messaging.

---

## 📋 Schema Overview

### 🧑 Users
Stores users with roles: `guest`, `host`, or `admin`.

### 🏠 Properties
Listings posted by hosts, each tied to a location.

### 📍 Locations
Geographic info for properties (country, city, coordinates).

### 📅 Bookings
Tracks reservations between guests and properties.

### 💳 Payments
Logs payment details associated with bookings.

### ⭐ Reviews
Guests can leave reviews and ratings on properties.

### 💬 Messages
Direct messages between platform users.

### 🔢 ENUM Types
- `role`: `guest`, `host`, `admin`
- `booking_status`: `pending`, `confirmed`, `canceled`
- `payment_method`: `credit_card`, `paypal`, `stripe`

---

## 🔑 Key SQL Queries

### 1. 🧾 INNER JOIN – Bookings with User Info

Retrieves all bookings along with the user details for each booking.

```sql
SELECT 
  b.booking_id,
  b.property_id,
  b.start_date,
  b.end_date,
  b.total_price,
  b.status,
  b.created_at AS booking_created_at,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id;
```

---

### 2. 🏘️ LEFT JOIN – Properties with Optional Reviews

Retrieves all properties and any reviews that may exist. Properties without reviews are still shown.

```sql
SELECT 
  p.property_id,
  p.name AS property_name,
  p.description,
  r.review_id,
  r.user_id AS reviewer_id,
  r.rating,
  r.comment,
  r.created_at AS review_created_at
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;
```

---

### 3. 🔁 FULL OUTER JOIN – All Users and All Bookings

Returns all users and all bookings, including:
- Users with no bookings.
- Bookings with no linked user.

```sql
SELECT 
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
  b.booking_id,
  b.property_id,
  b.start_date,
  b.end_date,
  b.total_price,
  b.status,
  b.created_at AS booking_created_at
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id;
```

---

## 📌 Notes
- Consider enabling `pgcrypto` in PostgreSQL to generate default UUIDs.
- Recommended to add foreign key constraints for better data integrity.
- Indexes have been created for performance on frequent queries (e.g., by email, location, or foreign key relations).

---
## 🔍 Query 1: Properties with Average Rating > 4.0

Retrieves all properties where the average guest rating is greater than 4.0.

```sql
SELECT 
  p.property_id,
  p.name,
  p.description,
  p.pricepernight
FROM properties p
WHERE (
  SELECT AVG(r.rating)
  FROM reviews r
  WHERE r.property_id = p.property_id
) > 4.0;
```

### 📝 Explanation
- A subquery calculates the average rating for each property.
- Only properties with an average rating greater than 4.0 are returned.

---

## 🔍 Query 2: Users with More Than 3 Bookings

Identifies users who have made more than three bookings using a correlated subquery.

```sql
SELECT 
  u.user_id,
  u.first_name,
  u.last_name,
  u.email
FROM users u
WHERE (
  SELECT COUNT(*)
  FROM bookings b
  WHERE b.user_id = u.user_id
) > 3;
```

### 📝 Explanation
- A correlated subquery counts the number of bookings per user.
- Users with more than 3 bookings are selected.

---

## 🧠 Notes
- Ensure foreign key relationships are properly set to maintain data consistency.
- Use indexes on `bookings.user_id` and `reviews.property_id` for performance optimization on these queries.

# 📊 SQL Analytics – User Booking Count & Property Ranking

This document describes how to:
1. Calculate the total number of bookings per user.
2. Rank properties by total bookings using window functions.

---

## 🔹 1. Total Number of Bookings by Each User

This query calculates how many bookings each user has made.

```sql
SELECT 
  u.user_id,
  u.first_name,
  u.last_name,
  COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

# 📊 Rank Properties by Number of Bookings (Using RANK)

This document describes how to:
1. Rank properties by total bookings using window functions.

---

## 🔹 2. This query ranks all properties based on how many bookings they have received.

This query calculates how many bookings each user has made.
SELECT 
  p.property_id,
  p.name AS property_name,
  COUNT(b.booking_id) AS booking_count,
  RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS property_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY property_rank;


## 📂 Structure

```
📦booking-system-db
 ┣ 📜schema.sql
   📜subqueries.sql
 ┣ 📜README.md
```

---

## 🔧 To Do
- Add ON DELETE CASCADE rules where appropriate
- Implement backend API to interact with the database
- Build frontend client (e.g., React) for booking interface

---

© 2025 | Built with ❤️ by Anthony Odhiambo