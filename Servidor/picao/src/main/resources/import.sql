-- crear roles
INSERT INTO roles (name) VALUES ('JUGADOR'),('CAPITAN_EQUIPO'),('ENTRENADOR'),('AGENDADOR_CANCHA');
-- crear paises
INSERT INTO countries (name,cell_prefix) VALUES ('colombia','57');
-- crear ciudades
INSERT INTO cities (name,country_id) VALUES ('cali',1);
-- crear status
INSERT INTO statuses (description) VALUES ('activo'),('inactivo');
-- crear usuario inicial
INSERT INTO users (name,second_name,last_name,second_last_name,mobile_number,email,password,username,city_id,status_id) VALUES ('golpi','segundo nombre','apellido golpi','segundo apellido golpi','31112111','golpi@gmail.com','$2a$10$an2sN0xzn8Ve7yjAoPNdHufOvtA5dfW2jd3ZKZtBpD5LPwWEzBYSC','golpi',1,1);
-- se asignan roles
INSERT INTO user_roles (role_id, user_id) VALUES (1,1),(2,1);