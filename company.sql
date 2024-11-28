PRAGMA foreign_keys = ON; -- Foreign key is by default off in sqlite, so we need to set it to on, when we need it

--##############  users, normal table, primary key  ##############--
DROP TABLE IF EXISTS users;

CREATE TABLE users(
    user_pk                 TEXT, --UNIQUE is not necessary
    user_username           TEXT UNIQUE,
    user_name               TEXT,
    user_last_name          TEXT,
    user_email              TEXT UNIQUE,
    user_password           TEXT,
    user_dob                TEXT,
    user_created_at         TEXT,
    user_updated_at         TEXT,
    user_is_active          TEXT,
    user_blocked_at         TEXT,
    user_deleted_at         TEXT,
    PRIMARY KEY(user_pk) -- makes it unique
)WITHOUT ROWID;

INSERT INTO users VALUES ("1", "username_A", "A", "Aa", "a@a.com", "pass", "EPOCH", "0", "1", "DD/MM/YYYY", "1", "0");
INSERT INTO users VALUES ("2", "username_B", "B", "Bb", "b@b.com", "pass", "EPOCH", "0", "1", "DD/MM/YYYY", "0", "0");
INSERT INTO users VALUES ("3", "username_C", "C", "Cc", "c@c.com", "pass", "EPOCH", "0", "1", "DD/MM/YYYY", "0", "0");
INSERT INTO users VALUES ("4", "username_D", "D", "Dd", "d@d.com", "pass", "EPOCH", "0", "1", "DD/MM/YYYY", "0", "1");

SELECT * FROM users;

--##############  roles, lookup table, primary key  ##############--
DROP TABLE IF EXISTS roles;

CREATE TABLE roles(
    role_pk                 TEXT, --UNIQUE is not necessary
    role_name               TEXT UNIQUE,
    PRIMARY KEY(role_pk) -- makes it unique
)WITHOUT ROWID;

INSERT INTO roles VALUES ("1", "customer");
INSERT INTO roles VALUES ("2", "delivery person");
INSERT INTO roles VALUES ("3", "restaurant owner");
INSERT INTO roles VALUES ("4", "admin");

SELECT * FROM roles;

--##############  user_roles, junction table, compound key  ##############--
DROP TABLE IF EXISTS users_roles;

CREATE TABLE users_roles(
    user_fk                 TEXT,
    role_fk                 TEXT,
    PRIMARY KEY(user_fk, role_fk),
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(role_fk) REFERENCES roles(role_pk) ON DELETE CASCADE
)WITHOUT ROWID;

INSERT INTO users_roles VALUES ("1", "1");
INSERT INTO users_roles VALUES ("1", "2");
INSERT INTO users_roles VALUES ("2", "3");
INSERT INTO users_roles VALUES ("3", "2");
INSERT INTO users_roles VALUES ("4", "1");
INSERT INTO users_roles VALUES ("4", "3");
INSERT INTO users_roles VALUES ("2", "1");
INSERT INTO users_roles VALUES ("3", "1");

SELECT * FROM users_roles;

-- DELETE FROM users WHERE user_pk = "1";

--##############  restaurants, lookup table, primary key  ##############--
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants(
    restaurant_pk           TEXT, --UNIQUE is not necessary
    restaurant_name         TEXT,
    restaurant_adress       TEXT UNIQUE,
    PRIMARY KEY(restaurant_pk) -- makes it unique
)WITHOUT ROWID;

INSERT INTO restaurants VALUES ("1", "Lulu's Diner", "Lulu street 43");
INSERT INTO restaurants VALUES ("2", "Bean the Bean", "Bean Avenue 22");

SELECT * FROM restaurants;

--##############  menu_items, lookup table, primary key  ##############--
DROP TABLE IF EXISTS menu_items;

CREATE TABLE menu_items(
    menu_item_pk            TEXT, --UNIQUE is not necessary
    menu_item_name          TEXT,
    PRIMARY KEY(menu_item_pk) -- makes it unique
)WITHOUT ROWID;

