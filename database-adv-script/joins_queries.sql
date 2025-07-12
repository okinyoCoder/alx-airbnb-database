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
LEFT JOIN reviews r ON p.property_id = r.property_id
ORDER BY p.name ASC, r.created_at DESC;

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