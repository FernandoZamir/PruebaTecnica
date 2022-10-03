--BEGIN TRAN

USE master

CREATE DATABASE samtel

USE samtel

/*
	Uso de camel_case para Base de datos
*/
-- ################### Creamos las tablas correspondientes --

-- # Estudiante
CREATE TABLE estudiante(
	id_estudiante INT IDENTITY(1, 1),
	identificacion VARCHAR(255), -- Registro Civil, Tarjeta Identidad, Pasaporte o Identificación Extranjera
	primer_nombre VARCHAR(100) NOT NULL,
	segundo_nombre VARCHAR(100) NULL,
	primer_apellido VARCHAR(100) NOT NULL,
	segundo_apellido VARCHAR(100) NOT NULL,
	genero BIT DEFAULT 0 NOT NULL, -- 0 Maculino, 1 Femenino (Por defecto sea siempre Masculino)
	fecha_nacimiento DATE NOT NULL,
	tipo_sangre SMALLINT NOT NULL, -- 1 A+, 2 A-, 3 B+, 4 B-, 5 AB+, 6 AB-, 7 O+, 8 O-
	residencia VARCHAR(300) NULL,
	telefono_representante VARCHAR(300) NULL,
	email VARCHAR(300) NULL,
	estado BIT DEFAULT 1, -- 1 Activo, 0 Inactivo
	fecha_actualizado DATETIME DEFAULT GETDATE(),  
	fecha_creado DATETIME DEFAULT GETDATE(),
	CONSTRAINT pk_id_estudiante PRIMARY KEY CLUSTERED (id_estudiante)
)

-- # Materia
CREATE TABLE materia(
	id_materia INT IDENTITY(1, 1),
	titulo VARCHAR(170) NOT NULL,
	descripcion VARCHAR(300) NOT NULL,
	estado BIT DEFAULT 1, -- 1 Activo, 0 Inactivo
	fecha_actualizado DATETIME DEFAULT GETDATE(),  
	fecha_creado DATETIME DEFAULT GETDATE(),
	CONSTRAINT pk_id_materia PRIMARY KEY CLUSTERED (id_materia)
)

-- # Notas
CREATE TABLE nota(
	id_nota INT IDENTITY(1, 1),
	nota DECIMAL(16, 2) NOT NULL,
	fk_id_estudiante INT NOT NULL,
	fk_id_materia INT NOT NULL,		
	fecha_actualizado DATETIME DEFAULT GETDATE(),  
	fecha_creado DATETIME DEFAULT GETDATE(),
	CONSTRAINT pk_id_nota PRIMARY KEY CLUSTERED (id_nota),
	CONSTRAINT fkey_id_estudiante FOREIGN KEY (fk_id_estudiante) REFERENCES estudiante(id_estudiante),
	CONSTRAINT fkey_id_materia FOREIGN KEY (fk_id_materia) REFERENCES materia(id_materia),
)

-- ################## Procedimientos almacenados 
-- Por ahora devolvemos el mensaje desde la base de datos

-- # Operaciones Estudiante
CREATE PROCEDURE sp_estudiante 
	@op VARCHAR(100) = 'LISTAR_ESTUDIANTE', 
	@identificacion VARCHAR(255) = NULL, 
	@primer_nombre VARCHAR(100) = NULL,
	@segundo_nombre VARCHAR(100) = NULL,
	@primer_apellido VARCHAR(100) = NULL,
	@segundo_apellido VARCHAR(100) = NULL,
	@genero BIT = NULL,
	@tipo_sangre SMALLINT = NULL,
	@fecha_nacimiento DATE = NULL,
	@email VARCHAR(300) = NULL,
	@residencia VARCHAR(300) = NULL,
	@telefono_representante VARCHAR(300) = NULL,
	@estado BIT = NULL,
	@transaccion BIT = 0
