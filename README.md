README - Admino Employee Management System

Overview

🚀 The Admino Employee Management System is an advanced platform for smart and efficient employee management. With intuitive functionality, innovative design, and scalable architecture, Admino is the perfect solution for improving employee management processes within organizations.

System Objectives

🎯 Streamline Employee Management: Provide tools for efficient management of employee data, actions, and performance.

🔒 Ensure Security: Protect sensitive data using advanced authentication and encryption techniques.

🌍 Support Scalability: Build a flexible system that can grow with organizational needs.

🖼️ Professional Design: Create a user-friendly interface aligned with modern design principles.

🔍 Advanced Search: Search employees by name or manager for quick and targeted results.

✏️ Action Management: Add customized actions to employees for efficient tracking and monitoring.

Key Features

🛡️ JWT Authentication: Secure authentication using JSON Web Tokens.

♻️ Dependency Injection: Implements the Singleton pattern for optimal resource management and modularity.

🧩 Middleware Integration:

⚠️ Error Handling Middleware: Custom error handling to improve debugging.

📋 Request Tracking Middleware: Advanced logging for HTTP requests.

🌐 Port Configuration: Dedicated ports for smooth client-server communication:

Client: http://localhost:4200

Server: http://localhost:5000

📊 Comprehensive Logging: Using Serilog for detailed information and error logging.

🗄️ SQL Integration:

Includes triggers, stored procedures, and indexes for optimal performance.

Configurable SQL connection settings via DbConfig.xml.

🏗️ Layered Architecture: Organized into distinct layers for improved management and scalability:

DAL: Data Access Layer

BL: Business Logic Layer

ORC: Orchestration Layer

WebAPI: RESTful API for frontend-backend communication

🎨 Professional Design: User-friendly, responsive, and visually appealing interface.

File Structure

📂 Client Side

Developed using React and styled with modern frameworks.

Entry point: src/main.jsx

Configuration file: vite.config.js

📂 Server Side

Backend logic implemented in .NET Core.

Main entry point: Program.cs

Middleware configuration: Startup.cs

📂 Database Side

Includes database scripts, triggers, stored procedures, and indexes.

Configuration file: DbConfig.xml

Technologies Used

💻 Backend: .NET Core

🌐 Frontend: React (using Vite for optimized builds)

🗄️ Database: SQL Server

How to Add the SQL Database

🖥️ Open SQL Server Management Studio (SSMS).

📁 Locate the SQL script file: DanielAmosAppDB.sql.

▶️ Run the script:

USE [master]
GO
CREATE DATABASE [DanielAmosDB]
GO
ALTER DATABASE [DanielAmosDB] SET COMPATIBILITY_LEVEL = 160
GO
-- Additional configurations

✅ Ensure the DanielAmosDB database is successfully created.

How to Configure SQL Connection

🛠️ Open the DbConfig.xml file in the project structure.

📝 Update the <ConnectionString> field with your SQL server details:

<DatabaseConfig>
    <ConnectionString>Server=YOUR_SERVER_NAME;Database=DanielAmosDB;Trusted_Connection=True;TrustServerCertificate=True;</ConnectionString>
</DatabaseConfig>

🔄 Save and restart the application.

How to Run the Application

🚀 Running the Client Side

Navigate to the client-side directory in your terminal:

cd path/to/client

Install the necessary dependencies using npm:

npm install

Start the client-side application:

npm run dev

Open your browser and navigate to:

http://localhost:4200

🚀 Running the Server Side

Navigate to the server-side directory in your terminal.

Ensure the database is configured and accessible (see the SQL setup section).

Run the server using the .NET Core CLI:

dotnet run

The server will be running at:

http://localhost:5000

Middleware Configuration

📝 LogRequest Middleware: Logs all incoming HTTP requests.

❌ ExceptionRequest Middleware: Handles custom errors and logs exceptions.

🔒 CORS Configuration: Allows Cross-Origin requests for smooth client-server communication.

Logging with Serilog

📄 Information Logs: Records general application activities.

⚠️ Error Logs: Captures critical and unexpected issues.

Example Serilog configuration in appsettings.json:

"Serilog": {
    "Using": [ "Serilog.Sinks.Console", "Serilog.Sinks.File" ],
    "MinimumLevel": {
        "Default": "Information",
        "Override": {
            "Microsoft": "Warning",
            "System": "Warning"
        }
    }
}

Thank you for choosing Admino - The Smart Employee Management System! 🎉

