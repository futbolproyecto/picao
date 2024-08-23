CREATE TABLE users
(
    user_id          INTEGER,
    name             VARCHAR(30),
    second_name      VARCHAR(30),
    last_name        VARCHAR(30),
    second_last_name VARCHAR(30),
    mobile_number    VARCHAR(15),
    email            VARCHAR(50),
    country_id       INTEGER,
    city_id          INTEGER,
    rol_id           INTEGER,
    PRIMARY KEY (user_id)
);

CREATE TABLE countries
(
    country_id  INTEGER,
    name        VARCHAR(50),
    cell_prefix VARCHAR(10),
    PRIMARY KEY (country_id)
);

CREATE TABLE cities
(
    city_id    INTEGER,
    name       VARCHAR(50),
    country_id INTEGER,
    PRIMARY KEY (city_id)
);

CREATE TABLE roles
(
    rol_id INTEGER,
    name   VARCHAR(20),
    PRIMARY KEY (rol_id)
);

CREATE TABLE profiles
(
    profile_id INTEGER,
    rol_id     INTEGER,
    modul_id   INTEGER,
    PRIMARY KEY (profile_id)
);

CREATE TABLE modules
(
    modul_id INTEGER,
    name     VARCHAR(40),
    PRIMARY KEY (modul_id)
);