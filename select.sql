SELECT id, first_name, last_name FROM users;


SELECT id FROM users;

--Результатом завжди будет таблиця;

SELECT first_name, last_name FROM users;


SELECT * FROM users
WHERE id = 500;

SELECT * FROM users
WHERE gender = 'male';

SELECT * FROM users
WHERE gender = 'male' AND is_subscribe;

SELECT * FROM users
WHERE id % 2 = 0;

SELECT * FROM users
WHERE gender = 'female' AND is_subscribe = FALSE;

SELECT email FROM users
WHERE is_subscribe;

SELECT * FROM users
WHERE first_name IN ('John', 'Ruslan', 'She');


SELECT * FROM users
WHERE id IN (1, 10, 100, 1000);


SELECT * FROM users
WHERE id > 300 AND id < 1000;

SELECT * FROM users
WHERE id BETWEEN 300 AND 1000;

SELECT * FROM users
WHERE first_name LIKE 'K%';


-- % - будь яка кількість будьяких літер

--- _ - 1 будь який символ


SELECT * FROM users
WHERE first_name LIKE '_____';


SELECT * FROM users
WHERE first_name LIKE '%a';


UPDATE users
SET weight = 70
WHERE id % 5 = 0
RETURNING *;


UPDATE users
SET is_subscribe = true
WHERE is_subscribe IS NULL
RETURNING *;

SELECT * FROM users
WHERE id % 5 = 0;

SELECT * FROM users
WHERE birthday < '2004-01-01';

SELECT * FROM users
WHERE extract("years" from age(birthday)) > 25;


SELECT email,  extract("years" from age(birthday)) FROM users
WHERE (gender = 'male' AND
extract("years" from age(birthday)) BETWEEN 18 AND 60);


SELECT first_name, birthday, extract("month" from age(birthday)) FROM users
WHERE extract("month" from birthday)=10;


SELECT first_name, birthday, extract("day" from age(birthday)) FROM users
WHERE extract("month" from birthday)=11
AND extract("day" from birthday)=1;


UPDATE users
SET height = 2.0;
WHERE extract("years" from age(birthday)) > 60;

UPDATE users
SET weight = 20
WHERE (extract("years" from age(birthday)) BETWEEN 30 AND 50)
AND gender = 'male';


SELECT id AS "Порядковий номер",
first_name AS "Імя",
last_name AS "Прізвище"
FROM users AS u;


SELECT * FROM orders
LIMIT 50
OFFSET 100;

CREATE TABLE workers(
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL CHECK (name != ''),
    salary numeric(10, 2) NOT NULL CHECK (salary > 0),
    birthday date
);


INSERT INTO workers (name, birthday, salary) VALUES
('Oleh', '1990-01-01', 300);

INSERT INTO workers (name, salary) VALUES
('Yaroslava', 300);


INSERT INTO workers (name, birthday, salary) VALUES
('Sasha', '1985-01-01', 1000),
('Masha', '1995-01-01', 900);

UPDATE workers
SET salary = 500
WHERE name = 'Oleh';

UPDATE workers
SET birthday = '1987-01-01'
WHERE id = 4;

UPDATE workers
SET salary = 700
WHERE salary > 500;

UPDATE workers
SET birthday = '1999-01-01'
WHERE id BETWEEN 2 AND 5;

UPDATE workers
SET name = 'Evhen',
salary = 900
WHERE name = 'Sasha';


SELECT * FROM workers
WHERE id = 4;

SELECT salary, birthday FROM workers
WHERE name = 'Evhen';

SELECT * FROM workers
WHERE extract("month" from birthday) = 1;

DELETE FROM workers
WHERE name = 'Oleh';

SELECT avg(weight) FROM users
WHERE gender = 'male';


SELECT avg(weight), gender
FROM users
WHERE extract('year' from age(birthday)) > 25
GROUP BY gender;

SELECT avg(height)
FROM users;

SELECT max(height), min(height)
FROM users;

SELECT count(*) FROM users
WHERE (extract("years" from age(birthday)) BETWEEN 20 AND 30);

SELECT count(*) FROM users
WHERE height>1.5;

SELECT count(*), customer_id FROM orders
GROUP BY customer_id;

SELECT brand, avg(price)
FROM products
GROUP BY brand;

SELECT sum(quantity)
FROM products;


SELECT sum(quantity)
FROM orders_to_products;



SELECT extract("years" from age(birthday)), first_name FROM users
ORDER BY extract("years" from age(birthday)), first_name DESC;


SELECT * FROM products
ORDER BY price ASC;

SELECT sum(quantity), brand FROM products
GROUP BY(brand)
HAVING sum(quantity) > 300000;


CREATE TABLE a
(v char(3),
t int);

CREATE TABLE b
(v char (3));

