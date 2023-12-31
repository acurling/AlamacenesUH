USE [AlmacenUH]
GO
/****** Object:  UserDefinedFunction [dbo].[FNC_DECRIPTION_PW]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FNC_DECRIPTION_PW](@encryp varbinary(8000))
RETURNS nvarchar(4000)
AS
BEGIN
		DECLARE @decript varbinary(4000)
		SET @decript = DECRYPTBYPASSPHRASE('KEY',@encryp)
		RETURN (@decript)
END
GO
/****** Object:  UserDefinedFunction [dbo].[FNC_ENCRIPTION_PW]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FNC_ENCRIPTION_PW](@str nvarchar(4000))
RETURNS varbinary(8000)
AS
BEGIN
		DECLARE @encript varbinary(8000)
			SET @encript = ENCRYPTBYPASSPHRASE('KEY',@str)
		RETURN (@encript)
END
GO
/****** Object:  Table [dbo].[articulos]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[articulos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo]  AS (('ART-'+right('0000'+CONVERT([varchar](4),[ID]),(4)))+'xy') PERSISTED,
	[Descripcion] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BODEGA]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BODEGA](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[Idx] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Direccion] [varchar](50) NULL,
	[Telefono] [varchar](12) NULL,
 CONSTRAINT [Pk_id] PRIMARY KEY CLUSTERED 
(
	[Idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[producto_bodega]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[producto_bodega](
	[id_producto] [int] NULL,
	[id_bodega] [int] NULL,
	[fecha] [datetime] NULL,
	[CANTIDAD] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTO1]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO1](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[cantidad] [int] NULL,
	[precio] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOS](
	[USUARIO] [nvarchar](50) NOT NULL,
	[CLAVE] [varbinary](8000) NULL,
 CONSTRAINT [PK_USUARIO] PRIMARY KEY CLUSTERED 
(
	[USUARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[producto_bodega] ADD  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[producto_bodega] ADD  DEFAULT ((0)) FOR [CANTIDAD]
GO
ALTER TABLE [dbo].[PRODUCTO1] ADD  DEFAULT ((0)) FOR [cantidad]
GO
ALTER TABLE [dbo].[PRODUCTO1] ADD  DEFAULT ((0)) FOR [precio]
GO
ALTER TABLE [dbo].[producto_bodega]  WITH CHECK ADD FOREIGN KEY([id_bodega])
REFERENCES [dbo].[BODEGA] ([id])
GO
ALTER TABLE [dbo].[producto_bodega]  WITH CHECK ADD FOREIGN KEY([id_producto])
REFERENCES [dbo].[PRODUCTO1] ([id])
GO
/****** Object:  StoredProcedure [dbo].[Bodegas]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Bodegas]
@operacion int = 0,
 @id int = 0,
 @nombre varchar(30) =''
  as


	begin
		    IF @OPERACION = 1  -- Reporte de todo  
			    BEGIN 
			
				 SELECT  p.nombre as Bodega,b.nombre as Producto, pb.CANTIDAD as Cantidad
				FROM producto_bodega pb
				INNER JOIN BODEGA b on b.id = pb.id_bodega
				INNER JOIN PRODUCTO1 p on p.id = pb.id_producto
				order by PB.CANTIDAD ASC
				END
			ELSE IF @OPERACION = 2 -- Reporet con filtro
			 BEGIN 
				SELECT  p.nombre as Bodega,b.nombre as Producto, pb.CANTIDAD as Cantidad
				FROM producto_bodega pb
				INNER JOIN BODEGA b on b.id = pb.id_bodega
				INNER JOIN PRODUCTO1 p on p.id = pb.id_producto
				where b.id = @id
				order by PB.CANTIDAD ASC
			END

			ELSE IF @OPERACION = 3 -- Reporet con filtro
			 BEGIN 
				SELECT  p.nombre as Bodega,b.nombre as Producto, pb.CANTIDAD as Cantidad
				FROM producto_bodega pb
				INNER JOIN BODEGA b on b.id = pb.id_bodega
				INNER JOIN PRODUCTO1 p on p.id = pb.id_producto
				where p.nombre like '%'+ @nombre +'%'
				order by PB.CANTIDAD ASC
			END
	end
GO
/****** Object:  StoredProcedure [dbo].[BorrarCliente]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[BorrarCliente]
@Id int
 as 

     begin
	  delete clientes where id = @ID
     end
GO
/****** Object:  StoredProcedure [dbo].[DesEncriptarClave]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DesEncriptarClave]
 @Correo nvarchar(50)= '',
 @Clave nvarchar(50) = '',
 @Codigo varbinary(8000) = NULL,
 @encript varbinary(8000) = null,
 @decript nvarchar(4000) = '',
 @resultado int=  null
  	AS
		BEGIN
		 SET @Codigo = (SELECT CLAVE  FROM Usuarios WHERE usuario = @Correo)
		 SET @decript = [dbo].[FNC_DECRIPTION_PW](@Codigo)
		 
		IF EXISTS (SELECT usuario,CLAVE  FROM Usuarios WHERE usuario = @Correo and @Clave = @decript)
		 begin
			set @resultado = 1
			select @resultado
	    end
			else
		 begin
			set @resultado = -1
			select @resultado
          end 
		END 
GO
/****** Object:  StoredProcedure [dbo].[EncriptarClave]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[EncriptarClave]    Script Date: 21/07/2023 19:46:13 ******/


