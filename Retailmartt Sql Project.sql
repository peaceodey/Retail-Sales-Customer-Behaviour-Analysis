create database Retailmartt;
    
    #I made use of the USE statement
    Use Retailmartt;
    
    #I created Customers table
    create table customers
    (
		customer_id integer primary key,
		customer_name varchar (100), 
		gender varchar (100),
		age integer,
		location varchar (100),
		signup_date date
    );
    
    #I created Orders table
    create table orders
    (
		order_id integer primary key,
		customer_id integer,
		order_date date,
		order_status varchar (100)
);

#I created Product table
create table product
	(
	product_id integer primary key,
	category varchar (100),
	product_name varchar (100),
	price integer
	);
    
    #I created a Orderitems table
    create table orderitems
		(
		order_item_id integer primary key,
		order_id integer,
		product_id integer,
		quantity integer,
		unit_price integer
		);
        
        #I created a Payment table
        create table payment
        (
        payment_id integer primary key,
        order_id integer,
        payment_method varchar (100),
        payment_status varchar (100),
        payment_date date 
        );
        
#I imported orders table
		select *
		from orders;
 
 #I imported customers table
	 select *
	 from customers;
     
  #I importred orderitems table
	  select *
	  from orderitems;
      
   #I imported payment table
	   select *
	   from payment;
 
#I imported product table
	  select *
	  from product;
      
      
      # Business Questions 
      
      #1.  Which products generate the highest total sales?
      SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM product p
JOIN orderitems oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_sales DESC;
#Cooking gas is the top-selling product, generating the highest total sales of 19,192. This indicates strong demand for essential household items and highlights cooking gas as a key contributor to overall revenue.
   
   #2. Which product categories perform best in sales? 
   SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM product p
JOIN orderitems oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_sales DESC;
#The groceries category generates the highest total sales, making it the strongest-performing product category. This suggests consistent customer demand and positions groceries as a key driver of overall revenue growth.

#3. How many orders are completed, cancelled, or pending?
SELECT
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
# Cancelled orders represent the highest volume at 422, followed by pending orders at 399, while completed orders are the lowest at 379. This indicates a significant drop-off in the order process, suggesting opportunities to improve fulfillment and payment processes to increase successful order completion.

#4. Do failed payments affect order completion?
SELECT
		p.payment_status,
		o.order_status,
		COUNT(o.order_id) AS total_orders
	FROM orders o
	JOIN payment p
		ON o.order_id = p.order_id
	GROUP BY
		p.payment_status,
		o.order_status
	ORDER BY
	p.payment_status,
		total_orders DESC;
	# Orders with failed payments are more likely to be cancelled or remain pending than completed. This indicates a strong link between payment failure and unsuccessful order completion, suggesting that improving payment success rates could significantly reduce cancellations and increase completed orders.
 
 #5. Which customers place the most orders?
 Select c. customer_id,
 c.customer_name,
Count(o.order_id) as total_order
From customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
group by customer_id,
customer_name
order by total_order desc;
#Anna Ojo is the most active customer, placing a total of 9 orders. This indicates strong engagement and repeat purchasing behavior, suggesting an opportunity to strengthen customer loyalty through personalized offers or retention programs.

#6  Which locations generate the most sales?
SELECT
    c.location,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN orderitems oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.location
ORDER BY total_sales DESC;
# Customers from Lagos generate the highest total sales, with ₦87,309 in completed order revenue. This indicates that Lagos is the strongest revenue-driving location and a key market for the business, making it a strategic focus for growth and targeted marketing efforts.
