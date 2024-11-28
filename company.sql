PRAGMA foreign_keys = ON; -- Foreign key is by default off in sqlite, so we need to set it to on, when we need it

--##############  users, normal table, primary key  ##############--
DROP TABLE IF EXISTS users;

CREATE TABLE users(
    user_pk                 CHAR(36), --UNIQUE is not necessary
    user_username           VARCHAR(20)     UNIQUE,
    user_name               VARCHAR(20),
    user_last_name          VARCHAR(20),
    user_email              VARCHAR(255)    UNIQUE,
    user_password           VARCHAR(50),
    user_dob                BIGINT          UNSIGNED,
    user_created_at         BIGINT          UNSIGNED,
    user_updated_at         BIGINT          UNSIGNED,
    user_is_active          BOOLEAN,
    user_blocked_at         BIGINT          UNSIGNED,
    user_deleted_at         BIGINT          UNSIGNED,
    PRIMARY KEY(user_pk) -- makes it unique
)WITHOUT ROWID;

INSERT INTO users VALUES ("8a505c5d-f7c0-4cbe-9e97-16e7ef6cfd60", "username_A", "A", "Aa", "a@a.com", "pass", "1732804223", "1732804223", "1732804223", "1", "0", "0");
INSERT INTO users VALUES ("ea793097-bf74-4434-b506-024fbe1ad680", "username_B", "B", "Bb", "b@b.com", "pass", "1732804223", "1732804223", "1732804223", "1", "0", "0");
INSERT INTO users VALUES ("7cb9bf5d-eeb7-4f1a-b837-3621415285a0", "username_C", "C", "Cc", "c@c.com", "pass", "1732804223", "1732804223", "0", "1", "0", "0");
INSERT INTO users VALUES ("6d289cb7-7701-4296-b49e-641d39f6c5a7", "username_D", "D", "Dd", "d@d.com", "pass", "1732804223", "1732804223", "0", "1", "0", "0");

SELECT * FROM users;

--##############  roles, lookup table, primary key  ##############--
DROP TABLE IF EXISTS roles;

CREATE TABLE roles(
    role_pk                 CHAR(36), --UNIQUE is not necessary
    role_name               VARCHAR(20) UNIQUE,
    PRIMARY KEY(role_pk) -- makes it unique
)WITHOUT ROWID;

INSERT INTO roles VALUES ("ade3e136-53fa-4f08-8993-159a4fd3ac0b", "customer");
INSERT INTO roles VALUES ("09478ebd-c37c-4c97-9d16-271604093037", "delivery person");
INSERT INTO roles VALUES ("a8e1777d-304e-4675-a1a1-6970f4c9ca68", "restaurant owner");
INSERT INTO roles VALUES ("d3a75b5c-58cf-4d1b-a4b4-c1cce5eaa08d", "admin");

SELECT * FROM roles;

--##############  user_roles, junction table, compound key  ##############--
DROP TABLE IF EXISTS users_roles;

CREATE TABLE users_roles(
    user_fk                 CHAR(36),
    role_fk                 CHAR(36),
    PRIMARY KEY(user_fk, role_fk),
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(role_fk) REFERENCES roles(role_pk) ON DELETE CASCADE
);

INSERT INTO users_roles VALUES ("8a505c5d-f7c0-4cbe-9e97-16e7ef6cfd60", "ade3e136-53fa-4f08-8993-159a4fd3ac0b");
INSERT INTO users_roles VALUES ("8a505c5d-f7c0-4cbe-9e97-16e7ef6cfd60", "09478ebd-c37c-4c97-9d16-271604093037");
INSERT INTO users_roles VALUES ("ea793097-bf74-4434-b506-024fbe1ad680", "a8e1777d-304e-4675-a1a1-6970f4c9ca68");
INSERT INTO users_roles VALUES ("ea793097-bf74-4434-b506-024fbe1ad680", "09478ebd-c37c-4c97-9d16-271604093037");
INSERT INTO users_roles VALUES ("7cb9bf5d-eeb7-4f1a-b837-3621415285a0", "ade3e136-53fa-4f08-8993-159a4fd3ac0b");
INSERT INTO users_roles VALUES ("7cb9bf5d-eeb7-4f1a-b837-3621415285a0", "ade3e136-53fa-4f08-8993-159a4fd3ac0b");
INSERT INTO users_roles VALUES ("6d289cb7-7701-4296-b49e-641d39f6c5a7", "d3a75b5c-58cf-4d1b-a4b4-c1cce5eaa08d");

SELECT * FROM users_roles;

-- DELETE FROM users WHERE user_pk = "1";

--##############  restaurants, lookup table, primary key  ##############--
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants(
    restaurant_pk           CHAR(36), --UNIQUE is not necessary
    restaurant_name         VARCHAR(20),
    restaurant_adress       VARCHAR(50) UNIQUE,
    PRIMARY KEY(restaurant_pk) -- makes it unique
)WITHOUT ROWID;

INSERT INTO restaurants VALUES ("883d66a9-695e-48b8-856c-89936789d2a4", "Lulu's Diner", "Lulu street 43");
INSERT INTO restaurants VALUES ("6a44aa2c-08c2-4b0e-ae2f-6e10669cd6f8", "Bean the Bean", "Bean Avenue 22");

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