INSERT INTO a VALUES
('XXX', 1), ('XXY', 1), ('XXZ', 1),
('XYX', 2), ('XYY', 2), ('XYZ', 2),
('YXX', 3), ('YXY', 3), ('YXZ', 3);

INSERT INTO b VALUES
('ZXX'), ('XXX'), ('ZXZ'), ('YXZ'), ('YXY');

INSERT INTO users (first_name, last_name,email,birthday,gender)
VALUES ('tester1', 'tester1', 'tester@1', '1990-02-02','male'),
('tester2',
    'tester2',
    'tester@2',
    '1990-03-02',
    'male'),
    ('tester2',
    'tester2',
    'tester@2',
    '1990-01-02',
    'male'
  );

SELECT id FROM users
EXCEPT
SELECT customer_id FROM orders;


SELECT email FROM users
WHERE id IN (SELECT id FROM users
EXCEPT
SELECT customer_id FROM orders);

SELECT u.*, o.id AS order_id
FROM users AS u
JOIN orders AS o
ON o.customer_id = u.id
WHERE u.id = 355;



 SELECT p.model, o_p.product_id
 FROM products AS p
 JOIN orders_to_products AS o_p
 ON o_p.product_id = p.id
 WHERE o_p.order_id = 20178;


 SELECT email
 FROM users AS u
 JOIN orders AS o
 ON u.id = o.customer_id
 JOIN orders_to_products AS otp
 ON o.id=otp.order_id
 JOIN products AS p
 ON otp.product_id=p.id
 WHERE p.model='15 model 73';

SELECT *
FROM products AS p LEFT JOIN orders_to_products AS otp
ON p.id = otp.product_id
WHERE otp.order_id IS NULL;

SELECT otp.order_id, sum(otp.quantity*p.price)
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
GROUP BY otp.order_id;


SELECT otp.order_id, p.brand
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
WHERE p.brand = 'Samsung'
GROUP BY otp.order_id, p.brand;


SELECT u.email, count(*)
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id;



SELECT otp.order_id, count(*)
FROM orders_to_products AS otp
GROUP BY otp.order_id;

SELECT p.brand, p.model, sum(otp.quantity)
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
GROUP BY p.model, p.brand
ORDER BY sum(otp.quantity) DESC
LIMIT 1;

SELECT brand, avg(price)
FROM products
GROUP BY brand;

SELECT avg(o_w_sum.order_sum)
FROM (
SELECT otp.order_id, sum(otp.quantity*p.price)AS order_sum
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
GROUP BY otp.order_id) AS o_w_sum;

SELECT u.*, sum(otp.quantity*p.price)
 FROM users AS u
 JOIN orders AS o
 ON u.id = o.customer_id
 JOIN orders_to_products AS otp
 ON o.id=otp.order_id
 JOIN products AS p
 ON otp.product_id=p.id
 GROUP BY u.id
 ORDER BY sum(otp.quantity*p.price) DESC
 LIMIT 1;

SELECT p.brand, sum(otp.quantity)
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
GROUP BY p.brand
ORDER BY sum(otp.quantity) DESC
LIMIT 1;

SELECT avg(o_w_sum.order_sum) AS chek
FROM (
SELECT otp.order_id, sum(otp.quantity*p.price)AS order_sum
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
GROUP BY otp.order_id) AS o_w_sum
WHERE order_sum>avg(o_w_sum.order_sum);


  SELECT avg(o_w_sum.order_sum) AS chek
  FROM (
          SELECT otp.order_id, sum(otp.quantity*p.price)AS order_sum
          FROM orders_to_products AS otp
          JOIN products AS p
          ON otp.product_id = p.id
          GROUP BY otp.order_id) AS o_w_sum;


WITH orders_with_costs AS (
          SELECT otp.order_id, sum(otp.quantity*p.price)AS total_amount
          FROM orders_to_products AS otp
          JOIN products AS p
          ON otp.product_id = p.id
          GROUP BY otp.order_id
)
SELECT owc.*
FROM orders_with_costs AS owc
WHERE owc.total_amount > (SELECT avg(o_w_sum.order_sum) AS chek
  FROM (
          SELECT otp.order_id, sum(otp.quantity*p.price)AS order_sum
          FROM orders_to_products AS otp
          JOIN products AS p
          ON otp.product_id = p.id
          GROUP BY otp.order_id) AS o_w_sum);


 SELECT avg(o_w_sum.order_count) AS chek
  FROM (
          SELECT u.first_name, count(*) AS order_count
          FROM orders AS o
          JOIN users AS u
          ON o.customer_id = u.id
          GROUP BY o.customer_id, u.first_name) AS o_w_sum;



WITH users_with_orders AS (
          SELECT u.first_name, count(*) AS order_count
          FROM orders AS o
          JOIN users AS u
          ON o.customer_id = u.id
          GROUP BY o.customer_id, u.first_name
          )
