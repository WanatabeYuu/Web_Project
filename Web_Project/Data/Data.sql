USE [master]
GO
/****** Object:  Database [Web_bh]    Script Date: 12/20/2019 2:53:44 PM ******/
CREATE DATABASE [Web_bh]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Web_bh', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Web_bh.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Web_bh_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Web_bh_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Web_bh] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Web_bh].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Web_bh] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Web_bh] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Web_bh] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Web_bh] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Web_bh] SET ARITHABORT OFF 
GO
ALTER DATABASE [Web_bh] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Web_bh] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Web_bh] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Web_bh] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Web_bh] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Web_bh] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Web_bh] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Web_bh] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Web_bh] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Web_bh] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Web_bh] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Web_bh] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Web_bh] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Web_bh] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Web_bh] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Web_bh] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Web_bh] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Web_bh] SET RECOVERY FULL 
GO
ALTER DATABASE [Web_bh] SET  MULTI_USER 
GO
ALTER DATABASE [Web_bh] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Web_bh] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Web_bh] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Web_bh] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Web_bh] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Web_bh', N'ON'
GO
ALTER DATABASE [Web_bh] SET QUERY_STORE = OFF
GO
USE [Web_bh]
GO
/****** Object:  User [NT AUTHORITY\NETWORK SERVICE]    Script Date: 12/20/2019 2:53:45 PM ******/
CREATE USER [NT AUTHORITY\NETWORK SERVICE] FOR LOGIN [NT AUTHORITY\NETWORK SERVICE] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\NETWORK SERVICE]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [NT AUTHORITY\NETWORK SERVICE]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 12/20/2019 2:53:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](20) NULL,
	[BirthDay] [date] NULL,
	[Address] [nchar](50) NULL,
	[Tel] [int] NULL,
	[Email] [nchar](50) NULL,
	[Password] [varchar](50) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupProduct]    Script Date: 12/20/2019 2:53:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupProduct](
	[Id] [int] NOT NULL,
	[Name] [nchar](20) NULL,
 CONSTRAINT [PK_GroupProduct] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 12/20/2019 2:53:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[Order_Id] [int] NOT NULL,
	[Product_Id] [int] NOT NULL,
	[Quantity] [int] NULL,
	[Price] [float] NULL,
	[Dates] [date] NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[Order_Id] ASC,
	[Product_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/20/2019 2:53:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_Id] [int] NULL,
	[Status] [bit] NULL,
	[shipAdress] [varchar](50) NULL,
	[shipTel] [varchar](50) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12/20/2019 2:53:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](50) NULL,
	[Detail] [nchar](100) NULL,
	[PrinceOld] [int] NULL,
	[PriceNew] [int] NULL,
	[Date] [date] NULL,
	[Status] [bit] NULL,
	[Group_Product] [int] NULL,
	[Image] [varchar](100) NULL,
	[Hotdeal] [bit] NULL,
	[Sold] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Support]    Script Date: 12/20/2019 2:53:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Support](
	[Phone] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Support] [nvarchar](max) NULL,
 CONSTRAINT [PK_Support] PRIMARY KEY CLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/20/2019 2:53:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[UserName] [varchar](20) NULL,
	[Password] [varchar](20) NULL,
	[Rule] [int] NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [Name], [BirthDay], [Address], [Tel], [Email], [Password]) VALUES (2, N'KH2                 ', CAST(N'2000-12-10' AS Date), NULL, NULL, N'kh2@gmail.com                                     ', N'123456')
