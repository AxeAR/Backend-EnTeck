DECLARE @RenamedLegacyTable bit = 0;

IF OBJECT_ID(N'dbo.Usuarios', N'U') IS NULL
   AND OBJECT_ID(N'dbo.Clientes', N'U') IS NOT NULL
BEGIN
    EXEC sp_rename N'dbo.Clientes', N'Usuarios';
    SET @RenamedLegacyTable = 1;
END;

IF COL_LENGTH(N'dbo.Usuarios', N'esAdmin') IS NULL
BEGIN
    ALTER TABLE dbo.Usuarios
    ADD esAdmin bit NOT NULL
        CONSTRAINT DF_Usuarios_esAdmin DEFAULT (0);
END;

IF @RenamedLegacyTable = 1
BEGIN
    UPDATE dbo.Usuarios
    SET esAdmin = 1
    WHERE id = 1;
END;