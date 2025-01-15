using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.DB;
using danielAmosServer_Core.Helpers.Service;
using Microsoft.Data.SqlClient;
using System.Data;

namespace danielAmosServer_Core.DAL
{
    /// <summary>
    /// The MiddlewareDAL class responsible for Calling the procedures and their data 
    /// According to the middleware' area.
    /// </summary>
    public class MiddlewareDAL : IMiddlewareDAL
    {
        private readonly string connectionString;
        private readonly IDataHelper dataHelper;

        public MiddlewareDAL(IDataHelper dataHelper)
        {
            // Reading Connection String from the XML
            connectionString = DbConfigReader.GetConnectionString();
            // Calling and executing helper functions for SQL services.
            this.dataHelper = dataHelper;
        }

        public async Task<List<Models.Log>> ActionInsert(Models.Log log)
        {
            SqlParameter[] sqlParameters = AppService.GenerateSqlParameters(log);
            DataTable? res = await dataHelper.ExecSPWithRes("Log_Insert", sqlParameters);
            List<Models.Log> logs;
            if (res != null)
            {
                logs = AppService.ConvertDataTableToList<Models.Log>(res);
            }
            else
            {
                logs = new List<Models.Log>();
            }
            return logs;
        }
    }
}
