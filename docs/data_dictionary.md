# 📚 Data Dictionary - E-Commerce Intelligence Warehouse

---

### 1. `customers` Table
*Primary Key:* `customer_id`

| Column Name | Data Type | Nullable | Key Constraint | Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | `INT` | No | Primary Key | Unique identifier for each customer account. |
| `customer_name` | `VARCHAR(100)` | No | None | Customer's full name. |
| `email` | `VARCHAR(150)` | No | Unique | Account login email address. |
| `gender` | `VARCHAR(20)` | Yes | None | Demographic gender marker. |
| `city` | `VARCHAR(100)` | Yes | None | City of customer primary address. |
| `state` | `VARCHAR(100)` | Yes | None | State of customer primary address. |
| `signup_date` | `DATE` | No | None | Date account was created. |
| `acquisition_channel` | `VARCHAR(50)` | No | None | Marketing channel source (`Paid Ads`, `Email`, `Organic Search`, `Social Media`, `Referral`). |

---

### 2. `products` Table
*Primary Key:* `product_id`

| Column Name | Data Type | Nullable | Key Constraint | Description |
| :--- | :--- | :--- | :--- | :--- |
| `product_id` | `INT` | No | Primary Key | Unique product SKU identifier. |
| `product_name` | `VARCHAR(150)` | No | None | Retail item title. |
| `category` | `VARCHAR(50)` | No | None | Item department (`Electronics`, `Home`, `Fashion`). |
| `price` | `DECIMAL(10,2)` | No | None | Catalog price per unit ($). |

---

### 3. `orders` Table
*Primary Key:* `order_id` | *Foreign Key:* `customer_id`

| Column Name | Data Type | Nullable | Key Constraint | Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_id` | `INT` | No | Primary Key | Unique order header identifier. |
| `customer_id` | `INT` | No | Foreign Key | References `customers(customer_id)`. |
| `order_date` | `DATE` | No | Index | Timestamp when order was placed. |
| `order_status` | `VARCHAR(30)` | No | None | Fulfillment state (`Completed`, `Cancelled`, `Returned`, `Pending`). |

---

### 4. `order_items` Table
*Primary Key:* `order_item_id` | *Foreign Keys:* `order_id`, `product_id`

| Column Name | Data Type | Nullable | Key Constraint | Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_item_id` | `INT` | No | Primary Key | Unique line item record identifier. |
| `order_id` | `INT` | No | Foreign Key | References `orders(order_id)`. |
| `product_id` | `INT` | No | Foreign Key | References `products(product_id)`. |
| `quantity` | `INT` | No | None | Number of units purchased. |
| `unit_price` | `DECIMAL(10,2)` | No | None | Price per unit at transaction time ($). |

---

### 5. `payments` Table
*Primary Key:* `payment_id` | *Foreign Key:* `order_id`

| Column Name | Data Type | Nullable | Key Constraint | Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_id` | `INT` | No | Primary Key | Unique payment transaction identifier. |
| `order_id` | `INT` | No | Foreign Key | References `orders(order_id)`. |
| `payment_method` | `VARCHAR(50)` | No | None | Gateway channel (`Credit Card`, `UPI`, `Net Banking`, `Debit Card`). |
