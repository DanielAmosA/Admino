using Azure.Core;
using danielAmosServer_Core.DAL;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.CustomException;
using danielAmosServer_Core.Helpers.Enum;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;

namespace danielAmosServer_Core.Helpers.Middleware
{
    /// <summary>
    /// The class responsible for erros.
    /// </summary>
    /// 
    public class ExceptionRequest
    {
        private readonly RequestDelegate next;
        private readonly IMiddlewareDAL middlewareDAL;

        public ExceptionRequest(RequestDelegate next, IMiddlewareDAL middlewareDAL)
        {
            // Tracking errors.
            this.next = next;
            this.middlewareDAL = middlewareDAL;

        }

        //Creating a general error handling function, including creating the log.
        private async Task HandleExceptionAsync(HttpContext context, Exception ex, string info)
        {
            context.Response.StatusCode = ex is Exception ? 500 : context.Response.StatusCode;
            context.Response.ContentType = "application/json";

            var errorResponse = new { message = ex.Message };
            await context.Response.WriteAsync(JsonConvert.SerializeObject(errorResponse));

            Models.Log log = new Models.Log
            {
                Created = DateTime.UtcNow,
                Type = LogType.Error.ToString(),
                Info = info,
                ExceptionData = ex.Message
            };

            await middlewareDAL.ActionInsert(log);
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await next(context);
            }
            catch (CreateException ex)
            {
                await HandleExceptionAsync(context, ex, "CreateException");
            }
            catch (DeleteException ex)
            {
                await HandleExceptionAsync(context, ex, "DeleteException");
            }
            catch (FieldsException ex)
            {
                await HandleExceptionAsync(context, ex, "FieldsException");
            }
            catch (NotFoundException ex)
            {
                await HandleExceptionAsync(context, ex, "NotFoundException");
            }
            catch (SqlException ex)
            {
                await HandleExceptionAsync(context, ex, "SqlException");
            }
            catch (UpdateException ex)
            {
                await HandleExceptionAsync(context, ex, "UpdateException");
            }
            catch (Exception ex)
            {
                await HandleExceptionAsync(context, ex, "Exception");
            }
        }
    }
}
