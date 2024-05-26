CREATE DATABASE DB_ACME2;
USE DB_ACME2;

CREATE TABLE persona_unificada (
    usuId INT IDENTITY(1,1) PRIMARY KEY,
    tipo_documento_id INT NOT NULL,
    numero_documento VARCHAR(50) NOT NULL UNIQUE,
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    tipo_usuario VARCHAR(50) NOT NULL CHECK (tipo_usuario IN ('natural', 'juridica')),
    razon_social VARCHAR(100),
    tipo_empresa VARCHAR(50),
    departamento VARCHAR(50),
    municipio VARCHAR(50)
);

CREATE TABLE usuario_rol (
    id INT IDENTITY(1,1) PRIMARY KEY,
    numero_identificacion VARCHAR(50) NOT NULL,
    tipo_identificacion INT NOT NULL,
    nombres VARCHAR(100),
    tipo_usuario VARCHAR(50) NOT NULL CHECK (tipo_usuario IN ('natural', 'juridica')),
    rol VARCHAR(50),
	id_empresa INT NOT NULL,
    FOREIGN KEY (numero_identificacion) REFERENCES persona_unificada(numero_documento)
);

CREATE TABLE representante_legal (
    empresa_id INT NOT NULL,
    representante_id INT NOT NULL,
    representante_numero_documento VARCHAR(50) NOT NULL,
    representante_nombres VARCHAR(100),
    razon_social_empresa VARCHAR(100),
    PRIMARY KEY (empresa_id),
    FOREIGN KEY (empresa_id) REFERENCES persona_unificada(usuId),
    FOREIGN KEY (representante_id) REFERENCES persona_unificada(usuId)
);

CREATE TABLE composicion_accionaria (
	id INT IDENTITY(1,1) PRIMARY KEY,
    empresa_id INT NOT NULL,
    accionista_id INT NOT NULL,
    accionista_numero_documento VARCHAR(50) NOT NULL,
    accionista_nombres VARCHAR(100),
    FOREIGN KEY (empresa_id) REFERENCES persona_unificada(usuId),
    FOREIGN KEY (accionista_id) REFERENCES persona_unificada(usuId)
);

CREATE TABLE cuenta_ahorro (
    id INT IDENTITY(1,1) PRIMARY KEY,
    numero_cuenta VARCHAR(50) UNIQUE NOT NULL,
    saldo_total DECIMAL(18, 2),
    saldo_canje DECIMAL(18, 2),
    saldo_disponible DECIMAL(18, 2),
    estado VARCHAR(50) CHECK (estado IN ('ACTIVA', 'INACTIVA')),
    fecha_creacion DATE
);

CREATE TABLE cuenta_ahorro_usuarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    numero_cuenta VARCHAR(50),
    usuId INT,
    FOREIGN KEY (numero_cuenta) REFERENCES cuenta_ahorro(numero_cuenta),
    FOREIGN KEY (usuId) REFERENCES persona_unificada(usuId)
);

CREATE TABLE movimientos_cuenta_ahorro (
    id INT IDENTITY(1,1) PRIMARY KEY,
    numero_cuenta VARCHAR(50),
    tipo_movimiento VARCHAR(50),
    monto DECIMAL(18, 2),
    fecha_transaccion DATE,
    num_transaccion VARCHAR(50),
    FOREIGN KEY (numero_cuenta) REFERENCES cuenta_ahorro(numero_cuenta)
);

CREATE TABLE tarjeta_credito (
    id INT IDENTITY(1,1) PRIMARY KEY,
    franquicia VARCHAR(50),
    numero_tarjeta VARCHAR(50) UNIQUE NOT NULL,
    cupo_aprobado DECIMAL(18, 2),
    cupo_disponible DECIMAL(18, 2),
    estado VARCHAR(50) CHECK (estado IN ('ACTIVA', 'INACTIVA')),
    fecha_creacion DATE,
    usuId INT UNIQUE,
    FOREIGN KEY (usuId) REFERENCES persona_unificada(usuId)
);

CREATE TABLE movimientos_tarjeta_credito (
    id INT IDENTITY(1,1) PRIMARY KEY,
    numero_tarjeta VARCHAR(50),
    tipo_movimiento VARCHAR(50),
    monto DECIMAL(18, 2),
    fecha_transaccion DATE,
    num_transaccion VARCHAR(50),
    FOREIGN KEY (numero_tarjeta) REFERENCES tarjeta_credito(numero_tarjeta)
);




