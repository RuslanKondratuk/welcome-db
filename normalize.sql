CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(200),
    position varchar(200),
    car_aviability boolean
);

DROP TABLE employees;
DROP TABLE positions;
INSERT INTO employees (name, position) VALUES
('Johfsfn', 'HR'),
('Janfdssse', 'Sales'),
('Makasssads', 'Developer'),
('Andsssre', 'Driver');

CREATE TABLE positions(
    name varchar(200) PRIMARY KEY,
    car_aviability boolean
);

INSERT INTO positions VALUES
('HR', false), ('Sales', false), ('Developer', false), ('Driver', true);


ALTER TABLE employees
DROP COLUMN car_aviability;

ALTER TABLE employees
ADD CONSTRAINT "position_fkey" FOREIGN KEY (position) REFERENCES
positions (name);


SELECT * FROM employees
JOIN positions
ON employees.position=positions.name;