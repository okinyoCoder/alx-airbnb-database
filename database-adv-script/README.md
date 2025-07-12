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

## 📂 Structure

```
📦booking-system-db
 ┣ 📜schema.sql
 ┣ 📜README.md
```

---

## 🔧 To Do
- Add ON DELETE CASCADE rules where appropriate
- Implement backend API to interact with the database
- Build frontend client (e.g., React) for booking interface

---

© 2025 | Built with ❤️ by Anthony Odhiambo