using danielAmosServer_Core.BL;
using danielAmosServer_Core.BLInterfaces;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.Factory.Interfaces;

namespace danielAmosServer_Core.Helpers.Factory
{
    public class ManagerBLFactory : IManagerBLFactory
    {
        private readonly IManagerDAL managerDAL;
        private readonly IEmployeeDAL employeeDAL;

        public ManagerBLFactory(IManagerDAL managerDAL, IEmployeeDAL employeeDAL)
        {
            this.managerDAL = managerDAL;
            this.employeeDAL = employeeDAL;
        }

        public IManagerBL Create()
        {
            return new ManagerBL(managerDAL,employeeDAL);
        }
    }
}
