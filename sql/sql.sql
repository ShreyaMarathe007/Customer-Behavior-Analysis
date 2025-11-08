-- DATA
select * from customer limit 5;


-- CUSTOMER ANALYSIS

-- number of customers 
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customer;
-- 3900

-- Average age of customer 
SELECT ROUND(AVG(age), 0) AS avg_age
FROM customer;
-- indicates that the customer base is primarily middle-aged

-- Gender and shopping trend
SELECT gender, COUNT(*) AS total_purchases, 
       ROUND(AVG(purchase_amount), 2) AS avg_spent,
       AVG(loyalty_score) AS avg_loyalty
FROM customer
GROUP BY gender;
-- female total purchase less than male but spending is more

-- Relationship between age and loyalty score: 
SELECT age_group,  COUNT(*) AS total_purchases, 
AVG(loyalty_score) AS avg_loyalty
FROM customer
GROUP BY age_group
ORDER BY avg_loyalty DESC;
-- Senior found to be more loyal than Adult

-- Subscription status vs purchase behavior 
SELECT subscription_status,
       AVG(previous_purchases) AS avg_prev,
       AVG(purchase_amount) AS avg_spent,
       AVG(loyalty_score) AS avg_loyalty
FROM customer
GROUP BY subscription_status;
-- suscribers are more loyal but both suscribers and non-suscribers spend same on average


-- PRODUCT AND CATEGORY PERFORMANCE

-- Top selling categories
SELECT category, COUNT(*) AS total_orders
FROM customer
GROUP BY category
ORDER BY total_orders DESC;
-- Clothing category followed by Accessories


-- Which category generates the highest revenue? 
SELECT category, SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY category
ORDER BY total_revenue DESC;
-- Clothing generate high revenue in categories while Outwear is at bottom in the list

-- Most popular item purchased 
SELECT item_purchased, COUNT(*) AS total_orders
FROM customer
GROUP BY item_purchased
ORDER BY total_orders DESC
LIMIT 5;
-- Blouse, Pants, Jewelry, Shirt, Dress 

-- Categories by rating
SELECT category, ROUND(AVG(review_rating), 2) AS avg_rating
FROM customer
GROUP BY category
ORDER BY avg_rating DESC;
-- Footwear followed by Accessories, Outwear and Clothing

-- top 5 products with high avg review rating 
select item_purchased , Round(AVG(review_rating) ,2) as AverageProductRating
from customer
group by item_purchased
order by AverageProductRating desc
limit 5;
-- gloves, sandals, boots , hat, tshirt

-- Most preferred colors in all categories
SELECT color, COUNT(*) AS total_purchases
FROM customer 
GROUP BY color
ORDER BY total_purchases DESC
LIMIT 5;
-- Olive, Yellow, Silver, Teal, Green

-- Most preferred colors in Clothing
SELECT color
FROM customer where category = 'Clothing'
GROUP BY color
ORDER BY COUNT(item_purchased) DESC
LIMIT 1;
-- Teal

-- Which season drives the most purchases? 
SELECT season, SUM(purchase_amount) AS total_spent
FROM customer
GROUP BY season
ORDER BY total_spent DESC;
-- Customer prefer to purchase more in fall season followed by Spring and Winter


-- DISCOUNT AND PURCHASE BEHAVIOUR

-- Average amount of purchase with or without discount
SELECT discount_applied, 
       ROUND(AVG(purchase_amount), 2) AS avg_purchase
FROM customer
GROUP BY discount_applied;
-- average amount is slightly less when discount is applied

-- aveage frequncy days of purchase among age groups
SELECT age_group, ROUND(AVG(purchase_cycle_days), 0) AS avg_cycle
FROM customer
GROUP BY age_group
ORDER BY avg_cycle;
-- Adults purchase more frequently than Seniors

-- Most loyal and frequent customers
SELECT customer_id, frequency_of_purchases, loyalty_score
FROM customer
ORDER BY purchase_cycle_days, loyalty_score DESC
LIMIT 10;

-- Average purchase rate and avergae loyalty 
SELECT ROUND(AVG(purchase_amount), 2) AS avg_spent, 
       ROUND(AVG(loyalty_score), 2) AS avg_loyalty
FROM customer;
-- average purchase amount by each customer is around 60 USD

-- which customer spent more than average with discount
SELECT customer_id, purchase_amount
from customer
where discount_applied = 'Yes' and purchase_amount > (Select AVG(purchase_amount) from customer);
SELECT count(customer_id)
from customer
where discount_applied = 'Yes' and purchase_amount > (Select AVG(purchase_amount) from customer);
-- total 839 customers

-- Do customers buy more during discounts? 
SELECT discount_applied, AVG(purchase_amount) AS avg_spent, COUNT(*) AS num_orders
FROM customer
GROUP BY discount_applied;
-- No, may indicate discounts are do not attract customers 


-- REGIONAL INSIGHTS

SELECT location, SUM(purchase_amount) AS total_sales
FROM customer
GROUP BY location
ORDER BY total_sales DESC;
-- Top 5 are : Montana, Illinois, California, Idaho, Nevada

-- Average spend by loaction
SELECT location, ROUND(AVG(purchase_amount), 2) AS avg_spent
FROM customer
GROUP BY location
ORDER BY avg_spent DESC;


-- PAYMENT AND SHIPPING INSIGHTS

-- How many Customers prefer digital payment 
SELECT is_digital_payment, COUNT(*) AS total_orders
FROM customer
GROUP BY is_digital_payment;
-- 83% of the customers pay digitally

-- Most commonly used payment category 
SELECT payment_category, COUNT(*) AS usage_count
FROM customer
GROUP BY payment_category
ORDER BY usage_count DESC; 
-- Digital Wallet

-- Most used payment method 
SELECT payment_method, COUNT(*) AS usage_count,
	AVG(purchase_amount) AS avg_spent
FROM customer
GROUP BY payment_method
ORDER BY usage_count DESC;
-- Paypal and Credit Card

-- Do digital payments correlate with higher loyalty score? 
SELECT is_digital_payment, AVG(loyalty_score) AS avg_loyalty
FROM customer
GROUP BY is_digital_payment;
-- No, payment has no relation with layalty score

-- Most preferred shipping type 
SELECT shipping_type, COUNT(*) AS total_orders, avg(purchase_amount) as average_purchase_amount
FROM customer
GROUP BY shipping_type
ORDER BY total_orders DESC;
-- Free Shipping

-- Average Purchase Amount by Shipping Type
SELECT shipping_type, AVG(purchase_amount) AS avg_spent
FROM customer
GROUP BY shipping_type
ORDER BY avg_spent DESC;

-- Shipping type and review rating 
SELECT shipping_type, AVG(review_rating) AS avg_rating
FROM customer
GROUP BY shipping_type
ORDER BY avg_rating DESC;
-- Standard shipping is high rated followed by Express and 2-Day shipping













































