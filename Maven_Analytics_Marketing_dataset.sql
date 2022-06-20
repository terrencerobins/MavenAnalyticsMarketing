-- Observing the dataset -- 
SELECT *
FROM marketing.data

-- Getting a total row count --
SELECT COUNT(*)
FROM 
	marketing.data

-- Checking the dataset for duplicate ID's (returned the same row count as the previous query) --
SELECT 
	DISTINCT(id)
FROM 
	marketing.data 

-- Ensuring the string length for Year_Birth is 4 for the entire dataset (zero rows returned) --
SELECT 
	LENGTH(Year_Birth)
FROM 
	marketing.data
WHERE
	LENGTH(Year_Birth) > 4 OR
    LENGTH(Year_Birth) < 4

-- Checking for nulls in the Income Column (Zero Rows Returned) --
SELECT 
    id,
    Income
FROM i
	marketing.data
WHERE 
	Income IS NULL

-- Checking for nulls in the Year_Birth column (Zero Rows Returned) -- 
SELECT 
    id,
    Year_Birth
FROM 
	marketing.data
WHERE
	Year_Birth IS NULL

-- Observing the sum of sales for each category --
SELECT 
	SUM(MntWines) AS wine_sales,
    SUM(MntFruits) AS fruit_sales,
    SUM(MntMeatProducts) AS meat_sales,
    SUM(MntFishProducts) AS fish_sales,
    SUM(MntSweetProducts) AS sweet_sales,
    SUM(MntGoldProds) AS gold_sales
FROM 
	marketing.data
    
-- Observing the sum of sales for each category, grouped by country --
SELECT
	Country,
	SUM(MntWines) AS wine_sales,
    SUM(MntFruits) AS fruit_sales,
    SUM(MntMeatProducts) AS meat_sales,
    SUM(MntFishProducts) AS fish_sales,
    SUM(MntSweetProducts) AS sweet_sales,
    SUM(MntGoldProds) AS gold_sales
FROM 
	marketing.data
GROUP BY 1

-- Observing the sum of sales per category, grouped by children at home --
SELECT
	Kidhome AS children_at_home,
	SUM(MntWines) AS wine_sales,
    SUM(MntFruits) AS fruit_sales,
    SUM(MntMeatProducts) AS meat_sales,
    SUM(MntFishProducts) AS fish_sales,
    SUM(MntSweetProducts) AS sweet_sales,
    SUM(MntGoldProds) AS gold_sales
FROM 
	marketing.data
GROUP BY 1

-- Observing the total quantity of sales per category, by teens at home --
SELECT
	Teenhome AS teens_at_home,
	SUM(MntWines) AS wine_orders,
    SUM(MntFruits) AS fruit_orders,
    SUM(MntMeatProducts) AS meat_orders,
    SUM(MntFishProducts) AS fish_orders,
    SUM(MntSweetProducts) AS sweet_orders,
    SUM(MntGoldProds) AS gold_orders
FROM 
	marketing.data
GROUP BY 1
ORDER BY 2 DESC, 3 DESC, 4 DESC, 5 DESC, 6 DESC , 7 DESC

-- Observing the quantity of transaction types --
SELECT 
	SUM(NumDealsPurchases) AS deal_purchases,
    SUM(NumWebPurchases) AS web_purchases,
    SUM(NumCatalogPurchases) AS catalog_purchases,
    SUM(NumStorePurchases) AS store_purchases
FROM
	marketing.data

-- Oberserving the transaction types, grouped by country --
SELECT 
	country,
	SUM(NumDealsPurchases) AS deal_purchases,
    SUM(NumWebPurchases) AS web_purchases,
    SUM(NumCatalogPurchases) AS catalog_purchases,
    SUM(NumStorePurchases) AS store_purchases
FROM 
	marketing.data
GROUP BY 1
ORDER BY 2 DESC, 3 DESC, 4 DESC, 5 DESC

-- Observing the transaction types, grouped by kids at home --
SELECT 
	Kidhome,
	SUM(NumDealsPurchases) AS deal_purchases,
    SUM(NumWebPurchases) AS web_purchases,
    SUM(NumCatalogPurchases) AS catalog_purchases,
    SUM(NumStorePurchases) AS store_purchases
FROM 
	marketing.data
GROUP BY 1
ORDER BY 1,  2 DESC, 3 DESC, 4 DESC, 5 DESC

-- Observing the transaction types, grouped by teens at home --
SELECT 
	Teenhome,
	SUM(NumDealsPurchases) AS deal_purchases,
    SUM(NumWebPurchases) AS web_purchases,
    SUM(NumCatalogPurchases) AS catalog_purchases,
    SUM(NumStorePurchases) AS store_purchases
FROM 
	marketing.data
GROUP BY 1
ORDER BY 1,  2 DESC, 3 DESC, 4 DESC, 5 DESC

