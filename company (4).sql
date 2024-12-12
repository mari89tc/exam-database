DROP TABLE IF EXISTS orders_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS restaurants_owners;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;

DROP TABLE IF EXISTS users_phones;
DROP TABLE IF EXISTS phones_numbers;

DROP TABLE IF EXISTS users_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
    user_pk                 CHAR(36), 
    user_username           VARCHAR(20) UNIQUE,
    user_name               VARCHAR(20),
    user_last_name          VARCHAR(20),
    user_email              VARCHAR(255) UNIQUE,
    user_password           VARCHAR(50),
    user_created_at         BIGINT UNSIGNED,
    user_updated_at         BIGINT UNSIGNED,
    user_dob                BIGINT UNSIGNED,
    user_is_active          BOOLEAN,
    user_blocked_at         BIGINT UNSIGNED,
    user_deleted_at         BIGINT UNSIGNED,
    PRIMARY KEY(user_pk)
);

INSERT INTO users VALUES 
("8a505c5d-f7c0-4cbe-9e97-16e7ef6cfd60", "username_A", "A", "Aa", "a@a.com", "pass", "1732804223", "1732804223", "1732804223", "1", "0", "0"),
("ea793097-bf74-4434-b506-024fbe1ad680", "username_B", "B", "Bb", "b@b.com", "pass", "1732804223", "1732804223", "1732804223", "1", "0", "0"),
("7cb9bf5d-eeb7-4f1a-b837-3621415285a0", "username_C", "C", "Cc", "c@c.com", "pass", "1732804223", "1732804223", "0", "1", "0", "0"),
("6d289cb7-7701-4296-b49e-641d39f6c5a7", "username_D", "D", "Dd", "d@d.com", "pass", "1732804223", "1732804223", "0", "1", "0", "0");

CREATE TABLE roles(
    role_pk                 CHAR(36),
    role_name               VARCHAR(20) UNIQUE,
    PRIMARY KEY(role_pk)
);

INSERT INTO roles VALUES 
("ade3e136-53fa-4f08-8993-159a4fd3ac0b", "customer"),
("09478ebd-c37c-4c97-9d16-271604093037", "delivery person"),
("a8e1777d-304e-4675-a1a1-6970f4c9ca68", "restaurant owner"),
("d3a75b5c-58cf-4d1b-a4b4-c1cce5eaa08d", "admin");

CREATE TABLE users_roles(
    user_fk                 CHAR(36),
    role_fk                 CHAR(36),
    PRIMARY KEY(user_fk, role_fk),
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(role_fk) REFERENCES roles(role_pk) ON DELETE CASCADE
);

INSERT INTO users_roles VALUES 
("8a505c5d-f7c0-4cbe-9e97-16e7ef6cfd60", "ade3e136-53fa-4f08-8993-159a4fd3ac0b"),
("8a505c5d-f7c0-4cbe-9e97-16e7ef6cfd60", "09478ebd-c37c-4c97-9d16-271604093037"),
("ea793097-bf74-4434-b506-024fbe1ad680", "a8e1777d-304e-4675-a1a1-6970f4c9ca68"),
("ea793097-bf74-4434-b506-024fbe1ad680", "09478ebd-c37c-4c97-9d16-271604093037"),
("7cb9bf5d-eeb7-4f1a-b837-3621415285a0", "ade3e136-53fa-4f08-8993-159a4fd3ac0b"),
("7cb9bf5d-eeb7-4f1a-b837-3621415285a0", "09478ebd-c37c-4c97-9d16-271604093037"),
("6d289cb7-7701-4296-b49e-641d39f6c5a7", "d3a75b5c-58cf-4d1b-a4b4-c1cce5eaa08d");

CREATE TABLE restaurants(
    restaurant_pk           CHAR(36),
    restaurant_name         VARCHAR(20),
    restaurant_address      VARCHAR(50) UNIQUE,
    PRIMARY KEY(restaurant_pk)
);

INSERT INTO restaurants VALUES ("883d66a9-695e-48b8-856c-89936789d2a4", "Lulu's Diner", "Lulu street 43");
INSERT INTO restaurants VALUES ("6a44aa2c-08c2-4b0e-ae2f-6e10669cd6f8", "Bean the Bean", "Bean Avenue 22");

CREATE TABLE menu_items(
    menu_item_pk            CHAR(36),
    menu_item_name          VARCHAR(50),
    PRIMARY KEY(menu_item_pk)
);

INSERT INTO menu_items VALUES ("ef9e3bc2-b164-4fe0-b083-9d6ed0c5e31d", "carrot salad");
INSERT INTO menu_items VALUES ("231b08de-bbda-4607-9ff5-3e1af964ae06", "cucumber drink");
INSERT INTO menu_items VALUES ("2468ee78-84b0-4213-a1a0-d5153b161631", "bean salad");
INSERT INTO menu_items VALUES ("8f02a907-cf6f-4368-bc07-0c53c91ee891", "burger");
INSERT INTO menu_items VALUES ("8b989df9-7a24-4dee-b980-177ee3adc7a5", "fries");
INSERT INTO menu_items VALUES ("35dcdb60-cbb5-4b64-9261-e6c5b40bae62", "nuggets");

