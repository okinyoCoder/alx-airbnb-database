## 🗃️ Database Normalization: Location Table

To improve data structure and support scalability, the `location` information was normalized in the database schema.

### 🔄 Original Design
Previously, the `location` was stored as a simple `VARCHAR` column within the `properties` table. While sufficient for basic listing, this approach limited our ability to support advanced features such as geospatial queries or map integration.

### ✅ Updated Design

A new `locations` table was introduced, which:
- Stores detailed information about each location.
- Includes latitude and longitude coordinates.
- Establishes a **foreign key** relationship to the `properties` table.

### 🗺️ Why This Matters

By creating a dedicated `locations` table:
- 🌍 We can easily **integrate maps** into the application using coordinates.
- 📦 We avoid **data duplication**, especially if multiple properties share the same location.
- 📈 We enable more advanced features like **distance calculations**, **location-based filtering**, and **geospatial indexing**.