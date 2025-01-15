using Microsoft.Data.SqlClient;
using System.Data;

namespace danielAmosServer_Core.Helpers.DB
{
    public interface IDataHelper
    {
        Task<object?> ExecSPAsScalar(string storedProcedureName, SqlParameter[] parameters);
        Task<bool> ExecSPWithoutRes(string storedProcedureName, SqlParameter[] parameters);
        Task<DataTable?> ExecSPWithRes(string storedProcedureName, SqlParameter[] parameters);
    }
}