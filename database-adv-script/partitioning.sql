-- Step 1: Rename original table (if exists) to backup
ALTER TABLE bookings RENAME TO bookings_backup;

-- Step 2: Create new partitioned bookings table
CREATE TABLE bookings (
  booking_id UUID PRIMARY KEY,
  property_id UUID,
  user_id UUID,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL NOT NULL,
  status booking_status NOT NULL,
  created_at TIMESTAMP DEFAULT now()
) PARTITION BY RANGE (start_date);

-- Step 3: Create partitions (e.g., per year)
CREATE TABLE bookings_2023 PARTITION OF bookings
  FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
  FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
  FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 4: (Optional) Copy data from backup if needed
-- INSERT INTO bookings (...) SELECT ... FROM bookings_backup;

-- Step 5: Create indexes for partitions (PostgreSQL requires indexes on each)
CREATE INDEX idx_bookings_2023_user_id ON bookings_2023(user_id);
CREATE INDEX idx_bookings_2024_user_id ON bookings_2024(user_id);
CREATE INDEX idx_bookings_2025_user_id ON bookings_2025(user_id);
