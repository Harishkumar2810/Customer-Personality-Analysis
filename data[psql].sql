CREATE TABLE Data (
    ID INT PRIMARY KEY,
    Year_Birth INT,
    Education VARCHAR(50),
    Marital_Status VARCHAR(20),
    Income DECIMAL(15, 2),
    Kidhome INT,
    Teenhome INT,
    Dt_Customer DATE,
    Recency INT,
    MntWines DECIMAL(10, 2),
    MntFruits DECIMAL(10, 2),
    MntMeatProducts DECIMAL(10, 2),
    MntFishProducts DECIMAL(10, 2),
    MntSweetProducts DECIMAL(10, 2),
    MntGoldProds DECIMAL(10, 2),
    NumDealsPurchases INT,
    NumWebPurchases INT,
    NumCatalogPurchases INT,
    NumStorePurchases INT,
    NumWebVisitsMonth INT,
    AcceptedCmp3 INT,
    AcceptedCmp4 INT,
    AcceptedCmp5 INT,
    AcceptedCmp1 INT,
    AcceptedCmp2 INT,
    Complain INT,
    Z_CostContact DECIMAL(10, 2),
    Z_Revenue DECIMAL(10, 2),
    Response INT
);

select * from data;
select count(*) from data;

delete FROM data WHERE income IS NULL;


-- find the top 5 customers who spent the most on wine (MntWines). Show their ID and MntWines only
select id, Mntwines from data order by Mntwines desc limit 5;

--how many customers have kids at home (Kidhome > 0) and how many don’t. Show two columns: Has_Kids (Yes/No) and Customer_Count
select case when kidhome > 0 then 'Yes'
else 'No'
end as haskids, count(*)
from data GROUP BY 1  order by 2 desc;

--Which education level has the highest average income
select education, round(avg(income),2)as Avg_income from data group by 1 order by 2 desc;

-- How many customers made more than 5 web purchases 
select count(*) from data where numwebpurchases > 5;

--Total amount spent on wine, fruits, and meat by each customer

SELECT 
  id,income,
  ROUND(mntwines, 2) AS wine_spent,
  ROUND(mntfruits, 2) AS fruit_spent,
  ROUND(mntmeatproducts, 2) AS meat_spent, mntwines + mntfruits + mntmeatproducts as total_spent
FROM data;

--  top 5 customers who have the highest total spending on wine, fruits, and meat combined

with top_5 as(SELECT 
  id,income,
  ROUND(mntwines, 2) AS wine_spent,
  ROUND(mntfruits, 2) AS fruit_spent,
  ROUND(mntmeatproducts, 2) AS meat_spent, mntwines + mntfruits + mntmeatproducts as total_spent
FROM data), 
ranked as(
 select id,income, total_spent, dense_rank() over (order by total_spent desc)as top_list from top_5)
SELECT id, income, total_spent, top_list
FROM ranked
WHERE top_list <= 5;

-- average income for each marital status group
select distinct(marital_status) from data

select marital_status, round(avg(income),2) as avg_income from data group by marital_status order by avg_income desc;

-- Find the total number of customers who no kids and teenagers at home
select count(*) from data where kidhome=0 and teenhome=0

--Find the top 5 months where the most customers joined the platform
select distinct(date_part('year', dt_customer)) from data;

with customer_count as(select count(*) as customer, date_part('year',dt_customer)as year, date_part('month',dt_customer)as Month from data group by 2,3)
select * from customer_count where year=2012;

--Find the month (in 2014) with the highest number of new customers.
with customer_count as(select count(*) as customer, date_part('year',dt_customer)as year, date_part('month',dt_customer)as Month from data group by 2,3)
select customer, year, month from customer_count where year=2014 order by 1 desc limit 2;

--Find the month with the lowest number of new customers in the year 2013.
with customer_count as(select count(*) as customer, date_part('year',dt_customer)as year, date_part('month',dt_customer)as Month from data group by 2,3)
select customer, year, month from customer_count where year=2013 order by 1 asc limit 1;

--Find the average income of customers who joined in the year 2013
select round(avg(income),2) avg_incomes from data where date_part('year',dt_customer) =2013;

-- Find the number of customers who have not made any purchases — i.e., their spending on wine, fruits, meat products, fish products, sweet products, and gold products is all zero.
select count(*)as non_spending_customers from data where mntwines=0 and mntfruits=0 and mntmeatproducts=0 and mntfishproducts=0 and mntsweetproducts=0 and mntgoldprods=0

--Find the top 3 customers in each year based on their total spending (sum of mntwines, mntfruits, mntmeatproducts, mntfishproducts, mntsweetproducts, mntgoldprods).
with cte as(select id, date_part('year',dt_customer)year, (mntwines+mntfruits+mntmeatproducts+mntfishproducts+mntsweetproducts+mntgoldprods)total from data),with ranks as(
select id,year,total, rank() over (partition by year order by total)as rank from cte)
SELECT * 
FROM ranks
WHERE rank <= 3
ORDER BY year, rank;



WITH spending_cte AS (
  SELECT 
    id, 
    DATE_PART('year', dt_customer) AS year,
    (mntwines + mntfruits + mntmeatproducts + mntfishproducts + mntsweetproducts + mntgoldprods) AS total_spent
  FROM data
),
ranked_cte AS (
  SELECT 
    id,
    year,
    total_spent,
    RANK() OVER (PARTITION BY year ORDER BY total_spent DESC) AS rank
  FROM spending_cte
)
SELECT * 
FROM ranked_cte
WHERE rank <= 3
ORDER BY year, rank;

-- Which marital status group has the highest average spending across all product categories combined
select marital_status, round(avg(mntwines + mntfruits + mntmeatproducts + mntfishproducts + mntsweetproducts + mntgoldprods),2) AS total_spent from data 
group by marital_status order by marital_status;

select * from data

--Find the top 3 education levels by average total customer spending.
with education as (select education, round(avg(mntwines + mntfruits + mntmeatproducts + mntfishproducts + mntsweetproducts + mntgoldprods),2) AS total_spent from data 
 group by education)
select * from education order by total_spent desc limit 3

-- Identify the top 3 customer acquisition months (across all years) based on the number of new customers,and calculate the average income of customers acquired in those months
select * from(select round(avg(income),2)as avg_income,count(*)as customer_count, date_part('month',dt_customer)as month from data group by month)order by customer_count desc limit 3

-- which  marital status and education level combinations have the highest average total spending?
select marital_status, education, round(avg(mntwines + mntfruits + mntmeatproducts + mntfishproducts + mntsweetproducts + mntgoldprods),2) AS total_spent from data
group by 1,2 order by 3 desc limit 5

-- Customer Behavior Clustering 
SELECT id, CASE WHEN numwebpurchases + numstorepurchases > 10 THEN 'Frequent Buyer'
ELSE 'Occasional Buyer'
END AS behavior_type FROM data;

-- Yearly spending trend:
SELECT DATE_PART('year', dt_customer) AS year,
ROUND(AVG(mntwines + mntfruits + mntmeatproducts + mntfishproducts + mntsweetproducts + mntgoldprods), 2) AS avg_spending FROM data GROUP BY 1;

