using danielAmosServer_Core.Models;

namespace danielAmosServer_Core.DALInterfaces
{
    /// <summary>
    /// The IMiddlewareDAL interface responsible for Structure declaration for MiddlewareDAL
    /// </summary>
    public interface IMiddlewareDAL
    {
        Task<List<Models.Log>> ActionInsert(Log log);
    }
}