-- Sum of sales per category for web purchases --
SELECT 
	SUM(MntWines) AS wine_sales,
    SUM(MntFruits) AS fruit_sales,
    SUM(MntMeatProducts) AS meat_sales,
    SUM(MntFishProducts) AS fish_sales,
    SUM(MntSweetProducts) AS sweet_sales,
    SUM(MntGoldProds) AS gold_sales
FROM 
	marketing.data
WHERE 
	NumWebPurchases IN (MntWines,
						MntFruits,
						MntMeatProducts,
                        MntFishProducts,
                        MntSweetProducts,
                        MntGoldProds)
                        
-- Sum of Sales for store purchases --
SELECT 
	SUM(MntWines) AS wine_sales,
    SUM(MntFruits) AS fruit_sales,
    SUM(MntMeatProducts) AS meat_sales,
    SUM(MntFishProducts) AS fish_sales,
    SUM(MntSweetProducts) AS sweet_sales,
    SUM(MntGoldProds) AS gold_sales
FROM 
	marketing.data
WHERE 
	NumStorePurchases IN (MntWines,
						MntFruits,
						MntMeatProducts,
                        MntFishProducts,
                        MntSweetProducts,
                        MntGoldProds)
						

-- Observing the youngest and oldest customers in the dataset -- 
SELECT 
	MIN(Year_Birth) AS oldest_cust,
    MAX(Year_Birth) AS youngest_cust
FROM
	marketing.data

-- Segmenting the customers into three categories, then counting the total # of customers in each segment --
SELECT
	COUNT(CASE WHEN Year_Birth >= 1893 AND Year_Birth <= 1962 THEN 1 END) AS age_60_plus,
    COUNT(CASE WHEN Year_Birth >= 1963 AND Year_Birth <= 1981 THEN 1 END) AS age_41_to_59,
    COUNT(CASE WHEN Year_Birth >= 1982 AND Year_Birth <= 1996 THEN 1 END) AS age_40_and_under
FROM 
	marketing.data
    
-- Observing the quantity of sales per category, grouped into each age segment --
SELECT
	CASE WHEN Year_Birth >= 1893 AND Year_Birth <= 1962 THEN 'age_60_plus'
	WHEN Year_Birth >= 1963 AND Year_Birth <= 1981 THEN 'age_41_to_59'
	WHEN Year_Birth >= 1982 AND Year_Birth <= 1996 THEN 'age_40_and_under'
    END as customer_demographic,
	SUM(MntWines) AS wine_orders,
    SUM(MntFruits) AS fruit_orders,
    SUM(MntMeatProducts) AS meat_orders,
    SUM(MntFishProducts) AS fish_orders,
    SUM(MntSweetProducts) AS sweet_orders,
    SUM(MntGoldProds) AS gold_orders
FROM
	marketing.data
GROUP BY 1
ORDER BY 2 DESC, 3 DESC, 4 DESC, 5 DESC, 6 DESC, 7 DESC

-- Average income per Country --
SELECT
	Country,
    AVG(Income) AS avg_income
FROM 
	marketing.data
GROUP BY 1
ORDER BY 2 DESC

-- Average income per customer age segment --
SELECT
	CASE WHEN Year_Birth >= 1893 AND Year_Birth <= 1962 THEN 'age_60_plus'
	WHEN Year_Birth >= 1963 AND Year_Birth <= 1981 THEN 'age_41_to_59'
	WHEN Year_Birth >= 1982 AND Year_Birth <= 1996 THEN 'age_40_and_under'
    END as customer_demographic,
    AVG(Income)
FROM 
	marketing.data
GROUP BY 1
ORDER BY 2

-- Observing the total # of complaints per country--
SELECT 
	country,
    SUM(complain)
FROM 
	marketing.data
GROUP BY 1

-- Oberserving the total # of complaints per age demographic--
SELECT 
	CASE WHEN Year_Birth >= 1893 AND Year_Birth <= 1962 THEN 'age_60_plus'
	WHEN Year_Birth >= 1963 AND Year_Birth <= 1981 THEN 'age_41_to_59'
	WHEN Year_Birth >= 1982 AND Year_Birth <= 1996 THEN 'age_40_and_under'
    END as customer_demographic,
    SUM(complain)
FROM 
	marketing.data
GROUP BY 1
ORDER BY 2 DESC

-- Average # transactions per transaction type (per customer) -- 
SELECT 
	AVG(NumWebPurchases) AS avg_web,
    AVG(NumStorePurchases) AS avg_store,
    AVG(NumCatalogPurchases) AS avg_catalog,
    AVG(NumDealsPurchases) AS avg_deal
FROM 
	marketing.data

-- Average # transactions per transaction type, grouped by country --
SELECT
	country,
	AVG(NumWebPurchases) AS avg_web,
    AVG(NumStorePurchases) AS avg_store,
    AVG(NumCatalogPurchases) AS avg_catalog,
    AVG(NumDealsPurchases) AS avg_deal
FROM
	marketing.data
