-- crear roles
INSERT INTO roles (name) VALUES ('JUGADOR'),('CAPITAN_EQUIPO'),('ENTRENADOR'),('AGENDADOR_CANCHA');
-- crear paises
INSERT INTO countries (name,cell_prefix) VALUES ('colombia','57');
-- crear ciudades
INSERT INTO cities (name,country_id) VALUES ('cali',1);
-- crear status
INSERT INTO statuses (description) VALUES ('activo'),('inactivo');
