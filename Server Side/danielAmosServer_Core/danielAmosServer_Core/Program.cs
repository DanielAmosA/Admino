using danielAmosServer_Core;
using danielAmosServer_Core.BL;
using danielAmosServer_Core.BLInterfaces;
using danielAmosServer_Core.DAL;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.DB;
using danielAmosServer_Core.Helpers.Factory.Interfaces;
using danielAmosServer_Core.Helpers.Factory;
using danielAmosServer_Core.Helpers.Middleware;
using danielAmosServer_Core.Helpers.Service;
using danielAmosServer_Core.Orchestration;
using danielAmosServer_Core.OrchestrationInterfaces;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Serilog;
using Serilog.AspNetCore;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.


// Configure Dependency injection

builder.Services.AddSingleton<AppService>();
builder.Services.AddSingleton<IDataHelper, DataHelper>();

// DAL Layer
builder.Services.AddSingleton<IEmployeeDAL, EmployeeDAL>();
builder.Services.AddSingleton<IManagerDAL, ManagerDAL>();
builder.Services.AddSingleton<IMiddlewareDAL, MiddlewareDAL>();

// BL Layer

builder.Services.AddSingleton<IEmployeeBLFactory, EmployeeBLFactory>();
builder.Services.AddSingleton<IManagerBLFactory, ManagerBLFactory>();

// Orc Layer

builder.Services.AddSingleton<IEmployeeOrcWrite>(provider =>
{
    var factory = provider.GetRequiredService<IEmployeeBLFactory>();
    return new EmployeeOrcWrite(factory.Create());
});

builder.Services.AddSingleton<IEmployeeOrcRead>(provider =>
{
    var factory = provider.GetRequiredService<IEmployeeBLFactory>();
    return new EmployeeOrcRead(factory.Create());
});

builder.Services.AddSingleton<IManagerOrcWrite>(provider =>
{
    var factory = provider.GetRequiredService<IManagerBLFactory>();
    return new ManagerOrcWrite(factory.Create());
});

builder.Services.AddSingleton<IManagerOrcRead>(provider =>
{
    var factory = provider.GetRequiredService<IManagerBLFactory>();
    return new ManagerOrcRead(factory.Create());
});

// Configure CORS (Cross-Origin)

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowClientSide",
        builder =>
        {
            builder
                .WithOrigins("http://localhost:4200")
                .AllowAnyMethod()
                .AllowAnyHeader()
                .AllowCredentials();
        });
});


builder.Services.AddControllers();

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


// Configure Authentication

var jwtSettings = new JwtSettings();
builder.Configuration.GetSection("jwtSettings").Bind(jwtSettings);
builder.Services.AddSingleton(jwtSettings);

builder.Services.AddAuthentication(option =>
{
    option.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    option.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;

})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtSettings.Issuer,
        ValidAudience = jwtSettings.Audience,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SecretKey!))
    };
});

builder.Services.AddAuthentication();



// Configure Log Tool

builder.Host.UseSerilog((context, configuration) =>
configuration.ReadFrom.Configuration(context.Configuration));

var app = builder.Build();

// Middleware
app.UseMiddleware<LogRequest>();
app.UseMiddleware<ExceptionRequest>();
app.UseCors("AllowClientSide");

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();


app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