CREATE TABLE restaurants_owners(
    user_fk                 CHAR(36),
    restaurant_fk           CHAR(36),
    PRIMARY KEY(user_fk, restaurant_fk),
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(restaurant_fk) REFERENCES restaurants(restaurant_pk) ON DELETE CASCADE
);

INSERT INTO restaurants_owners VALUES ("ea793097-bf74-4434-b506-024fbe1ad680", "883d66a9-695e-48b8-856c-89936789d2a4");
INSERT INTO restaurants_owners VALUES ("6d289cb7-7701-4296-b49e-641d39f6c5a7", "6a44aa2c-08c2-4b0e-ae2f-6e10669cd6f8");
INSERT INTO restaurants_owners VALUES ("6d289cb7-7701-4296-b49e-641d39f6c5a7", "883d66a9-695e-48b8-856c-89936789d2a4");

CREATE TABLE orders(
    order_pk                        CHAR(36),
    user_fk                         CHAR(36),
    restaurant_fk                   CHAR(36),
    order_created_at                BIGINT UNSIGNED,
    order_updated_at                BIGINT UNSIGNED,
    PRIMARY KEY(order_pk),
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(restaurant_fk) REFERENCES restaurants(restaurant_pk) ON DELETE CASCADE
);

INSERT INTO orders VALUES ("a1c35f00-8d47-4d3b-bf80-b87a3fdf14c1", "8a505c5d-f7c0-4cbe-9e97-16e7ef6cfd60", "883d66a9-695e-48b8-856c-89936789d2a4", "1732804223", "1732804223");
INSERT INTO orders VALUES ("b6d45e11-c234-41f9-b6e5-84f33d2a44f1", "ea793097-bf74-4434-b506-024fbe1ad680", "6a44aa2c-08c2-4b0e-ae2f-6e10669cd6f8", "1732804223", "1732804223");
INSERT INTO orders VALUES ("c2d56712-d125-4e4a-a634-7dc73f2035c9", "7cb9bf5d-eeb7-4f1a-b837-3621415285a0", "883d66a9-695e-48b8-856c-89936789d2a4", "1732804223", "1732804223");
INSERT INTO orders VALUES ("d3f67813-e126-4e5b-b734-9fc84f4146d0", "6d289cb7-7701-4296-b49e-641d39f6c5a7", "6a44aa2c-08c2-4b0e-ae2f-6e10669cd6f8", "1732804223", "1732804223");

CREATE TABLE orders_details(
    order_fk                        CHAR(36),
    menu_item_fk                    CHAR(36),
    quantity                        INT UNSIGNED,
    PRIMARY KEY(order_fk, menu_item_fk),
    FOREIGN KEY(order_fk) REFERENCES orders(order_pk) ON DELETE CASCADE,
    FOREIGN KEY(menu_item_fk) REFERENCES menu_items(menu_item_pk) ON DELETE CASCADE
);

INSERT INTO orders_details VALUES ("a1c35f00-8d47-4d3b-bf80-b87a3fdf14c1", "ef9e3bc2-b164-4fe0-b083-9d6ed0c5e31d", 2);
INSERT INTO orders_details VALUES ("a1c35f00-8d47-4d3b-bf80-b87a3fdf14c1", "231b08de-bbda-4607-9ff5-3e1af964ae06", 1);
INSERT INTO orders_details VALUES ("b6d45e11-c234-41f9-b6e5-84f33d2a44f1", "2468ee78-84b0-4213-a1a0-d5153b161631", 3);
INSERT INTO orders_details VALUES ("c2d56712-d125-4e4a-a634-7dc73f2035c9", "8f02a907-cf6f-4368-bc07-0c53c91ee891", 1);
INSERT INTO orders_details VALUES ("d3f67813-e126-4e5b-b734-9fc84f4146d0", "8b989df9-7a24-4dee-b980-177ee3adc7a5", 2);


CREATE TABLE phones_numbers(
    phone_number_pk             CHAR(36),
    phone_number                CHAR(8) UNIQUE,
    PRIMARY KEY(phone_number_pk)
);

CREATE TABLE users_phones(
    phone_number_fk           CHAR(36),
    user_fk                   CHAR(36),
    PRIMARY KEY(phone_number_fk, user_fk),
    FOREIGN KEY(user_fk) REFERENCES users(user_pk) ON DELETE CASCADE,
    FOREIGN KEY(phone_number_fk) REFERENCES phones_numbers(phone_number_pk) ON DELETE CASCADE
);
INSERT INTO phones_numbers VALUES 
("11111111-aaaa-4cbe-9e97-111111111111", "73128322"),
("22222222-bbbb-4434-b506-222222222222", "76332873"),
("33333333-cccc-4f1a-b837-333333333333", "76221873"),
("44444444-dddd-4296-b49e-444444444444", "76342873");

INSERT INTO users_phones VALUES 
("11111111-aaaa-4cbe-9e97-111111111111", "8a505c5d-f7c0-4cbe-9e97-16e7ef6cfd60"),
("22222222-bbbb-4434-b506-222222222222", "ea793097-bf74-4434-b506-024fbe1ad680"),
("33333333-cccc-4f1a-b837-333333333333", "7cb9bf5d-eeb7-4f1a-b837-3621415285a0"),
("44444444-dddd-4296-b49e-444444444444", "6d289cb7-7701-4296-b49e-641d39f6c5a7");

