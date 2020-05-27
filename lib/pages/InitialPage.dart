import 'package:amsome_school/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:amsome_school/pages/signupPage.dart';
import 'package:amsome_school/pages/schoolHomePage.dart';

class InitialPage extends StatelessWidget {

  final TextStyle style =
  TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "AMSOME",
                              softWrap: true,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 40.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "School Management App",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.0,
                                    color: Colors.blue),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                child: RaisedButton(
                  elevation: 5.0,
                  color: Colors.blue,
                  child: Text("Login with Phone", style: style,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  onPressed: (){
                    return Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(isPhone: true,),
                        ));
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                child: RaisedButton(
                  elevation: 5.0,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Text("Login with Email", style: style,),
                  onPressed: (){
                    return Navigator.push(context,
                        MaterialPageRoute(
                          //builder: (context) => LoginPage(isPhone: false,),
                          builder: (context) => SchoolHomePage(),
                        ));
                  },
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Not a member,",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                        color: Colors.blue),
                  ),
                  FlatButton(
                    onPressed: (){
                      return showDialog( context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context){
                          return SimpleDialog(
                            elevation: 10.0,
                            backgroundColor: Colors.white70,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            ),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                                child: RaisedButton(
                                  onPressed: (){
                                    return Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpPage(isPhone: false,),
                                        ));
                                  },
                                  child: Text("Register with Email",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 18.0,
                                        color: Colors.white70),
                                  ),
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                child: RaisedButton(
                                  onPressed: (){
                                    return Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpPage(isPhone: true,),
                                        ));
                                  },
                                  child: Text("Register with Phone",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 18.0,
                                          color: Colors.white70)),
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }

}