#  Retail Sales & Customer Behaviour Analysis

### SQL Case Study – RetailMartt


##  Project Overview

RetailMartt is an e-commerce company operating across multiple locations. The company sells everyday consumer products online and depends on efficient order processing and reliable payments to drive revenue.

This SQL case study analyses:

* Customer behaviour
* Sales performance
* Order outcomes
* Payment reliability

The objective is to identify revenue drivers, understand operational bottlenecks, and provide data-driven recommendations for business growth.

##  Problem Statement

RetailMartt is experiencing:

* High-order cancellations
* Frequent failed payments
* Unclear visibility into revenue drivers

Management lacks clarity on:

1. Which products and categories drive the most revenue
2. Why are many orders not successfully completed
3. Which customers and locations contribute most to sales

This analysis provides insight into revenue concentration, customer value, and operational friction in the sales process.



##  Data Source

**Source:** RetailMartt Dataset 


## Data Cleaning & Transformation

The dataset was prepared using the following steps:

* Removed duplicate records where necessary
* Standardized categorical fields (`order_status`, `payment_status`)
* Validated numerical fields (`quantity`, `unit_price`)
* Filtered revenue analysis to **Completed Orders** only
* Created derived metric:

```
total_sales = quantity × unit_price
```


##  Database Schema

```sql
CREATE DATABASE Retailmartt;
USE Retailmartt;
```

### Customers Table

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(100),
    age INT,
    location VARCHAR(100),
    signup_date DATE
);
```

### Orders Table

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(100)
);
```

### Product Table

```sql
CREATE TABLE product (
    product_id INT PRIMARY KEY,
    category VARCHAR(100),
    product_name VARCHAR(100),
    price INT
);
```

### OrderItems Table

```sql
CREATE TABLE orderitems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price INT
);
```

### Payment Table

```sql
CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(100),
    payment_status VARCHAR(100),
    payment_date DATE
);
```


## Business Questions & SQL Analysis


### 1️⃣ Which products generate the highest total sales?

```sql
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM product p
JOIN orderitems oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_sales DESC;
```

**Insight:**
Cooking Gas generated **₦19,192**, making it the top-selling product and a key revenue driver.


### 2️⃣ Which product categories perform best in sales?

```sql
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM product p
JOIN orderitems oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_sales DESC;
```

**Insight:**
Groceries is the highest-revenue-generating category, indicating that essential daily-use products drive the majority of revenue.


### 3️⃣ How many orders are completed, cancelled, or pending?

```sql
SELECT
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
```

**Results:**

* Cancelled: 422 orders (**35%**)
* Pending: 399 orders (**33%**)
* Completed: 379 orders (**32%**)

**Insight:**
Only **32% of orders are successfully completed**, meaning nearly **68% of orders drop off** before revenue is realized.


### 4️⃣ Do failed payments affect order completion?

```sql
SELECT
    p.payment_status,
    o.order_status,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN payment p ON o.order_id = p.order_id
GROUP BY p.payment_status, o.order_status
ORDER BY p.payment_status, total_orders DESC;
```

**Insight:**
Orders with failed payments are significantly more likely to be cancelled or remain pending.

This confirms that **payment failure is a major operational bottleneck** affecting revenue realization.


### 5️⃣ Which customers place the most orders?

```sql
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;
```

**Insight:**
Anna Ojo placed **9 orders**, making her the most active customer and a high-value repeat buyer.


### 6️⃣ Which locations generate the most sales?

```sql
SELECT
    c.location,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN orderitems oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.location
ORDER BY total_sales DESC;
```

**Insight:**
Lagos generated **₦87,309** in completed sales, making it the highest revenue-contributing location.


# Key Insights & Findings

### 📌 Revenue Drivers

* Cooking Gas leads individual product revenue (₦19,192).
* Groceries category contributes the highest overall sales.
* Revenue is heavily concentrated in essential household goods.

### 📌 Order Funnel Performance

* 422 cancelled orders vs 379 completed.
* Completion rate: **32%**
* Drop-off rate: **68%**

This signals serious friction in the checkout/payment process.

### 📌 Payment Reliability

* Failed payments strongly correlate with cancellations.
* Improving payment success rate could directly increase revenue realization.

### 📌 Customer & Location Concentration

* The top customer placed 9 orders.
* Lagos alone generated ₦87,309 in completed revenue.
* Sales are geographically concentrated.


# Recommendations

### 1️⃣ Improve Payment System Reliability

* Integrate more stable payment gateways
* Add automatic retry logic
* Offer alternative payment methods

**Expected Impact:** Even a 10% increase in completion rate could significantly lift revenue.


### 2️⃣ Optimise High-Demand Products

* Maintain steady inventory for grocery items
* Ensure competitive pricing for Cooking Gas
* Bundle essential products for a higher basket value


### 3️⃣ Strengthen Customer Retention

* Offer loyalty rewards for repeat buyers
* Send personalized offers to high-frequency customers
* Track repeat purchase behavior


### 4️⃣ Focus on High-Performing Locations

* Invest more marketing resources in Lagos
* Improve logistics and delivery speed in top markets
* Replicate Lagos strategies in other states


#  Conclusion

This SQL case study provided a structured, data-driven evaluation of RetailMartt’s:
* Revenue performance
* Customer behaviour
* Operational challenges

The analysis revealed:
* Revenue concentration in essential products
* A high order drop-off rate (68%)
* Strong impact of payment failures on order success
* Geographic revenue concentration

These insights can guide improvements in payment systems, product strategy, and growth planning.


## Tools & Skills Demonstrated

* SQL (JOINs, GROUP BY, Aggregations, Filtering, Sorting)
* Business problem framing
* Revenue analysis
* Customer behaviour analysis
* Insight generation & strategic recommendations
* Portfolio documentation


