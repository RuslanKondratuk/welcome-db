CREATE TABLE books (
    name varchar(300),
    author varchar(300),
    type varchar(150),
    pages int,
    year date,
    publisher varchar(256)
)


INSERT INTO users (first_name, last_name, email, birthday, gender) VALUES
('Clark', 'Kent', 'super@man.com', '1990-09-09', 'male');

INSERT INTO users (first_name, last_name, email, birthday, gender) VALUES
('Ruslan', 'Kond', 'tones@mail.com', '1990-02-02', 'male'),
('Spider', 'Man', 'spider@mail.com', '1990-02-01', 'male'),
('She', 'Jane', 'sp22ider@mail.com', '1990-12-12', 'male'),
('Loki', 'Odi', 'odi@mail.com', '1990-10-02', 'male');



INSERT INTO messages (body, author, is_read) VALUES
('I spent2 messages', 'Oleg', 'true'),
('I spent3 messages', 'I', 'false'),
('I spent messages', 'ME', 'true'),
('I spent messages', 'He', 'false');


ALTER TABLE users
ADD COLUMN height numeric(3, 2);

ALTER TABLE users
ADD COLUMN weight numeric(5, 2);

ALTER TABLE users
ADD CONSTRAINT "too_hight_user" CHECK (height < 4.0);



ALTER TABLE users
ADD CONSTRAINT "check_birthday" CHECK (birthday > '1990-01-01');


ALTER TABLE users
DROP CONSTRAINT "users_email_key";

ALTER TABLE users
DROP CONSTRAINT "name_pair";


CREATE TABLE products (
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL CHECK (name != ''),
    category varchar(100),
    price numeric(10, 2) NOT NULL CHECK (price > 0),
    quantity int CHECK (quantity > 0)
);

INSERT INTO products (name, price, quantity) VALUES
('Samsung', 100, 5),
('Iphone', 500, 1),
('Sony', 200, 3);

CREATE TABLE orders (
    id serial PRIMARY KEY,
    created_at timestamp DEFAULT current_timestamp,
    customer_id int REFERENCES users(id)
);

INSERT INTO orders (customer_id) VALUES
(4), (4), (7), (6), (5);


CREATE TABLE orders_to_products (
    product_id int REFERENCES products(id),
    order_id int REFERENCES orders(id),
    quantity int CHECK (quantity > 0),
    PRIMARY KEY (product_id, order_id)
)

INSERT INTO orders_to_products (product_id, order_id, quantity) VALUES
(1, 11, 1),
(2, 11, 1),
(3, 11, 1);

INSERT INTO orders_to_products (product_id, order_id, quantity) VALUES
(2, 12, 1);


DROP TABLE users;

CREATE TABLE users (
    id serial PRIMARY KEY,
    first_name varchar(100) NOT NULL CHECK (first_name != ''),
    last_name varchar(100) NOT NULL CHECK (last_name != ''),
    email varchar(200) NOT NULL UNIQUE CHECK (email != ''),
    birthday date,
    gender varchar(100) CHECK (gender != ''),
    CONSTRAINT name_pair UNIQUE(first_name, last_name)
);

DROP TABLE messages;

CREATE TABLE messages(
    id serial PRIMARY KEY,
    body text NOT NULL CHECK (body != ''),
    author int REFERENCES users(id),
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    is_read boolean NOT NULL DEFAULT false
);

ALTER TABLE messages
ADD COLUMN chat_id int REFERENCES chat(id);



INSERT INTO messages (body, author) VALUES
('Text 1', (4)),
('Text 2', (4)),
('Text 3', (5)),
('Text 4', (6));



CREATE TABLE chat (
    id  serial PRIMARY KEY,
    name_chat varchar(100) NOT NULL CHECK (name_chat != ''),
    owner_id int REFERENCES users(id),
    created_at timestamp NOT NULL DEFAULT current_timestamp
);

DROP TABLE users_to_chats;

CREATE TABLE users_to_chats(
    chat_id int REFERENCES chat(id),
    user_id int REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (chat_id, user_id)
)

INSERT INTO chat (name_chat, owner_id) VALUES
('First chat', 4);

INSERT INTO users_to_chats VALUES
(1, 4), (1, 5), (1, 6), (1, 7);

INSERT INTO messages (body, author, chat_id) VALUES
('hello',4, 1), ('hello yourself', 5, 1);

--------------------------------------------------------------------

DROP TABLE content;

CREATE TABLE content(
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL CHECK (name != ''),
    description varchar(256),
    created_at timestamp NOT NULL DEFAULT current_timestamp
);


CREATE TABLE reaction(
    user_id int REFERENCES users(id),
    content_id int REFERENCES content(id),
    reaction boolean DEFAULT NULL,
    PRIMARY KEY (user_id, content_id)
)

INSERT INTO content (name, description) VALUES
('blog', 'move lifestyle'),
('film', 'action film about war'),
('prank', 'new genre on youtube');


INSERT INTO reaction VALUES
(4, 2, false),
(5, 1, true),
(6, 2, true),
(4,1, true);

INSERT INTO reaction VALUES
(4, 2, true);


UPDATE users
SET last_name = 'Kondratuk'
WHERE id = 4;


UPDATE users
SET weight = 30
WHERE birthday < '1990-03-01';


SELECT * FROM users
WHERE birthday > '1990-03-01';


ALTER TABLE users
ADD COLUMN is_subscribe boolean;