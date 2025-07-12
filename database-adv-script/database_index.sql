-- Create indexes to optimize frequently used queries

-- USERS
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_last_name ON users(last_name);

-- BOOKINGS
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_created_at ON bookings(created_at);

-- PROPERTIES
CREATE INDEX IF NOT EXISTS idx_properties_location ON properties(location);
CREATE INDEX IF NOT EXISTS idx_properties_name ON properties(name);

-- Test performance of a frequent query using EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT 
  u.first_name,
  u.last_name,
  COUNT(b.booking_id) AS total_bookings
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE u.email = 'test@example.com'
GROUP BY u.user_id, u.first_name, u.last_name;
