import { Col, Container, Image, Row } from "react-bootstrap"
import { typeKindsLoadData } from "../../utils/generalVar"
import waitImg from '../../assets/images/loading.png';
import waitImg2 from '../../assets/images/loading2.png';
import errorLoadImg from '../../assets/images/error3.gif';
import './ShowKindLoadData.scss'

// Displaying an details about the data being loaded / received / failed
export const ShowKindLoadData = (kind: typeKindsLoadData): JSX.Element => {
    if (kind === "Wait") {
      return (
        <Container className="text-center mainKindLoadData">
          <Row className="justify-content-md-center">
            <Col xs={12} md={6}>
              <p className='mainKindLoadDataTitle'>כמה רגעים, אנחנו מכינים את הכל למהלך המושלם! 🚀✨ </p>
              <Image className='mainKindLoadDataImg' src={waitImg} alt="waitImg" rounded />
            </Col>
          </Row>
        </Container>
      )
    }
    else if (kind === "Error") {
      return (
        <Container className="text-center mainKindLoadData">
          <Row className="justify-content-md-center">
            <Col xs={12} md={6}>
              <p className='mainKindLoadDataTitle'>אופס! נראה שהמידע בורח לנו... 🕵️‍♂️💨</p>
              <Image className='mainKindLoadDataImg' src={errorLoadImg} alt="errorLoadImg" rounded />
            </Col>
          </Row>
        </Container>
      )
    }
  
    else {
      return (
        <Container className="text-center mainKindLoadData">
          <Row className="justify-content-md-center">
            <Col xs={12} md={6}>
              <p className='mainKindLoadDataTitle'>אלוהי כל השפרות איך הגעת לפה ? אנחנו נפצפץ פצפצים ונחזור אלייך 💡🌠</p>
              <Image className='mainKindLoadDataImg' src={waitImg2} alt="waitImg" rounded />
            </Col>
          </Row>
        </Container>
      )
    }
  
  }
  