SELECT uwo.*
FROM users_with_orders AS uwo
WHERE order_count > (SELECT avg(o_w_sum.order_count) AS chek
  FROM (
          SELECT u.first_name, count(*) AS order_count
          FROM orders AS o
          JOIN users AS u
          ON o.customer_id = u.id
          GROUP BY o.customer_id, u.first_name) AS o_w_sum);


SELECT u.first_name, count(*), otp.product_id
 FROM users AS u
 JOIN orders AS o
 ON u.id = o.customer_id
 JOIN orders_to_products AS otp
 ON o.id=otp.order_id
 JOIN products AS p
 ON otp.product_id=p.id
 GROUP BY otp.product_id, u.first_name;


 ALTER TABLE  orders
 ADD COLUMN status boolean;


UPDATE orders
SET status = false;

UPDATE orders
SET status = true
WHERE (id%3) = 0;


 SELECT *,  (
  CASE
    WHEN status = true
      THEN 'done'
    WHEN status = false
      THEN 'processing'
    ELSE
      'new'
    END
 )FROM orders;

 SELECT *, (
  CASE (extract("year" from age(birthday)))>18
      WHEN year>18 THEN 'Повнолітній'
      WHEN year<18 THEN 'NOT Повнолітній'
  ELSE 'NOt info'
  END
 ) AS 'OLDER'
FROM users;

 SELECT *,  (
  CASE
    WHEN extract("year" from age(birthday)) > 18
      THEN 'Повнолітній'
    WHEN extract("year" from age(birthday)) < 18
      THEN 'NOT Повнолітній'
    ELSE
      'NOt info'
    END
 ) AS "older" FROM users;


 SELECT *,  (
  CASE
    WHEN brand = 'Iphone'
      THEN 'Apple'
    ELSE
      'Other'
    END
 ) AS "manufactured" FROM products;


 SELECT *,  (
  CASE
    WHEN price > 10000
      THEN 'Flagman'
    WHEN price < 1000
      THEN 'Cheap'
    WHEN price < 10000 AND price > 1000
      THEN 'middle'
    ELSE
      'Other'
    END
 ) AS "price_category" FROM products;



SELECT u.id, u.email, count(o.id),(
  CASE
  WHEN count(o.id) > 3
  THEN ' regular client'
  WHEN count(o.id) BETWEEN 1 AND 3
  THEN ' active client'
  WHEN count(o.id) = 0
  THEN ' new client'
  ELSE 'unknown'
  END
)
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id, u.email;

--  SELECT * ,(
--   CASE
--     WHEN count_table.count > 20
--       THEN 'Постінйий'
--     WHEN count_table.count < 20
--       THEN 'Не постіний'
--     ELSE
--       'Other'
--     END
--  ) AS "price_category" FROM (
--   SELECT customer_id, count(*) AS count
--   FROM users AS u
--   JOIN orders AS o
--   ON u.id = o.customer_id
--   GROUP BY o.customer_id
--  ) AS count_table;

SELECT *
FROM products AS p
WHERE p.id NOT IN (
  SELECT otp.product_id
  FROM orders_to_products AS otp
);

CREATE VIEW users_with_order_count AS (SELECT u.*, count(*) AS order_count
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id, u.email);

SELECT *
FROM users_with_order_count;

SELECT *
FROM users_with_order_count
WHERE order_count > 2;


DROP VIEW orders_with_costs_and_model;

CREATE VIEW orders_with_costs_and_model_count AS (
  SELECT o.*, sum(otp.quantity*p.price), count(otp.product_id)
FROM orders as o
JOIN orders_to_products AS otp
ON o.id = otp.order_id
JOIN products AS p
ON p.id = otp.product_id
GROUP BY o.id
);


SELECT *
FROM orders_with_costs_and_model_count;

SELECT u.*, sum(owcamc.sum) AS sum_orders
FROM users AS u
JOIN orders_with_costs_and_model_count AS owcamc
ON u.id = owcamc.customer_id
GROUP BY u.id;

DROP VIEW info_users_and_their_sum_orders;

CREATE VIEW info_users_and_their_sum_orders AS (SELECT u.id, concat(u.first_name, ' ', u.last_name) AS full_name, u.email, sum(owcamc.sum)
FROM users AS u
JOIN orders_with_costs_and_model_count AS owcamc
ON u.id = owcamc.customer_id
GROUP BY u.id);

SELECT * FROM
info_users_and_their_sum_orders
ORDER BY sum DESC
LIMIT 10;

SELECT u.id, u.email, sum(owsmc.count) AS model_count
FROM users as u
JOIN orders_with_costs_and_model_count as owsmc
ON u.id=owsmc.customer_id
GROUP BY u.id, u.email
ORDER BY model_count DESC
LIMIT 10;


SELECT *
FROM orders_with_costs_and_model_count
WHERE count > (SELECT avg(count)
FROM orders_with_costs_and_model_count AS owsmc);