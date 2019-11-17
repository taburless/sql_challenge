SELECT * FROM actor;

DROP VIEW all_parties;
CREATE VIEW all_parties AS
SELECT DISTINCT 'actor' AS actor,
				actor.first_name,
				actor.last_name
				FROM actor
UNION
SELECT DISTINCT 'staff' AS staff,
				staff.first_name,
	            staff.last_name
				FROM staff
UNION
SELECT DISTINCT 'customer' AS customer,
				customer.first_name,
			    customer.last_name
				FROM customer;
SELECT * FROM all_parties;

SELECT * FROM inventory

CREATE VIEW titles AS
	SELECT f.title, sub.film_count AS "Count"
		FROM film AS f, 
		(
			SELECT film_id, COUNT(*) AS film_count
			FROM inventory
			WHERE film_id IN
			(
				SELECT film_id
				FROM film 
			)
					GROUP BY film_id 
		)			AS sub
						WHERE f.film_id = sub.film_id
						ORDER BY f.title
						
SELECT * FROM titles

SELECT * FROM titles WHERE "Count" = 7