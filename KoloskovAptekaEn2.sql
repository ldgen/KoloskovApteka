USE [master]
GO
/****** Object:  Database [KoloskovApteka]    Script Date: 09.11.2024 22:28:27 ******/
CREATE DATABASE [KoloskovApteka]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KoloskovApteka', FILENAME = N'D:\applications\sql\MSSQL15.SQLEXPRESS\MSSQL\DATA\KoloskovApteka.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KoloskovApteka_log', FILENAME = N'D:\applications\sql\MSSQL15.SQLEXPRESS\MSSQL\DATA\KoloskovApteka_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KoloskovApteka].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KoloskovApteka] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KoloskovApteka] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KoloskovApteka] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KoloskovApteka] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KoloskovApteka] SET ARITHABORT OFF 
GO
ALTER DATABASE [KoloskovApteka] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KoloskovApteka] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KoloskovApteka] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KoloskovApteka] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KoloskovApteka] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KoloskovApteka] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KoloskovApteka] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KoloskovApteka] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KoloskovApteka] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KoloskovApteka] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KoloskovApteka] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KoloskovApteka] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KoloskovApteka] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KoloskovApteka] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KoloskovApteka] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KoloskovApteka] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KoloskovApteka] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KoloskovApteka] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [KoloskovApteka] SET  MULTI_USER 
GO
ALTER DATABASE [KoloskovApteka] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KoloskovApteka] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KoloskovApteka] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KoloskovApteka] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KoloskovApteka] SET DELAYED_DURABILITY = DISABLED 
GO
USE [KoloskovApteka]
GO
/****** Object:  User [seller]    Script Date: 09.11.2024 22:28:27 ******/
CREATE USER [seller] FOR LOGIN [PharmDBCreator] WITH DEFAULT_SCHEMA=[seller]
GO
/****** Object:  User [security]    Script Date: 09.11.2024 22:28:27 ******/
CREATE USER [security] FOR LOGIN [PharmSecAdm] WITH DEFAULT_SCHEMA=[security]
GO
/****** Object:  User [administrator]    Script Date: 09.11.2024 22:28:27 ******/
CREATE USER [administrator] FOR LOGIN [PharmSysAdm] WITH DEFAULT_SCHEMA=[administrator]
GO
/****** Object:  DatabaseRole [db_seller]    Script Date: 09.11.2024 22:28:27 ******/
CREATE ROLE [db_seller]
GO
/****** Object:  DatabaseRole [db_secure]    Script Date: 09.11.2024 22:28:27 ******/
CREATE ROLE [db_secure]
GO
/****** Object:  DatabaseRole [db_admin]    Script Date: 09.11.2024 22:28:27 ******/
CREATE ROLE [db_admin]
GO
ALTER ROLE [db_seller] ADD MEMBER [seller]
GO
ALTER ROLE [db_datareader] ADD MEMBER [seller]
GO
ALTER ROLE [db_secure] ADD MEMBER [security]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [security]
GO
ALTER ROLE [db_admin] ADD MEMBER [administrator]
GO
ALTER ROLE [db_owner] ADD MEMBER [administrator]
GO
ALTER ROLE [db_datareader] ADD MEMBER [db_seller]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [db_secure]
GO
ALTER ROLE [db_owner] ADD MEMBER [db_admin]
GO
/****** Object:  Schema [administrator]    Script Date: 09.11.2024 22:28:28 ******/
CREATE SCHEMA [administrator]
GO
/****** Object:  Schema [db_admin]    Script Date: 09.11.2024 22:28:28 ******/
CREATE SCHEMA [db_admin]
GO
/****** Object:  Schema [db_secure]    Script Date: 09.11.2024 22:28:28 ******/
CREATE SCHEMA [db_secure]
GO
/****** Object:  Schema [db_seller]    Script Date: 09.11.2024 22:28:28 ******/
CREATE SCHEMA [db_seller]
GO
/****** Object:  Schema [security]    Script Date: 09.11.2024 22:28:28 ******/
CREATE SCHEMA [security]
GO
/****** Object:  Schema [seller]    Script Date: 09.11.2024 22:28:28 ******/
CREATE SCHEMA [seller]
GO
/****** Object:  UserDefinedFunction [dbo].[Calculator]    Script Date: 09.11.2024 22:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Calculator]
(@opd1 bigint,
@opd2 bigint,
@oprt varchar(1) = '*')
RETURNS bigint
AS
BEGIN
DECLARE @Result bigint
SET @Result = CASE @oprt
WHEN '+' THEN @opd1 + @opd2
WHEN '-' THEN @opd1 - @opd2
WHEN '*' THEN @opd1 * @opd2
WHEN '/' THEN @opd1 / @opd2
ELSE 0
END
RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[SplitStr]    Script Date: 09.11.2024 22:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitStr] (@string NVARCHAR(500))
RETURNS @table TABLE
(Num INT IDENTITY(1,1) NOT NULL,
SubStr NVARCHAR(30))
AS
BEGIN
DECLARE @str1 NVARCHAR(500), @pos INT,
@count INT, @posCount INT
SET @count = 0
SET @posCount = 1
SET @str1 = @string
WHILE @count < LEN(@str1)
	BEGIN
	SET @pos = CHARINDEX(' ',@str1)
	IF @pos > 0
		BEGIN
		SET @count = @count + 1
		INSERT INTO @table
		VALUES (SUBSTRING(@str1, 1, @pos))
		SET @str1 = REPLACE(@str1, SUBSTRING(@str1, 1, @pos), '')
		END
	ELSE
		BEGIN
		INSERT INTO @table
		VALUES(@str1)
		BREAK
		END
	END
RETURN
END
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 09.11.2024 22:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] NOT NULL,
	[Surname] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Patronymic] [nvarchar](20) NULL,
	[Address] [nvarchar](50) NOT NULL,
	[City] [nvarchar](20) NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
 CONSTRAINT [PK_Покупатели] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicine]    Script Date: 09.11.2024 22:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicine](
	[MedicineID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	[Kind] [nvarchar](20) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[MedicineImagePath] [nvarchar](max) NULL,
 CONSTRAINT [PK_Лекарства] PRIMARY KEY CLUSTERED 
(
	[MedicineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicinePrescription]    Script Date: 09.11.2024 22:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicinePrescription](
	[PrescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[DateOfIssue] [date] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[DoctorFullName] [nvarchar](50) NOT NULL,
	[Diagnosis] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Рецепты] PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicineSale]    Script Date: 09.11.2024 22:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicineSale](
	[SaleID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[MedicineID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PrescriptionID] [int] NOT NULL,
	[SellerID] [int] NOT NULL,
 CONSTRAINT [PK_Продажа лекарств] PRIMARY KEY CLUSTERED 
(
	[SaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seller]    Script Date: 09.11.2024 22:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seller](
	[SellerID] [int] NOT NULL,
	[Surname] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Patronymic] [nvarchar](20) NULL,
	[DateOfAdmission] [date] NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Education] [nvarchar](30) NULL,
 CONSTRAINT [PK_Продавцы] PRIMARY KEY CLUSTERED 
(
	[SellerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[DynamicTable]    Script Date: 09.11.2024 22:28:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[DynamicTable] (@type NVARCHAR(20))
RETURNS TABLE
AS
RETURN SELECT [Номер лекарства], Название,
Тип, Цена FROM Лекарства
WHERE Вид = @type
GO
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (1, N'Голубев', N'Иосиф', N'Тимофеевич', N'пр. Ломоносова, 91', N'Брянск', N'89458546547')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (2, N'Ермакова', N'Алла', N'Мироновна', N'ул. Ленина, 23', N'Москва', N'87455642565')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (3, N'Селиверстов', N'Глеб', N'Максимович', N'ул. Космонавтов, 5', N'Владимир', N'82345787865')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (4, N'Агафонов', N'Юстиниан', N'Олегович', N'ул. Летчиков, 8', N'Уфа', N'89456548785')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (5, N'Колобова', N'Злата', N'Романовна', N'ул. Пушкина, 9', N'Казань', N'89458524514')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (6, N'Сысоева', N'Дарина', N'Ярославовна', N'ул. Гоголя, 12', N'Москва', N'89456542585')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (7, N'Некрасов', N'Варлам', N'Михайлович', N'ул. Московская, 34', N'Уфа', N'84759655412')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (8, N'Крюков', N'Наум', N'Ильяович', N'ул. Революционная, 18', N'Брянск', N'85642319654')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (9, N'Сидорова', N'Татьяна', N'Михайловна', N'пр. Октября, 123', N'Москва', N'84561459645')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (10, N'Трофимова', N'Альжбета', N'Якововна', N'ул. Гагарина, 78', N'Туймазы', N'84562255465')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (11, N'Новиков', N'Адриан', N'Аркадьевич', N'ул. Героев, 36', N'Уфа', N'84651234565')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (12, N'Мишина', N'Иветта', N'Андреевна', N'ул. Сибирская, 65', N'Владивосток', N'89994562587')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (13, N'Шестаков', N'Геннадий', N'Рубенович', N'ул. Ленина, 61', N'Казань', N'89456996606')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (14, N'Зуев', N'Матвей', N'Иванович', N'ул. Левитана, 67', N'Уфа', N'89665666606')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (15, N'Турова', N'Георгина', N'Семёновна', N'ул. Писателей, 23', N'Нижний Новгород', N'84558557565')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (17, N'Кадиков', N'Данил', N'Николаевич', N'Ул. Ленина, 21', N'Уфа', NULL)
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (18, N'Мишустин', N'Тимур', NULL, N'Ул. Зелёная роща, 5', N'Уфа', N'79885486134')
INSERT [dbo].[Customer] ([CustomerID], [Surname], [Name], [Patronymic], [Address], [City], [PhoneNumber]) VALUES (19, N'Иванов', N'Иван', N'Иванович', N'Ул. Мингажева, 1', N'Самара', N'89874569144')
GO
SET IDENTITY_INSERT [dbo].[Medicine] ON 

INSERT [dbo].[Medicine] ([MedicineID], [Name], [Type], [Kind], [Price], [MedicineImagePath]) VALUES (1, N'ТераФлю', N'Изготовляемое', N'Порошковый', CAST(500.00 AS Decimal(18, 2)), N'medicine_res/teraflu.jpg')
INSERT [dbo].[Medicine] ([MedicineID], [Name], [Type], [Kind], [Price], [MedicineImagePath]) VALUES (2, N'Колдакт Флю', N'Готовое', N'Капсульный', CAST(750.00 AS Decimal(18, 2)), N'medicine_res/koldactflu.jpg')
INSERT [dbo].[Medicine] ([MedicineID], [Name], [Type], [Kind], [Price], [MedicineImagePath]) VALUES (3, N'Релиф', N'Готовое', N'Свечи', CAST(330.75 AS Decimal(18, 2)), N'medicine_res/relif.jpg')
INSERT [dbo].[Medicine] ([MedicineID], [Name], [Type], [Kind], [Price], [MedicineImagePath]) VALUES (4, N'Парацетамол', N'Готовое', N'Капсульный', CAST(150.00 AS Decimal(18, 2)), N'medicine_res/paracetomol.jpg')
INSERT [dbo].[Medicine] ([MedicineID], [Name], [Type], [Kind], [Price], [MedicineImagePath]) VALUES (5, N'Левомеколь', N'Готовое', N'Мазь', CAST(350.00 AS Decimal(18, 2)), N'medicine_res/levomekol.jpg')
INSERT [dbo].[Medicine] ([MedicineID], [Name], [Type], [Kind], [Price], [MedicineImagePath]) VALUES (6, N'Ибуклин', N'Изготовляемое', N'Порошковый', CAST(400.00 AS Decimal(18, 2)), N'medicine_res/ibuklin.jpg')
INSERT [dbo].[Medicine] ([MedicineID], [Name], [Type], [Kind], [Price], [MedicineImagePath]) VALUES (7, N'Радевит Актив', N'Готовое', N'Мазь', CAST(200.00 AS Decimal(18, 2)), N'medicine_res/radevit.jpg')
INSERT [dbo].[Medicine] ([MedicineID], [Name], [Type], [Kind], [Price], [MedicineImagePath]) VALUES (8, N'Фитолакс', N'Изготовляемое', N'Порошковый', CAST(250.00 AS Decimal(18, 2)), N'medicine_res/fitolaks.jpg')
INSERT [dbo].[Medicine] ([MedicineID], [Name], [Type], [Kind], [Price], [MedicineImagePath]) VALUES (9, N'Гидрохлортиазид', N'Изготовляемое', N'Порошковый', CAST(700.00 AS Decimal(18, 2)), N'medicine_res/gidrokhlor.jpg')
SET IDENTITY_INSERT [dbo].[Medicine] OFF
GO
SET IDENTITY_INSERT [dbo].[MedicinePrescription] ON 

INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (1, CAST(N'2021-03-18' AS Date), 1, N'Полякова Виктория Кирилловна', N'Простуда')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (2, CAST(N'2021-04-05' AS Date), 2, N'Костина Милана Савельевна', N'Простуда')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (3, CAST(N'2021-04-11' AS Date), 3, N'Ефимова Виктория Васильевна', N'Геморрой')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (4, CAST(N'2021-07-11' AS Date), 4, N'Шишкина Милана Ярославовна', N'Мигрень')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (5, CAST(N'2021-09-03' AS Date), 5, N'Голованов Георгий Алиевич', N'Абсцесс')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (6, CAST(N'2021-10-28' AS Date), 6, N'Беляев Андрей Александрович', N'Простуда')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (7, CAST(N'2022-03-20' AS Date), 7, N'Михайлов Владислав Сергеевич', N'Простуда')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (8, CAST(N'2022-05-29' AS Date), 8, N'Новикова Екатерина Васильевна', N'Мигрень')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (9, CAST(N'2022-07-13' AS Date), 9, N'Сафонова Валерия Игнатиевна', N'Шелушение кожи')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (10, CAST(N'2022-08-29' AS Date), 10, N'Григорьева Арина Артёмовна', N'Простуда')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (11, CAST(N'2022-10-01' AS Date), 11, N'Корнилов Дмитрий Владимирович', N'Запор')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (12, CAST(N'2022-10-10' AS Date), 12, N'Белоусов Пётр Владиславович', N'Отеки')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (13, CAST(N'2022-11-02' AS Date), 13, N'Баранова Александра Ильинична', N'Мигрень')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (14, CAST(N'2022-11-24' AS Date), 14, N'Кузнецов Семён Даниилович', N'Простуда')
INSERT [dbo].[MedicinePrescription] ([PrescriptionID], [DateOfIssue], [CustomerID], [DoctorFullName], [Diagnosis]) VALUES (15, CAST(N'2022-12-04' AS Date), 15, N'Максимова Татьяна Артёмовна', N'Мигрень')
SET IDENTITY_INSERT [dbo].[MedicinePrescription] OFF
GO
SET IDENTITY_INSERT [dbo].[MedicineSale] ON 

INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (1, CAST(N'2023-01-20' AS Date), 1, 1, 1, 1)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (2, CAST(N'2023-01-25' AS Date), 2, 1, 2, 2)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (3, CAST(N'2023-01-30' AS Date), 3, 1, 3, 1)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (4, CAST(N'2023-02-03' AS Date), 4, 1, 4, 3)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (5, CAST(N'2023-02-05' AS Date), 5, 1, 5, 2)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (6, CAST(N'2023-02-10' AS Date), 1, 1, 6, 4)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (7, CAST(N'2023-02-12' AS Date), 6, 1, 7, 5)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (8, CAST(N'2023-02-18' AS Date), 4, 1, 8, 3)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (9, CAST(N'2023-02-20' AS Date), 7, 1, 9, 6)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (10, CAST(N'2023-02-25' AS Date), 2, 1, 10, 4)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (11, CAST(N'2023-03-04' AS Date), 8, 1, 11, 7)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (12, CAST(N'2023-03-07' AS Date), 9, 1, 12, 5)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (13, CAST(N'2023-03-09' AS Date), 4, 1, 13, 6)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (14, CAST(N'2023-03-10' AS Date), 2, 1, 14, 7)
INSERT [dbo].[MedicineSale] ([SaleID], [Date], [MedicineID], [Quantity], [PrescriptionID], [SellerID]) VALUES (15, CAST(N'2023-03-14' AS Date), 4, 1, 15, 1)
SET IDENTITY_INSERT [dbo].[MedicineSale] OFF
GO
INSERT [dbo].[Seller] ([SellerID], [Surname], [Name], [Patronymic], [DateOfAdmission], [BirthDate], [Education]) VALUES (1, N'Чехов', N'Алексей', N'Гаврилович', CAST(N'2018-12-28' AS Date), CAST(N'1972-10-21' AS Date), N'Магистр')
INSERT [dbo].[Seller] ([SellerID], [Surname], [Name], [Patronymic], [DateOfAdmission], [BirthDate], [Education]) VALUES (2, N'Доскалиев', N'Михаил', N'Григорьевич', CAST(N'2019-02-10' AS Date), CAST(N'1986-07-09' AS Date), N'Среднее профессиональное')
INSERT [dbo].[Seller] ([SellerID], [Surname], [Name], [Patronymic], [DateOfAdmission], [BirthDate], [Education]) VALUES (3, N'Капп', N'Ростислав', N'Савванович', CAST(N'2023-01-06' AS Date), CAST(N'1971-02-24' AS Date), N'Бакалавр')
INSERT [dbo].[Seller] ([SellerID], [Surname], [Name], [Patronymic], [DateOfAdmission], [BirthDate], [Education]) VALUES (4, N'Ремизова', N'Татьяна', N'Иннокентьевна', CAST(N'2018-11-20' AS Date), CAST(N'1992-01-22' AS Date), N'Бакалавр')
INSERT [dbo].[Seller] ([SellerID], [Surname], [Name], [Patronymic], [DateOfAdmission], [BirthDate], [Education]) VALUES (5, N'Злобин', N'Николай', N'Никифорович', CAST(N'2023-03-20' AS Date), CAST(N'1987-06-27' AS Date), N'Среднее профессиональное')
INSERT [dbo].[Seller] ([SellerID], [Surname], [Name], [Patronymic], [DateOfAdmission], [BirthDate], [Education]) VALUES (6, N'Ёлкина', N'Оксана', N'Серафимовна', CAST(N'2016-08-03' AS Date), CAST(N'1976-12-12' AS Date), N'Магистр')
INSERT [dbo].[Seller] ([SellerID], [Surname], [Name], [Patronymic], [DateOfAdmission], [BirthDate], [Education]) VALUES (7, N'Погодова', N'Тамара', N'Елизаровна', CAST(N'2018-06-09' AS Date), CAST(N'1994-03-25' AS Date), N'Среднее профессиональное')
INSERT [dbo].[Seller] ([SellerID], [Surname], [Name], [Patronymic], [DateOfAdmission], [BirthDate], [Education]) VALUES (8, N'Иванов', N'Иван', N'Иванович', CAST(N'2020-11-03' AS Date), CAST(N'1999-09-16' AS Date), N'Бакалавр')
INSERT [dbo].[Seller] ([SellerID], [Surname], [Name], [Patronymic], [DateOfAdmission], [BirthDate], [Education]) VALUES (9, N'Кузьмин', N'Олег', N'Кириллович', CAST(N'2021-03-20' AS Date), CAST(N'2000-05-15' AS Date), N'Среднее профессиональное')
GO
ALTER TABLE [dbo].[MedicinePrescription]  WITH CHECK ADD  CONSTRAINT [FK_Рецепты_Покупатели] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[MedicinePrescription] CHECK CONSTRAINT [FK_Рецепты_Покупатели]
GO
ALTER TABLE [dbo].[MedicineSale]  WITH CHECK ADD  CONSTRAINT [FK_Продажа лекарств_Лекарства] FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicine] ([MedicineID])
GO
ALTER TABLE [dbo].[MedicineSale] CHECK CONSTRAINT [FK_Продажа лекарств_Лекарства]
GO
ALTER TABLE [dbo].[MedicineSale]  WITH CHECK ADD  CONSTRAINT [FK_Продажа лекарств_Продавцы] FOREIGN KEY([SellerID])
REFERENCES [dbo].[Seller] ([SellerID])
GO
ALTER TABLE [dbo].[MedicineSale] CHECK CONSTRAINT [FK_Продажа лекарств_Продавцы]
GO
ALTER TABLE [dbo].[MedicineSale]  WITH CHECK ADD  CONSTRAINT [FK_Продажа лекарств_Рецепты] FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[MedicinePrescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[MedicineSale] CHECK CONSTRAINT [FK_Продажа лекарств_Рецепты]
GO
USE [master]
GO
ALTER DATABASE [KoloskovApteka] SET  READ_WRITE 
GO
