Imports
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force 
 npx create-react-app . 
npm install
 npm start
npm install reactstrap
npm install  bootstrap
npm install yup
npm install react-hook-form
npm install @hookform/resolvers
npm install @reduxjs/toolkit react-redux


Home.js
import logo from "../Images/logo-t.png";
import Posts from "./Posts";
import SharePost from "./SharePost";
import User from "./User";
import { Container, Row, Col } from "reactstrap"; //import the Reactstrap Components

const Home = () => {
  return (
    <>
      <Row>
        <Col md={3}>
          <User />
        </Col>

        <Col md={9}>
          <SharePost />
        </Col>
      </Row>

      <Row>
        <Col md={3}>
        </Col>

        <Col md={9}>
          <Posts />
        </Col>
      </Row>
    </>
  );
};

export default Home;


Header.js
import { Navbar, NavItem, NavLink, Nav } from "reactstrap";
import logo from "../Images/logo-t.png";
import { Link } from "react-router-dom";

import { useSelector } from "react-redux";

const Header = () => {
  const cuser = useSelector((state) => state.users.user);
  return (
    <>
      <Navbar className="header">
        <Nav>
          <NavItem>
            <img src={logo} className="logo" />
          </NavItem>
          <NavItem>
            <Link to="/">Home</Link>
          </NavItem>

          <NavItem>
            <Link to="/profile">Profile</Link>
          </NavItem>

          <NavItem>
            <Link to="/login">Login</Link>
          </NavItem>

          <NavItem>Hi {cuser}!</NavItem>
        </Nav>
      </Navbar>
    </>
  );
};

export default Header;


Login.js
//import log from "../Images/loginImage.jpg";
import logo from "../Images/logo-t.png";

import { Link } from "react-router-dom";

import {
  Button,
  Input,
  FormGroup,
  Label,
  Col,
  Container,
  Form,
  Row,
} from "reactstrap";

const Login = () => {
  return (
    <div>
      <Container>
        <Form>
          <Row>
            <Col md={3}>
              <img src={logo} alt="" />
            </Col>
          </Row>

          <Row>
            <Col md={3}>
              <FormGroup>
                <Label for="email">Email</Label>
                <Input
                  id="email"
                  name="email"
                  placeholder="Enter email..."
                  type="email"
                />
              </FormGroup>
            </Col>
          </Row>

          <Row>
            <Col md={3}>
              <FormGroup>
                <Label for="password">Password</Label>
                <Input
                  id="password"
                  name="password"
                  placeholder="Enter email..."
                  type="password"
                />
              </FormGroup>
            </Col>
          </Row>

          <Row>
            <Col md={3}>
              <Button>Login</Button>
              <p className="smalltext">
                No Account? <Link to="/register">Sign Up now.</Link>
              </p>
            </Col>
          </Row>
        </Form>
      </Container>
    </div>
  );
};

export default Login;


register.js
import { Button, Col, Row, Container, Form } from "reactstrap";

import { userSchemaValidation } from "../Validations/UserValidations";
import * as yup from "yup";
import { useForm } from "react-hook-form";
import { yupResolver } from "@hookform/resolvers/yup";

import { useSelector, useDispatch } from "react-redux";
import { useState } from "react";
import { addUser, deleteUser, updateUser } from "../Features/UserSlice.js";