CREATE procedure [dbo].[EncriptarClave]
 @Correo varchar(50)= null,
 @Clave varchar(50) ='',
 @encript varbinary(8000) = 0
	AS
		BEGIN
			SET @encript = [dbo].[FNC_ENCRIPTION_PW](@Clave)
			INSERT INTO Usuarios (usuario, Clave) VALUES (@Correo, @encript)
			--SELECT @clave,  @encript as claveentriptada
		END
GO
/****** Object:  StoredProcedure [dbo].[InsertarCliente]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertarCliente]
@Nombre varchar(50),
@Direccion varchar(50),
@Telefono varchar(12)
 as 

     begin
	  insert into clientes values (@Nombre, @Direccion,@Telefono)
     end
GO
/****** Object:  StoredProcedure [dbo].[ModificarCliente]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ModificarCliente]
@Id int,
@Nombre varchar(50),
@Direccion varchar(50),
@Telefono varchar(12)

 as 

     begin
	  update clientes set Nombre= @Nombre, Direccion= @Direccion, telefono =@Telefono
	  where id =@Id
     end
GO
/****** Object:  StoredProcedure [dbo].[ReporteCliente]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[ReporteCliente]
  as 
    begin 
	   select * from clientes
	end
GO
/****** Object:  StoredProcedure [dbo].[Sp_GestionarCliente]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_GestionarCliente]
	@operacion int = 0,
	@Id int = 0,
	@Nombre varchar(50) = '',
	@Direccion varchar(50) = '',
	@Telefono varchar(12) = ''
	   as 
		   begin
		    IF @OPERACION = 1  -- AGREGAR 
			    BEGIN 
			
				 insert into clientes(nombre, Direccion,Telefono) values ( @Nombre, @Direccion,@Telefono)
				END
			ELSE IF @OPERACION = 2 -- BORRAR
			 BEGIN 
				 delete clientes where idx = @ID
				END
			ELSE IF @OPERACION = 3 -- MODIFICAR
			BEGIN 
				  update clientes set Nombre= @Nombre, Direccion= @Direccion, telefono =@Telefono
				  where idx=@Id
				END
			ELSE IF @OPERACION = 4 -- CONSULTAR
			    BEGIN 
				SELECT idx, nombre, Direccion, Telefono FROM clientes
				END
		   end
GO
/****** Object:  StoredProcedure [dbo].[ValidarUsuario]    Script Date: 28/07/2023 20:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ValidarUsuario]
 @usuario VARCHAR(50),
 @clave VARCHAR(50)
 as 
   begin
       SELECT USUARIO, CLAVE FROM USUARIOS WHERE USUARIO = @USUARIO AND CLAVE=@CLAVE
   end
GO