AS
BEGIN

	BEGIN TRY

	IF(@transaccion = 1)
	BEGIN	
		BEGIN TRAN
	END

		DECLARE @respuesta VARCHAR(MAX)
	
		SET @op = UPPER(@op)
		SET @primer_nombre = LOWER(LTRIM(RTRIM(@primer_nombre)))
		SET @segundo_nombre = LOWER(LTRIM(RTRIM(@segundo_nombre)))
		SET @primer_apellido = LOWER(LTRIM(RTRIM(@primer_apellido)))
		SET @segundo_apellido = LOWER(LTRIM(RTRIM(@segundo_apellido)))

		IF(@op = 'GUARDAR_ESTUDIANTE')
		BEGIN

			IF EXISTS(SELECT 1 FROM estudiante WHERE identificacion = @identificacion)
			BEGIN
				UPDATE estudiante 
				SET
					primer_nombre = @primer_nombre,
					segundo_nombre = @segundo_nombre,
					primer_apellido = @primer_apellido,
					segundo_apellido = @segundo_apellido,
					genero = @genero,
					fecha_nacimiento = @fecha_nacimiento,
					tipo_sangre = @tipo_sangre,
					residencia = @residencia,
					telefono_representante = @telefono_representante,
					email = @email,
					estado = @estado,
					fecha_actualizado = GETDATE()
				WHERE identificacion = @identificacion		
				
				SELECT
				'EXITO' tipo_error,
				'Estudiante '+ @primer_nombre + ' ' + @primer_apellido +' con identificación'+ @identificacion +' actualizado con exito' mensaje  
			END
			ELSE
			BEGIN
				INSERT INTO estudiante (
					identificacion,
					primer_nombre,
					segundo_nombre,
					primer_apellido,
					segundo_apellido,
					genero,
					fecha_nacimiento,
					tipo_sangre,
					residencia,
					telefono_representante,
					email,
					estado
				)
				VALUES (
					@identificacion,
					@primer_nombre,
					@segundo_nombre,
					@primer_apellido,
					@segundo_apellido,
					@genero,
					@fecha_nacimiento,
					@tipo_sangre,
					@residencia,
					@telefono_representante,
					@email,
					@estado
				)

				SELECT
				'EXITO' tipo_error,
				'Estudiante '+ @primer_nombre + ' ' + @primer_apellido +' con identificación '+ @identificacion +' registrado con exito' mensaje

			END

		END

		IF(@op = 'LISTAR_ESTUDIANTE')
		BEGIN
			SELECT * FROM estudiante ORDER BY primer_apellido, segundo_apellido ASC
		END

	IF(@transaccion = 1)
	BEGIN	
		COMMIT
	END

	END TRY

	BEGIN CATCH

		SET @respuesta = 'Error al registrar o actualizar los datos del estudiante '+ @primer_nombre + ' ' + @primer_apellido + ERROR_MESSAGE()
		SELECT 'ERROR' tipo_error, @respuesta mensaje 
		RAISERROR(@respuesta, 18, 1)

		IF(@transaccion = 1)
		BEGIN	
			ROLLBACK
		END

	END CATCH

END

--EXEC sp_estudiante 
--@op = 'GUARDAR_ESTUDIANTE',
--@identificacion = '1067943671',
--@primer_nombre = 'FERNANDO',
--@segundo_nombre = 'ZAMIR',
--@primer_apellido = 'MORENO',
--@segundo_apellido = 'OVIEDO',
--@genero = 1,
--@fecha_nacimiento = '1995-09-09',
--@estado = 1,
--@transaccion = 1

--EXEC sp_estudiante 
--@op = 'LISTAR_ESTUDIANTE'

-- # Operaciones Materia
CREATE PROCEDURE sp_materia 
	@op VARCHAR(100) = 'LISTAR_MATERIA', 
	@id_materia INT = NULL,
	@titulo VARCHAR(170) = NULL,
	@descripcion VARCHAR(300) = NULL,
	@estado BIT = NULL, 
	@transaccion BIT = 0
AS
BEGIN

	BEGIN TRY

	IF(@transaccion = 1)
	BEGIN	
		BEGIN TRAN
	END

		DECLARE @respuesta VARCHAR(MAX)
	
		SET @op = UPPER(@op)
		SET @titulo = LOWER(LTRIM(RTRIM(@titulo)))
		SET @descripcion = LOWER(LTRIM(RTRIM(@descripcion)))

		IF(@op = 'GUARDAR_MATERIA')
		BEGIN

			IF EXISTS(SELECT 1 FROM materia WHERE id_materia = @id_materia)
			BEGIN
				UPDATE materia 
				SET
					titulo = @titulo,
					descripcion = @descripcion,
					estado = @estado,
					fecha_actualizado = GETDATE()
				WHERE id_materia = @id_materia		
				
				SELECT 'EXITO' tipo_error, 'Materia '+ @titulo + 'actualizada con exito' mensaje  
			END
			ELSE
			BEGIN
				INSERT INTO materia(
					titulo,
					descripcion,
					estado
				)
				VALUES (
					@titulo,
					@descripcion,
					@estado
				)

				SELECT
				'EXITO' tipo_error,
				'Materia ' + @titulo +' registrada con exito' mensaje

			END

		END

		IF(@op = 'LISTAR_MATERIA')
		BEGIN
			SELECT * FROM materia ORDER BY titulo ASC
		END

	IF(@transaccion = 1)
	BEGIN	
		COMMIT
	END

	END TRY

	BEGIN CATCH

		SET @respuesta = 'Error al registrar o actualizar los datos de la materia'+ @titulo + ' ' + ERROR_MESSAGE()
		SELECT 'ERROR' tipo_error, @respuesta mensaje 
		RAISERROR(@respuesta, 18, 1)

		IF(@transaccion = 1)
		BEGIN	
			ROLLBACK
		END

	END CATCH

