USE sakila;

# 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT title, length, DENSE_RANK() OVER (ORDER BY length DESC) AS "rank"
FROM film
WHERE length > 0;

# 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT title, length, rating, 
       RANK() OVER(PARTITION BY rating ORDER BY length DESC) AS rank_num 
FROM film 
WHERE length IS NOT NULL AND length != 0 
ORDER BY rating, rank_num;

# 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT c.name AS category_name, COUNT(*) AS num_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY num_films DESC;

# 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT a.first_name, a.last_name, COUNT(*) AS num_films
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY num_films DESC
LIMIT 1;

# 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT c.first_name, c.last_name, COUNT(*) AS num_rented_film
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY num_rented_film DESC
LIMIT 1;

# Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
# This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
# Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

SELECT f.title, COUNT(*) AS num_rentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY num_rentals DESC
LIMIT 1; # --> Check: The answer is Bucket Brotherhood
