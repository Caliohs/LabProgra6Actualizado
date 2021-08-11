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
Se está quitando la columna [dbo].[Agencias].[NombreCompleto]; puede que se pierdan datos.

Debe agregarse la columna [dbo].[Agencias].[Nombre] de la tabla [dbo].[Agencias], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[Agencias])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Quitando Clave externa [dbo].[FK_Agencia_Provincia]...';


GO
ALTER TABLE [dbo].[Agencias] DROP CONSTRAINT [FK_Agencia_Provincia];


GO
PRINT N'Quitando Clave externa [dbo].[Fk_Agencia_Canton]...';


GO
ALTER TABLE [dbo].[Agencias] DROP CONSTRAINT [Fk_Agencia_Canton];


GO
PRINT N'Quitando Clave externa [dbo].[Fk_Agencia_Distrito]...';


GO
ALTER TABLE [dbo].[Agencias] DROP CONSTRAINT [Fk_Agencia_Distrito];


GO
PRINT N'Quitando Clave externa [dbo].[FK_Clientes_Angecias]...';


GO
ALTER TABLE [dbo].[Clientes] DROP CONSTRAINT [FK_Clientes_Angecias];


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Agencias]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Agencias] (
    [AgenciaId]           INT           IDENTITY (1, 1) NOT NULL,
    [Nombre]              VARCHAR (250) NOT NULL,
    [IdCatalogoProvincia] INT           NOT NULL,
    [IdCatalogoCanton]    INT           NOT NULL,
    [IdCatalogoDistrito]  INT           NOT NULL,
    [Estado]              BIT           NOT NULL,
    CONSTRAINT [tmp_ms_xx_constraint_Agencia1] PRIMARY KEY CLUSTERED ([AgenciaId] ASC)
)
WITH (DATA_COMPRESSION = PAGE);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Agencias])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Agencias] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Agencias] ([AgenciaId], [IdCatalogoProvincia], [IdCatalogoCanton], [IdCatalogoDistrito], [Estado])
        SELECT   [AgenciaId],
                 [IdCatalogoProvincia],
                 [IdCatalogoCanton],
                 [IdCatalogoDistrito],
                 [Estado]
        FROM     [dbo].[Agencias]
        ORDER BY [AgenciaId] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Agencias] OFF;
    END

DROP TABLE [dbo].[Agencias];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Agencias]', N'Agencias';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_Agencia1]', N'Agencia', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Clave externa [dbo].[FK_Agencia_Provincia]...';


GO
ALTER TABLE [dbo].[Agencias] WITH NOCHECK
    ADD CONSTRAINT [FK_Agencia_Provincia] FOREIGN KEY ([IdCatalogoProvincia]) REFERENCES [dbo].[CatalogoProvincia] ([IdCatalogoProvincia]);


GO
PRINT N'Creando Clave externa [dbo].[Fk_Agencia_Canton]...';


GO
ALTER TABLE [dbo].[Agencias] WITH NOCHECK
    ADD CONSTRAINT [Fk_Agencia_Canton] FOREIGN KEY ([IdCatalogoCanton]) REFERENCES [dbo].[CatalogoCanton] ([IdCatalogoCanton]);


GO
PRINT N'Creando Clave externa [dbo].[Fk_Agencia_Distrito]...';


GO
ALTER TABLE [dbo].[Agencias] WITH NOCHECK
    ADD CONSTRAINT [Fk_Agencia_Distrito] FOREIGN KEY ([IdCatalogoDistrito]) REFERENCES [dbo].[CatalogoDistrito] ([IdCatalogoDistrito]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Clientes_Angecias]...';


GO
ALTER TABLE [dbo].[Clientes] WITH NOCHECK
    ADD CONSTRAINT [FK_Clientes_Angecias] FOREIGN KEY ([AgenciaId]) REFERENCES [dbo].[Agencias] ([AgenciaId]);


GO
PRINT N'Modificando Procedimiento [dbo].[AgenciaLista]...';


GO
ALTER PROCEDURE [dbo].AgenciaLista
	
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
PRINT N'Actualizando Procedimiento [dbo].[AgenciaActualizar]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[AgenciaActualizar]';


GO
PRINT N'Actualizando Procedimiento [dbo].[AgenciaEliminar]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[AgenciaEliminar]';


GO
PRINT N'Actualizando Procedimiento [dbo].[AgenciaInsertar]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[AgenciaInsertar]';


GO
PRINT N'Actualizando Procedimiento [dbo].[AgenciaObtener]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[AgenciaObtener]';


GO
PRINT N'Actualizando Procedimiento [dbo].[ClientesObtener]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[ClientesObtener]';


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
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Agencias] WITH CHECK CHECK CONSTRAINT [FK_Agencia_Provincia];

ALTER TABLE [dbo].[Agencias] WITH CHECK CHECK CONSTRAINT [Fk_Agencia_Canton];

ALTER TABLE [dbo].[Agencias] WITH CHECK CHECK CONSTRAINT [Fk_Agencia_Distrito];

ALTER TABLE [dbo].[Clientes] WITH CHECK CHECK CONSTRAINT [FK_Clientes_Angecias];


GO
PRINT N'Actualización completada.';


GO
