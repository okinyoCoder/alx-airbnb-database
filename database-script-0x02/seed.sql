CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

--- Insert user
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES 
  (uuid_generate_v4(), 'Alice', 'Wanjiku', 'alice@example.com', 'hashedpassword1', '0712345678', 'guest', now()),
  (uuid_generate_v4(), 'Bob', 'Odhiambo', 'bob@example.com', 'hashedpassword2', '0723456789', 'host', now()),
  (uuid_generate_v4(), 'Carol', 'Mutua', 'carol@example.com', 'hashedpassword3', '0734567890', 'guest', now()),
  (uuid_generate_v4(), 'David', 'Mwangi', 'david@example.com', 'hashedpassword4', '0745678901', 'host', now()),
  (uuid_generate_v4(), 'Admin', 'User', 'admin@example.com', 'adminpassword', '0700000000', 'admin', now());

--- Insert Location
INSERT INTO locations (location_id, country, state, city, postal_code, lat, lng)
VALUES 
  (uuid_generate_v4(), 'Kenya', 'Nairobi', 'Nairobi', '00100', -1.286389, 36.817223),
  (uuid_generate_v4(), 'Kenya', 'Coast', 'Mombasa', '80100', -4.043477, 39.668206),
  (uuid_generate_v4(), 'Kenya', 'Central', 'Thika', '01000', -1.033, 37.069);

---Insert Properties
-- Assume host_id and location_id retrieved from previous inserts (subqueries used here for clarity)
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight, created_at)
VALUES 
  (uuid_generate_v4(),
   (SELECT user_id FROM users WHERE email = 'bob@example.com'),
   'Modern 1BR Apartment',
   'A modern apartment in central Nairobi with Wi-Fi and parking.',
   (SELECT location_id FROM locations WHERE city = 'Nairobi'),
   50.00,
   now()),

  (uuid_generate_v4(),
   (SELECT user_id FROM users WHERE email = 'david@example.com'),
   'Cozy Beach House',
   'A relaxing beach house perfect for getaways in Mombasa.',
   (SELECT location_id FROM locations WHERE city = 'Mombasa'),
   120.00,
   now());

--- insert bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES 
  (uuid_generate_v4(),
   (SELECT property_id FROM properties WHERE name = 'Modern 1BR Apartment'),
   (SELECT user_id FROM users WHERE email = 'alice@example.com'),
   '2025-07-10',
   '2025-07-15',
   250.00,
   'confirmed',
   now()),

  (uuid_generate_v4(),
   (SELECT property_id FROM properties WHERE name = 'Cozy Beach House'),
   (SELECT user_id FROM users WHERE email = 'carol@example.com'),
   '2025-08-01',
   '2025-08-05',
   480.00,
   'pending',
   now());

--- insert payment
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
VALUES 
  (uuid_generate_v4(),
   (SELECT booking_id FROM bookings WHERE total_price = 250.00),
   250.00,
   now(),
   'credit_card');

--- insert reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
VALUES 
  (uuid_generate_v4(),
   (SELECT property_id FROM properties WHERE name = 'Modern 1BR Apartment'),
   (SELECT user_id FROM users WHERE email = 'alice@example.com'),
   5,
   'Great stay! Very clean and convenient location.',
   now());

--- Insert Message
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES 
  (uuid_generate_v4(),
   (SELECT user_id FROM users WHERE email = 'alice@example.com'),
   (SELECT user_id FROM users WHERE email = 'bob@example.com'),
   'Hi, is your apartment available for early check-in?',
   now()),

  (uuid_generate_v4(),
   (SELECT user_id FROM users WHERE email = 'bob@example.com'),
   (SELECT user_id FROM users WHERE email = 'alice@example.com'),
   'Yes, early check-in is possible from 11am.',
   now());