INSERT INTO menu_items VALUES ("1", "carrot salad");
INSERT INTO menu_items VALUES ("2", "cucumber drink");
INSERT INTO menu_items VALUES ("3", "bean salad");
INSERT INTO menu_items VALUES ("4", "burger");
INSERT INTO menu_items VALUES ("5", "fries");
INSERT INTO menu_items VALUES ("6", "nuggets");

SELECT * FROM menu_items;
--##############  restaurants_owners, junction table, compound key  ##############--
DROP TABLE IF EXISTS restaurants_owners;

CREATE TABLE restaurants_owners(
    user_fk                 TEXT,
    restaurant_fk           TEXT,
    PRIMARY KEY(user_fk, restaurant_fk),
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(restaurant_fk) REFERENCES restaurants(restaurant_pk) ON DELETE CASCADE
)WITHOUT ROWID;

INSERT INTO restaurants_owners VALUES ("2", "2");
INSERT INTO restaurants_owners VALUES ("4", "1");
INSERT INTO restaurants_owners VALUES ("4", "2");

SELECT * FROM restaurants_owners;

--##############  orders, junction table, primary key  ##############--
DROP TABLE IF EXISTS orders;

CREATE TABLE orders(
    order_pk                        TEXT,
    user_fk                         TEXT,
    restaurant_fk                   TEXT,
    order_created_at                TEXT,
    order_updated_at                TEXT,
    PRIMARY KEY(order_pk),
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(restaurant_fk) REFERENCES restaurants(restaurant_pk) ON DELETE CASCADE
)WITHOUT ROWID;

INSERT INTO orders VALUES ("1", "1", "1", "EPOCH", "EPOCH");
INSERT INTO orders VALUES ("2", "4", "2", "EPOCH", "EPOCH");
INSERT INTO orders VALUES ("3", "2", "2", "EPOCH", "EPOCH");
INSERT INTO orders VALUES ("4", "3", "1", "EPOCH", "EPOCH");
INSERT INTO orders VALUES ("5", "1", "2", "EPOCH", "EPOCH");
INSERT INTO orders VALUES ("6", "1", "1", "EPOCH", "EPOCH");

SELECT * FROM orders;

--##############  orders_details, junction table, compound key  ##############--

DROP TABLE IF EXISTS orders_details;

CREATE TABLE orders_details(
    order_fk                        TEXT,
    menu_item_fk                    TEXT,
    quantity                        TEXT,
    PRIMARY KEY(order_fk, menu_item_fk),
    FOREIGN KEY(order_fk) REFERENCES orders(order_pk) ON DELETE CASCADE,
    FOREIGN KEY(menu_item_fk) REFERENCES menu_items(menu_item_pk) ON DELETE CASCADE
)WITHOUT ROWID;

INSERT INTO orders_details VALUES ("1", "5", "1");
INSERT INTO orders_details VALUES ("2", "2", "3");
INSERT INTO orders_details VALUES ("2", "3", "1");
INSERT INTO orders_details VALUES ("3", "1", "2");
INSERT INTO orders_details VALUES ("4", "6", "1");
INSERT INTO orders_details VALUES ("5", "2", "3");
INSERT INTO orders_details VALUES ("6", "4", "8");

SELECT * FROM orders_details;

--##############  phone_numbers, lookup table, composite key  ##############--
DROP TABLE IF EXISTS phone_numbers;

CREATE TABLE phone_numbers(
    phone_numbers               TEXT,
    user_fk                     TEXT,
    PRIMARY KEY(phone_numbers, user_fk),
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE
)WITHOUT ROWID;

SELECT * FROM phone_numbers;

-- ############################Brug join############################### --

SELECT orders_details.order_fk, orders_details.quantity, menu_items.menu_item_name
FROM orders_details -- AS cod, hvis man ønsker at gøre ordet kortere
INNER JOIN menu_items ON orders_details.menu_item_fk=menu_items.menu_item_pk;