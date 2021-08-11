/*
Script de implementación para LaboratorioProgra6

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "LaboratorioProgra6"
:setvar DefaultFilePrefix "LaboratorioProgra6"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando la base de datos $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creando Tabla [dbo].[Agencias]...';


GO
CREATE TABLE [dbo].[Agencias] (
    [AgenciaId]           INT           IDENTITY (1, 1) NOT NULL,
    [Nombre]              VARCHAR (250) NOT NULL,
    [IdCatalogoProvincia] INT           NOT NULL,
    [IdCatalogoCanton]    INT           NOT NULL,
    [IdCatalogoDistrito]  INT           NOT NULL,
    [Estado]              BIT           NOT NULL,
    CONSTRAINT [Agencia] PRIMARY KEY CLUSTERED ([AgenciaId] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Tabla [dbo].[CatalogoCanton]...';


GO
CREATE TABLE [dbo].[CatalogoCanton] (
    [IdCatalogoCanton]     INT          IDENTITY (1, 1) NOT NULL,
    [NombreCatalogoCanton] VARCHAR (50) NULL,
    [IdCatalogoProvincia]  INT          NOT NULL,
    CONSTRAINT [PK_Canton] PRIMARY KEY CLUSTERED ([IdCatalogoCanton] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Tabla [dbo].[CatalogoDistrito]...';


GO
CREATE TABLE [dbo].[CatalogoDistrito] (
    [IdCatalogoDistrito]     INT          IDENTITY (1, 1) NOT NULL,
    [NombreCatalogoDistrito] VARCHAR (50) NULL,
    [IdCatalogoCanton]       INT          NOT NULL,
    CONSTRAINT [PK_Distrito] PRIMARY KEY CLUSTERED ([IdCatalogoDistrito] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Tabla [dbo].[CatalogoProvincia]...';


GO
CREATE TABLE [dbo].[CatalogoProvincia] (
    [IdCatalogoProvincia]     INT          IDENTITY (1, 1) NOT NULL,
    [NombreCatalogoProvincia] VARCHAR (50) NULL,
    CONSTRAINT [PK_Provincia] PRIMARY KEY CLUSTERED ([IdCatalogoProvincia] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Clientes]...';


GO
CREATE TABLE [dbo].[Clientes] (
    [ClientesId]     INT           IDENTITY (1, 1) NOT NULL,
    [NombreCompleto] VARCHAR (250) NOT NULL,
    [Direccion]      VARCHAR (500) NOT NULL,
    [Telefono]       VARCHAR (500) NOT NULL,
    [AgenciaId]      INT           NOT NULL,
    [Estado]         BIT           NULL,
    CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED ([ClientesId] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Tabla [dbo].[MarcaVehiculo]...';


GO
CREATE TABLE [dbo].[MarcaVehiculo] (
    [MarcaVehiculoId] INT           IDENTITY (1, 1) NOT NULL,
    [Descripcion]     VARCHAR (250) NOT NULL,
    [Estado]          BIT           NOT NULL,
    CONSTRAINT [PK_MarcaVehiculo] PRIMARY KEY CLUSTERED ([MarcaVehiculoId] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Tabla [dbo].[Usuarios]...';


GO
CREATE TABLE [dbo].[Usuarios] (
    [UsuariosId] INT             IDENTITY (1, 1) NOT NULL,
    [Usuario]    VARCHAR (250)   NOT NULL,
    [Nombre]     VARCHAR (500)   NOT NULL,
    [Contrasena] VARBINARY (MAX) NOT NULL,
    [Estado]     BIT             NOT NULL,
    CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED ([UsuariosId] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Vehiculo]...';


GO
CREATE TABLE [dbo].[Vehiculo] (
    [VehiculoId]      INT            IDENTITY (1, 1) NOT NULL,
    [MarcaVehiculoId] INT            NOT NULL,
    [Matricula]       VARCHAR (250)  NOT NULL,
    [Color]           VARCHAR (250)  NOT NULL,
    [Modelo]          VARCHAR (250)  NOT NULL,
    [FechaModelo]     DATE           NOT NULL,
    [TieneDefectos]   BIT            NOT NULL,
    [Defectos]        VARCHAR (1000) NULL,
    [Estado]          BIT            NOT NULL,
    CONSTRAINT [PK_Vehiculo] PRIMARY KEY CLUSTERED ([VehiculoId] ASC)
)
WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Índice [dbo].[Vehiculo].[IDX_Vehiculo_Matricula]...';


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_Vehiculo_Matricula]
    ON [dbo].[Vehiculo]([Matricula] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_Vehiculo_FechaModelo]...';


GO
ALTER TABLE [dbo].[Vehiculo]
    ADD CONSTRAINT [DF_Vehiculo_FechaModelo] DEFAULT ('2020-01-01') FOR [FechaModelo];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_Vehiculo_TieneDefectos]...';


GO
ALTER TABLE [dbo].[Vehiculo]
    ADD CONSTRAINT [DF_Vehiculo_TieneDefectos] DEFAULT (0) FOR [TieneDefectos];


GO
PRINT N'Creando Clave externa [dbo].[FK_Agencia_Provincia]...';


GO
ALTER TABLE [dbo].[Agencias]
    ADD CONSTRAINT [FK_Agencia_Provincia] FOREIGN KEY ([IdCatalogoProvincia]) REFERENCES [dbo].[CatalogoProvincia] ([IdCatalogoProvincia]);


GO
PRINT N'Creando Clave externa [dbo].[Fk_Agencia_Canton]...';


GO
ALTER TABLE [dbo].[Agencias]
    ADD CONSTRAINT [Fk_Agencia_Canton] FOREIGN KEY ([IdCatalogoCanton]) REFERENCES [dbo].[CatalogoCanton] ([IdCatalogoCanton]);


GO
PRINT N'Creando Clave externa [dbo].[Fk_Agencia_Distrito]...';


GO
ALTER TABLE [dbo].[Agencias]
    ADD CONSTRAINT [Fk_Agencia_Distrito] FOREIGN KEY ([IdCatalogoDistrito]) REFERENCES [dbo].[CatalogoDistrito] ([IdCatalogoDistrito]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Canton_Provincia]...';


GO
ALTER TABLE [dbo].[CatalogoCanton]
    ADD CONSTRAINT [FK_Canton_Provincia] FOREIGN KEY ([IdCatalogoProvincia]) REFERENCES [dbo].[CatalogoProvincia] ([IdCatalogoProvincia]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Distrito_Canton]...';


GO
ALTER TABLE [dbo].[CatalogoDistrito]
    ADD CONSTRAINT [FK_Distrito_Canton] FOREIGN KEY ([IdCatalogoCanton]) REFERENCES [dbo].[CatalogoCanton] ([IdCatalogoCanton]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Clientes_Angecias]...';


GO
ALTER TABLE [dbo].[Clientes]
    ADD CONSTRAINT [FK_Clientes_Angecias] FOREIGN KEY ([AgenciaId]) REFERENCES [dbo].[Agencias] ([AgenciaId]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Vehiculo_MarcaVehiculo]...';


GO
ALTER TABLE [dbo].[Vehiculo]
    ADD CONSTRAINT [FK_Vehiculo_MarcaVehiculo] FOREIGN KEY ([MarcaVehiculoId]) REFERENCES [dbo].[MarcaVehiculo] ([MarcaVehiculoId]);


GO
PRINT N'Creando Procedimiento [dbo].[AgenciaActualizar]...';


GO
CREATE PROCEDURE dbo.AgenciaActualizar
    @AgenciaId INT,
	@Nombre VARCHAR(500),
	@IdCatalogoProvincia INT,
	@IdCatalogoCanton INT,
	@IdCatalogoDistrito INT,
    @Estado BIT
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY
	-- AQUI VA EL CODIGO
		
	UPDATE dbo.Agencias SET
	    Nombre=@Nombre,
		IdCatalogoProvincia=@IdCatalogoProvincia,
		IdCatalogoCanton=@IdCatalogoCanton,
		IdCatalogoDistrito=@IdCatalogoDistrito,
		Estado=@Estado

	WHERE AgenciaId=@AgenciaId

		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[AgenciaEliminar]...';


GO
CREATE PROCEDURE [dbo].[AgenciaEliminar]
@AgenciaId INT
  
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY

		
	DELETE FROM Dbo.Agencias WHERE AgenciaId=@AgenciaId


		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[AgenciaInsertar]...';


GO
CREATE PROCEDURE dbo.AgenciaInsertar
	@Nombre VARCHAR(500),
	@IdCatalogoProvincia INT,
	@IdCatalogoCanton INT,
	@IdCatalogoDistrito INT,
    @Estado BIT
	
	
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY

		
		INSERT INTO dbo.Agencias 
		(	       
	      Nombre,
		  IdCatalogoProvincia,
		  IdCatalogoCanton,
		  IdCatalogoDistrito,
		  Estado
		)
		VALUES
		(
		
	      @Nombre,
		  @IdCatalogoProvincia,
		  @IdCatalogoCanton,
		  @IdCatalogoDistrito,
		  @Estado
		)


		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[AgenciaLista]...';


GO
CREATE PROCEDURE [dbo].AgenciaLista
	
AS
	BEGIN
	SET NOCOUNT ON


	SELECT
	 AgenciaId,
	 Nombre
	FROM Agencias
	WHERE Estado=1


	END
GO
PRINT N'Creando Procedimiento [dbo].[AgenciaObtener]...';


GO
CREATE PROCEDURE [dbo].AgenciaObtener
@AgenciaId INT=NULL

AS BEGIN
	SET NOCOUNT ON

	SELECT
			A.AgenciaId
		,   A.Nombre
		,   A.Estado

		,   CP.IdCatalogoProvincia
		,	CP.NombreCatalogoProvincia

		,   CC.IdCatalogoCanton
		,	CC.NombreCatalogoCanton

		,   CD.IdCatalogoDistrito
		,	CD.NombreCatalogoDistrito
	
				

	FROM dbo.Agencias A
	 INNER JOIN dbo.CatalogoProvincia CP
         ON A.IdCatalogoProvincia = CP.IdCatalogoProvincia
     INNER JOIN dbo.CatalogoCanton CC
         ON A.IdCatalogoCanton = CC.IdCatalogoCanton
	 INNER JOIN dbo.CatalogoDistrito CD
         ON A.IdCatalogoDistrito = CD.IdCatalogoDistrito
	WHERE
	     (@AgenciaId IS NULL OR AgenciaId=@AgenciaId)

END
GO
PRINT N'Creando Procedimiento [dbo].[CatalogoCantonLista]...';


GO
CREATE PROCEDURE [dbo].[CatalogoCantonLista]
@IdCatalogoProvincia INT=null
AS
	BEGIN
		SET NOCOUNT ON
		SELECT 
		IdCatalogoCanton,
		NombreCatalogoCanton

		FROM	
			dbo.CatalogoCanton

	    WHERE
		    IdCatalogoProvincia=@IdCatalogoProvincia


	END
GO
PRINT N'Creando Procedimiento [dbo].[CatalogoDistritoLista]...';


GO
CREATE PROCEDURE [dbo].CatalogoDistritoLista
@IdCatalogoCanton INT=null
AS
	BEGIN
		SET NOCOUNT ON
		SELECT 
		IdCatalogoDistrito,
		NombreCatalogoDistrito

		FROM	
			dbo.CatalogoDistrito

	    WHERE
		    IdCatalogoCanton=@IdCatalogoCanton


	END
GO
PRINT N'Creando Procedimiento [dbo].[CatalogoProvinciaLista]...';


GO
CREATE PROCEDURE [dbo].[CatalogoProvinciaLista]
AS
	BEGIN
		SET NOCOUNT ON



		SELECT 
		IdCatalogoProvincia,
		NombreCatalogoProvincia

		FROM	
			dbo.CatalogoProvincia

	


	END
GO
PRINT N'Creando Procedimiento [dbo].[ClientesActualizar]...';


GO
CREATE PROCEDURE [dbo].ClientesActualizar
	@ClientesId INT,
	@NombreCompleto VARCHAR(500),
	@Direccion varchar(250),
	@Telefono varchar(250),
	@AgenciaId INT,
    @Estado BIT
	
	
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY

		
		update dbo.Clientes set     
	      NombreCompleto=@NombreCompleto,
		  Direccion=@Direccion,
		  Telefono=@Telefono,
		  AgenciaId=@AgenciaId,
		  Estado=@Estado
		where ClientesId=@ClientesId


		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[ClientesEliminar]...';


GO
CREATE PROCEDURE [dbo].ClientesEliminar
@ClientesId int
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY

		
	DELETE FROM Dbo.Clientes WHERE ClientesId=@ClientesId


		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[ClientesInsertar]...';


GO
CREATE PROCEDURE [dbo].ClientesInsertar
		@NombreCompleto VARCHAR(500),
	@Direccion varchar(250),
	@Telefono varchar(250),
	@AgenciaId INT,
    @Estado BIT
	
	
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY

		
		INSERT INTO dbo.Clientes 
		(	       
	      NombreCompleto,
		  Direccion,
		  Telefono,
		  AgenciaId,
		  Estado
		)
		VALUES
		(
		
	      @NombreCompleto,
		  @Direccion,
		  @Telefono,
		  @AgenciaId,
		  @Estado
		)


		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[ClientesObtener]...';


GO
CREATE PROCEDURE [dbo].ClientesObtener
	@ClientesId INT= null
AS
	begin
	SET NOCOUNT ON


	 SELECT
	 C.ClientesId,
	 C.NombreCompleto,
	 C.Direccion,
	 C.Telefono,
	 C.Estado,
	 A.AgenciaId,
	 A.Nombre
	 FROM dbo.Clientes C
	 INNER JOIN dbo.Agencias A
			ON (C.AgenciaId=A.AgenciaId)
	 WHERE

	 (@ClientesId IS NULL OR ClientesId=@ClientesId)



	end
GO
PRINT N'Creando Procedimiento [dbo].[Login]...';


GO
CREATE PROCEDURE dbo.Login
@Usuario VARCHAR(250),
@Contrasena VARCHAR(250)
AS 
BEGIN
SET NOCOUNT  ON


DECLARE @ContrasenaSHA1 VARBINARY(MAX)=(SELECT HASHBYTES('SHA1',@Contrasena));

IF NOT EXISTS(SELECT * FROM Usuarios WHERE Usuario=@Usuario) BEGIN
	SELECT -1 AS CodeError, 'El nombre del usuario no existe' AS MsgError

END
ELSE IF EXISTS( SELECT * FROM Usuarios WHERE Usuario=@Usuario AND Estado =0) BEGIN
 
 SELECT -1 AS CodeError, 'El Usuario se encuentra inactivo!' AS MsgError
END
ELSE IF  NOT EXISTS( SELECT * FROM Usuarios WHERE Usuario=@Usuario and Contrasena=@ContrasenaSHA1 AND Estado =1) BEGIN
 
 SELECT -1 AS CodeError, 'La contraseña es incorrecta por favor volver a intentar!' AS MsgError
END
ELSE BEGIN

	SELECT 
	0 AS CodeError,
	UsuariosId,
	Usuario,
	Nombre

	FROM Usuarios 
		WHERE Usuario=@Usuario and Contrasena=@ContrasenaSHA1 

END



	

END
GO
PRINT N'Creando Procedimiento [dbo].[MarcaVehiculoActualizar]...';


GO
CREATE PROCEDURE [dbo].[MarcaVehiculoActualizar]
@MarcaVehiculoId INT,
@Descripcion VARCHAR(250),
@Estado BIT

AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY

       UPDATE MarcaVehiculo
       SET
       Descripcion=@Descripcion,
       Estado=@Estado
       WHERE 
           MarcaVehiculoId=@MarcaVehiculoId

       COMMIT TRANSACTION TRASA

          SELECT 0 AS CodeError, '' AS MsgError
    END TRY

    BEGIN CATCH
          SELECT 
                 ERROR_NUMBER() AS CodeError, 
                 ERROR_MESSAGE() AS MsgError
           ROLLBACK TRANSACTION TRASA    
    END CATCH

  END
GO
PRINT N'Creando Procedimiento [dbo].[MarcaVehiculoEliminar]...';


GO
CREATE PROCEDURE [dbo].[MarcaVehiculoEliminar]
@MarcaVehiculoId INT
AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY
     
     DELETE FROM MarcaVehiculo
     WHERE
         MarcaVehiculoId=@MarcaVehiculoId

       COMMIT TRANSACTION TRASA

          SELECT 0 AS CodeError, '' AS MsgError

    END TRY

    BEGIN CATCH
          SELECT 
                 ERROR_NUMBER() AS CodeError, 
                 ERROR_MESSAGE() AS MsgError
           ROLLBACK TRANSACTION TRASA    
    END CATCH

  END
GO
PRINT N'Creando Procedimiento [dbo].[MarcaVehiculoInsertar]...';


GO
CREATE PROCEDURE [dbo].[MarcaVehiculoInsertar]
@Descripcion VARCHAR(250),
@Estado BIT

AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY
       INSERT INTO MarcaVehiculo
       ( Descripcion, Estado)
       VALUES
       (@Descripcion, @Estado)


       COMMIT TRANSACTION TRASA

          SELECT 0 AS CodeError, '' AS MsgError
    END TRY

    BEGIN CATCH
          SELECT 
                 ERROR_NUMBER() AS CodeError, 
                 ERROR_MESSAGE() AS MsgError
           ROLLBACK TRANSACTION TRASA    
    END CATCH

  END
GO
PRINT N'Creando Procedimiento [dbo].[MarcaVehiculoLista]...';


GO
CREATE PROCEDURE dbo.MarcaVehiculoLista

AS
	BEGIN
		SET NOCOUNT ON



		SELECT 
		MarcaVehiculoId,
		Descripcion

		FROM	
			dbo.MarcaVehiculo

			WHERE
					Estado=1






	END
GO
PRINT N'Creando Procedimiento [dbo].[MarcaVehiculoObtener]...';


GO
CREATE PROCEDURE [dbo].[MarcaVehiculoObtener]
	@MarcaVehiculoId INT=NULL
AS
BEGIN
  SET NOCOUNT ON

SELECT 
      MarcaVehiculoId
	, Descripcion
	, Estado
FROM MarcaVehiculo
WHERE (@MarcaVehiculoId IS NULL OR MarcaVehiculoId=@MarcaVehiculoId)

END
GO
PRINT N'Creando Procedimiento [dbo].[UsuarioRegistrar]...';


GO
CREATE PROCEDURE dbo.UsuarioRegistrar
@Usuario varchar(250),
@Nombre varchar(500),
@Contrasena VARCHAR(250)
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY
	-- AQUI VA EL CODIGO
		
DECLARE @ContrasenaSHA1 VARBINARY(MAX)=(SELECT HASHBYTES('SHA1',@Contrasena));

	IF NOT EXISTS( SELECT * FROM dbo.Usuarios WHERE @Usuario=Usuario) BEGIN

				INSERT INTO dbo.Usuarios
					(Usuario,Nombre,Contrasena,Estado)
					VALUES
					(@Usuario,@Nombre,@ContrasenaSHA1,1)

		
		
		SELECT 0 AS CodeError, '' AS MsgError

		END
		ELSE BEGIN 
		
			SELECT -1 AS CodeError, 'Este Usuario se encuentra en uso por favor ingresar otro usuario!' AS MsgError


		END


		COMMIT TRANSACTION TRASA


	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[VehiculoActualizar]...';


GO
CREATE PROCEDURE dbo.VehiculoActualizar
	@VehiculoId INT,
	@MarcaVehiculoId INT,
    @Matricula VARCHAR(250),
	@Color VARCHAR(250),
	@Modelo VARCHAR(250),
	@Estado BIT,
	@FechaModelo DATE,
	@TieneDefectos BIT ,
	@Defectos VARCHAR(1000)= NULL
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY
	-- AQUI VA EL CODIGO
		
	UPDATE dbo.Vehiculo SET
	 MarcaVehiculoId=@MarcaVehiculoId,
	 Matricula=@Matricula,
	 Color=@Color,
	 Modelo=@Modelo,
	 Estado=@Estado,
	 FechaModelo=@FechaModelo,
	 TieneDefectos=@TieneDefectos,
	 Defectos=@Defectos

	WHERE VehiculoId=@VehiculoId

		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[VehiculoEliminar]...';


GO
CREATE PROCEDURE dbo.VehiculoEliminar
 @VehiculoId INT
  
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY
	-- AQUI VA EL CODIGO
		
	DELETE FROM DBO.Vehiculo WHERE VehiculoId=@VehiculoId


		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[VehiculoInsertar]...';


GO
CREATE PROCEDURE dbo.VehiculoInsertar
    @MarcaVehiculoId INT,
	@Matricula varchar(250)	,
	@Color varchar(250)	,
	@Modelo varchar(250),
	@Estado BIT,
	@FechaModelo DATE,
	@TieneDefectos BIT ,
	@Defectos VARCHAR(1000)= NULL
	
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY
	-- AQUI VA EL CODIGO
		
		INSERT INTO dbo.Vehiculo 
		(
	     MarcaVehiculoId
	    , Matricula 
	    , Color
	    , Modelo 
	    , Estado 
		, FechaModelo
		, TieneDefectos
		, Defectos
		)
		VALUES
		(
		 @MarcaVehiculoId
	    , @Matricula 
	    , @Color
	    , @Modelo 
	    , @Estado 
		, @FechaModelo
		, @TieneDefectos
		, @Defectos
		)


		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError



	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[VehiculoObtener]...';


GO
CREATE PROCEDURE [dbo].VehiculoObtener
@VehiculoId INT=NULL

AS BEGIN
	SET NOCOUNT ON

	SELECT
			V.VehiculoId
		,   V.Matricula
		,   V.Color
		,   V.Modelo
		,   V.Estado
		,   V.FechaModelo
		,	V.TieneDefectos
		,   V.Defectos
		,   MV.MarcaVehiculoId
		,	MV.Descripcion
				

	FROM dbo.Vehiculo V
	 INNER JOIN dbo.MarcaVehiculo MV
         ON V.MarcaVehiculoId = MV.MarcaVehiculoId
	WHERE
	     (@VehiculoId IS NULL OR VehiculoId=@VehiculoId)

END
GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fea0e116-f223-482b-81e9-982c1116f79c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fea0e116-f223-482b-81e9-982c1116f79c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'fa64e290-59a7-448a-9657-62e0b02b7292')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('fa64e290-59a7-448a-9657-62e0b02b7292')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Actualización completada.';


GO