INSERT INTO persona_unificada (tipo_documento_id, numero_documento, nombres, apellidos, tipo_usuario, razon_social, tipo_empresa, departamento, municipio)
VALUES
    (1, '1111111111', 'Pedro', 'García', 'natural', NULL, NULL, 'Antioquia', 'Medellín'),
    (2, '2222222222', 'Ana', 'Martínez', 'natural', NULL, NULL, 'Cundinamarca', 'Bogotá'),
    (3, '3333333333', NULL, NULL, 'juridica', 'Empresa ABC Ltda.', 'SAS', 'Valle del Cauca', 'Cali'),
    (1, '4444444444', 'Carlos', 'Rodríguez', 'natural', NULL, NULL, 'Antioquia', 'Medellín'),
    (2, '5555555555', 'Luisa', 'López', 'natural', NULL, NULL, 'Cundinamarca', 'Bogotá'),
    (1, '6666666666', 'Marcela', 'Herrera', 'natural', NULL, NULL, 'Valle del Cauca', 'Cali'),
    (1, '7777777777', 'Andrés', 'Díaz', 'natural', NULL, NULL, 'Antioquia', 'Medellín'),
    (2, '8888888888', 'Laura', 'Gómez', 'natural', NULL, NULL, 'Cundinamarca', 'Bogotá'),
    (3, '9999999999', NULL, NULL, 'juridica', 'Empresa XYZ Ltda.', 'SAS', 'Valle del Cauca', 'Cali'),
    (1, '0000000000', 'Javier', 'Pérez', 'natural', NULL, NULL, 'Antioquia', 'Medellín');

INSERT INTO usuario_rol (numero_identificacion, tipo_identificacion, nombres, tipo_usuario, rol, id_empresa)
VALUES
    ('1111111111', 1, 'Pedro García', 'natural', 'clientes persona natural' , 3),
    ('2222222222', 2, 'Ana Martínez', 'natural', 'representantes legales' , 3),
    ('4444444444', 1, 'Carlos Rodríguez', 'natural', 'proveedores' , 3),
    ('5555555555', 2, 'Luisa López', 'natural', 'proveedores' , 9),
    ('6666666666', 1, 'Marcela Herrera', 'natural', 'proveedores' , 9),
    ('7777777777', 1, 'Andrés Díaz', 'natural', 'clientes persona natural' , 3),
    ('8888888888', 2, 'Laura Gómez', 'natural', 'clientes persona natural' , 3),
    ('0000000000', 1, 'Javier Pérez', 'natural', 'accionistas' , 9),
    ('0000000000', 1, 'Javier Pérez', 'natural', 'representantes legales' , 3);

INSERT INTO representante_legal (empresa_id, representante_id, representante_numero_documento, representante_nombres, razon_social_empresa)
VALUES
    (3, 2, '2222222222', 'Ana Martínez', 'Empresa ABC Ltda.'),
    (9, 10, '0000000000', 'Javier Pérez', 'Empresa XYZ Ltda.');

INSERT INTO composicion_accionaria (empresa_id, accionista_id, accionista_numero_documento, accionista_nombres)
VALUES
    (3, 3, '4444444444', 'Carlos Rodríguez'),
    (3, 4, '5555555555', 'Luisa López'),
    (9, 1, '1111111111', 'Pedro García'),
    (9, 10, '0000000000', 'Javier Pérez');

INSERT INTO cuenta_ahorro (numero_cuenta, saldo_total, saldo_canje, saldo_disponible, estado, fecha_creacion)
VALUES
    ('AHORRO-003', 1200000.00, 600000.00, 600000.00, 'ACTIVA', '2024-05-27'),
    ('AHORRO-004', 1500000.00, 700000.00, 700000.00, 'ACTIVA', '2024-05-27'),
    ('AHORRO-005', 900000.00, 300000.00, 600000.00, 'ACTIVA', '2024-05-27'),
    ('AHORRO-006', 1800000.00, 800000.00, 1000000.00, 'ACTIVA', '2024-05-27'),
    ('AHORRO-007', 700000.00, 200000.00, 500000.00, 'ACTIVA', '2024-05-27'),
    ('AHORRO-008', 2000000.00, 1000000.00, 1000000.00, 'ACTIVA', '2024-05-27'),
    ('AHORRO-009', 300000.00, 100000.00, 200000.00, 'ACTIVA', '2024-05-27'),
    ('AHORRO-010', 600000.00, 200000.00, 400000.00, 'ACTIVA', '2024-05-27'),
    ('AHORRO-011', 2400000.00, 1200000.00, 1200000.00, 'ACTIVA', '2024-05-27'),
    ('AHORRO-012', 500000.00, 100000.00, 400000.00, 'ACTIVA', '2024-05-27');


INSERT INTO cuenta_ahorro_usuarios (numero_cuenta, usuId)
VALUES
    ('AHORRO-003', 2),
    ('AHORRO-004', 2),
    ('AHORRO-005', 5), 
    ('AHORRO-006', 6),
    ('AHORRO-007', 7),
    ('AHORRO-008', 8),
    ('AHORRO-009', 9),
    ('AHORRO-010', 10), 
    ('AHORRO-005', 2), 
    ('AHORRO-005', 1);  

INSERT INTO movimientos_cuenta_ahorro (numero_cuenta, tipo_movimiento, monto, fecha_transaccion, num_transaccion)
VALUES
    ('AHORRO-003', 'Depósito', 300000.00, '2024-05-28', 'TRX003'),
    ('AHORRO-003', 'Retiro', 200000.00, '2024-05-28', 'TRX004'),
    ('AHORRO-004', 'Depósito', 500000.00, '2024-05-28', 'TRX005'),
    ('AHORRO-004', 'Retiro', 300000.00, '2024-05-28', 'TRX006'),
    ('AHORRO-005', 'Depósito', 200000.00, '2024-05-28', 'TRX007'),
    ('AHORRO-005', 'Retiro', 100000.00, '2024-05-28', 'TRX008'),
    ('AHORRO-006', 'Depósito', 800000.00, '2024-05-28', 'TRX009'),
    ('AHORRO-006', 'Retiro', 700000.00, '2024-05-28', 'TRX010'),
    ('AHORRO-007', 'Depósito', 300000.00, '2024-05-28', 'TRX011'),
    ('AHORRO-007', 'Retiro', 200000.00, '2024-05-28', 'TRX012');
    
