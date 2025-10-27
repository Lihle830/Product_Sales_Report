---CHECKING NULLS
SELECT
    COUNT(*) AS NullOrZeroCount
FROM workspace.sales.inventory
WHERE `Quantity Sold` IS NULL 
OR `Quantity Sold` = 0;


---QUESTION 1
---What is the daily sales price per unit?
SELECT
    Date,
    Sales,
    `Quantity Sold`,
    ROUND(Sales / `Quantity Sold`,2) AS Sales_Price_Per_Unit
FROM workspace.sales.inventory

---QUESTION 2
---What is the average unit sales price of this product?

SELECT 
    ROUND(SUM(Sales) / SUM(`Quantity Sold`),2) AS Avg_Unit_Sales_Price
FROM workspace.sales.inventory

--QUESTION 3
--What is the daily % gross profit?
SELECT
    Date,
    Sales,
    `Cost Of Sales`,
    ROUND((Sales - `Cost Of Sales`) / Sales * 100,2) AS Daily_Gross_Profit_Percent
FROM workspace.sales.inventory;

--QUESTION 4
---What is the daily % gross profit per unit?

SELECT
    Date,
    Sales,
    `Cost Of Sales`,
    `Quantity Sold`,
    (Sales / `Quantity Sold`) AS SalesPerUnit,
    (`Cost Of Sales` / `Quantity Sold`) AS CostPerUnit,
    ((Sales / `Quantity Sold` - `Cost Of Sales` / `Quantity Sold`) / (Sales / `Quantity Sold`) * 100) AS GrossProfitPercentPerUnit
FROM workspace.sales.inventory;

---QUESTION 5
--- Pick any 3 periods during which this product was on promotion/special:
---What was the Price Elasticity of Demand during each of these periods?
---In your opinion, does this product perform better or worse when sold at a promotional price?
SELECT DISTINCT 
    YEAR(Date) AS year,
    DATE_FORMAT(Date, 'MMMM') AS month
FROM workspace.sales.inventory
ORDER BY year, month;

SELECT 
    YEAR(Date) AS Year,
    DATE_FORMAT( Date, 'MMMM') AS Month,
    SUM(Sales) AS Total_Sales,
    SUM(`Cost Of Sales`) AS Total_Cost,
    SUM(`Quantity Sold`) AS Total_Quantity
FROM workspace.sales.inventory
GROUP BY YEAR(Date), DATE_FORMAT( Date, 'MMMM'),MONTH(Date)
ORDER BY Year, MONTH(Date);
