import { useState } from "react";
import { Container, Card, Form, Button, Image } from "react-bootstrap";
import {
  User,
  StepForward,
  BookType
} from "lucide-react";
import CreatePic from "../../assets/images/create2.png";
import "../../styles/webForm.scss";
import { ValidateDescription, ValidateType } from "../../utils/validFun";
import { ShowWarningDialog } from "../../components/webTools/ShowWarningDialog";
import { ShowSuccessDialog } from "../../components/webTools/ShowSuccessDialog";
import { IAction } from "../../Interfaces/Api/IAction";
import { CallApiPostAction } from "../../services/apiService";
import { AppAuthData } from "../../App";

export const CreateNewAction = () => {

  // #region Hook and Members

  const [type, setType] = useState<string>("");
  const [typeError, setTypeError] = useState<string>("");

  const [description, setDescription] = useState<string>("");
  const [descriptionError, setDescriptionError] = useState<string>("");

  const [showWarning, setShowWarning] = useState<boolean>(false);
  const [msgWarning, setMsgWarning] = useState<string>('');
  const [showSuccess, setShowSuccess] = useState<boolean>(false);

  const { user } = AppAuthData();

  const HandleTypeChange = (value: string) => {
    setType(value);
    const err = ValidateType(value);
    setTypeError(err);

  };

  const HandleDescriptionChange = (value: string) => {
    setDescription(value);
    const err = ValidateDescription(value);
    setDescriptionError(err);

  };

  // Checking if all the entered data is correct and proceeding to the next step.

  const HandleSubmit = async (e: React.FormEvent<HTMLFormElement>): Promise<void> => {
    e.preventDefault();

    if (
      descriptionError === "" &&
      typeError === ""
    ) {
      try {
        const actionData: IAction = {
          type: type,
          description: description

        };

        const jsonData = await CallApiPostAction({
          serviceName: 'Manager',
          apiMethod: 'ActionInsert',
          body: actionData,
          token: user?.token
        });
        const actionInsert = jsonData;
        if (!actionInsert.success) {
          if (actionInsert.error)
            setMsgWarning(actionInsert.error!)
          else
            setMsgWarning("Oppps Error at create action service");
          setShowWarning(true);
          return;
        }
        else {
          setShowSuccess(true);
        }

      }

      catch (err) {
        console.log(err, "error");
        setShowWarning(true);
      }
    }

  };

  // Dialog Action
  const GetUserChoiceOnError = (): void => {
    setShowWarning(false);
  }

  const GetUserChoiceOnSuccess = (): void => {
    setShowSuccess(false);
  }

  return (
    <div className="page">
      <Container className="webContainer py-5">
        <Card className="webCard">
          <Card.Body className="webCardBody">
            <div className="titleContainer mb-4">
              <div className="titleIcon">
                <User size={32} />
              </div>
              <h2 className="titleDesc">צור פעולה חדשה 🎡</h2>
            </div>

            <Form onSubmit={HandleSubmit}>
              <div className="webFormFields">

                <Form.Group
                  controlId="formCreatedType"
                  className="webFormField">
                  <div className="webFormFieldIcon">
                    <StepForward size={20} />
                  </div>
                  <Form.Control
                    type="text"
                    placeholder="הכנס סוג פעולה"
                    value={type}
                    onChange={(e) => HandleTypeChange(e.target.value)}
                    isInvalid={!!typeError}
                    autoComplete="type"
                    required
                    className="webFormFieldControl"
                  />
                  <Form.Control.Feedback type="invalid">
                    {typeError}
                  </Form.Control.Feedback>
                </Form.Group>

                <Form.Group
                  controlId="formCreatedDescription"
                  className="webFormField">
                  <div className="webFormFieldIcon">
                    <BookType size={20} />
                  </div>
                  <Form.Control
                    type="text"
                    placeholder="הכנס תיאור פעולה"
                    value={description}
                    onChange={(e) => HandleDescriptionChange(e.target.value)}
                    isInvalid={!!descriptionError}
                    autoComplete="description"
                    required
                    className="webFormFieldControl"
                  />
                  <Form.Control.Feedback type="invalid">
                    {descriptionError}
                  </Form.Control.Feedback>
                </Form.Group>


              </div>

              <Button type="submit" className="btnSubmit">
                הוסף פעולה
              </Button>
              <Container className="text-center">
                <br />
                <Image
                  className="webFormImg"
                  src={CreatePic}
                  rounded
                />
              </Container>
            </Form>
          </Card.Body>
        </Card>
      </Container>
      {
        showWarning &&
        (
          ShowWarningDialog("אזהרה ביצירת פעולה 📛",
            <>{msgWarning}</>,
            GetUserChoiceOnError,
            "Ok"
          )
        )
      }

      {
        showSuccess &&
        (
          ShowSuccessDialog("יצירת פעולה צלחה❇️",
            <>הפעולה התווספה למערכת, עכשיו הכל זורם! 🔄🚀</>,
            GetUserChoiceOnSuccess,
            "Ok"
          )
        )
      }
    </div>
  );
};
