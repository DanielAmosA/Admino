import { Container, Row, Col, Button, Card } from "react-bootstrap";
import MotivationCatDogPic from "../../assets/images/motivationCatDog.gif";
import MotivationDogPic from "../../assets/images/motivationDog.gif";
import MotivationGirlPic from "../../assets/images/motivationGirl.gif";
import MotivationMorningsPic from "../../assets/images/motivationMornings.gif";
import motivationPingiPic from "../../assets/images/motivationPingi.gif";
import MotivationSpongPic from "../../assets/images/motivationSpong.gif";
import ShilaWorkVideo from '../../assets/videos/WorkVideo.mp4';

import "./HomePage.scss";

export const HomePage = () => {
    
    return (
        <div className="page">
            <header className="homePageHeader">
                <Container>
                    <div className="infoBox">
                        <h3 className="homePageHeaderTitle">ניהול נט</h3>
                        <p className="homePageHeaderDesc">נהל את החברה בקליק</p>
                        <p className="homePageHeaderDesc">
                        האתר הוא פלטפורמת ניהול מתקדמת המיועדת למנהלים ולעובדים.
                        <br/>
                        הוא מאפשר למנהלים לנהל את הצוותים שלהם בצורה יעילה, לעקוב אחרי עובדים, להקצות משימות, ולבצע ניהול משאבים בצורה חכמה.
                        <br/>
                        המטרה היא לשפר את האפקטיביות של הצוותים ולהעצים את המנהלים עם כלים שמפשטים את התהליכים ומסייעים בקבלת החלטות ומשימות.
                       </p>
                    </div>
                </Container>
            </header>

            <Container className="servicesSection">
                <Row className="text-center servicesSectionTopRow">
                    <Col className="servicesSectionTopCol">
                        <h2 className="servicesTitle">רגעי מוטיבציה</h2>
                        <p className="servicesDescription">
                        מקום השראה שבו סרטוני וציטוטי מוטיבציה מעוררים אותך להגיע להצלחה!
                        </p>
                    </Col>
                </Row>

                <Row className="gy-4 servicesSectionContentRow">
                    {[
                        {
                            title: "שעת סיפור",
                            description: "7 סיפורים מעוררי השראה שייכנסו לכם עמוק ללב",
                            image: MotivationCatDogPic,
                            link: "https://www.mako.co.il/tv-special/stories_from_the_heart/Article-ebd9bfbed120171027.htm",
                        },
                        {
                            title: "מה אמרת ?",
                            description: "משפטי מוטיבציה: מעל 100 משפטים מעוררי השראה של גיבורים ועוד",
                            image: MotivationGirlPic,
                            link: "https://nlp-il.co.il/%D7%9E%D7%94-%D7%96%D7%94-nlp/%D7%9E%D7%A9%D7%A4%D7%98%D7%99-%D7%9E%D7%95%D7%98%D7%99%D7%91%D7%A6%D7%99%D7%94/",
                        },
                        {
                            title: "ריילס או רייל",
                            description: "עמוד האינסטגרם שיכיל כל מידע וסרטון מעורר השראה שתרצה , 5 דקות ביום שישנו לך את החיים",
                            image: MotivationMorningsPic,
                            link: "https://www.instagram.com/ildailymotivation/",
                        },
                        {
                            title: "השראה בואי אליי",
                            description:"השראה בתקופה מורכבת: 5 טכניקות לשמירה על מוטיבציה ופרודוקטיביות",
                            image: MotivationSpongPic,
                            link: "https://www.operationlp.com/%D7%9E%D7%95%D7%98%D7%99%D7%91%D7%A6%D7%99%D7%94/%D7%94%D7%A9%D7%A8%D7%90%D7%94/"
                        },
                        {
                            title: "קדימה להתפתח",
                            description: "5 השלבים לפיתוח מוטיבציה, כוח רצון והתמדה",
                            image: motivationPingiPic,
                            link: "https://www.shaharcohen.co.il/psychology/motivation/",
                        },
                        {
                            title: "זמן השערה",
                            description:"מהי מוטיבציה, איך נמדוד ואיך נטפח אותה?",
                            image: MotivationDogPic,
                            link: "https://business-excellence.co.il/blog/1015-17-18?srsltid=AfmBOor-4M8wzGQ90rkz1hiQBfp4AEwJsCsrb2SMy1bnXhUMPlMlsv07",
                        }

                    ].map((service, index) => (
                        <Col key={index} md={4} className="servicesSectionContentCol">
                            <Card className="serviceCard">
                                <Card.Img
                                    variant="top"
                                    src={service.image}
                                    className="serviceImage"
                                />
                                <Card.Body className="servicesSectionContentBody">
                                    <Card.Title className="serviceTitle">
                                        {service.title}
                                    </Card.Title>
                                    <Card.Text className="serviceDescription">
                                        {service.description}
                                    </Card.Text>
                                    <Button
                                        variant="primary"
                                        className="serviceButton"
                                        onClick={() => window.location.href = service.link}
                                    >
                                        לפרטים נוספים
                                    </Button>
                                </Card.Body>
                            </Card>
                        </Col>
                    ))}
                </Row>
                <Row className="gy-6 videoContainerRow">
                    <div className="videoContainer">
                        <video controls className="serviceVideo">
                            <source src={ShilaWorkVideo} type="video/mp4" />
                            הדפדפן שלך לא תומך בסרטונים.
                        </video>
                    </div>
                </Row>
            </Container>
        </div>
    );
};