INSERT [dbo].[Customers] ([Id], [Name], [BirthDay], [Address], [Tel], [Email], [Password]) VALUES (3, N'Uông Quang Minh     ', CAST(N'1999-09-09' AS Date), N'244                                               ', 961148271, N'drkiller1230@gmail.com                            ', N'123456')
INSERT [dbo].[Customers] ([Id], [Name], [BirthDay], [Address], [Tel], [Email], [Password]) VALUES (11, N'Danh                ', CAST(N'1999-01-01' AS Date), N'Thu Duc                                           ', 399432909, N'danh.nguyen104@gmail.com                          ', N'danh0101')
INSERT [dbo].[Customers] ([Id], [Name], [BirthDay], [Address], [Tel], [Email], [Password]) VALUES (12, N'Ryan                ', CAST(N'1999-01-01' AS Date), N'Ký túc xá khu B Đại Học Quốc Gia                  ', 399432909, N'123@gmail.com                                     ', N'1')
INSERT [dbo].[Customers] ([Id], [Name], [BirthDay], [Address], [Tel], [Email], [Password]) VALUES (13, N'Ryan Steward 1      ', CAST(N'1999-01-01' AS Date), N'Ký túc xá khu B Đại Học Quốc Gia                  ', 399432909, N'ryan@gmail.com                                    ', NULL)
INSERT [dbo].[Customers] ([Id], [Name], [BirthDay], [Address], [Tel], [Email], [Password]) VALUES (14, N'Danh Ryan           ', CAST(N'1999-01-01' AS Date), N'Ký túc xá khu B Đại Học Quốc Gia                  ', 399432909, N'danh.nguyen@gmail.com                             ', NULL)
SET IDENTITY_INSERT [dbo].[Customers] OFF
INSERT [dbo].[GroupProduct] ([Id], [Name]) VALUES (1, N'Laptop              ')
INSERT [dbo].[GroupProduct] ([Id], [Name]) VALUES (2, N'VGA                 ')
INSERT [dbo].[GroupProduct] ([Id], [Name]) VALUES (3, N'Mainboard           ')
INSERT [dbo].[GroupProduct] ([Id], [Name]) VALUES (4, N'HeadPhone           ')
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (2, 3, 2, 295, NULL)
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (4, 3, 4, 295, NULL)
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (5, 3, 2, 295, NULL)
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (6, 3, 2, 295, NULL)
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (7, 3, 2, 295, NULL)
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (8, 3, 4, 295, NULL)
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (9, 3, 2, 295, NULL)
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (10, 3, 2, 295, NULL)
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (11, 12, 1, 470, CAST(N'2019-12-11' AS Date))
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (12, 21, 1, 300, CAST(N'2019-12-20' AS Date))
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (13, 9, 1, 470, CAST(N'2019-12-20' AS Date))
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (14, 4, 1, 178, CAST(N'2019-12-20' AS Date))
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (15, 13, 1, 500, CAST(N'2019-12-20' AS Date))
INSERT [dbo].[OrderDetail] ([Order_Id], [Product_Id], [Quantity], [Price], [Dates]) VALUES (16, 4, 1, 178, CAST(N'2019-12-20' AS Date))
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (2, 3, 1, N'', N'')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (3, 3, 1, N'sdasd', N'1234')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (4, 3, 1, N'sdasd', N'1234')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (5, 3, 1, N'sdasd', N'1234')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (6, 3, 1, N'sdasd', N'1234')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (7, 3, 1, N'', N'')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (8, 3, 1, N'', N'')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (9, 3, 1, N'', N'')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (10, 3, 1, NULL, NULL)
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (11, 11, 1, N'', N'')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (12, 11, 1, N'Thu Duc', N'0399432909')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (13, 11, 1, N'', N'')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (14, 12, 1, N'Thu Duc', N'0399432909')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (15, 13, 1, N'Thu Duc', N'0399432909')
INSERT [dbo].[Orders] ([Id], [Customer_Id], [Status], [shipAdress], [shipTel]) VALUES (16, 14, 1, N'Thu Duc', N'0399432909')
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (2, N'ASUS TUF GTX 1660 6G Gaming GDDR5
               ', N'~/Content/Image/VGA/description/VGA.jpg                                                             ', NULL, 330, CAST(N'2017-10-09' AS Date), 1, 2, N'~/Content/Image/VGA/ASUS TUF GTX 1660 6G Gaming GDDR5

.png         ', 0, 412)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (3, N'MSI GTX 1660 GAMING X 6G GDDR5
                  ', N'~/Content/Image/VGA/description/VGA.jpg                                                             ', 325, 295, CAST(N'2017-10-10' AS Date), 1, 2, N'~/Content/Image/VGA/MSI GTX 1660 GAMING X 6G GDDR5

.png  ', 1, 221)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (4, N'ASUS TUF GAMING GeForce GTX 1650 4GB
            ', N'~/Content/Image/VGA/description/VGA.jpg                                                             ', 208, 178, CAST(N'2019-10-10' AS Date), 1, 2, N'~/Content/Image/VGA/ASUS TUF GAMING GeForce GTX 1650 4GB

.jpg            ', 0, 201)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (5, N'MSI GTX 1650 Aero ITX 4G OC GDDR5
               ', N'~/Content/Image/VGA/description/VGA.jpg                                                             ', NULL, 216, CAST(N'2019-10-10' AS Date), 1, 2, N'~/Content/Image/VGA/MSI GTX 1650 Aero ITX 4G OC GDDR5
.png              ', 0, 98)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (6, N'GIGABYTE GeForce GTX 1650 Gaming OC 4G            ', N'~/Content/Image/VGA/description/VGA.jpg                                                             ', 228, 216, CAST(N'2018-10-10' AS Date), 1, 2, N'~/Content/Image/VGA/GIGABYTE GeForce GTX 1650 Gaming OC 4G
.png         ', 0, 10)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (7, N'MSI GTX 1660 Ti Ventus XS 6G OC GDDR6             ', N'~/Content/Image/VGA/description/VGA.jpg                                                             ', 364, 312, CAST(N'2018-10-10' AS Date), 1, 2, N'~/Content/Image/VGA/MSI GTX 1660 Ti Ventus XS 6G OC GDDR6.png    ', 1, 9)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (8, N'ASUS TUF3 GeForce GTX 1660Ti A6G GAMING
         ', N'~/Content/Image/VGA/description/VGA.jpg                                                             ', 382, 364, CAST(N'2019-10-10' AS Date), 1, 2, N'~/Content/Image/VGA/ASUS TUF3 GeForce GTX 1660Ti A6G GAMING

.jpg       ', 1, 8)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (9, N'Laptop Gaming Acer Nitro 5 2019 AN515-54 59SF     ', N'~/Content/Image/Laptop/description/Laptop Gaming Acer Nitro 5 2019 AN515-54 59SF.jpg                ', 500, 470, CAST(N'2019-10-10' AS Date), 1, 1, N'~/Content/Image/Laptop/Laptop Gaming Acer Nitro 5 2019 AN515-54 59SF

.jpg       ', 0, 101)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (12, N'Laptop Gaming Acer Predator Triton 500 PT515-51   ', N'~/Content/Image/Laptop/description/Laptop Gaming Acer Predator Triton 500 PT515-51.jpg              ', 500, 470, CAST(N'2019-10-10' AS Date), 1, 1, N'~/Content/Image/Laptop/Laptop Gaming Acer Predator Triton 500 PT515-51

.jpg       ', 0, 51)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (13, N'Laptop Gaming Acer Nitro 7 2019 AN715-51 71F8
   ', N'~/Content/Image/Laptop/description/Laptop Gaming Acer Nitro 7 2019 AN715-51 71F8
.jpg              ', NULL, 500, CAST(N'2019-10-10' AS Date), 1, 1, N'~/Content/Image/Laptop/Laptop Gaming Acer Nitro 7 2019 AN715-51 71F8
.jpg', 0, 6)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (20, N'Laptop Gaming Acer Predator Helios 300 2019       ', N'~/Content/Image/Laptop/description/Laptop Gaming Acer Predator Helios 300 2019.jpg                  ', NULL, 500, CAST(N'2019-10-10' AS Date), 1, 1, N'~/Content/Image/Laptop/Laptop Gaming Acer Predator Helios 300 2019
.jpg', 1, 30)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (21, N'Laptop ASUS TUF Gaming FX505DD AL186T             ', N'~/Content/Image/Laptop/description/Laptop ASUS TUF Gaming FX505DD AL186T.jpg                        ', 249, 300, CAST(N'2019-10-10' AS Date), NULL, 1, N'~/Content/Image/Laptop/Laptop ASUS TUF Gaming FX505DD AL186T.jpg', NULL, NULL)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (22, N'Laptop Gaming Asus ROG STRIX G G531GU UAL214T     ', N'~/Content/Image/Laptop/description/Laptop Gaming Asus ROG STRIX G G531GU UAL214T.jpg                ', 400, 500, CAST(N'2019-10-10' AS Date), NULL, 1, N'~/Content/Image/Laptop/Laptop Gaming Asus ROG STRIX G G531GU UAL214T.jpg', NULL, NULL)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (23, N'Laptop Gaming Dell G3 Inspiron 3590               ', N'~/Content/Image/Laptop/description/Laptop Gaming Dell G3 Inspiron 3590.jpg                          ', 750, 500, CAST(N'2019-10-10' AS Date), NULL, 1, N'~/Content/Image/Laptop/Laptop Gaming Dell G3 Inspiron 3590
.jpg', 1, 30)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (24, N'Laptop Gaming Lenovo Legion Y7000                 ', N'~/Content/Image/Laptop/description/Laptop Gaming Lenovo Legion Y7000.jpg                            ', 660, 500, CAST(N'2019-10-10' AS Date), NULL, 1, N'~/Content/Image/Laptop/Laptop Gaming Lenovo Legion Y7000.jpg', 1, 30)
INSERT [dbo].[Product] ([Id], [Name], [Detail], [PrinceOld], [PriceNew], [Date], [Status], [Group_Product], [Image], [Hotdeal], [Sold]) VALUES (25, N'Laptop Lenovo Legion Y730 81HD003KVN              ', N'~/Content/Image/Laptop/description/Laptop Lenovo Legion Y730 81HD003KVN.jpg                         ', 600, 500, CAST(N'2019-10-10' AS Date), NULL, 1, N'~/Content/Image/Laptop/Laptop Lenovo Legion Y730 81HD003KVN.jpg', 1, 20)
SET IDENTITY_INSERT [dbo].[Product] OFF
INSERT [dbo].[Users] ([Id], [Name], [UserName], [Password], [Rule], [Status]) VALUES (1, N'Admin', N'admin', N'000000', 1, 1)
INSERT [dbo].[Users] ([Id], [Name], [UserName], [Password], [Rule], [Status]) VALUES (2, N'Mod 1', N'mod1', N'1', 2, 1)
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([Order_Id])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([Product_Id])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customers] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Order_Customers]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_GroupProduct] FOREIGN KEY([Group_Product])
REFERENCES [dbo].[GroupProduct] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_GroupProduct]
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTheoNam]    Script Date: 12/20/2019 2:53:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeTheoNam]
as
BEGIN
select YEAR(Dates) as Nam,sum(Price) as Tong
from Orders join OrderDetail on Order_Id = Orders.id
GROUP BY YEAR(Dates)
END;
GO
USE [master]
GO
ALTER DATABASE [Web_bh] SET  READ_WRITE 
GO
