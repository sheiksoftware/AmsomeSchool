import 'package:amsome_school/pages/schoolHomePage.dart';
import 'package:amsome_school/utils/backgroundPaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amsome_school/model/school_model.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatefulWidget {

  final bool isPhone;

  LoginPage({this.isPhone});

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class Codes{
  Codes(this.code, this.country);
  final String code;
  final String country;
}

class LoginPageState extends State<LoginPage> {

  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
  TextStyle hintStyle = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white70);

  TextEditingController emailPhoneInputController =  new TextEditingController();
  TextEditingController passwordController =  new TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool isSuccess = false;

  String selectedCode;
  List<Codes> codeList = <Codes>[
    Codes("+91", "India"),
    Codes("+55", "Brazil"),
    Codes("+1", "Canada"),
    Codes("+33", "France"),
    Codes("+49", "Germany"),
    Codes("+966", "Saudi Arabia"),
    Codes("+27", "South Africa"),
    Codes("+90", "Turkey"),
    Codes("+971", "UAE"),
    Codes("+1", "United States"),
    Codes("+44", "United Kingdom"),
  ];

  String emailValidator(String iString){

    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = new RegExp(pattern);

    if(!regex.hasMatch(iString)){
      return 'Email is invalid';
    }
    else
    {
      return null;
    }

  }

  String phoneValidator(String iString){

    Pattern pattern = r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';

    RegExp regex = new RegExp(pattern);

    if(!regex.hasMatch(iString)){
      return 'Phone Number is invalid';
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
        ),
      ),
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraint){
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SafeArea(
                      child: Form(
                        key: _loginFormKey,
                        child: ScopedModelDescendant<SchoolModel>(
                          builder: (context, child, model){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 50.0,
                                ),
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
                                                  color: Colors.white,
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
                                                      color: Colors.white),
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
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      (widget.isPhone) ? Container(
                                        color: Colors.blue,
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              canvasColor: Colors.white,
                                            ),
                                            child: DropdownButton<String>(
                                              elevation: 5,
                                              hint: Text("Select Country", style: hintStyle,),
                                              value: selectedCode,
                                              onChanged: (String value){
                                                setState(() {
                                                  selectedCode = value;
                                                });
                                              },
                                              items: codeList.map((Codes eachCode){
                                                return DropdownMenuItem<String>(
                                                  value: eachCode.code + " " + eachCode.country,
                                                  child: Text(eachCode.code + " " + eachCode.country, style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black.withAlpha(150)),),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ) : Container(),
                                      (widget.isPhone) ? SizedBox(
                                        height: 10.0,
                                      ): Container(),
                                      TextFormField(
                                        style: style,
                                        controller: emailPhoneInputController,
                                        cursorColor: Colors.black,
                                        validator: (widget.isPhone) ? phoneValidator : emailValidator,
                                        decoration: InputDecoration(
                                          labelText: (widget.isPhone) ? "Phone Number" : "Email",
                                          labelStyle: hintStyle,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white70),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      TextFormField(
                                        style: style,
                                        //key: passKey,
                                        controller: passwordController,
                                        obscureText: true,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white70),
                                          ),
                                          labelText: "Enter Password",
                                          labelStyle: hintStyle,
                                        ),
                                        validator: (value){
                                          if(value.length < 6){
                                            return "Please enter minimum 6 characters";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2,
                                        height: 45.0,
                                        child: RaisedButton(
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                          ),
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 25.0,
                                                color: Colors.blue),
                                          ),
                                          onPressed: () async {
                                            if(_loginFormKey.currentState.validate())
                                            {
                                              final email = emailPhoneInputController.text.toString().trim();
                                              final password = passwordController.text.toString().trim();

                                              Widget page;
                                              try{
                                                page = FutureBuilder(
                                                  future: model.loginUserwithEmail(email, password),
                                                  builder: (context, snapshot){
                                                    if (snapshot.hasError){
                                                      return Scaffold(backgroundColor: Colors.white, body: Center(child: Text(snapshot.error.toString())));
                                                    }
                                                    else if(snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                                      return SchoolHomePage();
                                                    }
                                                    else if(snapshot.connectionState == ConnectionState.done && snapshot.data == null){
                                                      return Scaffold(backgroundColor: Colors.white,
                                                          body: CustomPaint(
                                                            painter: BackgroundPaint(),
                                                            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Text("Error Login. Please check your credentials or connection", textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
                                                                  SizedBox(height: 10.0),
                                                                  RaisedButton(
                                                                    color: Colors.blue,
                                                                    elevation: 20.0,
                                                                    onPressed: (){
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Text(
                                                                      "BACK",
                                                                      style: TextStyle(color: Colors.white),
                                                                    ),),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    }
                                                    else{
                                                      return Scaffold(
                                                        backgroundColor: Colors.white,
                                                        body: CustomPaint(
                                                          painter: BackgroundPaint(),
                                                          size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: <Widget>[
                                                                new CircularProgressIndicator(backgroundColor: Colors.black,),
                                                                new SizedBox(height: 20.0,),
                                                                new Text("Loading", style: TextStyle(color: Colors.black),),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                );
                                              } on PlatformException catch(err){
                                                print("printing the exception now : " + err.toString());
                                              }

                                              if(page != null){
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (context)
                                                      {
                                                        return page;
                                                      },
                                                    ));
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      (widget.isPhone) ? FlatButton(
                                        onPressed: (){},
                                        child: Text(
                                          "Send OTP for Phone Login",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 18.0,
                                              color: Colors.white70),
                                        ),
                                      ) : Container(),
                                      FlatButton(
                                        onPressed: (){

                                        },
                                        child: Text(
                                            "Forgot Password ?",
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                fontFamily: 'Montserrat',
                                                fontSize: 18.0,
                                                color: Colors.white70)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        ),
    );
  }
}
