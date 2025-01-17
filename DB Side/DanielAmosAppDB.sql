USE [master]
GO
/****** Object:  Database [DanielAmosDB]    Script Date: 15/01/2025 10:32:27 ******/
CREATE DATABASE [DanielAmosDB]
GO
ALTER DATABASE [DanielAmosDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DanielAmosDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DanielAmosDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DanielAmosDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DanielAmosDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DanielAmosDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DanielAmosDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DanielAmosDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DanielAmosDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DanielAmosDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DanielAmosDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DanielAmosDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DanielAmosDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DanielAmosDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DanielAmosDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DanielAmosDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DanielAmosDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DanielAmosDB] SET RECOVERY FULL 
GO
ALTER DATABASE [DanielAmosDB] SET  MULTI_USER 
GO
ALTER DATABASE [DanielAmosDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DanielAmosDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DanielAmosDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DanielAmosDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DanielAmosDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DanielAmosDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DanielAmosDB', N'ON'
GO
ALTER DATABASE [DanielAmosDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [DanielAmosDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DanielAmosDB]
GO
/****** Object:  UserDefinedFunction [dbo].[ValidateEmail]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [dbo].[ValidateEmail](
@email varchar(255)
)
returns BIT
AS
Begin
    if @email like '%[a-zA-Z0-9._%+-]@[a-zA-Z0-9.-]%.[a-zA-Z]{2,}%' 
        return 1;
    return 0;
End;
GO
/****** Object:  Table [dbo].[Action]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Action](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](255) NOT NULL,
	[Description] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Action] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](255) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[Email] [varchar](255) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Created] [datetime] NOT NULL,
	[GUID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[History]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[ActionID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ManagerID] [int] NOT NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[Info] [text] NOT NULL,
	[Created] [datetime] NOT NULL,
	[RequestData] [text] NULL,
	[ExceptionData] [text] NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manager]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manager](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](255) NOT NULL,
	[Department] [varchar](255) NOT NULL,
	[Start] [datetime] NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_Manager] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManagerWithEmployee]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagerWithEmployee](
	[ManagerID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_ManagerWithEmployee_1] PRIMARY KEY CLUSTERED 
(
	[ManagerID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Action] ON 
GO
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (24, N'ניהול', N'הוספת משכורת')
GO
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (26, N'ניהול', N'שיחת סטטוס')
GO
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (27, N'ניהול', N'שיפור תנאים')
GO
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (28, N'שירה', N'שיחת משוב ')
GO
INSERT [dbo].[Action] ([ID], [Type], [Description]) VALUES (30, N'סטטוס', N'השמה')
GO
SET IDENTITY_INSERT [dbo].[Action] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 
GO
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (129, N'דניאל עמוס ארצי', N'0523565655', N'edardaniel20001030@gmail.com', N'AQAAAAIAAYagAAAAEL17JEsGS9WxdnwlvYSrLyDEP+C/B/vQPi4HCK9KvV4BwVzem8iejeGXMDBGjzsK8g==', CAST(N'2025-01-12T14:25:00.000' AS DateTime), N'b026570d-3471-4525-bb4d-876e97db8c2f')
GO
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (130, N'אדוארד ארצי', N'0523565543', N'edardaniel@gmail.com', N'AQAAAAIAAYagAAAAELCHBzGBfOQdm/2BTtikilJ/q6zZKanlJknyj1QArjd1ZyV/vatwXi+ibg9xSRnlGQ==', CAST(N'2025-01-12T14:25:00.000' AS DateTime), N'39342b4e-c001-43fb-964c-57c8544c781f')
GO
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (131, N'דניאל נעים', N'0523565123', N'daniel@gmail.com', N'AQAAAAIAAYagAAAAEPi5PE4ZnxwdNdbTxfk3Pgb3xNpHhTmLarnx63v+MMbicIbAnmu4dsGcqCrJqdSbxg==', CAST(N'2025-01-12T14:25:00.000' AS DateTime), N'85f65134-e1ed-43e2-b5c8-90ad9778f3c5')
GO
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (132, N'עמוס כבתי', N'0523565623', N'tehila@gmail.com', N'AQAAAAIAAYagAAAAELPHCwfnfi1ClO7ZrGjiZrS6kYuHmGQ7GIUOqOZok+1EPzRXoyizd5QMWdch/B74Fg==', CAST(N'2025-01-12T14:25:00.000' AS DateTime), N'8d808fe9-4e65-4c9e-93b3-eae32561b7e9')
GO
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (133, N'איתי', N'0523565612', N'itay@gmail.com', N'AQAAAAIAAYagAAAAECcsFHhp88zp/7uKSm62Vp4IuAEBd4kMSQQj1zN+jBsvzYQ0A6jVFs71p8UyyShK8Q==', CAST(N'2025-01-12T14:51:00.000' AS DateTime), N'fa661058-d49e-4888-b197-962977bf7219')
GO
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (134, N'איתי חביב', N'0523565633', N'itay2@gmail.com', N'AQAAAAIAAYagAAAAEJPUiGvtv98t8qUiMG65yxUfhUz7dFGlGmiwUOhDxfE9aKzEZQnLQ1u2pxJqN3WQ9g==', CAST(N'2025-01-12T14:51:00.000' AS DateTime), N'17ee7648-f50c-4f3d-a50d-e73c3beab62b')
GO
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (135, N'תהילה נעים', N'0507432498', N'tehilaN@gmail.com', N'AQAAAAIAAYagAAAAEGJ+qUfuY1INux0aM2SSgx2XQIPb2J5ElYAcyMZpm2DBfYW3+IvutyDEdOU6MbZWyg==', CAST(N'2025-01-15T05:58:00.000' AS DateTime), N'f9defb9a-00d5-4785-8a7f-0d3828ac9214')
GO
INSERT [dbo].[Employee] ([ID], [FullName], [Phone], [Email], [Password], [Created], [GUID]) VALUES (136, N'דור אוחיון', N'0538456988', N'dor@gmail.com', N'AQAAAAIAAYagAAAAEP7sMgyYbBa6uRvv2tfOglZuME+dmQDvGFAenS4TWp6DzH25rdWdzmHJnSznCgUuxg==', CAST(N'2025-01-15T06:01:00.000' AS DateTime), N'9e1f63d0-b408-4be0-9d18-3d454107116b')
GO
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[History] ON 
GO
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (47, CAST(N'2025-01-13T17:55:00.000' AS DateTime), 24, 133, 37)
GO
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (48, CAST(N'2025-01-13T18:55:00.000' AS DateTime), 24, 133, 37)
GO
INSERT [dbo].[History] ([ID], [Date], [ActionID], [EmployeeID], [ManagerID]) VALUES (49, CAST(N'2025-01-15T12:02:00.000' AS DateTime), 30, 136, 41)
GO
SET IDENTITY_INSERT [dbo].[History] OFF
GO
SET IDENTITY_INSERT [dbo].[Log] ON 
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (18, N'Info', N'GET', CAST(N'2025-01-12T15:46:38.857' AS DateTime), N'/swagger/index.html', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (19, N'Info', N'GET', CAST(N'2025-01-12T15:46:39.493' AS DateTime), N'/swagger/v1/swagger.json', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (20, N'Info', N'GET', CAST(N'2025-01-12T15:46:39.507' AS DateTime), N'/swagger/favicon-32x32.png', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (21, N'Info', N'GET', CAST(N'2025-01-12T15:47:24.103' AS DateTime), N'/swagger/index.html', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (22, N'Info', N'GET', CAST(N'2025-01-12T15:47:24.570' AS DateTime), N'/swagger/v1/swagger.json', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (23, N'Info', N'GET', CAST(N'2025-01-12T16:04:54.120' AS DateTime), N'/swagger/index.html', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (24, N'Info', N'GET', CAST(N'2025-01-12T16:04:54.517' AS DateTime), N'/swagger/v1/swagger.json', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (25, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:19:29.973' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (26, N'Info', N'GET', CAST(N'2025-01-12T16:19:41.013' AS DateTime), N'/swagger/index.html', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (27, N'Info', N'GET', CAST(N'2025-01-12T16:19:41.420' AS DateTime), N'/swagger/v1/swagger.json', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (28, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:19:47.137' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (29, N'Info', N'GET', CAST(N'2025-01-12T16:20:33.587' AS DateTime), N'/swagger/index.html', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (30, N'Info', N'GET', CAST(N'2025-01-12T16:20:34.003' AS DateTime), N'/swagger/v1/swagger.json', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (31, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:20:44.087' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (32, N'Info', N'POST', CAST(N'2025-01-12T16:20:44.097' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (33, N'Error', N'Exception', CAST(N'2025-01-12T16:20:44.260' AS DateTime), NULL, N'Unable to resolve service for type ''danielAmosServer_Core.Orchestration.ManagerOrcRead'' while attempting to activate ''danielAmosServer_Core.Controllers.ManagerController''.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (34, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:22:08.510' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (35, N'Info', N'POST', CAST(N'2025-01-12T16:22:08.520' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (36, N'Error', N'Exception', CAST(N'2025-01-12T16:22:08.540' AS DateTime), NULL, N'Unable to resolve service for type ''danielAmosServer_Core.Orchestration.ManagerOrcRead'' while attempting to activate ''danielAmosServer_Core.Controllers.ManagerController''.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (37, N'Info', N'GET', CAST(N'2025-01-12T16:24:35.330' AS DateTime), N'/swagger/index.html', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (38, N'Info', N'GET', CAST(N'2025-01-12T16:24:35.727' AS DateTime), N'/swagger/v1/swagger.json', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (39, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:24:42.803' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (40, N'Info', N'POST', CAST(N'2025-01-12T16:24:42.817' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (41, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:25:12.763' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (42, N'Info', N'GET', CAST(N'2025-01-12T16:25:12.773' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (43, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:25:12.887' AS DateTime), NULL, N'Employee with Email = > edardaniessssl20001030@gmail.com  and password = > Ead0112024Easd! not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (44, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:25:25.113' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (45, N'Info', N'GET', CAST(N'2025-01-12T16:25:25.120' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (46, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:25:25.150' AS DateTime), NULL, N'Employee with Email = > edardaniessssl20001030@gmail.com  and password = > Ead0112024Easd! not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (47, N'Info', N'GET', CAST(N'2025-01-12T16:25:28.043' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (48, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:25:28.070' AS DateTime), NULL, N'Employee with Email = > edardaniessssl20001030@gmail.com  and password = > Ead0112024Easd! not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (49, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:28:25.097' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (50, N'Info', N'POST', CAST(N'2025-01-12T16:28:25.110' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (51, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:28:53.983' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (52, N'Info', N'POST', CAST(N'2025-01-12T16:28:53.990' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (53, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:29:10.327' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (54, N'Info', N'POST', CAST(N'2025-01-12T16:29:10.333' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (55, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:29:26.093' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (56, N'Info', N'POST', CAST(N'2025-01-12T16:29:26.100' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (57, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:29:39.087' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (58, N'Info', N'GET', CAST(N'2025-01-12T16:29:39.093' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (59, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:29:39.123' AS DateTime), NULL, N'Employee with Email = > edardaniessssl20001030@gmail.com  and password = > ASDasd123! not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (60, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:29:57.777' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (61, N'Info', N'GET', CAST(N'2025-01-12T16:29:57.783' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (62, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:29:57.850' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (63, N'Info', N'POST', CAST(N'2025-01-12T16:29:57.857' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (64, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:29:58.687' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (65, N'Info', N'GET', CAST(N'2025-01-12T16:29:58.700' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (66, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:29:58.690' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (67, N'Info', N'GET', CAST(N'2025-01-12T16:29:58.760' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (68, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:30:08.187' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (69, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:30:08.190' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (70, N'Info', N'GET', CAST(N'2025-01-12T16:30:08.197' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (71, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:30:08.247' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (72, N'Info', N'GET', CAST(N'2025-01-12T16:30:08.250' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (73, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:30:08.297' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (74, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:30:28.583' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (75, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:30:28.587' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (76, N'Info', N'GET', CAST(N'2025-01-12T16:30:28.600' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (77, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:30:28.640' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (78, N'Info', N'GET', CAST(N'2025-01-12T16:30:28.643' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (79, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:30:28.680' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (80, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:30:36.847' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (81, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:30:36.850' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (82, N'Info', N'GET', CAST(N'2025-01-12T16:30:36.857' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (83, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:30:36.900' AS DateTime), NULL, N'History with employee id - 129 not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (84, N'Info', N'GET', CAST(N'2025-01-12T16:30:36.903' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (85, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:30:36.943' AS DateTime), NULL, N'History with employee id - 129 not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (86, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:30:38.917' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (87, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:30:38.923' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (88, N'Info', N'GET', CAST(N'2025-01-12T16:30:38.930' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (89, N'Info', N'GET', CAST(N'2025-01-12T16:30:38.947' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (90, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:30:59.713' AS DateTime), N'/api/Manager/ActionInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (91, N'Info', N'POST', CAST(N'2025-01-12T16:30:59.723' AS DateTime), N'/api/Manager/ActionInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (92, N'Info', N'POST', CAST(N'2025-01-12T16:31:01.250' AS DateTime), N'/api/Manager/ActionInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (93, N'Error', N'CreateException', CAST(N'2025-01-12T16:31:11.310' AS DateTime), NULL, N'The addition failed try again soon...')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (94, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:31:18.473' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (95, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:31:18.477' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (96, N'Info', N'GET', CAST(N'2025-01-12T16:31:18.483' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (97, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:18.530' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (98, N'Info', N'GET', CAST(N'2025-01-12T16:31:18.533' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (99, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:18.573' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (100, N'Info', N'GET', CAST(N'2025-01-12T16:31:19.993' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (101, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:20.037' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (102, N'Info', N'GET', CAST(N'2025-01-12T16:31:20.040' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (103, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:20.083' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (104, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:31:34.990' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (105, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:31:34.993' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (106, N'Info', N'GET', CAST(N'2025-01-12T16:31:35.003' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (107, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:35.043' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (108, N'Info', N'GET', CAST(N'2025-01-12T16:31:35.047' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (109, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:35.087' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (110, N'Info', N'GET', CAST(N'2025-01-12T16:31:39.413' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (111, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:39.450' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (112, N'Info', N'GET', CAST(N'2025-01-12T16:31:39.457' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (113, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:39.503' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (114, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:31:53.657' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (115, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:31:53.660' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (116, N'Info', N'GET', CAST(N'2025-01-12T16:31:53.670' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (117, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:53.710' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (118, N'Info', N'GET', CAST(N'2025-01-12T16:31:53.713' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (119, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:31:53.757' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (120, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:32:11.017' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (121, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:32:11.020' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (122, N'Info', N'GET', CAST(N'2025-01-12T16:32:11.030' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (123, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:32:11.070' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (124, N'Info', N'GET', CAST(N'2025-01-12T16:32:11.073' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (125, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:32:11.117' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (126, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:32:49.293' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (127, N'Info', N'GET', CAST(N'2025-01-12T16:32:49.303' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (128, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:32:49.377' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (129, N'Info', N'POST', CAST(N'2025-01-12T16:32:49.383' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (130, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:32:50.083' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (131, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:32:50.087' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (132, N'Info', N'GET', CAST(N'2025-01-12T16:32:50.097' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (133, N'Info', N'GET', CAST(N'2025-01-12T16:32:50.113' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (134, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:33:21.347' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (135, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:33:21.347' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (136, N'Info', N'GET', CAST(N'2025-01-12T16:33:21.363' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (137, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:33:21.417' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (138, N'Info', N'GET', CAST(N'2025-01-12T16:33:21.423' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (139, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:33:21.470' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (140, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:35:08.727' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (141, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:35:08.727' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (142, N'Info', N'GET', CAST(N'2025-01-12T16:35:08.760' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (143, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:35:08.800' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (144, N'Info', N'GET', CAST(N'2025-01-12T16:35:08.803' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (145, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:35:08.840' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (146, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:35:27.707' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (147, N'Info', N'GET', CAST(N'2025-01-12T16:35:27.713' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (148, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:35:27.790' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (149, N'Info', N'POST', CAST(N'2025-01-12T16:35:27.797' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (150, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:35:28.460' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (151, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:35:28.460' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (152, N'Info', N'GET', CAST(N'2025-01-12T16:35:28.470' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (153, N'Info', N'GET', CAST(N'2025-01-12T16:35:28.483' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (154, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:35:29.210' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (155, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:35:29.210' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (156, N'Info', N'GET', CAST(N'2025-01-12T16:35:29.220' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (157, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:35:29.257' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (158, N'Info', N'GET', CAST(N'2025-01-12T16:35:29.260' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (159, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:35:29.297' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (160, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:37:08.347' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (161, N'Info', N'GET', CAST(N'2025-01-12T16:37:08.357' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (162, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:37:08.433' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (163, N'Info', N'POST', CAST(N'2025-01-12T16:37:08.440' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (164, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:37:09.070' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (165, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:37:09.073' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (166, N'Info', N'GET', CAST(N'2025-01-12T16:37:09.083' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (167, N'Info', N'GET', CAST(N'2025-01-12T16:37:09.097' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (168, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:37:09.913' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (169, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:37:09.913' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (170, N'Info', N'GET', CAST(N'2025-01-12T16:37:09.920' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (171, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:37:09.957' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (172, N'Info', N'GET', CAST(N'2025-01-12T16:37:09.960' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (173, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:37:10.000' AS DateTime), NULL, N'That''s it, the company has moved to the cloud – there are no more managers, only robots X O X O.')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (174, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:38:19.053' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (175, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:38:19.057' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (176, N'Info', N'GET', CAST(N'2025-01-12T16:38:19.067' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (177, N'Info', N'GET', CAST(N'2025-01-12T16:51:18.213' AS DateTime), N'/swagger/index.html', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (178, N'Info', N'GET', CAST(N'2025-01-12T16:51:18.693' AS DateTime), N'/swagger/v1/swagger.json', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (179, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:51:21.460' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (180, N'Info', N'GET', CAST(N'2025-01-12T16:51:21.473' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (181, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:51:21.660' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (182, N'Info', N'POST', CAST(N'2025-01-12T16:51:21.670' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (183, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:51:22.850' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (184, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:51:22.857' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (185, N'Info', N'GET', CAST(N'2025-01-12T16:51:22.870' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (186, N'Info', N'GET', CAST(N'2025-01-12T16:51:22.927' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (187, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:51:25.210' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (188, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:51:25.210' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (189, N'Info', N'GET', CAST(N'2025-01-12T16:51:25.243' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (190, N'Info', N'GET', CAST(N'2025-01-12T16:51:27.590' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (191, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:52:26.377' AS DateTime), N'/api/Employee/EmployeeInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (192, N'Info', N'POST', CAST(N'2025-01-12T16:52:26.387' AS DateTime), N'/api/Employee/EmployeeInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (193, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:52:39.790' AS DateTime), N'/api/Employee/EmployeeInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (194, N'Info', N'POST', CAST(N'2025-01-12T16:52:39.797' AS DateTime), N'/api/Employee/EmployeeInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (195, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:52:43.090' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (196, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:52:43.097' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (197, N'Info', N'GET', CAST(N'2025-01-12T16:52:43.137' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (198, N'Info', N'GET', CAST(N'2025-01-12T16:52:45.627' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (199, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:52:57.727' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (200, N'Info', N'GET', CAST(N'2025-01-12T16:52:57.737' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (201, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:52:57.830' AS DateTime), NULL, N'No employees were found for the manager whose ID is - 37')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (202, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:53:00.003' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (203, N'Info', N'GET', CAST(N'2025-01-12T16:53:00.013' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (204, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:53:00.053' AS DateTime), NULL, N'No employees were found for the manager whose ID is - 38')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (205, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:53:02.007' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (206, N'Info', N'GET', CAST(N'2025-01-12T16:53:02.017' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (207, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:53:02.053' AS DateTime), NULL, N'No employees were found for the manager whose ID is - 39')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (208, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:53:03.850' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (209, N'Info', N'GET', CAST(N'2025-01-12T16:53:03.857' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (210, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:53:16.260' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (211, N'Info', N'GET', CAST(N'2025-01-12T16:53:16.267' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (212, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:53:19.697' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (213, N'Info', N'GET', CAST(N'2025-01-12T16:53:19.707' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (214, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:54:05.300' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (215, N'Info', N'GET', CAST(N'2025-01-12T16:54:05.313' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (216, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:54:05.363' AS DateTime), NULL, N'No employees were found for the manager whose ID is - 37')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (217, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:54:07.227' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (218, N'Info', N'GET', CAST(N'2025-01-12T16:54:07.237' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (219, N'Info', N'GET', CAST(N'2025-01-12T16:54:43.193' AS DateTime), N'/swagger/index.html', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (220, N'Info', N'GET', CAST(N'2025-01-12T16:54:43.600' AS DateTime), N'/swagger/v1/swagger.json', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (221, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:54:47.873' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (222, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:54:47.877' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (223, N'Info', N'GET', CAST(N'2025-01-12T16:54:47.903' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (224, N'Info', N'GET', CAST(N'2025-01-12T16:54:51.853' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (225, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:54:53.920' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (226, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:54:53.920' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (227, N'Info', N'GET', CAST(N'2025-01-12T16:54:53.933' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (228, N'Info', N'GET', CAST(N'2025-01-12T16:54:53.953' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (229, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:54:56.640' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (230, N'Info', N'GET', CAST(N'2025-01-12T16:54:56.650' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (231, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:02.193' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (232, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:02.197' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (233, N'Info', N'GET', CAST(N'2025-01-12T16:55:02.210' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (234, N'Info', N'GET', CAST(N'2025-01-12T16:55:02.227' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (235, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:08.727' AS DateTime), N'/api/Manager/HistoryInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (236, N'Info', N'POST', CAST(N'2025-01-12T16:55:08.737' AS DateTime), N'/api/Manager/HistoryInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (237, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:10.750' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (238, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:10.753' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (239, N'Info', N'GET', CAST(N'2025-01-12T16:55:10.763' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (240, N'Info', N'GET', CAST(N'2025-01-12T16:55:10.787' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (241, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:11.990' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (242, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:11.993' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (243, N'Info', N'GET', CAST(N'2025-01-12T16:55:12.003' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (244, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:55:12.113' AS DateTime), NULL, N'History with employee id - 129 not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (245, N'Info', N'GET', CAST(N'2025-01-12T16:55:12.120' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (246, N'Error', N'NotFoundException', CAST(N'2025-01-12T16:55:12.163' AS DateTime), NULL, N'History with employee id - 129 not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (247, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:14.600' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (248, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:14.603' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (249, N'Info', N'GET', CAST(N'2025-01-12T16:55:14.617' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (250, N'Info', N'GET', CAST(N'2025-01-12T16:55:14.637' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (251, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:19.150' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (252, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:19.157' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (253, N'Info', N'GET', CAST(N'2025-01-12T16:55:19.163' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (254, N'Info', N'GET', CAST(N'2025-01-12T16:55:19.177' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (255, N'Info', N'GET', CAST(N'2025-01-12T16:55:21.427' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (256, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:21.927' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (257, N'Info', N'GET', CAST(N'2025-01-12T16:55:21.937' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (258, N'Info', N'GET', CAST(N'2025-01-12T16:55:23.293' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (259, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:23.797' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (260, N'Info', N'GET', CAST(N'2025-01-12T16:55:23.803' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (261, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:28.547' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (262, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:28.553' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (263, N'Info', N'GET', CAST(N'2025-01-12T16:55:28.560' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (264, N'Info', N'GET', CAST(N'2025-01-12T16:55:28.573' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (265, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:37.503' AS DateTime), N'/api/Manager/HistoryInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (266, N'Info', N'POST', CAST(N'2025-01-12T16:55:37.510' AS DateTime), N'/api/Manager/HistoryInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (267, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:43.233' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (268, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:43.240' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (269, N'Info', N'GET', CAST(N'2025-01-12T16:55:43.247' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (270, N'Info', N'GET', CAST(N'2025-01-12T16:55:43.263' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (271, N'Info', N'GET', CAST(N'2025-01-12T16:55:47.453' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (272, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:55:47.953' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (273, N'Info', N'GET', CAST(N'2025-01-12T16:55:47.963' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (274, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:56:26.167' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (275, N'Info', N'GET', CAST(N'2025-01-12T16:56:26.173' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (276, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:56:26.260' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (277, N'Info', N'POST', CAST(N'2025-01-12T16:56:26.267' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (278, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:56:26.940' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (279, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:56:26.943' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (280, N'Info', N'GET', CAST(N'2025-01-12T16:56:26.957' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (281, N'Info', N'GET', CAST(N'2025-01-12T16:56:26.973' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (282, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:56:29.593' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (283, N'Info', N'OPTIONS', CAST(N'2025-01-12T16:56:29.597' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (284, N'Info', N'GET', CAST(N'2025-01-12T16:56:29.607' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (285, N'Info', N'GET', CAST(N'2025-01-12T16:56:29.623' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (286, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:21.850' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (287, N'Info', N'GET', CAST(N'2025-01-12T17:02:21.863' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (288, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:21.937' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (289, N'Info', N'POST', CAST(N'2025-01-12T17:02:21.943' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (290, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:22.627' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (291, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:22.637' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (292, N'Info', N'GET', CAST(N'2025-01-12T17:02:22.643' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (293, N'Info', N'GET', CAST(N'2025-01-12T17:02:22.690' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (294, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:24.683' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (295, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:24.683' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (296, N'Info', N'GET', CAST(N'2025-01-12T17:02:24.697' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (297, N'Info', N'GET', CAST(N'2025-01-12T17:02:24.710' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (298, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:28.127' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (299, N'Info', N'GET', CAST(N'2025-01-12T17:02:28.133' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (300, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:36.473' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (301, N'Info', N'GET', CAST(N'2025-01-12T17:02:36.480' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (302, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:36.977' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (303, N'Info', N'GET', CAST(N'2025-01-12T17:02:36.983' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (304, N'Error', N'NotFoundException', CAST(N'2025-01-12T17:02:37.030' AS DateTime), NULL, N'Employee with FullName t not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (305, N'Info', N'GET', CAST(N'2025-01-12T17:02:40.437' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (306, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:40.943' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (307, N'Info', N'GET', CAST(N'2025-01-12T17:02:40.950' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (308, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:48.077' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (309, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:48.077' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (310, N'Info', N'GET', CAST(N'2025-01-12T17:02:48.083' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (311, N'Info', N'GET', CAST(N'2025-01-12T17:02:48.097' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (312, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:50.987' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (313, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:50.990' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (314, N'Info', N'GET', CAST(N'2025-01-12T17:02:51.000' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (315, N'Info', N'GET', CAST(N'2025-01-12T17:02:51.010' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (316, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:56.963' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (317, N'Info', N'GET', CAST(N'2025-01-12T17:02:56.967' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (318, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:58.427' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (319, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:02:58.427' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (320, N'Info', N'GET', CAST(N'2025-01-12T17:02:58.437' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (321, N'Info', N'GET', CAST(N'2025-01-12T17:02:58.447' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (322, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:06.287' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (323, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:06.290' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (324, N'Info', N'GET', CAST(N'2025-01-12T17:03:06.297' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (325, N'Info', N'GET', CAST(N'2025-01-12T17:03:06.310' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (326, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:07.910' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (327, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:07.910' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (328, N'Info', N'GET', CAST(N'2025-01-12T17:03:07.920' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (329, N'Info', N'GET', CAST(N'2025-01-12T17:03:07.930' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (330, N'Info', N'GET', CAST(N'2025-01-12T17:03:09.177' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (331, N'Info', N'GET', CAST(N'2025-01-12T17:03:09.190' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (332, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:09.723' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (333, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:09.727' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (334, N'Info', N'GET', CAST(N'2025-01-12T17:03:09.733' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (335, N'Info', N'GET', CAST(N'2025-01-12T17:03:09.743' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (336, N'Info', N'GET', CAST(N'2025-01-12T17:03:11.567' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (337, N'Info', N'GET', CAST(N'2025-01-12T17:03:11.580' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (338, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:14.583' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (339, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:14.583' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (340, N'Info', N'GET', CAST(N'2025-01-12T17:03:14.597' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (341, N'Info', N'GET', CAST(N'2025-01-12T17:03:14.613' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (342, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:16.527' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (343, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:16.530' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (344, N'Info', N'GET', CAST(N'2025-01-12T17:03:16.540' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (345, N'Error', N'NotFoundException', CAST(N'2025-01-12T17:03:16.577' AS DateTime), NULL, N'History with employee id - 131 not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (346, N'Info', N'GET', CAST(N'2025-01-12T17:03:16.580' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (347, N'Error', N'NotFoundException', CAST(N'2025-01-12T17:03:16.623' AS DateTime), NULL, N'History with employee id - 131 not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (348, N'Info', N'GET', CAST(N'2025-01-12T17:03:18.137' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (349, N'Info', N'GET', CAST(N'2025-01-12T17:03:18.153' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (350, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:19.643' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (351, N'Info', N'GET', CAST(N'2025-01-12T17:03:19.653' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (352, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:29.290' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (353, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:29.290' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (354, N'Info', N'GET', CAST(N'2025-01-12T17:03:29.297' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (355, N'Info', N'GET', CAST(N'2025-01-12T17:03:29.310' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (356, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:30.330' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (357, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:03:30.333' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (358, N'Info', N'GET', CAST(N'2025-01-12T17:03:30.340' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (359, N'Info', N'GET', CAST(N'2025-01-12T17:03:30.353' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (360, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:08:39.690' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (361, N'Info', N'GET', CAST(N'2025-01-12T17:08:39.700' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (362, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:08:39.773' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (363, N'Info', N'POST', CAST(N'2025-01-12T17:08:39.780' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (364, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:08:40.690' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (365, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:08:40.697' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (366, N'Info', N'GET', CAST(N'2025-01-12T17:08:40.703' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (367, N'Info', N'GET', CAST(N'2025-01-12T17:08:40.717' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (368, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:11:32.057' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (369, N'Info', N'GET', CAST(N'2025-01-12T17:11:32.067' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (370, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:11:32.140' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (371, N'Info', N'POST', CAST(N'2025-01-12T17:11:32.147' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (372, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:11:32.763' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (373, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:11:32.767' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (374, N'Info', N'GET', CAST(N'2025-01-12T17:11:32.777' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (375, N'Info', N'GET', CAST(N'2025-01-12T17:11:32.790' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (376, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:11:49.450' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (377, N'Info', N'GET', CAST(N'2025-01-12T17:11:49.457' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (378, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:11:49.517' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (379, N'Info', N'POST', CAST(N'2025-01-12T17:11:49.523' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (380, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:11:50.227' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (381, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:11:50.233' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (382, N'Info', N'GET', CAST(N'2025-01-12T17:11:50.240' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (383, N'Info', N'GET', CAST(N'2025-01-12T17:11:50.250' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (384, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:12:17.573' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (385, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:12:17.577' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (386, N'Info', N'GET', CAST(N'2025-01-12T17:12:17.623' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (387, N'Info', N'GET', CAST(N'2025-01-12T17:12:17.637' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (388, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:13:07.423' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (389, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:13:07.430' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (390, N'Info', N'GET', CAST(N'2025-01-12T17:13:07.477' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (391, N'Info', N'GET', CAST(N'2025-01-12T17:13:07.487' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (392, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:15:57.140' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (393, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:15:57.140' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (394, N'Info', N'GET', CAST(N'2025-01-12T17:15:57.180' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (395, N'Info', N'GET', CAST(N'2025-01-12T17:15:57.193' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (396, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:16:24.087' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (397, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:16:24.087' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (398, N'Info', N'GET', CAST(N'2025-01-12T17:16:24.100' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (399, N'Info', N'GET', CAST(N'2025-01-12T17:16:24.113' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (400, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:25:31.863' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (401, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:25:31.870' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (402, N'Info', N'GET', CAST(N'2025-01-12T17:25:31.897' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (403, N'Info', N'GET', CAST(N'2025-01-12T17:25:31.907' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (404, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:27:32.437' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (405, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:27:32.440' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (406, N'Info', N'GET', CAST(N'2025-01-12T17:27:32.453' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (407, N'Info', N'GET', CAST(N'2025-01-12T17:27:32.467' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (408, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:28:26.477' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (409, N'Info', N'GET', CAST(N'2025-01-12T17:28:26.483' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (410, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:28:26.557' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (411, N'Info', N'POST', CAST(N'2025-01-12T17:28:26.563' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (412, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:28:27.377' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (413, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:28:27.380' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (414, N'Info', N'GET', CAST(N'2025-01-12T17:28:27.387' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (415, N'Info', N'GET', CAST(N'2025-01-12T17:28:27.397' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (416, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:29:53.143' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (417, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:29:53.143' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (418, N'Info', N'GET', CAST(N'2025-01-12T17:29:53.180' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (419, N'Info', N'GET', CAST(N'2025-01-12T17:29:53.190' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (420, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:30:11.223' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (421, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:30:11.227' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (422, N'Info', N'GET', CAST(N'2025-01-12T17:30:11.237' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (423, N'Info', N'GET', CAST(N'2025-01-12T17:30:11.250' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (424, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:30:16.367' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (425, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:30:16.370' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (426, N'Info', N'GET', CAST(N'2025-01-12T17:30:16.383' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (427, N'Info', N'GET', CAST(N'2025-01-12T17:30:16.397' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (428, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:36:52.230' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (429, N'Info', N'GET', CAST(N'2025-01-12T17:36:52.247' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (430, N'Error', N'NotFoundException', CAST(N'2025-01-12T17:36:52.330' AS DateTime), NULL, N'Employee with Email = > edardaniel20001030@gmail.com  and password = > logOut not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (431, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:37:08.303' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (432, N'Info', N'GET', CAST(N'2025-01-12T17:37:08.310' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (433, N'Error', N'NotFoundException', CAST(N'2025-01-12T17:37:08.383' AS DateTime), NULL, N'Employee with Email = > edardaniel20001030@gmail.com  and password = > ASdasd123! not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (434, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:37:25.713' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (435, N'Info', N'GET', CAST(N'2025-01-12T17:37:25.723' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (436, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:37:25.793' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (437, N'Info', N'POST', CAST(N'2025-01-12T17:37:25.800' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (438, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:37:26.600' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (439, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:37:26.633' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (440, N'Info', N'GET', CAST(N'2025-01-12T17:37:26.643' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (441, N'Info', N'GET', CAST(N'2025-01-12T17:37:26.667' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (442, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:37:27.847' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (443, N'Info', N'OPTIONS', CAST(N'2025-01-12T17:37:27.847' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (444, N'Info', N'GET', CAST(N'2025-01-12T17:37:27.857' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (445, N'Info', N'GET', CAST(N'2025-01-12T17:37:27.867' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (446, N'Info', N'GET', CAST(N'2025-01-15T07:58:33.150' AS DateTime), N'/swagger', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (447, N'Info', N'GET', CAST(N'2025-01-15T07:58:33.480' AS DateTime), N'/swagger/index.html', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (448, N'Info', N'GET', CAST(N'2025-01-15T07:58:33.537' AS DateTime), N'/swagger/swagger-ui.css', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (449, N'Info', N'GET', CAST(N'2025-01-15T07:58:33.547' AS DateTime), N'/swagger/swagger-ui-bundle.js', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (450, N'Info', N'GET', CAST(N'2025-01-15T07:58:33.557' AS DateTime), N'/swagger/swagger-ui-standalone-preset.js', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (451, N'Info', N'GET', CAST(N'2025-01-15T07:58:33.787' AS DateTime), N'/swagger/v1/swagger.json', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (452, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:00:33.837' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (453, N'Info', N'POST', CAST(N'2025-01-15T08:00:33.850' AS DateTime), N'/api/Manager/ManagerInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (454, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:00:48.480' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (455, N'Info', N'GET', CAST(N'2025-01-15T08:00:48.487' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (456, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:00:48.567' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (457, N'Info', N'POST', CAST(N'2025-01-15T08:00:48.573' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (458, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:00:49.930' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (459, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:00:49.930' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (460, N'Info', N'GET', CAST(N'2025-01-15T08:00:49.943' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (461, N'Info', N'GET', CAST(N'2025-01-15T08:00:49.990' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (462, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:00:56.450' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (463, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:00:56.450' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (464, N'Info', N'GET', CAST(N'2025-01-15T08:00:56.460' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (465, N'Error', N'NotFoundException', CAST(N'2025-01-15T08:00:56.587' AS DateTime), NULL, N'History with employee id - 135 not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (466, N'Info', N'GET', CAST(N'2025-01-15T08:00:56.590' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (467, N'Error', N'NotFoundException', CAST(N'2025-01-15T08:00:56.630' AS DateTime), NULL, N'History with employee id - 135 not found')
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (468, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:00:58.503' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (469, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:00:58.503' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (470, N'Info', N'GET', CAST(N'2025-01-15T08:00:58.510' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (471, N'Info', N'GET', CAST(N'2025-01-15T08:00:58.530' AS DateTime), N'/api/Manager/LogSelectByType', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (472, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:01:28.750' AS DateTime), N'/api/Manager/ActionInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (473, N'Info', N'POST', CAST(N'2025-01-15T08:01:28.760' AS DateTime), N'/api/Manager/ActionInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (474, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:01:30.810' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (475, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:01:30.813' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (476, N'Info', N'GET', CAST(N'2025-01-15T08:01:30.823' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (477, N'Info', N'GET', CAST(N'2025-01-15T08:01:30.840' AS DateTime), N'/api/Manager/ManagerSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (478, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:05.670' AS DateTime), N'/api/Employee/EmployeeInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (479, N'Info', N'POST', CAST(N'2025-01-15T08:02:05.680' AS DateTime), N'/api/Employee/EmployeeInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (480, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:08.583' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (481, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:08.590' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (482, N'Info', N'GET', CAST(N'2025-01-15T08:02:08.600' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (483, N'Info', N'GET', CAST(N'2025-01-15T08:02:08.617' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (484, N'Info', N'GET', CAST(N'2025-01-15T08:02:10.900' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (485, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:11.400' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (486, N'Info', N'GET', CAST(N'2025-01-15T08:02:11.407' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (487, N'Info', N'GET', CAST(N'2025-01-15T08:02:12.183' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (488, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:12.690' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (489, N'Info', N'GET', CAST(N'2025-01-15T08:02:12.697' AS DateTime), N'/api/Employee/SelectByContaintsFullName', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (490, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:14.227' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (491, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:14.227' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (492, N'Info', N'GET', CAST(N'2025-01-15T08:02:14.237' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (493, N'Info', N'GET', CAST(N'2025-01-15T08:02:14.250' AS DateTime), N'/api/Manager/ActionSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (494, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:24.447' AS DateTime), N'/api/Manager/HistoryInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (495, N'Info', N'POST', CAST(N'2025-01-15T08:02:24.457' AS DateTime), N'/api/Manager/HistoryInsert', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (496, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:29.560' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (497, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:29.563' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (498, N'Info', N'GET', CAST(N'2025-01-15T08:02:29.577' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (499, N'Info', N'GET', CAST(N'2025-01-15T08:02:29.587' AS DateTime), N'/api/Manager/ManagerWithEmployeeSelect', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (500, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:32.947' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (501, N'Info', N'GET', CAST(N'2025-01-15T08:02:32.950' AS DateTime), N'/api/Manager/SelectByManager', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (502, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:56.180' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (503, N'Info', N'GET', CAST(N'2025-01-15T08:02:56.190' AS DateTime), N'/api/Employee/SelectByEmailAndPassword', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (504, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:56.253' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (505, N'Info', N'POST', CAST(N'2025-01-15T08:02:56.260' AS DateTime), N'/api/Auth/GenerateToken', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (506, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:56.880' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (507, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:02:56.887' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (508, N'Info', N'GET', CAST(N'2025-01-15T08:02:56.893' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (509, N'Info', N'GET', CAST(N'2025-01-15T08:02:56.907' AS DateTime), N'/api/Manager/ManagerFullDataSelectByID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (510, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:03:00.380' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (511, N'Info', N'OPTIONS', CAST(N'2025-01-15T08:03:00.380' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (512, N'Info', N'GET', CAST(N'2025-01-15T08:03:00.387' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
INSERT [dbo].[Log] ([ID], [Type], [Info], [Created], [RequestData], [ExceptionData]) VALUES (513, N'Info', N'GET', CAST(N'2025-01-15T08:03:00.400' AS DateTime), N'/api/Manager/HistorySelectByEmployeeID', NULL)
GO
SET IDENTITY_INSERT [dbo].[Log] OFF
GO
SET IDENTITY_INSERT [dbo].[Manager] ON 
GO
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (37, N'Project', N'סייבר', CAST(N'2025-01-12T14:25:00.000' AS DateTime), 129)
GO
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (38, N'CEO', N'סייבר', CAST(N'2025-01-12T14:25:00.000' AS DateTime), 130)
GO
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (39, N'Sales', N'סייבר', CAST(N'2025-01-12T14:25:00.000' AS DateTime), 131)
GO
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (40, N'Team Leader', N'סייבר', CAST(N'2025-01-12T14:25:00.000' AS DateTime), 132)
GO
INSERT [dbo].[Manager] ([ID], [Role], [Department], [Start], [EmployeeID]) VALUES (41, N'HR', N'גיוס', CAST(N'2025-01-15T05:58:00.000' AS DateTime), 135)
GO
SET IDENTITY_INSERT [dbo].[Manager] OFF
GO
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (40, 133)
GO
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (40, 134)
GO
INSERT [dbo].[ManagerWithEmployee] ([ManagerID], [EmployeeID]) VALUES (41, 136)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Employee_FullName]    Script Date: 15/01/2025 10:32:27 ******/
CREATE NONCLUSTERED INDEX [IX_Employee_FullName] ON [dbo].[Employee]
(
	[FullName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Employees_Email]    Script Date: 15/01/2025 10:32:27 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Employees_Email] ON [dbo].[Employee]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_History_Date]    Script Date: 15/01/2025 10:32:27 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_History_Date] ON [dbo].[History]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Log_Created]    Script Date: 15/01/2025 10:32:27 ******/