END

--EXEC sp_materia 
--@op = 'GUARDAR_MATERIA', 
--@id_materia = 2, -- NULL para crear una nueva materia
--@titulo = 'Matemática',
--@descripcion = 'Ciencia que estudia las propiedades de los números y las relaciones que se establecen entre ellos.',
--@estado = 1, 
--@transaccion = 1

--EXEC sp_materia 
--@op = 'GUARDAR_MATERIA', 
--@id_materia = NULL, -- NULL para crear una nueva materia
--@titulo = 'Ciencias Naturales',
--@descripcion = 'Las ciencias naturales buscan entender el funcionamiento del universo y el mundo que nos rodea..',
--@estado = 1, 
--@transaccion = 1

--EXEC sp_materia 
--@op = 'LISTAR_MATERIA'


-- # Operaciones Nota

CREATE PROCEDURE sp_nota 
	@op VARCHAR(100) = 'LISTAR_NOTA', 
	@id_nota INT = NULL,
	@id_estudiante INT = NULL,
	@id_materia INT = NULL,
	@nota DECIMAL(10, 2) = 0.00,
	@transaccion BIT = 0
AS
BEGIN

	BEGIN TRY

	IF(@transaccion = 1)
	BEGIN	
		BEGIN TRAN
	END

		DECLARE @respuesta VARCHAR(MAX)	
		SET @op = UPPER(@op)
		
		IF(@op = 'GUARDAR_NOTA')
		BEGIN

			IF EXISTS(SELECT 1 FROM nota WHERE id_nota = @id_nota)
			BEGIN
				UPDATE nota 
				SET
					nota = @nota,
					fecha_actualizado = GETDATE()
				WHERE id_nota = @id_nota		
				
				SELECT 'EXITO' tipo_error, 'Nota actualizada con exito' mensaje  
			END
			ELSE
			BEGIN
				INSERT INTO nota(
					nota,
					fk_id_estudiante,
					fk_id_materia
				)
				VALUES (
					@nota,
					@id_estudiante,
					@id_materia
				)

				SELECT
				'EXITO' tipo_error,
				'Nota registrada con exito' mensaje

			END

		END

		IF(@op = 'LISTAR_NOTA')
		BEGIN
			SELECT n.id_nota, n.fk_id_materia, n.fk_id_estudiante, e.primer_nombre, e.primer_apellido, m.titulo, ISNULL(n.nota, 0) nota FROM nota n
			LEFT JOIN materia m ON m.id_materia = n.fk_id_materia
			LEFT JOIN estudiante e ON e.id_estudiante = n.fk_id_estudiante			
			ORDER BY e.primer_nombre, e.primer_apellido ASC
		END

	IF(@transaccion = 1)
	BEGIN	
		COMMIT
	END

	END TRY

	BEGIN CATCH

		SET @respuesta = 'Error al registrar o actualizar los datos de la nota ' + ERROR_MESSAGE()
		SELECT 'ERROR' tipo_error, @respuesta mensaje 
		RAISERROR(@respuesta, 18, 1)

		IF(@transaccion = 1)
		BEGIN	
			ROLLBACK
		END

	END CATCH

END
--DECLARE @nota DECIMAL(10, 2) = 4.50

--EXEC sp_nota 
--@op = 'GUARDAR_NOTA', 
--@id_nota = NULL,
--@id_estudiante = 1,
--@id_materia = 2,
--@nota = @nota,
--@transaccion = 1

--EXEC sp_nota 
--@op = 'LISTAR_NOTA'

--ROLLBACK
