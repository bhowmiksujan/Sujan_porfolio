1.Write a query to f1nd the customers who have placed orders for products with a price greater than $100.
Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order„date), Products (product_id, product_name, price), Order_DetaiIs (order_id, product_id, quantity)
 
SELECT DISTINCT C.customer_id, C.customer_name
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Details OD ON O.order_id = OD.order_id
JOIN Products P ON OD.product_id = P.product_id
WHERE P.price > 100;

2.Write a query to find the customers who have placed orders for more than two difierent products.
Dataset: Customers (customer_id, customer_name), Orders (order_id, customer_id, order„date), Order„ltems (order_id, product_id, quantity)

SELECT C.customer_id, C.customer_name
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
GROUP BY C.customer_id, C.customer_name
HAVING COUNT(DISTINCT OI.product_id) > 2;

3.Get a list of products and the total quantity ordered for each product.
Dataset: Products (product_id, product_name), Order_ltems(order_id, product_id, quantity)

SELECT P.product_id, P.product_name, SUM(OI.quantity) AS total_quantity_ordered
FROM Products P
LEFT JOIN Order_Items OI ON P.product_id = OI.product_id
GROUP BY P.product_id, P.product_name;

4.Get the list of employees sorted by their salary in descending order. NULL values should appear at the beginning. 
Dataset: Employees (empIoyee_id, empIoyee_name, salary)

SELECT employee_id, employee_name, salary
FROM Employees
ORDER BY (CASE WHEN salary IS NULL THEN 0 ELSE 1 END), salary DESC;

5.Calculate the average rating and the number of reviews for each product category.
 Dataset: Products (product_id, product„name, category id), Reviews (product_id, rating)

SELECT P.category_id,
       AVG(R.rating) AS average_rating,
       COUNT(R.product_id) AS number_of_reviews
FROM Products P
LEFT JOIN Reviews R ON P.product_id = R.product_id
GROUP BY P.category_id;

6.Optimize a query that retrieves the list of products with their respective categories, filtering them by a specific category. 
Dataset: Products (product_id, product„name, category_id), Categories (category_id, category_name)
SELECT P.product_id, P.product_name, C.category_name
FROM Products P
JOIN Categories C ON P.category_id = C.category_id
WHERE C.category_id = <specific_category_id>;

7.Create a stored procedure to update the quantity in stock for a specific product and log the change in a separate table. 
Dataset: Products (product_id, product_name,quantity_in_stock), Stock_Log (Iog_id, product_id, oId_quantity, new_quantity, modified_date)

CREATE PROCEDURE UpdateStockAndLog(
    IN product_id_param INT,
    IN new_quantity_param INT
)
BEGIN
    ##Declare variables to store old quantity and current date
    DECLARE old_quantity INT;
    DECLARE current_date DATETIME;
    
    ##Get the old quantity from the Products table
    SELECT quantity_in_stock INTO old_quantity FROM Products WHERE product_id = product_id_param;
    
    ##Update the quantity in the Products table
    UPDATE Products SET quantity_in_stock = new_quantity_param WHERE product_id = product_id_param;
    
    ##Get the current date and time
    SET current_date = NOW();
    
    ##Insert the change log into the Stock_Log table
    INSERT INTO Stock_Log (product_id, old_quantity, new_quantity, modified_date)
    VALUES (product_id_param, old_quantity, new_quantity_param, current_date);
END;

8.Use advanced SQL techniques to unpivot the given table and transform columns into rows.
Dataset: Sales (product	id, month1_amount, month2 amount, month3 amount)

SELECT product_id, 'month1' AS month, month1_amount AS amount FROM Sales
UNION ALL
SELECT product_id, 'month2' AS month, month2_amount AS amount FROM Sales
UNION ALL
SELECT product_id, 'month3' AS month, month3_amount AS amount FROM Sales;

9.Apply window functions to calculate the rank and dense rank of sales amounts for each product.
Dataset: Products (product	id, product_name), Order_ltems (order_id, product_id, amount)

SELECT
  product_id,
  product_name,
  amount,
  RANK() OVER (PARTITION BY product_id ORDER BY amount DESC) AS sales_rank,
  DENSE_RANK() OVER (PARTITION BY product_id ORDER BY amount DESC) AS dense_sales_rank
FROM
  Products
JOIN
  Order_Items ON Products.product_id = Order_Items.product_id;







 


 
