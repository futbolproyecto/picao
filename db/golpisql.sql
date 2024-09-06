

CREATE TABLE IF NOT EXISTS statuses
(
    status_id   INTEGER,
    description VARCHAR(20),
    PRIMARY KEY (status_id)
);

CREATE TABLE IF NOT EXISTS countries
(
    country_id  INTEGER,
    name        VARCHAR(50),
    cell_prefix VARCHAR(10),
    PRIMARY KEY (country_id)
);

CREATE TABLE IF NOT EXISTS cities
(
    city_id    INTEGER,
    name       VARCHAR(50),
    country_id INTEGER,
    PRIMARY KEY (city_id),
    FOREIGN KEY (country_id) REFERENCES countries
);

CREATE TABLE IF NOT EXISTS roles
(
    rol_id INTEGER,
    name   VARCHAR(50),
    PRIMARY KEY (rol_id)
);

CREATE TABLE IF NOT EXISTS users
(
    user_id          INTEGER,
    name             VARCHAR(50),
    second_name      VARCHAR(50),
    last_name        VARCHAR(50),
    second_last_name VARCHAR(50),
    mobile_number    VARCHAR(20),
    email            VARCHAR(80),
    password         VARCHAR(20),
    city_id          INTEGER,
    rol_id           INTEGER,
    status_id        INTEGER,
    PRIMARY KEY (user_id),
    FOREIGN KEY (city_id) REFERENCES cities,
    FOREIGN KEY (rol_id) REFERENCES roles,
    FOREIGN KEY (status_id) REFERENCES statuses
);

CREATE TABLE IF NOT EXISTS modules
(
    modul_id INTEGER,
    name     VARCHAR(50),
    PRIMARY KEY (modul_id)
);

CREATE TABLE IF NOT EXISTS profiles
(
    profile_id INTEGER,
    rol_id     INTEGER,
    modul_id   INTEGER,
    PRIMARY KEY (profile_id),
    FOREIGN KEY (modul_id) REFERENCES modules,
    FOREIGN KEY (rol_id) REFERENCES roles

);

CREATE TABLE IF NOT EXISTS teams
(
    team_id   INTEGER,
    name      VARCHAR(50),
    status_id INTEGER,
    PRIMARY KEY (team_id),
    FOREIGN KEY (status_id) REFERENCES statuses
);

CREATE TABLE IF NOT EXISTS usersbyteams
(
    user_by_team_id INTEGER,
    team_id         INTEGER,
    user_id         INTEGER,
    PRIMARY KEY (user_by_team_id),
    FOREIGN KEY (team_id) REFERENCES teams,
    FOREIGN KEY (user_id) REFERENCES users
);

CREATE TABLE IF NOT EXISTS fields
(
    field_id  INTEGER,
    name      VARCHAR(50),
    city_id   INTEGER,
    address   VARCHAR(100),
    latitude  NUMERIC,
    longitude NUMERIC,
    status_id INTEGER,
    PRIMARY KEY (field_id),
    FOREIGN KEY (city_id) REFERENCES cities,
    FOREIGN KEY (status_id) REFERENCES statuses
);

CREATE TABLE IF NOT EXISTS usersbyfields
(
    user_id  INTEGER,
    field_id INTEGER,
    PRIMARY KEY (user_id, field_id),
    FOREIGN KEY (user_id) REFERENCES users,
    FOREIGN KEY (field_id) REFERENCES fields
);

CREATE table IF NOT EXISTS fieldhours
(
    field_schedule_id INTEGER,
    field_id          INTEGER,
    start_time        TIME,
    end_time          TIME,
    PRIMARY KEY (field_schedule_id),
    FOREIGN KEY (field_id) REFERENCES fields
);

CREATE table IF NOT EXISTS fieldschedules
(
    field_schedule_id INTEGER,
    field_id          INTEGER,
    user_id           INTEGER,
    start_time        TIME,
    number_hours      INTEGER,
    state_id          INTEGER,
    PRIMARY KEY (field_schedule_id),
    FOREIGN KEY (field_id) REFERENCES fields,
    FOREIGN KEY (user_id) REFERENCES users
);

CREATE TABLE IF NOT EXISTS filestypes
(
    file_type_id INTEGER,
    name         VARCHAR(50),
    PRIMARY KEY (file_type_id)
);

CREATE TABLE IF NOT EXISTS files
(
    files_id     INTEGER,
    file_type_id INTEGER,
    content      VARCHAR(100),
    extension    VARCHAR(10),
    status_id    INTEGER,
    PRIMARY KEY (files_id),
    FOREIGN KEY (file_type_id) REFERENCES filestypes,
    FOREIGN KEY (status_id) REFERENCES statuses
);

CREATE TABLE IF NOT EXISTS filesbyusers
(
    file_id INTEGER,
    user_id INTEGER,
    PRIMARY KEY (file_id, user_id),
    FOREIGN KEY (file_id) REFERENCES files,
    FOREIGN KEY (user_id) REFERENCES users
);
CREATE TABLE IF NOT EXISTS filesbyfields
(
    file_id  INTEGER,
    field_id INTEGER,
    PRIMARY KEY (file_id, field_id),
    FOREIGN KEY (file_id) REFERENCES files,
    FOREIGN KEY (field_id) REFERENCES fields
);