PRAGMA foreign_keys = ON; -- Foreign key is by default off in sqlite, so we need to set it to on, when we need it

---------------------------------------
-- Users table, normal table with primary key
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_pk             TEXT,
    user_username       TEXT UNIQUE,
    user_name           TEXT,
    user_last_name      TEXT,
    user_email          TEXT UNIQUE,
    user_password       TEXT,
    user_dob            TEXT,
    user_created_at     TEXT,
    user_updated_at     TEXT,
    is_user_active      TEXT,
    is_user_blocked     TEXT,
    is_user_deleted     TEXT,
    PRIMARY KEY(user_pk)
)WITHOUT ROWID;

INSERT INTO users VALUES ("1", "username_A", "A", "Aa", "a@a.com", "pass", "EPOCH", "0", "1", "DD/MM/YYYY", "1", "0");
INSERT INTO users VALUES ("2", "username_B", "B", "Bb", "b@b.com", "pass", "EPOCH", "0", "1", "DD/MM/YYYY", "1", "0");
INSERT INTO users VALUES ("3", "username_C", "C", "Cc", "c@c.com", "pass", "EPOCH", "0", "1", "DD/MM/YYYY", "1", "0");
INSERT INTO users VALUES ("4", "username_D", "D", "Dd", "d@d.com", "pass", "EPOCH", "0", "1", "DD/MM/YYYY", "1", "0");

SELECT * FROM users;

---------------------------------------
-- Roles table, lookup table with primary key
DROP TABLE IF EXISTS roles;

CREATE TABLE roles(
    role_pk             TEXT,
    role_name           TEXT UNIQUE,
    PRIMARY KEY(role_pk)
) WITHOUT ROWID;

INSERT INTO roles VALUES ("1", "customer");
INSERT INTO roles VALUES ("2", "delivery person");
INSERT INTO roles VALUES ("3", "restaurant owner");
INSERT INTO roles VALUES ("4", "admin");

SELECT * FROM roles;

---------------------------------------
-- Users_roles table, junction table with compound key
DROP TABLE IF EXISTS users_roles;

