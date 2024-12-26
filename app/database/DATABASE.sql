CREATE DATABASE YONDAINV;
USE YONDAINV;

CREATE TABLE personas
(
	idpersona			INT AUTO_INCREMENT PRIMARY KEY,
    apellidos			VARCHAR(50) NOT NULL,
    nombres 			VARCHAR(50) NOT NULL,
    tipodoc 			CHAR(3) 	NOT NULL,
    nrodoc 				VARCHAR(11)	NOT NULL,
    fechanac 			DATETIME 	NOT NULL,
    genero 				CHAR(1)		NOT NULL,
    created 			DATETIME 	NOT NULL DEFAULT NOW(),
    updated 			DATETIME 	NULL,
    disabled			DATETIME 	NULL,
    CONSTRAINT uk_tipodoc_per UNIQUE (tipodoc, nrodoc)
)ENGINE = INNODB;

CREATE TABLE empresas
(
	idempresa 			INT AUTO_INCREMENT PRIMARY KEY,
    razonsocial	 		VARCHAR(400) NOT NULL,
    ruc 				CHAR(11)	 NOT NULL,
	created 			DATETIME 	NOT NULL DEFAULT NOW(),
    updated 			DATETIME 	NULL,
    disabled			DATETIME 	NULL,
    CONSTRAINT uk_ruc_emp UNIQUE (ruc)
)ENGINE = INNODB;

CREATE TABLE ubigeoinei
(
	idubigeo 			VARCHAR(6) 	NOT NULL PRIMARY KEY,
    distrito 			VARCHAR(50) NOT NULL,
    provincia 			VARCHAR(50) NOT NULL,
    departamento 		VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE entidades
(	
	identidad 			INT AUTO_INCREMENT PRIMARY KEY,
    entidad 			VARCHAR(50) NOT NULL,
	created 			DATETIME 	NOT NULL DEFAULT NOW(),
    updated 			DATETIME 	NULL,
    disabled			DATETIME 	NULL,
    CONSTRAINT uk_entidad_ent UNIQUE (entidad)
)ENGINE = INNODB;

CREATE TABLE usuarios
(
	idusuario 			INT AUTO_INCREMENT PRIMARY KEY,
    idpersona			INT 		NOT NULL,
    nomuser 			VARCHAR(15) NOT NULL,
    passuser 			VARCHAR(15) NOT NULL,
    nivelacceso 		VARCHAR(15) NOT NULL,
    telacceso 			CHAR(9) 	NULL,
    email 				VARCHAR(100)NULL,
	created 			DATETIME 	NOT NULL DEFAULT NOW(),
    updated 			DATETIME 	NULL,
    disabled			DATETIME 	NULL,
    CONSTRAINT fk_idpersona_usu FOREIGN KEY (idpersona) REFERENCES personas (idpersona),
    CONSTRAINT uk_idpersona_usu UNIQUE (idpersona),
    CONSTRAINT uk_nomuser_usu UNIQUE (nomuser)
)ENGINE = INNODB;

CREATE TABLE inversionistas
(
	idinversionista 	INT AUTO_INCREMENT PRIMARY KEY,
    tipoinversionista 	CHAR(1) 	NOT NULL, -- Persona - Empresa
    idpersona 			INT 		NULL,
    idempresa 			INT 		NULL,
    idubigeo			VARCHAR(6) 	NOT NULL,
    telprimario			CHAR(9) 	NOT NULL,
    telalternativo 		CHAR(9) 	 NULL,
    direccion 			VARCHAR(100) NULL,
    email 				VARCHAR(100) NULL,
    idasesor 			INT 		NOT NULL,
	created 			DATETIME 	NOT NULL DEFAULT NOW(),
    updated 			DATETIME 	NULL,
    disabled			DATETIME 	NULL,
    CONSTRAINT fk_idpersona_inv FOREIGN KEY (idpersona) REFERENCES personas (idpersona),
    CONSTRAINT fk_idempresa_inv FOREIGN KEY (idempresa) REFERENCES empresas (idempresa),
    CONSTRAINT fk_idubigeo_inv FOREIGN KEY (idubigeo) REFERENCES ubigeoinei (idubigeo),
    CONSTRAINT fk_idasesor_inv FOREIGN KEY (idasesor) REFERENCES usuarios (idusuario)
)ENGINE = INNODB;

CREATE TABLE cuentas
(
	idcuenta			INT AUTO_INCREMENT PRIMARY KEY,
    idinversionista		INT 			NOT NULL,
    identidad 			INT 			NOT NULL,
    moneda				CHAR(3) 		NOT NULL,
    numcuenta			VARCHAR(25) 	NOT NULL,
    cci 				VARCHAR(30) 	NOT NULL,
	created 			DATETIME 		NOT NULL DEFAULT NOW(),
    updated 			DATETIME 		NULL,
    disabled			DATETIME 		NULL,
    CONSTRAINT fk_idinversionista_cta FOREIGN KEY (idinversionista) REFERENCES inversionistas (idinversionista),
    CONSTRAINT fk_identidad_cta FOREIGN KEY (identidad) REFERENCES entidades (identidad)
)ENGINE = INNODB;

