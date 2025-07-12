-- Initial Query
SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  b.status,
  b.created_at AS booking_created_at,
  
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
  
  p.property_id,
  p.name AS property_name,
  p.pricepernight,
  
  pay.payment_id,
  pay.amount,
  pay.payment_method,
  pay.payment_date

FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;