CREATE NONCLUSTERED INDEX [IX_Log_Created] ON [dbo].[Log]
(
	[Created] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Manager_Department]    Script Date: 15/01/2025 10:32:27 ******/
CREATE NONCLUSTERED INDEX [IX_Manager_Department] ON [dbo].[Manager]
(
	[Department] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF__Employee__GUID__5EBF139D]  DEFAULT (newid()) FOR [GUID]
GO
ALTER TABLE [dbo].[History] ADD  CONSTRAINT [DF_History_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_Created]  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[Manager] ADD  CONSTRAINT [DF_Manager_Start]  DEFAULT (getdate()) FOR [Start]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Action] FOREIGN KEY([ActionID])
REFERENCES [dbo].[Action] ([ID])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Action]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Employee]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Manager] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Manager] ([ID])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Manager]
GO
ALTER TABLE [dbo].[Manager]  WITH CHECK ADD  CONSTRAINT [FK_Manager_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[Manager] CHECK CONSTRAINT [FK_Manager_Employee]
GO
ALTER TABLE [dbo].[ManagerWithEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ManagerWithEmployee_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([ID])
GO
ALTER TABLE [dbo].[ManagerWithEmployee] CHECK CONSTRAINT [FK_ManagerWithEmployee_Employee]
GO
ALTER TABLE [dbo].[ManagerWithEmployee]  WITH CHECK ADD  CONSTRAINT [FK_ManagerWithEmployee_Manager] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Manager] ([ID])
GO
ALTER TABLE [dbo].[ManagerWithEmployee] CHECK CONSTRAINT [FK_ManagerWithEmployee_Manager]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [checkEmailFormat] CHECK  (([Email] like '%@%.%'))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [checkEmailFormat]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [checkPhoneFormat] CHECK  (([Phone] like '[0-9]%' AND (len([Phone])=(10) OR len([Phone])=(12))))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [checkPhoneFormat]
GO
ALTER TABLE [dbo].[Log]  WITH CHECK ADD  CONSTRAINT [type Check] CHECK  (([Type]='Error' OR [Type]='Info'))
GO
ALTER TABLE [dbo].[Log] CHECK CONSTRAINT [type Check]
GO
ALTER TABLE [dbo].[Manager]  WITH CHECK ADD  CONSTRAINT [Check Role] CHECK  (([Role]='Team Leader' OR [Role]='Content' OR [Role]='Logistics' OR [Role]='Creative Director' OR [Role]='CISO' OR [Role]='Quality' OR [Role]='Customer Service' OR [Role]='Sales' OR [Role]='Project' OR [Role]='HR' OR [Role]='CTO' OR [Role]='CMO' OR [Role]='CFO' OR [Role]='COO' OR [Role]='CEO'))
GO
ALTER TABLE [dbo].[Manager] CHECK CONSTRAINT [Check Role]
GO
/****** Object:  StoredProcedure [dbo].[Action_Insert]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New ManagerWithEmployee
-- =============================================
CREATE PROCEDURE [dbo].[Action_Insert]

	@Type varchar(255),
	@Description varchar(255)
	
	AS

	INSERT INTO Action
			   (Type, Description)
			Values
			   (@Type, @Description)

--We will retrieve the last values saved in the table to verify the process integrity
	Declare @ActionID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.
	Select ID, Type, Description
	From Action
	Where ID = @ActionID
GO
/****** Object:  StoredProcedure [dbo].[Action_Select]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select All Actions
-- =============================================
CREATE PROCEDURE [dbo].[Action_Select]

	AS

	SET NOCOUNT ON;

		Select 
				ID, Type, Description
		From	Action WITH(NOLOCK)
GO
/****** Object:  StoredProcedure [dbo].[Employee_Delete]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Deleting Employee
-- =============================================
CREATE PROCEDURE [dbo].[Employee_Delete]

	@Original_ID int,
	@Original_FullName varchar(255),
	@Original_Phone varchar(20),
	@Original_Email varchar(255),
	@Original_Created datetime

	 AS

	 -- Delete from anothers before the main

	 DELETE FROM History
		WHERE	(EmployeeID = @Original_ID) 

		DELETE FROM History
		WHERE	(EmployeeID = @Original_ID) 

	 DELETE FROM ManagerWithEmployee
		WHERE	(EmployeeID = @Original_ID) 

	 DELETE FROM Manager
		WHERE	(EmployeeID = @Original_ID) 


		DELETE FROM Employee
		WHERE	(ID = @Original_ID) 
			and (FullName = @Original_FullName) 
			and (Email = @Original_Email) 
			and (Phone = @Original_Phone) 
			and (Created = @Original_Created) 

	  
GO
/****** Object:  StoredProcedure [dbo].[Employee_GetThePasswordByEmail]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Get Employee Password by Email
-- =============================================
CREATE PROCEDURE [dbo].[Employee_GetThePasswordByEmail]

	@email varchar(255)
	AS

	SET NOCOUNT ON;

		Select Password
		From	Employee with(nolock)
		where (Email = @email)
			
GO
/****** Object:  StoredProcedure [dbo].[Employee_Insert]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New Employee
-- =============================================
CREATE PROCEDURE [dbo].[Employee_Insert]

	@FullName varchar(255),
	@Phone varchar(20),
	@Email varchar(255),
	@Password varchar(255),
	@Created datetime = NULL,
	@ManagerID int = NULL
	
	AS

	--Check if a date has not been entered
	If @Created IS NULL
		Begin
			INSERT INTO Employee
			   (FullName, Phone, Email, Password)
			Values
			   (@FullName, @Phone, @Email, @Password)
	End

	Else
		Begin
			INSERT INTO Employee
			   (FullName, Phone, Email, Password, Created)
			Values
			   (@FullName, @Phone, @Email, @Password, @Created)
	End

		--We will retrieve the last values saved in the table to verify the process integrity
	Declare @EmployeeID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.


	-- In a case where we add an employee, we want there to be a manager responsible for them.									
	If @ManagerID Is Not Null 
	Begin    
		INSERT INTO dbo.ManagerWithEmployee 
				(ManagerID, EmployeeID)
			Values (@ManagerID, @EmployeeID);

		select @ManagerID
	End
	

	Select ID, FullName, Phone, Email, Password, Created
	From Employee With(nolock)
	Where ID = @EmployeeID


GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByContaintsFullName]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employees by a containts full name. 
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByContaintsFullName]

	@fullName varchar(255)
	AS

	SET NOCOUNT ON;

		
		Select top 50 ID,FullName, Email, Phone, Password, Created
		From Employee with(nolock)
		where FullName like '%' + @fullname + '%'


		
GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByEmail]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employee by Email
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByEmail]

	@email varchar(255)
	AS

	SET NOCOUNT ON;

		Select 
				Employee.ID, FullName, Phone, Email, Created,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then 1 
				Else 0 
				End as IsManager ,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Role  
				Else null 
				End as Role,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Department  
				Else null 
				End as Department,
				Case 
				When Manager.EmployeeID IS NOT NULL 
				Then Start  
				Else null 
				End as Start

		From	Employee with(nolock)
		left join Manager with(nolock)
			on Manager.EmployeeID = Employee.ID
		where (Email = @email)
			
			
GO
/****** Object:  StoredProcedure [dbo].[Employee_SelectByManager]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select Employees of a Specific Manager. 
-- =============================================
CREATE PROCEDURE [dbo].[Employee_SelectByManager]

	@ID int
	AS

	SET NOCOUNT ON;
		
		Select ID, FullName, Phone, Email, Password, Created
		From ManagerWithEmployee with(nolock)
		inner join Employee with(nolock)
		on ManagerWithEmployee.EmployeeID = Employee.ID
		where ManagerWithEmployee.ManagerID = @ID


		
GO
/****** Object:  StoredProcedure [dbo].[History_Insert]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New History
-- =============================================
CREATE PROCEDURE [dbo].[History_Insert]

	
	
	@Date datetime = null,
	@ActionID int,
	@EmployeeID int,
	@ManagerEmployeeID int
	
	AS
		Declare @ManagerID INT;
		Select @ManagerID = id
		FROM Manager
		WHERE EmployeeID = @ManagerEmployeeID;

	--Check if a date has not been entered
	If @Date IS NULL
		Begin
			INSERT INTO History
			   (ActionID, EmployeeID, ManagerID)
			Values
			   (@ActionID, @EmployeeID, @ManagerID)
	End

	Else
		Begin
			INSERT INTO History
			   (Date, ActionID, EmployeeID, ManagerID)
			Values
			   (@Date, @ActionID, @EmployeeID, @ManagerID)
		End

	--We will retrieve the last values saved in the table to verify the process integrity
	Declare @HistoryID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.
	Select ID, Date, ActionID, EmployeeID, ManagerID
	From History
	Where ID = @HistoryID

GO
/****** Object:  StoredProcedure [dbo].[History_SelectByEmployeeID]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select History by Employee ID
-- =============================================
CREATE PROCEDURE [dbo].[History_SelectByEmployeeID]

	@employeeID INT
	AS

	SET NOCOUNT ON;

		Select 
				History.ID, Date, Action.Type, Action.Description , ManagerEmployee.FullName as ManagerFullName
		From	History with(nolock)
		inner join Action with(nolock)
			on History.ActionID = Action.ID
		inner join Manager with(nolock)
			on History.ManagerID = Manager.ID
		inner join Employee as ManagerEmployee with(nolock) 
			on Manager.EmployeeID = ManagerEmployee.ID
		Where	History.EmployeeID = @employeeID
GO
/****** Object:  StoredProcedure [dbo].[Log_Insert]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New Log
-- =============================================
CREATE PROCEDURE [dbo].[Log_Insert]

	@Type varchar(50),
    @Info text,
    @Created datetime,
    @RequestData text = NULL,
    @ExceptionData text = NULL
	
	AS

	INSERT INTO Log
			   (Type, Info, Created, RequestData, ExceptionData)
			Values
			   (@Type, @Info, @Created, @RequestData, @ExceptionData)

--We will retrieve the last values saved in the table to verify the process integrity
	Declare @LogID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.
	Select Type, Info, Created, RequestData, ExceptionData
	From Log
	Where ID = @LogID
GO
/****** Object:  StoredProcedure [dbo].[Log_SelectByType]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 13.12.24
-- Description:	Select Log by Type from now until 7 days ago
-- =============================================
CREATE PROCEDURE [dbo].[Log_SelectByType]

	@type varchar(50)
	AS

	SET NOCOUNT ON;

		Select top 100
				ID,	Type, Info, Created, RequestData, ExceptionData
		From	Log WITH(NOLOCK)
		Where	Type = @Type
				and Created >= DATEADD(DAY, -7, GETDATE() )
GO
/****** Object:  StoredProcedure [dbo].[Manager_FullDataSelectByID]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select AllData of Manager by ID
-- =============================================
CREATE PROCEDURE [dbo].[Manager_FullDataSelectByID]

	@id INT
	AS

	SET NOCOUNT ON;

		Select

		 Manager.Role, Manager.Department, Manager.Start, 
			   Employee.FullName , Employee.Phone, Employee.Email,
			   Employee.Created,
			   ManagerEmployee.FullName as ManagerFullName
		-- Manager as an employee.
		From Employee with(nolock) 
		left join  Manager with(nolock) 
			on Manager.EmployeeID = Employee.ID

		-- Not certain that the manager has a manager above them.
		left join ManagerWithEmployee with(nolock)
			on ManagerWithEmployee.EmployeeID = Employee.ID

		-- Manager as a a manager employee .
		left join Manager as ManagerOfEmployee with(nolock)
			on ManagerWithEmployee.ManagerID = ManagerOfEmployee.ID
		left join Employee as ManagerEmployee with(nolock)
			on ManagerOfEmployee.EmployeeID = ManagerEmployee.ID
		where Employee.ID = @id
GO
/****** Object:  StoredProcedure [dbo].[Manager_Insert]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New Manager
-- =============================================
CREATE PROCEDURE [dbo].[Manager_Insert]

	
	@Role varchar(255),
	@Department varchar(255),
	@Start datetime = null,
	@EmployeeID int
	
	AS

	If @Start IS NULL
		Begin
			INSERT INTO Manager
			   (Role, Department, EmployeeID)
			Values
			   (@Role, @Department, @EmployeeID)
	End

	Else
		Begin
		INSERT INTO Manager
			   (Role, Department, Start, EmployeeID)
			Values
			   (@Role, @Department, @Start, @EmployeeID)
			
	End

	--We will retrieve the last values saved in the table to verify the process integrity
	Declare @ManagerID INT = SCOPE_IDENTITY() -- Used to retrieve the last value of the IDENTITY column 
											   -- generated after adding a new row to the table.
	Select ID ,Role, Department, Start, EmployeeID
	From Manager
	Where ID = @ManagerID

GO
/****** Object:  StoredProcedure [dbo].[Manager_Select]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select all Managers
-- =============================================
CREATE PROCEDURE [dbo].[Manager_Select]
	as
		SELECT distinct Manager.ID, 
		   Manager.Role, 
		   Manager.Department, 
		   Manager.Start, 
		   Manager.EmployeeID, 
		   Employee.FullName AS EmployeeName
	FROM Manager
	inner join  Employee with(nolock) on Manager.EmployeeID = Employee.ID 


		
		
GO
/****** Object:  StoredProcedure [dbo].[ManagerWithEmployee_Insert]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Creating New ManagerWithEmployee
-- =============================================
CREATE PROCEDURE [dbo].[ManagerWithEmployee_Insert]

	@managerEmployeeID int,
	@employeeID int
	
	AS

		Declare @ManagerID INT;
		Select @ManagerID = id
		FROM Manager
		WHERE EmployeeID = @managerEmployeeID

	INSERT INTO ManagerWithEmployee
			   (ManagerID, EmployeeID)
			Values
			   (@ManagerID, @employeeID)

	Select ManagerID, EmployeeID
	From ManagerWithEmployee
	Where ManagerID = @ManagerID
		 and EmployeeID = @EmployeeID

GO
/****** Object:  StoredProcedure [dbo].[ManagerWithEmployee_Select]    Script Date: 15/01/2025 10:32:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Daniel Amos Artzi
-- Create date: 11.12.24
-- Description:	Select all Managers Who have employees 
-- =============================================
Create PROCEDURE [dbo].[ManagerWithEmployee_Select]
	as
		SELECT distinct Manager.ID, 
		   Manager.Role, 
		   Manager.Department, 
		   Manager.Start, 
		   Manager.EmployeeID, 
		   Employee.FullName AS EmployeeName
	FROM Manager
	inner join  Employee with(nolock) on Manager.EmployeeID = Employee.ID 
	inner join dbo.ManagerWithEmployee  as MWE with(nolock) on Manager.ID = MWE.ManagerID	


		
		
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Action id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Action', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Action type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Action', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Action description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Action', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee full name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee full name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee password' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee create date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Created'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'PK_Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' For performance improvement in search' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'INDEX',@level2name=N'IX_Employee_FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Since it is a column with unique values' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'INDEX',@level2name=N'IX_Employees_Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'HistoryID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Action date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Action' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'ActionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Manager' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'COLUMN',@level2name=N'ManagerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' For performance improvement in search' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'History', @level2type=N'INDEX',@level2name=N'IX_History_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log info' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'Info'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log create date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'Created'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log request data' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'RequestData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Log exception data' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'COLUMN',@level2name=N'ExceptionData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'for performance improvement in search queries by name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'INDEX',@level2name=N'IX_Log_Created'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Checks the log type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Log', @level2type=N'CONSTRAINT',@level2name=N'type Check'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manager id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manager role type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manager department' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manager start date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Start'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'for performance improvement in search queries by name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'INDEX',@level2name=N'IX_Manager_Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check Role type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'CONSTRAINT',@level2name=N'Check Role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Manager' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ManagerWithEmployee', @level2type=N'COLUMN',@level2name=N'ManagerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Key to Employee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ManagerWithEmployee', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
USE [master]
GO
ALTER DATABASE [DanielAmosDB] SET  READ_WRITE 
GO