INSERT INTO tarjeta_credito (franquicia, numero_tarjeta, cupo_aprobado, cupo_disponible, estado, fecha_creacion, usuId)
VALUES
    ('VISA', '3333444455556666', 4000000.00, 4000000.00, 'ACTIVA', '2024-05-27', 1),
    ('MasterCard', '7777888899990000', 3000000.00, 1500000.00, 'ACTIVA', '2024-05-27', 2),
    ('American Express', '1111222233334444', 5000000.00, 2500000.00, 'ACTIVA', '2024-05-27', 3),
    ('Diners Club', '5555666677778888', 2000000.00, 900000.00, 'ACTIVA', '2024-05-27', 4),
    ('VISA', '9999000011112222', 6000000.00, 3000000.00, 'ACTIVA', '2024-05-27', 5),
    ('MasterCard', '3333222211110000', 7000000.00, 3500000.00, 'ACTIVA', '2024-05-27', 6),
    ('American Express', '8888999900001111', 4000000.00, 2000000.00, 'ACTIVA', '2024-05-27', 7),
    ('Diners Club', '4444555566667777', 1500000.00, 750000.00, 'ACTIVA', '2024-05-27', 8),
    ('VISA', '6666777788889999', 3000000.00, 1500000.00, 'ACTIVA', '2024-05-27', 9),
    ('MasterCard', '2222333344445555', 2500000.00, 1250000.00, 'ACTIVA', '2024-05-27', 10);


INSERT INTO movimientos_tarjeta_credito (numero_tarjeta, tipo_movimiento, monto, fecha_transaccion, num_transaccion)
VALUES
    ('3333444455556666', 'Compra', 500000.00, '2024-05-28', 'TRX001'),
    ('3333444455556666', 'Compra', 1000000.00, '2024-05-28', 'TRX002'),
    ('3333444455556666', 'Pago', -300000.00, '2024-05-28', 'TRX003'),
    ('7777888899990000', 'Compra', 800000.00, '2024-05-28', 'TRX004'),
    ('7777888899990000', 'Compra', 600000.00, '2024-05-28', 'TRX005'),
    ('7777888899990000', 'Pago', -500000.00, '2024-05-28', 'TRX006'),
    ('1111222233334444', 'Compra', 1200000.00, '2024-05-28', 'TRX007'),
    ('1111222233334444', 'Compra', 500000.00, '2024-05-28', 'TRX008'),
    ('1111222233334444', 'Pago', -700000.00, '2024-05-28', 'TRX009'),
    ('5555666677778888', 'Compra', 300000.00, '2024-05-28', 'TRX010'),
    ('5555666677778888', 'Compra', 400000.00, '2024-05-28', 'TRX011'),
    ('5555666677778888', 'Pago', -200000.00, '2024-05-28', 'TRX012'),
    ('9999000011112222', 'Compra', 1500000.00, '2024-05-28', 'TRX013'),
    ('9999000011112222', 'Compra', 200000.00, '2024-05-28', 'TRX014'),
    ('9999000011112222', 'Pago', -1000000.00, '2024-05-28', 'TRX015'),
    ('3333222211110000', 'Compra', 1800000.00, '2024-05-28', 'TRX016'),
    ('3333222211110000', 'Compra', 700000.00, '2024-05-28', 'TRX017'),
    ('3333222211110000', 'Pago', -1200000.00, '2024-05-28', 'TRX018'),
    ('8888999900001111', 'Compra', 900000.00, '2024-05-28', 'TRX019'),
    ('8888999900001111', 'Compra', 600000.00, '2024-05-28', 'TRX020'),
    ('8888999900001111', 'Pago', -400000.00, '2024-05-28', 'TRX021'),
    ('4444555566667777', 'Compra', 500000.00, '2024-05-28', 'TRX022'),
    ('4444555566667777', 'Compra', 300000.00, '2024-05-28', 'TRX023'),
    ('4444555566667777', 'Pago', -300000.00, '2024-05-28', 'TRX024'),
    ('6666777788889999', 'Compra', 1200000.00, '2024-05-28', 'TRX025'),
    ('6666777788889999', 'Compra', 800000.00, '2024-05-28', 'TRX026'),
    ('6666777788889999', 'Pago', -600000.00, '2024-05-28', 'TRX027'),
    ('2222333344445555', 'Compra', 1000000.00, '2024-05-28', 'TRX028'),
    ('2222333344445555', 'Compra', 500000.00, '2024-05-28', 'TRX029'),
    ('2222333344445555', 'Pago', -800000.00, '2024-05-28', 'TRX030');
