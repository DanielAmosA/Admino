import { INavigationPart } from '../../Interfaces/Structure/INavigationPart';
import { LogIn } from '../../pages/LogIn/LogIn';
import { SignUp } from '../../pages/SignUp/SignUp';
import { HomePage } from '../../pages/HomePage/HomePage';
import Dashboard from '../../pages/Dashboard/Dashboard';
import { CreateNewEmployee } from '../../pages/CreateNewEmployee/CreateNewEmployee';
import { CreateNewAction } from '../../pages/CreateNewAction/CreateNewAction';
import { AddActionToEmployee} from '../../pages/AddHistoryEmployee/AddActionToEmployee';
import { SearchEmployee } from '../../pages/SearchEmployee/SearchEmployee';
import { SearchLog } from '../../pages/SearchLog/SearchLog';
import { ShowMyHistory } from '../../pages/ShowMyHistory/ShowMyHistory';
import { PageNotFound } from '../../pages/PageNotFound/PageNotFound';

// Array of routes

export const NavWeb : INavigationPart[] = [
        {path: "/", name:"עמוד הבית",element:<HomePage/>,isNeedAuth:false,isPrivate:false,isInMenu:true},
        {path: "/login", name:"התחבר",element:<LogIn/>,isNeedAuth:false,isPrivate:false,isInMenu:true},
        {path: "/signUp", name:"הרשם",element:<SignUp/>,isNeedAuth:false,isPrivate:false,isInMenu:true},
        {path: "/", name:"התנתק",element:<HomePage/>,isNeedAuth:false,isPrivate:true,isInMenu:true},
        {path: "/Dashboard", name:"Dashboard",element:<Dashboard/>,isNeedAuth:false,isPrivate:true,isInMenu:true},
        {path: "/SearchEmployee", name:"חפש עובד",element:<SearchEmployee/>,isNeedAuth:true,isPrivate:true,isInMenu:true},
        {path: "/AddActionToEmployee/:id", name:"הוסף פעולה לעובד",element:<AddActionToEmployee/>,isNeedAuth:true,isPrivate:true,isInMenu:false},
        {path: "/CreateNewEmployee", name:"צור עובד חדש",element:<CreateNewEmployee/>,isNeedAuth:true,isPrivate:true,isInMenu:true},
        {path: "/CreateNewAction", name:"צור פעולה חדשה",element:<CreateNewAction/>,isNeedAuth:true,isPrivate:true,isInMenu:true},
        {path: "/SearchLog", name:"הצג מידע מערכת",element:<SearchLog/>,isNeedAuth:true,isPrivate:true,isInMenu:true},
        {path: "/ShowMyHistory", name:"הצג היסטוריה",element:<ShowMyHistory/>,isNeedAuth:false,isPrivate:true,isInMenu:true},
        {path: "*", name:"עמוד לא נמצא",element:<PageNotFound/>,isNeedAuth:false,isPrivate:false,isInMenu:false},
    ]