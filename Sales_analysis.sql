use ecommerce;

#1. List all unique cities where customers are located.

SELECT DISTINCT
    (customer_city)
FROM
    customers;

#2. Count the number of orders placed in 2017.

SELECT 
    COUNT(order_id)
FROM
    orders
WHERE
    YEAR(order_purchase_timestamp) = 2017;

#3. Find the total sales per category.

SELECT 
    b.product_category, SUM(a.price)
FROM
    order_items a
        JOIN
    products b ON a.product_id = b.product_id
GROUP BY b.product_category;

#4. Calculate the percentage of orders that were paid in installments.

SELECT 
    ((SUM(CASE
        WHEN payment_installments > 1 THEN 1
        ELSE 0
    END)) / COUNT(order_id)) * 100 AS Percent_installments
FROM
    payments;
    
#5. Count the number of customers from each state. 

SELECT 
    customer_city, COUNT(*) AS count_cust
FROM
    customers
GROUP BY customer_city
ORDER BY count_cust DESC;

#6. Calculate the number of orders per month in 2018.

SELECT DISTINCT
    (MONTH(order_purchase_timestamp)) AS months,
    COUNT(*) as num_orders
FROM
    orders
where
   year(order_purchase_timestamp)=2018
GROUP BY months
order by months;

#7. Find the average number of products per order, grouped by customer city.

with count_per_order as (select orders.order_id, orders.customer_id, 
count(order_items.order_id) as oc
from orders join order_items
on orders.order_id = order_items.order_id
group by orders.order_id,orders.customer_id)

select customers.customer_city , avg(count_per_order.oc)
from customers join count_per_order
on customers.customer_id = count_per_order.customer_id
group by customers.customer_city
;

#8. Calculate the percentage of total revenue contributed by each product category.

SELECT 
    b.product_category,
    (SUM(a.price) / (SELECT 
            SUM(payment_value)
        FROM
            payments)) * 100 AS percent_sales
FROM
    order_items askin 
        JOIN
    products b ON a.product_id = b.product_id
GROUP BY b.product_category;


#9. Identify the correlation between product price and the number of times a product has been purchased.

SELECT 
    products.product_category,
    COUNT(order_items.product_id) as num_products,
    ROUND(AVG(order_items.price), 2) as avg_item_price
FROM
    products
        JOIN
    order_items ON products.product_id = order_items.product_id
GROUP BY products.product_category;


#10. Calculate the total revenue generated by each seller, and rank them by revenue.

select *, dense_rank() over(order by revenue desc) as rank_ from
(SELECT 
    order_items.seller_id,
    round(SUM(payments.payment_value),2) AS revenue
FROM
    order_items
        JOIN
    payments ON payments.order_id = order_items.order_id
GROUP BY order_items.seller_id
) as a; 


#11.Calculate the moving average of order values for each customer over their order history.

select customer_id,order_purchase_timestamp,
avg(payment) over(partition by customer_id order by order_purchase_timestamp
rows between 2 preceding and current row) as mov_avg
from
(SELECT 
    orders.customer_id,
    orders.order_purchase_timestamp,
    payments.payment_value as payment
FROM
    payments
        JOIN
    orders ON payments.order_id = orders.order_id) as a;  
    

#12. Calculate the cumulative sales per month for each year.

select years, months,payments,
sum(payments) over(order by years, months ) as cumulative_sales  from 
(SELECT 
    year(orders.order_purchase_timestamp) as years,
    month(orders.order_purchase_timestamp) as months,
    round(SUM(payments.payment_value),2) as payments
FROM payments join orders 
on orders.order_id = payments.order_id
group by years,months order by years,months) as a;

#13.Calculate the year-over-year growth rate of total sales

with a as 
(SELECT 
    YEAR(orders.order_purchase_timestamp) AS years,
    SUM(payments.payment_value) AS total_sales
FROM
    payments
        JOIN
    orders ON orders.order_id = payments.order_id
GROUP BY years
ORDER BY years)

select years,
((total_sales - lag(total_sales,1) over(order by years))/lag(total_sales,1) over(order by years))*100 as 'yoy_%_growth'
 from a ;

#14. Identify the top 3 customers who spent the most money in each year.

select years, customer_id, payment,d_rank from
(select year(orders.order_purchase_timestamp) as years, 
orders.customer_id,
sum(payments.payment_value) as payment,
dense_rank() over(partition by year(orders.order_purchase_timestamp) 
 order by sum(payments.payment_value) desc) as d_rank
from orders join payments 
on payments.order_id = orders.order_id
group by years,orders.customer_id) as a
where d_rank<=3;