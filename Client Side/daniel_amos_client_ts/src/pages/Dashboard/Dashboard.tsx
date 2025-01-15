import { Container, Image, Row } from "react-bootstrap";
import { PersonalDetails } from "./components/PersonalDetails";
import { useEffect, useState } from "react";
import { ManagerDetails } from "./components/ManagerDetails";
import DashboardPic from "../../assets/images/dashboard.gif";
import './Dashboard.scss';
import { AppAuthData } from "../../App";
import { IManagerData } from "../../Interfaces/Api/IManagerData";
import { typeKindsLoadData } from "../../utils/generalVar";
import { CallApiGetAction } from "../../services/apiService";
import { ShowKindLoadData } from "../../components/webTools/ShowKindLoadData";


const motivationalQuotes = [
  "מנהיגות היא היכולת להפוך חזון למציאות",
  "הצלחה היא לא המפתח לאושר. אושר הוא המפתח להצלחה",
  "כל הישג מתחיל בהחלטה לנסות",
  "מנהיג טוב לוקח קצת יותר מהאשמה ומעט פחות מהקרדיט",
  "הדרך הטובה ביותר לנבא את העתיד היא ליצור אותו",
  "ההצלחה מתחילה במקום שבו נגמרת הא-zone שלך.",
  "הדרך להצלחה מלאה בעיקולים, אבל כל עיקול מקרב אותך אליה.",
  "אל תיתן לפחד להפסיק אותך, תן לו להניע אותך.",
  "הכי טוב מתחיל אחרי הרגע שבו אתה חושב שאתה לא יכול יותר.",
  "החלום שלך לא צריך להיות ענק, הוא רק צריך להיות שלך.",
  "אל תראה את מה שיש לך כבעיה, תראה את מה שיש לך כהזדמנות.",
  "הכוח שבך הוא לא בכמות שעשית, אלא במאמצים שהשקעת.",
  "תאמין בעצמך, גם כשהעולם לא מאמין בך.",
  "אם אתה לא הולך אחרי החלום שלך, מישהו אחר יעסוק בו.",
  "אתה לא נמדד בכמה פעמים אתה נופל, אלא בכמה פעמים אתה קם.",
  "החיים הם מסע, תיהנה מהדרך ולא רק מהיעד.",
  "הכישלון הוא לא סוף הדרך, הוא רק צעד בדרך להצלחה.",
  "היום הוא ההזדמנות שלך להתחיל מחדש.",
  "הגשם לא מפסיק את הצמיחה, הוא פשוט משפר אותה.",
  "תהיה החזון של עצמך במקום לחכות למישהו אחר להוביל אותך.",
  "הדבר היחיד שמגביל אותך הוא המחשבות שלך.",
  "במהלך החיים תמיד יהיו נפילות, אבל זה לא אומר שאתה לא תוכל לקום שוב.",
  "הכוח לא נמצא בתוצאה, אלא בתהליך.",
  "תעשה את הדברים שמפחידים אותך, כי שם נמצאת הגדולה.",
  "ההצלחה מתחילה עם המחשבות שלך, שינוי מחשבה = שינוי חיים.",
  "כל יום הוא הזדמנות חדשה לשנות את הדרך שלך.",
  "הכישלון הוא רק צעד נוסף בדרך להצלחה.",
  "תהיה תמיד האור בחיים של אחרים.",
  "המסע הארוך ביותר מתחיל בצעד הראשון.",
  "האמונה בעצמך היא הצעד הראשון למימוש החלום שלך.",
  "ההצלחה לא נמדדת בהישגים, אלא בנכונות שלך להמשיך למרות הקשיים.",
  "הגשם את המטרות שלך, גם כשזה קשה.",
  "תבחר לא רק להיות טוב, תבחר להיות הטוב ביותר.",
  "אל תפחד לשאול שאלות – זה מה שמוביל אותך לתשובות",
  "החיים הם לא מושלמים, אבל הם יכולים להיות טובים אם תעשה את ההשקעה הנכונה.",
];

const Dashboard = () => {

  const [quote, setQuote] = useState<string>('');
  const { user } = AppAuthData();
  const [managerEmployeeData, setManagerEmployeeData] = useState<IManagerData[]>([]);
  const [kindLoadData, setKindLoadData] = useState<typeKindsLoadData>("Wait");

  useEffect(() => {

    const GetManagerEmployeeData = async (): Promise<void> => {

      try {

        setManagerEmployeeData([]);
        setKindLoadData("Wait");

        const queryParams = new URLSearchParams({
          id: String(user?.id)
        });

        const jsonData = await CallApiGetAction(
          {
            serviceName: 'Manager',
            apiMethod: 'ManagerFullDataSelectByID',
            params: queryParams,
            token: user?.token
          }
        );
        
        if(jsonData.success)
        {
          setManagerEmployeeData(jsonData.data as IManagerData[]);
        }

      }
      catch (err) {
        console.log(err, "error");
        setKindLoadData("Error");
      }
    }
    // Selecting a random quote on component load.
    const randomQuote = motivationalQuotes[Math.floor(Math.random() * motivationalQuotes.length)];
    setQuote(randomQuote);

    // Switching the quote every 10 seconds.
    const interval = setInterval(() => {
      const newQuote = motivationalQuotes[Math.floor(Math.random() * motivationalQuotes.length)];
      setQuote(newQuote);
    }, 10000);

    GetManagerEmployeeData();
    return () => clearInterval(interval);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);



  return (
    <div className="page">
      <Container className="dashboardContent p-4">
        <div className="quoteSection mb-4 text-center">
          <h2 className="quoteText">"{quote}"</h2>
        </div>
        {
          managerEmployeeData.length > 0 ?
        <Row className="g-4">
          <PersonalDetails
            fullName={managerEmployeeData[0].fullName}
            email={managerEmployeeData[0].email}
            phone={managerEmployeeData[0].phone}
            created={managerEmployeeData[0].created.toString()}
            managerFullName={managerEmployeeData[0].managerFullName}
          />
          {user?.isAuthenticated &&
            (
              <ManagerDetails
                role={managerEmployeeData[0].role}
                department={managerEmployeeData[0].department}
                start={managerEmployeeData[0].start.toString()}
              />
            )}

        </Row>
        :
        ShowKindLoadData(kindLoadData)
       }
      </Container>
      <Container className="text-center">
        <br />
        <Image
          src={DashboardPic}
          style={{ width: "20vw", height: "22vh", marginBottom:"0.5vh" }}
          rounded
        />
        <br />
      </Container>
    </div>

  );
};

export default Dashboard;
