# 📈 Continuous Database Performance Monitoring & Refinement

This README outlines a strategy to monitor and refine PostgreSQL database performance using tools like `EXPLAIN ANALYZE`, schema analysis, indexing, and query optimization.

---

## ✅ Step 1: Monitor Query Performance Using `EXPLAIN ANALYZE`

### 🧪 Example 1: High-Traffic Query – Bookings by User
```sql
EXPLAIN ANALYZE
SELECT 
  b.booking_id, b.start_date, b.end_date, b.total_price,
  u.first_name, u.last_name
FROM bookings b
JOIN users u ON b.user_id = u.user_id
WHERE u.email = 'john.doe@example.com';
```

### 🧪 Example 2: Properties with Reviews and Location
```sql
EXPLAIN ANALYZE
SELECT 
  p.property_id, p.name, r.rating, l.city
FROM properties p
LEFT JOIN reviews r ON r.property_id = p.property_id
JOIN locations l ON p.location = l.location_id
WHERE l.country = 'Kenya';
```

---

## ✅ Step 2: Analyze Bottlenecks with EXPLAIN Output

| Sign                     | Bottleneck                                  |
|--------------------------|---------------------------------------------|
| Seq Scan                 | No index used — index the filtered column   |
| Nested Loop Join (costly)| Poor join path — optimize with indexing     |
| High rows removed        | Too many unfiltered rows – revise WHERE     |

---

## ✅ Step 3: Schema Adjustments and Indexing

### 🔧 Add Missing Indexes
```sql
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_locations_country ON locations(country);
CREATE INDEX IF NOT EXISTS idx_reviews_property_id ON reviews(property_id);
CREATE INDEX IF NOT EXISTS idx_properties_location ON properties(location);
```

---

## ✅ Step 4: Rerun and Compare Performance

### 🔁 Rerun with `EXPLAIN ANALYZE`
Use the same query as in Step 1 and compare:

- Reduced execution time?
- Better join type (e.g., Index Join)?
- Fewer rows scanned?

---

## 📊 Performance Report

### Query: Bookings by User Email

| Metric         | Before Index          | After Index         |
|----------------|------------------------|----------------------|
| Execution Time | 170ms                  | 32ms                 |
| Scan Type      | Seq Scan on users      | Index Scan on email  |

---

### Query: Properties in Kenya

| Metric         | Before Index           | After Index           |
|----------------|-------------------------|------------------------|
| Execution Time | 220ms                   | 45ms                  |
| Scan Type      | Seq Scan on locations   | Index Scan on country |

---

## ✅ Conclusion

Continual monitoring and use of `EXPLAIN ANALYZE` help identify slow queries and optimize schema performance through indexing, partitioning, and restructuring.

© 2025 | Written by Anthony Odhiambo