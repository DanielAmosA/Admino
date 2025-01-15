using danielAmosServer_Core.BL;
using danielAmosServer_Core.BLInterfaces;
using danielAmosServer_Core.DALInterfaces;
using danielAmosServer_Core.Helpers.Factory.Interfaces;

namespace danielAmosServer_Core.Helpers.Factory
{
    public class EmployeeBLFactory : IEmployeeBLFactory
    {
        private readonly IEmployeeDAL employeeDAL;

        public EmployeeBLFactory(IEmployeeDAL employeeDAL)
        {
            this.employeeDAL = employeeDAL;
        }

        public IEmployeeBL Create()
        {
            return new EmployeeBL(employeeDAL);
        }
    }
}
