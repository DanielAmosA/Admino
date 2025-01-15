using danielAmosServer_Core.DAL;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.Enum;
using Serilog;

namespace danielAmosServer_Core.Helpers.Middleware
{
    /// <summary>
    /// The class responsible for logs.
    /// </summary>

    public class LogRequest
    {
        private readonly IMiddlewareDAL middlewareDAL;
        private readonly RequestDelegate next;

        public LogRequest(RequestDelegate next, IMiddlewareDAL middlewareDAL)
        {
            // Go tracking of the HTTP.
            this.next = next;
            this.middlewareDAL = middlewareDAL;
        }

        public async Task InvokeAsync(HttpContext httpContext)
        {
            var request = httpContext.Request;

            // Info Log
            Log.Information($"Incoming request: {request.Method} {request.Path}");

            Models.Log log = new Models.Log
            {
                Created = DateTime.UtcNow,
                Type = LogType.Info.ToString(),
                Info = request.Method,
                RequestData = request.Path,
            };

            await middlewareDAL.ActionInsert(log);
            try
            {
                await next(httpContext);
            }
            catch (Exception ex)
            {
                //Error Log
                Log.Error(ex, "An error occurred while processing the request");
                throw;
            }
        }
    }
}
