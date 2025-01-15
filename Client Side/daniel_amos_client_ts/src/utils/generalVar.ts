// Saving the types of log
export type typeLog = 'Error' | 'Info';

// Saving the names of the controllers and their corresponding services.

export type typeServiceName = 'Auth' | 'Employee' | 'Manager';
export type typeApiMethod = 'GenerateToken' |
                             'GetThePasswordByEmail' | 'SelectByEmailAndPassword' | 'SelectByContaintsFullName' | 'EmployeeInsert'|
                             'EmployeeDelete' | 'EmployeeUpdate' | 'ManagerFullDataSelectByID' |
                             'ManagerSelect' | 'ManagerWithEmployeeSelect' | 'SelectByManager' | 'ManagerInsert' | 'LogSelectByType' |
                             'HistoryInsert' | 'HistorySelectByEmployeeID' | 'ActionInsert' | 'ActionSelect';

  
 // Saving the data for loads and dialogs                          
export type typeKindsLoadData = 'Wait' | 'Error';
export type dialogActions = (choice?: string) => void;
export type kindButtons = 'YesNo' | 'Ok';

