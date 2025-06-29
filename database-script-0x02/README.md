# 📊  Airbnb – Sample Data

This repository provides a PostgreSQL schema for a property booking platform along with **realistic sample data** to help developers quickly populate the database for testing, prototyping, or demonstration purposes.

---

## 📂 Contents

- `schema.sql` – Contains all `CREATE TYPE` and `CREATE TABLE` statements.
- `seed.sql` – Contains `INSERT INTO` statements to populate the database.
- `README.md` – Documentation for understanding and using the database and sample data.

---

## 🔍 Sample Data Overview

The provided `sample_data.sql` file includes:

### 👥 Users
Five sample users with roles:
- Guests (e.g., Alice, Carol)
- Hosts (e.g., Bob, David)
- Admin user

### 🌍 Locations
Three real-world locations:
- Nairobi
- Mombasa
- Thika

### 🏠 Properties
Two listings:
- A modern apartment in Nairobi
- A cozy beach house in Mombasa

### 📅 Bookings
Two bookings:
- One confirmed booking for a Nairobi apartment
- One pending booking for the beach house

### 💳 Payments
One completed payment via credit card.

### ⭐ Reviews
A 5-star review for the Nairobi apartment.

### 💬 Messages
Two example messages between a guest and a host.

---

## 🚀 How to Use

1. **Start PostgreSQL** and ensure the `uuid-ossp` extension is enabled:
   ```sql
   CREATE EXTENSION IF NOT EXISTS "uuid-ossp";