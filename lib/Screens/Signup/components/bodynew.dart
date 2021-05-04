import 'dart:convert';
import 'package:propertygram_2021/Screens/Login/login_screen.dart';
import 'package:propertygram_2021/constants.dart';
import 'package:propertygram_2021/components/text_field_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:propertygram_2021/Screens/Login/components/background.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.32,
              ),

              //username
              TextFieldContainer(
                child: TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.text,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    hintText: "Enter Your Username",
                    border: InputBorder.none,
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter Your Username";
                    }

                    return null;
                  },
                  onSaved: (String name) {},
                ),
              ),

              //email
              TextFieldContainer(
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    hintText: "Enter Your Email",
                    border: InputBorder.none,
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter Your Email";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  onSaved: (String email) {},
                ),
              ),
              //Phone
              TextFieldContainer(
                child: TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.text,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: kPrimaryColor,
                    ),
                    hintText: "Enter Your Phone",
                    border: InputBorder.none,
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter Your Phone";
                    }
                    if (value.length < 9) {
                      return "Please Enter Valid Phone Number";
                    }
                    return null;
                  },
                  onSaved: (String phone) {},
                ),
              ),

              //password
              TextFieldContainer(
                child: TextFormField(
                  controller: _password,
                  keyboardType: TextInputType.text,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    hintText: "Enter Your Password",
                    border: InputBorder.none,
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please Enter Your Password";
                    }

                    return null;
                  },
                ),
              ),
              //confirm password

              TextFieldContainer(
                child: TextFormField(
                  controller: _confirmpassword,
                  keyboardType: TextInputType.text,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    hintText: "Confirm Your Password",
                    border: InputBorder.none,
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Confirm Your Password";
                    }
                    if (_password.text != _confirmpassword.text) {
                      return "Password Do not match";
                    }

                    return null;
                  },
                ),
              ),

              SizedBox(
                width: 200,
                height: 50,
                child: RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      registrationUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      print("Successful");
                    } else {
                      print("Unsuccessfull");
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.blue, width: 2)),
                  textColor: Colors.white,
                  child: Text("Submit"),
                ),
              ),
              //End of sized
            ],
          ),
        ),
      ),
    );
  }

  Future registrationUser() async {
    // url to registration php script
    var apiUrl =
        "https://www.ireproperty.com/promo/propertygram/registration.php";
    //json maping user entered details
    Map mapeddate = {
      'name': _name.text,
      'email': _email.text,
      'phone': _phone.text,
      'password': _password.text
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(apiUrl, body: mapeddate);
    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    print("DATA: $data");
  }
}
