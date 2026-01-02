SELECT * FROM DBO.customer 

--Q1. What is the total revenue gererated by male vs female customer
SELECT gender,SUM(purchase_amount) as total_revenue
FROM dbo.customer
GROUP BY gender; 

--Q2. Which customers used a discount but still spent more than the average purchase amount? 
SELECT customer_id , purchase_amount
from DBO.customer
WHERE discount_applied = 'YES' and purchase_amount > (SELECT AVG(purchase_amount) FROM DBO.customer)


--Q3. Which are the top 5 products with the highest average review rating?
SELECT TOP 5 
    item_purchased, 
    ROUND(AVG(CAST(review_rating AS float)), 2) AS [Average Product Rating]
FROM dbo.customer
GROUP BY item_purchased
ORDER BY AVG(review_rating) DESC;

--Q4. Compare the average Purchase Amounts between Standard and Express Shipping.
SELECT shipping_type , AVG(purchase_amount) as [Average Purchase Amount] FROM dbo.customer
WHERE shipping_type in ('Express','Standard')
GROUP BY shipping_type

--Q5. Do subscribed customers spend more? Compare average spend and total revenue 
--between subscribers and non-subscribers.
SELECT 
    subscription_status,
    COUNT(customer_id) AS total_customers,
    ROUND(AVG(purchase_amount), 2) AS [avg_spend], -- เพิ่มคอมม่าตรงนี้
    ROUND(SUM(purchase_amount), 2) AS [total_revenue]
FROM dbo.customer
GROUP BY subscription_status
ORDER BY [total_revenue] DESC; -- เพิ่ม DESC ถ้าต้องการดูรายได้จากมากไปน้อย

--Q6. Which 5 products have the highest percentage of purchases with discounts applied?
SELECT TOP 5 item_purchased,
ROUND(100 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS discount_rate
FROM dbo.customer
GROUP BY item_purchased
ORDER BY discount_rate DESC


--Q7. Segment customers into New, Returning, and Loyal based on their total
--number of previous purchases, and show the count of each segment.

WITH customer_type as(
    SELECT 
        CASE WHEN previous_purchases = 1 THEN 'New'
             WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Rturning'
             ELSE 'Loyal'
             END AS customer_segment
    FROM dbo.customer)

SELECT customer_segment , count(*) as 'Number of Customers'
FROM customer_type
GROUP BY customer_segment
ORDER BY count(*) DESC

--Q8. What are the top 3 most purchased products within each category?


WITH item_counts AS (
    SELECT
        category,
        item_purchased,
        COUNT(customer_id) as total_orders,
        DENSE_RANK() OVER(PARTITION BY category ORDER BY count(customer_id) DESC) as item_rank
    FROM dbo.customer
    GROUP BY category, item_purchased
)

SELECT item_rank,category,item_purchased,total_orders
FROM item_counts
WHERE item_rank <= 3

--Q9. Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
select subscription_status,
       count(customer_id) as repeat_buyers
from dbo.customer
where previous_purchases > 5 
group by subscription_status

--Q10. What is the revenue contribution of each age group? 
select age_group , sum(purchase_amount) as total_revenue
from dbo.customer
group by age_group
order by sum(purchase_amount) desc