CREATE TABLE users_roles(
    user_fk             TEXT,
    role_fk             TEXT,
    FOREIGN KEY (user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY (role_fk) REFERENCES roles(role_pk) ON DELETE CASCADE,
    PRIMARY KEY (user_fk, role_fk)
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

---------------------------------------
-- Restaurants table, lookup table with primary key
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants(
    restaurant_pk       TEXT,
    restaurant_name     TEXT,
    restaurant_adress   TEXT UNIQUE,
    PRIMARY KEY(restaurant_pk)
)WITHOUT ROWID;

INSERT INTO restaurants VALUES ("1", "Lulu's Diner", "Lulu street 43");
INSERT INTO restaurants VALUES ("1", "Bean the bean", "Bean avenue 22");

SELECT * FROM restaurants;

---------------------------------------
-- Restaurants_owners table, junction table with primary key
DROP TABLE IF EXISTS restaurants_owners;

CREATE TABLE restaurants_owners(
    user_fk             TEXT,
    restaurant_fk       TEXT,
    PRIMARY KEY(user_fk, restaurant_fk)
    FOREIGN KEY (user_fk) REFERENCES users(user_pk) ON DELETE CASCADE;
    FOREIGN KEY (restaurant_fk) REFERENCES restaurants(restaurant_pk) ON DELETE CASCADE;
)WITHOUT ROWID;

INSERT INTO restaurants_owners VALUES ("2", "2");
INSERT INTO restaurants_owners VALUES ("4", "1");
INSERT INTO restaurants_owners VALUES ("4", "2");

SELECT * FROM restaurants_owners;

---------------------------------------
-- Menu_items table, lookup table with primary key
DROP TABLE IF EXISTS menu_items

CREATE TABLE menu_items(
    menu_item_pk        TEXT,
    menu_item_name      TEXT,
    PRIMARY KEY(menu_item_pk)
)WITHOUT ROWID;

INSERT INTO menu_items VALUES ("1", "carrot salad");
INSERT INTO menu_items VALUES ("2", "cucumber drink");
INSERT INTO menu_items VALUES ("3", "bean salad");
INSERT INTO menu_items VALUES ("4", "burger");
INSERT INTO menu_items VALUES ("5", "fries");
INSERT INTO menu_items VALUES ("6", "nuggets");

SELECT * FROM menu_items;

---------------------------------------
-- Customers_orders table, junction table with primary key
DROP TABLE IF EXISTS customers_orders;

CREATE TABLE customers_orders(
    customer_order_pk               TEXT,
    user_fk                         TEXT,
    restaurant_fk                   TEXT,
    customer_order_created_at       TEXT,
    customer_order_updated_at       TEXT,
    PRIMARY KEY(customer_order_pk)
    FOREIGN KEY (user_fk) REFERENCES users(user_pk) ON DELETE CASCADE;
    FOREIGN KEY (restaurant_fk) REFERENCES restaurants(restaurant_pk) ON DELETE CASCADE;
)WITHOUT ROWID;

INSERT INTO customers_orders VALUES ("1", "1", "1", "EPOCH", "0");
INSERT INTO customers_orders VALUES ("2", "4", "2", "EPOCH", "0");
INSERT INTO customers_orders VALUES ("3", "2", "2", "EPOCH", "0");
INSERT INTO customers_orders VALUES ("4", "3", "1", "EPOCH", "0");
INSERT INTO customers_orders VALUES ("5", "1", "2", "EPOCH", "0");
INSERT INTO customers_orders VALUES ("6", "1", "1", "EPOCH", "0");

SELECT * FROM customers_orders;

---------------------------------------
-- Customers_orders_details table, junction table with compound key
DROP TABLE IF EXISTS customers_orders_details;

CREATE TABLE customers_orders_details(
    customer_order_fk       TEXT,
    menu_item_fk            TEXT,
    quantity                TEXT,
    PRIMARY KEY (customer_order_fk, menu_item_fk),
    FOREIGN KEY (customer_order_fk) REFERENCES customers_orders(customer_order_pk) ON DELETE CASCADE;
    FOREIGN KEY (menu_item_fk) REFERENCES menu_item(menu_item_pk) ON DELETE CASCADE;
)WITHOUT ROWID;

INSERT INTO customers_orders_details VALUES ("1", "5", "1");
INSERT INTO customers_orders_details VALUES ("2", "2", "3");
INSERT INTO customers_orders_details VALUES ("2", "3", "1");
INSERT INTO customers_orders_details VALUES ("3", "1", "2");
INSERT INTO customers_orders_details VALUES ("4", "6", "1");
INSERT INTO customers_orders_details VALUES ("5", "2", "3");
INSERT INTO customers_orders_details VALUES ("6", "4", "8");

SELECT * FROM customers_orders_details;

---------------------------------------
-- Phones table, lookup table with composite key

DROP TABLE IF EXISTS phones_numbers;

CREATE TABLE phones_numbers (
    phone_number            TEXT,
    user_fk                 TEXT,
    PRIMARY KEY (phone_number, user_fk),
    FOREIGN KEY (user_fk) REFERENCES users(user_pk) ON DELETE CASCADE;
)WITHOUT ROWID;

INSERT INTO phones_numbers VALUES ("111", "1");
INSERT INTO phones_numbers VALUES ("222", "2");
INSERT INTO phones_numbers VALUES ("222", "3");
INSERT INTO phones_numbers VALUES ("333", "1");
INSERT INTO phones_numbers VALUES ("444", "4");

SELECT * FROM phones_numbers;
---------------------------------------
-- Join tables
SELECT orders_details.order_fk, orders_details.quantity, menu_items.menu_item_name
FROM orders_details -- AS cod
INNER JOIN menu_items ON orders_details.menu_item_fk=menu_items.menu_item_pk;