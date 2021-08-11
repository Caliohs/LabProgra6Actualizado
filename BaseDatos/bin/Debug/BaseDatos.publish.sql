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
USE [$(DatabaseName)];


GO
/*
Se está quitando la columna [dbo].[Clientes].[Nombre]; puede que se pierdan datos.

Debe agregarse la columna [dbo].[Clientes].[NombreCompleto] de la tabla [dbo].[Clientes], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[Clientes])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Quitando Clave externa [dbo].[FK_Clientes_Angecias]...';


GO
ALTER TABLE [dbo].[Clientes] DROP CONSTRAINT [FK_Clientes_Angecias];


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Clientes]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Clientes] (
    [ClientesId]     INT           IDENTITY (1, 1) NOT NULL,
    [NombreCompleto] VARCHAR (250) NOT NULL,
    [Direccion]      VARCHAR (500) NOT NULL,
    [Telefono]       VARCHAR (500) NOT NULL,
    [AgenciaId]      INT           NOT NULL,
    [Estado]         BIT           NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Clientes1] PRIMARY KEY CLUSTERED ([ClientesId] ASC)
)
WITH (DATA_COMPRESSION = PAGE);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Clientes])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Clientes] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Clientes] ([ClientesId], [Direccion], [Telefono], [AgenciaId], [Estado])
        SELECT   [ClientesId],
                 [Direccion],
                 [Telefono],
                 [AgenciaId],
                 [Estado]
        FROM     [dbo].[Clientes]
        ORDER BY [ClientesId] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Clientes] OFF;
    END

DROP TABLE [dbo].[Clientes];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Clientes]', N'Clientes';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_PK_Clientes1]', N'PK_Clientes', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Clave externa [dbo].[FK_Clientes_Angecias]...';


GO
ALTER TABLE [dbo].[Clientes] WITH NOCHECK
    ADD CONSTRAINT [FK_Clientes_Angecias] FOREIGN KEY ([AgenciaId]) REFERENCES [dbo].[Agencias] ([AgenciaId]);


GO
PRINT N'Modificando Procedimiento [dbo].[ClientesActualizar]...';


GO
ALTER PROCEDURE [dbo].ClientesActualizar
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
PRINT N'Modificando Procedimiento [dbo].[ClientesInsertar]...';


GO
ALTER PROCEDURE [dbo].ClientesInsertar
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
PRINT N'Modificando Procedimiento [dbo].[ClientesObtener]...';


GO
ALTER PROCEDURE [dbo].ClientesObtener
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
PRINT N'Actualizando Procedimiento [dbo].[ClientesEliminar]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[ClientesEliminar]';


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Clientes] WITH CHECK CHECK CONSTRAINT [FK_Clientes_Angecias];


GO
PRINT N'Actualización completada.';


GO
