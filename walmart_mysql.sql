USE walmart_db;
SELECT * FROM walmart;
-- 1.  Find different payment method and number of transactions, number of qty sold-- 
SELECT DISTINCT payment_method, COUNT(*) AS no_of_transactions, SUM(quantity) FROM walmart
GROUP BY payment_method;
-- 2. Identify the higher-rated category in each branch, displaying the branch, category and AVG rating.
SELECT * FROM
(SELECT branch, category, AVG(rating),
		RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS ranking
	 FROM walmart
     GROUP BY 1, 2
) AS tests
WHERE ranking = 1;

-- 3. Identify the busiest day for each branch base don the number of transactions	
SELECT * FROM
	(SELECT 
		branch, 
		DAYNAME(STR_TO_DATE(date, '%d/%m/%Y')) AS day_name,
		COUNT(*) AS no_of_transactions,
		RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS ranking
	FROM walmart
	GROUP BY 1, 2
	ORDER BY 1, 3 DESC) AS transactions
WHERE ranking = 1;

-- 4. Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.
SELECT payment_method, SUM(quantity) AS no_qty_sold FROM walmart
GROUP BY 1;

-- 5. Determine the average, minmimum, and maximum rating of products for each city.
-- 	  List the city, average_rating, min_rating, and max_rating.
SELECT 
	city, 
    AVG(rating) AS average_rating,
	MIN(rating) AS min_rating,
	MAX(rating) AS max_rating 
    FROM walmart
    GROUP BY city;
    
