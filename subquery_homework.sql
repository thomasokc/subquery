-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, district
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
-- Answer, 5 customers

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM customer
FULL JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
-- Answer, 1406 payments over $6.99

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name, SUM(payment.amount)
FROM customer, payment
WHERE customer.customer_id = payment.customer_id 
GROUP BY first_name, last_name
HAVING SUM(amount) > 175
-- Answer, 6 customers
-- Actual subquery below, found top answer could also display the amount/was shorter

SELECT first_name, last_name
FROM customer
WHERE customer.customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175)

-- 4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';
-- Answer, only Kevin lives in nepal. Poor lonely Kevin

-- 5. Which staff member had the most transactions?
SELECT first_name, last_name, COUNT(payment.staff_id)
FROM staff, payment
WHERE staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT (payment.staff_id) DESC;
-- Answer, Jon

-- 6. How many movies of each rating are there?
SELECT COUNT(DISTINCT film_id), rating
FROM film
GROUP BY rating
ORDER BY COUNT (film_id) DESC;
-- Answer, 223 "PG-13", 210 "NC-17", 195 "R", 194	"PG", 178 "G"

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
);
-- Answer, 539 people have made payments over $6.99

-- 8. How many free rentals did our store give away?
SELECT COUNT(amount)
FROM payment
WHERE amount < 0.99
-- Answer, 24 free rentals

SELECT *
FROM customer

SELECT *
FROM payment