GROUP BY 1
ORDER BY 2 DESC

-- Average # of transactions per type, grouped by age demographic -- 
SELECT
	CASE WHEN Year_Birth >= 1893 AND Year_Birth <= 1962 THEN 'age_60_plus'
	WHEN Year_Birth >= 1963 AND Year_Birth <= 1981 THEN 'age_41_to_59'
	WHEN Year_Birth >= 1982 AND Year_Birth <= 1996 THEN 'age_40_and_under'
    END as customer_demographic,
	AVG(NumWebPurchases) AS avg_web,
    AVG(NumStorePurchases) AS avg_store,
    AVG(NumCatalogPurchases) AS avg_catalog,
    AVG(NumDealsPurchases) AS avg_deal
    
FROM
	marketing.data
GROUP BY 1
ORDER BY 2 DESC

-- Observing which campaign had the most enrolled customers --
SELECT 
	SUM(AcceptedCmp1) AS camp_1,
    SUM(AcceptedCmp2) AS camp_2,
    SUM(AcceptedCmp3) AS camp_3,
    SUM(AcceptedCmp4) AS camp_4,
    SUM(AcceptedCmp5) AS camp_5
FROM
	marketing.data

-- Grouping the total campaign enrollment by Country --
SELECT 
	Country,
    SUM(AcceptedCmp1) AS camp_1,
    SUM(AcceptedCmp2) AS camp_2,
    SUM(AcceptedCmp3) AS camp_3,
    SUM(AcceptedCmp4) AS camp_4,
    SUM(AcceptedCmp5) AS camp_5
FROM
	marketing.data
GROUP BY 1
ORDER BY 2 desc, 3 desc, 4 desc, 5 desc, 6 desc

-- Taking the campaign enrollment and grouping by the customer age segments --
SELECT 
	CASE WHEN Year_Birth >= 1893 AND Year_Birth <= 1962 THEN 'age_60_plus'
	WHEN Year_Birth >= 1963 AND Year_Birth <= 1981 THEN 'age_41_to_59'
	WHEN Year_Birth >= 1982 AND Year_Birth <= 1996 THEN 'age_40_and_under'
    END as customer_demographic,
    SUM(AcceptedCmp1) AS camp_1,
    SUM(AcceptedCmp2) AS camp_2,
    SUM(AcceptedCmp3) AS camp_3,
    SUM(AcceptedCmp4) AS camp_4,
    SUM(AcceptedCmp5) AS camp_5
FROM 
	marketing.data
GROUP BY 1
ORDER BY 1 

-- Campaign Overview #1 --
SELECT
	SUM(NumWebPurchases) AS web_trans,
    SUM(NumStorePurchases) AS store_trans,
    SUM(NumCatalogPurchases) AS cat_trans,
    SUM(NumDealsPurchases) AS deal_trans
FROM 
	marketing.data
WHERE 
	AcceptedCmp1 IN
(		NumWebPurchases,
		NumStorePurchases,
        NumCatalogPurchases,
        NumDealsPurchases
)

-- Campaign Overview #2 --
SELECT
	SUM(NumWebPurchases) AS web_trans,
    SUM(NumStorePurchases) AS store_trans,
    SUM(NumCatalogPurchases) AS cat_trans,
    SUM(NumDealsPurchases) AS deal_trans
FROM 
	marketing.data
WHERE 
	AcceptedCmp2 IN
(		NumWebPurchases,
		NumStorePurchases,
        NumCatalogPurchases,
        NumDealsPurchases
)

-- Campaign Overview #3 --
SELECT
	SUM(NumWebPurchases) AS web_trans,
    SUM(NumStorePurchases) AS store_trans,
    SUM(NumCatalogPurchases) AS cat_trans,
    SUM(NumDealsPurchases) AS deal_trans
FROM 
	marketing.data
WHERE 
	AcceptedCmp3 IN
(		NumWebPurchases,
		NumStorePurchases,
        NumCatalogPurchases,
        NumDealsPurchases
)

-- Campaign Overview #4 --
SELECT
	SUM(NumWebPurchases) AS web_trans,
    SUM(NumStorePurchases) AS store_trans,
    SUM(NumCatalogPurchases) AS cat_trans,
    SUM(NumDealsPurchases) AS deal_trans
FROM 
	marketing.data
WHERE 
	AcceptedCmp4 IN
(		NumWebPurchases,
		NumStorePurchases,
        NumCatalogPurchases,
        NumDealsPurchases
)		

-- Campaign Overview #5 --
SELECT
	SUM(NumWebPurchases) AS web_trans,
    SUM(NumStorePurchases) AS store_trans,
    SUM(NumCatalogPurchases) AS cat_trans,
    SUM(NumDealsPurchases) AS deal_trans
FROM 
	marketing.data
WHERE 
	AcceptedCmp5 IN
(		NumWebPurchases,
		NumStorePurchases,
        NumCatalogPurchases,
        NumDealsPurchases
)