const Register = () => {
  const userList = useSelector((state) => state.users.value);
  const cuser = useSelector((state) => state.users.user);

  const [name, setname] = useState("");
  const [email, setemail] = useState("");
  const [password, setpassword] = useState("");
  const [confirmpassword, setconfirmpassword] = useState("");
  //setage1
  const [age1, setage1] = useState("");
  //setage2
  const [age2, setage2] = useState("");
  //setsalary
  const [salary, setsalary] = useState("0.00");

  //For form validation using react-hook-form
  const {
    register,
    handleSubmit, // Submit the form when this is called
    formState: { errors },
  } = useForm({
    resolver: yupResolver(userSchemaValidation), //Associate your Yup validation schema using the resolver
  });

  const dispatch = useDispatch();

  // Handle form submission
  const onSubmit = (data) => {
    try {
      // You can handle the form submission here
      const userData = {
        name: data.name,
        email: data.email,
        password: data.password,
      };

      console.log("Form Data", data); // You can handle the form submission here
      alert("Validation all good.");
      dispatch(addUser(userData)); //use the useDispatch hook to dispatch an action, passing as parameter the userData
    } catch (error) {
      console.log("Error.");
    }
  };

  const handleDelete = (email) => {
    dispatch(deleteUser(email));
  };

  const handleUpdate = (email) => {
    const userData = {
      name: name, //create an object with the values from the state variables
      email: email,
      password: password,
    };
    dispatch(updateUser(userData)); //use the useDispatch hook to dispatch an action, passing as parameter the userData
  };

  return (
    <div>
      <Container fluid>
        <Row className="formrow">
          <Col className="columndiv1" lg="6">
            <Form className="div-form" onSubmit={handleSubmit(onSubmit)}>
              <section className="form">
                <div className="form-group">
                  <input
                    type="text"
                    id="name"
                    className="form-control"
                    placeholder="Enter your name..."
                    {...register("name", {
                      onChange: (e) => setname(e.target.value),
                    })}
                  />
                  <p className="error">{errors.name?.message}</p>
                </div>

                <div className="form-group">
                  <input
                    type="text"
                    id="email"
                    className="form-control"
                    placeholder="Enter your email..."
                    {...register("email", {
                      onChange: (e) => setemail(e.target.value),
                    })}
                  />
                  <p className="error">{errors.email?.message}</p>
                </div>

                <div className="form-group">
                  <input
                    type="password"
                    id="password"
                    className="form-control"
                    placeholder="Enter your password..."
                    {...register("password", {
                      onChange: (e) => setpassword(e.target.value),
                    })}
                  />
                  <p className="error">{errors.password?.message}</p>
                </div>

                <div className="form-group">
                  <input
                    type="password"
                    id="confirmpassword"
                    className="form-control"
                    placeholder="Confirm your password..."
                    {...register("confirmpassword", {
                      onChange: (e) => setconfirmpassword(e.target.value),
                    })}
                  />
                  <p className="error">{errors.confirmpassword?.message}</p>
                </div>

                <div className="form-group">
                  <input
                    type="text"
                    id="age1"
                    className="form-control"
                    placeholder="Enter your age1..."
                    {...register("age1", {
                      onChange: (e) => setage1(e.target.value),
                    })}
                  />
                  <p className="error">{errors.age1?.message}</p>
                </div>

                <div className="form-group">
                  <input
                    type="text"
                    id="age2"
                    className="form-control"
                    placeholder="Enter your age2..."
                    {...register("age2", {
                      onChange: (e) => setage2(e.target.value),
                    })}
                  />
                  <p className="error">{errors.age2?.message}</p>
                </div>

                <div className="form-group">
                  <input
                    type="text"
                    id="salary"
                    className="form-control"
                    placeholder="Enter your salary..."
                    {...register("salary", {
                      onChange: (e) => setsalary(e.target.value),
                    })}
                  />
                  <p className="error">{errors.salary?.message}</p>
                </div>

                <Button color="primary" className="button">
                  Register
                </Button>
              </section>
            </Form>
          </Col>

          <Col className="columndiv1" lg="6"></Col>
        </Row>

        <Row>
          <Col md={6}>
            Current User: {cuser}
            <br />
            List of Users
            <table>
              <tbody>
                {userList.map((user) => (
                  <tr key={user.email}>
                    <td>{user.name}</td>
                    <td>{user.email}</td>
                    <td>{user.password}</td>
                    <td>
                      <Button onClick={() => handleDelete(user.email)}>
                        Delete User
                      </Button>
                      <Button onClick={() => handleUpdate(user.email)}>
                        Update User
                      </Button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </Col>
        </Row>
      </Container>
    </div>
  );
};

export default Register;


validation.js
import * as yup from "yup"; //import all exports from the yup

export const userSchemaValidation = yup.object().shape({
  name: yup.string().required("Name is required"),
  email: yup
    .string()
    .email("Not valid email format")
    .required("Email is required"),
  password: yup.string().min(4).max(20).required("Password is required"),
  confirmpassword: yup
    .string()
    .oneOf([yup.ref("password"), null], "Passwords Don't Match")
    .required(),

  age1: yup
    .number()
    .typeError("Value must be a number...")
    .integer("Value must an integer...")
    .required("Age is required...")
    .min(10)
    .max(18),

  age2: yup
    .string()
    .matches(/^\d+$/, "Value must be a whole number...") // Ensures only whole numbers
    .required("Age2 is required...")
    .test("is-integer", "Value must be an integer...", (value) => {
      if (!value) return false; // Ensure it's not empty
      return Number.isInteger(Number(value)); // Ensures it's a valid integer
    })
    .test("within-range", "Age must be between 10 and 18...", (value) => {
      const numValue = Number(value);
      return numValue >= 10 && numValue <= 18;
    }),

  salary: yup
    .string()
    .matches(/^\d+\.\d+$/, "Value must have a decimal value")
    .required("Salary is required...")
    .test("is-decimal", "Value must have a decimal value", (value) => {
      if (!value) return false;
      return /^\d+\.\d+$/.test(value); // Ensures it contains a decimal part
    }),
});


App.js
import { Container, Row } from "reactstrap";
import "./App.css";
//import About from "./Components/About";

import Home from "./Components/Home";
import Login from "./Components/Login";
import Profile from "./Components/Profile";

import "bootstrap/dist/css/bootstrap.min.css";
import Header from "./Components/Header";
import Footer from "./Components/Footer";
import Register from "./Components/Register";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";

const App = () => {
  return (
    <Container fluid>
      <Router>
        <Row>
          <Header />
        </Row>

        <Row className="main">
          <Routes>
            <Route path="/" element={<Home />}></Route>
            <Route path="/profile" element={<Profile />}></Route>
            <Route path="/login" element={<Login />}></Route>
            <Route path="/register" element={<Register />}></Route>
          </Routes>
        </Row>

        <Row>
          <Footer />
        </Row>
      </Router>
    </Container>
  );
};

export default App;


index.js
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

import { store } from "./Store/store.js";
import { Provider } from "react-redux";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <Provider store={store}>
    <React.StrictMode>
      <App />
    </React.StrictMode>
  </Provider>
);


UserSlice.js
import { createSlice } from "@reduxjs/toolkit";
import { UsersData } from "../Exampledata.js";

//const initialState = { value: [] }; //list of user is an object with empty array as initial value

const initialState = { value: UsersData, user: "Anthony" };

export const userSlice = createSlice({
  name: "users", //name of the state
  initialState, // initial value of the state
  reducers: {
    addUser: (state, action) => {
      state.value.push(action.payload); //add the payload to the state
    },
    deleteUser: (state, action) => {
      //create a new array with the value that excludes the user with the email value from the action payload, and assign the new array to the state.
      state.value = state.value.filter((user) => user.email !== action.payload);
    },
    updateUser: (state, action) => {
      state.value.map((user) => {
        //iterate the array and compare the email with the email from the payload;
        if (user.email === action.payload.email) {
          user.name = action.payload.name;
          user.password = action.payload.password;
        }
      });
    },
  },
});

export const { addUser, deleteUser, updateUser } = userSlice.actions; //export the function
export default userSlice.reducer;


Store.js
import { configureStore } from "@reduxjs/toolkit";
import usersReducer from "../Features/UserSlice.js";

export const store = configureStore({
  reducer: {
    users: usersReducer,
  },
});


Footer.js
import { useSelector } from "react-redux";
const Footer = () => {
  const cuser = useSelector((state) => state.users.user);
  return (
    <footer className="footer">
      <div> Hi {cuser}!</div>
    </footer>
  );
};

export default Footer;


Posts.js

const Posts = () => {
  return (
    <div className="postsContainer">
      <h1>Display Posts</h1>
    </div> /* End of posts */
  );
};

export default Posts;


SharePosts.js
import { Container, Row, Col, Input, Button } from "reactstrap";

const SharePosts = () => {
  return (
    <Container>
      <Row>
        <Col>
          <Input
            id="share"
            name="share"
            placeholder="Share your thoughts..."
            type="textarea"
          />
          <Button>PostIT</Button>
        </Col>
      </Row>
    </Container>
  );
};

export default SharePosts;


user.js
import user from "../Images/user.png";
const User = () => {
  return (
    <div>
      <img src={user} className="userImage" />
    </div>
  );
};

export default User;


ExampleData
export const UsersData = [
  {
    id: 1,
    name: "Jasmin Tumulak",
    email: "jasmine@utas.edu.om",
    password: "12345",
  },
  {
    id: 2,
    name: "Marian Malig-on",
    email: "marian@utas.edu.om",
    password: "12345",
  },
  {
    id: 3,
    name: "Ahmed Ali Jaboob",
    email: "ahmed@utas.edu.om",
    password: "12345",
  },
];


App.css
.header {
  display: flex;
  align-items: center; /* Vertically align items */
  padding: 10px;
  background-color: #f8f9fa;
}

.nav {
  display: flex;
  align-items: center; /* Vertically align items */
}

.logo {
  height: 50px; /* Adjust the logo size as needed */
}

.nav a {
  text-decoration: none; /* Remove underline */
  color: #000; /* Set text color */
  margin: 0 15px; /* Add spacing between links */
}

.nav a:hover {
  color: #007bff; /* Change color on hover (optional) */
}

.nav-link a {
  color: inherit;
  text-decoration: none;
}

/* ---original below --------*/
a {
  text-decoration: none;
}
a:link {
  color: rgb(255, 200, 0);
}

/* visited link */
a:visited {
  color: green;
}

/* mouse over link */
a:hover {
  color: hotpink;
}

.login {
  align-items: center;
  justify-content: center;
}
.div-form {
  border-style: solid;
  border-width: thin;
  font-size: 24px;
  padding-left: 50px;
  padding-right: 50px;
  padding-bottom: 10px;
  padding-top: 10px;
  background-color: rgb(252, 252, 252);
  border-radius: 10px;
  width: 100%;
  height: 100%;
  border-color: #a6d49f;
  margin-top: 10px;
  margin-bottom: 10px;
}

.login-form input {
  margin: 2px;
}
.smalltext {
  font-size: 14px;
  font-weight: bold;
  color: #522a27;
}

.columndiv1 {
  border-color: #a6d49f;
  font-size: xx-large;
  background-color: rgb(252, 252, 252);
  height: auto;
  display: flex;
  align-items: center;
  justify-content: center;
}
.columndiv2 {
  border-color: rgb(182, 179, 176);
  font-size: xx-large;
  height: auto;
  padding: 20px;
  /*   background-image: url("http://localhost:3000/image1.jpg");
  background-size: cover;
  background-repeat: no-repeat; */
}

.loginImage {
  height: 100%;
  width: 100%;
}
.appTitle {
  text-align: center;
  color: #c73e1d;
}
.formrow {
  background-color: #522a27;
  padding: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.side {
  display: flex;
  vertical-align: top;
}
.checkbox {
  width: 25px;
  height: 25px;
}
.button {
  text-align: center;
  padding: 10px;
  width: 100%;
  background-color: #c59849;
  border-style: none;
}
body {
  font-family: "Roboto", sans-serif;
  margin: 0;
}
.navigation {
  background-color: #9cb380;
  height: 75px;
  font-weight: bolder;
  color: #522a27;
}
.logo {
  width: 150px;
  height: 70px;
}
.footer {
  display: flex;
  background-color: #9cb380;
  height: 100px;
  color: #522a27;
  justify-content: center;
  align-items: center;
  font-weight: bolder;
  flex-shrink: 0;
}
.socialmedia {
  width: 100px;
  height: 100px;
}

.userImage {
  width: 100px;
  height: 100px;
  border-radius: 50%;
}
.userInfos {
  padding: 20px;
  text-align: center;
}

.page {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.main {
  flex-grow: 1;
  min-height: 500px;
}
.sharePosts {
  padding-top: 10px;
  height: 200px;
  border-style: solid;
  border-width: thin;
  margin-top: 10px;
  border-color: #a6d49f;
  text-align: center;
}
.inputPost {
  margin-right: 10px;
  width: 80%;
  border-color: #522a27;
}
.input-button-container {
  display: flex;
  align-items: center;
  justify-content: center;
}
.postButton {
  background-color: #522a27;
}
.dept {
  display: flex;
  flex-direction: row;
  margin-top: 10px;
}
.selectDept .selectDept {
  width: 10%;
}
.postUserImage {
  width: 50px;
  height: 50px;
  margin: 10px;
}

.postsContainer {
  display: flex;
  flex-direction: column;
}
.post {
  display: flex;
  flex-direction: column;

  height: auto;
  width: 100%;
}
.postMsg {
  padding: 20px;

  border: 1px solid rgb(244, 241, 241);
}
.postedBy {
  padding: 10px;
  background-color: rgb(236, 238, 236);
  border-radius: 10px;
}
.postByName {
  font-weight: bolder;
  font: optional;
}
.postDate {
  margin-left: 5px;
}
.navs {
  padding: 10px;
}
.userName {
  font-weight: bold;
}
.likes {
  padding: 5px;
}

.error {
  color: red;
  font-size: small;
}


Another activity
export const UsersData = [
  {
    id: 1,
    name: "Jasmin Tumulak",
    email: "jasmine@utas.edu.om",
    password: "12345",
  },
  {
    id: 2,
    name: "Marian Malig-on",
    email: "marian@utas.edu.om",
    password: "12345",
  },
  {
    id: 3,
    name: "Ahmed Ali Jaboob",
    email: "ahmed@utas.edu.om",
    password: "12345",
  },
];


Validation
import * as yup from "yup"; //import all exports from the yup

export const myUserSchemaValidation = yup.object().shape({
  empname: yup.string().required("Name is required"),
  empno: yup.string().required("Name is required"),

  age: yup
    .string()
    .matches(/^\d+$/, "Value must be a whole number...") // Ensures only whole numbers
    .required("Age is required...")
    .test("is-integer", "Value must be an integer...", (value) => {
      if (!value) return false; // Ensure it's not empty
      return Number.isInteger(Number(value)); // Ensures it's a valid integer
    })
    .test("within-range", "Age must be between 18 and 35...", (value) => {
      const numValue = Number(value);
      return numValue >= 18 && numValue <= 35;
    }),

  bsalary: yup
    .string()
    .matches(/^\d+\.\d+$/, "Value must have a decimal value")
    .required("Basic Salary is required...")
    .test("is-decimal", "Value must have a decimal value", (value) => {
      if (!value) return false;
      return /^\d+\.\d+$/.test(value); // Ensures it contains a decimal part
    }),

  allowances: yup
    .string()
    .matches(/^\d+\.\d+$/, "Value must have a decimal value")
    .required("Allowances is required...")
    .test("is-decimal", "Value must have a decimal value", (value) => {
      if (!value) return false;
      return /^\d+\.\d+$/.test(value); // Ensures it contains a decimal part
    }),
});


Emplist.js
import { Button, Col, Row, Container, Form } from "reactstrap";
import { useSelector, userDipatch } from "react-redux";
import { empData } from "../EmployeeRecords";
const Emplist = () => {
  const empList = useSelector((state) => state.emp.value);

  return (
    <div>
      <h1>Employee Listing</h1>
      <Row>
        <Col md={6}>
          <br />
          List Of employee
          <table>
            <tbody>
              {empList.map((emp) => (
                <tr>
                  <td>{emp.empname}</td>
                  <td>{emp.empno}</td>
                  <td>{emp.department}</td>
                  <td>{emp.age}</td>
                  <td>{emp.bsalary}</td>
                  <td>{emp.allowances}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </Col>
      </Row>
    </div>
  );
};

export default Emplist;



