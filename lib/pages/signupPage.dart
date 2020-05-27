import 'package:flutter/material.dart';

import 'package:amsome_school/pages/homePage.dart';
import 'package:amsome_school/model/school_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpPage extends StatefulWidget{

  final bool isPhone;

  SignUpPage({this.isPhone});

  @override
  SignUpPageState createState() {
    return SignUpPageState();
  }
}

class Codes{
  Codes(this.code, this.country);
  final String code;
  final String country;
}

class SignUpPageState extends State<SignUpPage>{

  final _formKey = GlobalKey<FormState>();
  //var passKey = GlobalKey<FormFieldState>();

  TextStyle hintStyle = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.blue.withAlpha(250));
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black);
  final border = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  );

  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneInputController = new TextEditingController();
  TextEditingController emailInputController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  String selectedCode;
  List<Codes> codeList = <Codes>[
    Codes("+91", "India"),
    Codes("+55", "Brazil"),
    Codes("+1", "Canada"),
    Codes("+33", "France"),
    Codes("+49", "Germany"),
    Codes("+62", "Indonesia"),
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

  String nameValidator(String iString){
    Pattern pattern = r'^[a-zA-Z0-9 ]{2,30}$';
    RegExp regex = new RegExp(pattern);

    if(!regex.hasMatch(iString)){
      return 'Name is invalid';
    }
    else {
      return null;
    }
  }

  String passwordValidator(String iString){
    if(iString.length >= 6){
      return null;
    }
    else
    {
      return 'Password length should be 6 digit minimum';
    }
  }


  @override
  Widget build(BuildContext context) {

    var aWidget;

    if(widget.isPhone)
      {
        aWidget =  Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Align(alignment: Alignment.centerLeft, child: Text("Register", style: TextStyle(fontFamily: 'Montserrat', fontSize: 30.0, color: Colors.blue),)),
                      SizedBox(height: 20.0,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          color: Colors.white,
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
                                    child: Text(eachCode.code + " " + eachCode.country, style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.blue),),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: style,
                        controller: nameController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: border,
                          labelText: 'Name',
                          labelStyle: hintStyle,
                        ),
                        validator: nameValidator,
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: style,
                        controller: phoneInputController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: border,
                          labelText: 'Phone Number',
                          labelStyle: hintStyle,
                        ),
                        validator: phoneValidator,
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: style,
                        controller: passwordController,
                        //key: passKey,
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: border,
                          labelText: 'Password',
                          labelStyle: hintStyle,
                        ),
                        validator: passwordValidator,
                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        style: style,
                        controller: confirmPasswordController,
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: border,
                          labelText: 'Confirm Password',
                          labelStyle: hintStyle,
                        ),
                        validator: (value){
                          if(value != passwordController.text){
                            return "Password does not match";
                          }
                          else{
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: (){
                            _formKey.currentState.validate();
                          },
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Submit', style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 25.0,
                                color: Colors.white),),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    else
      {
        aWidget = Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: ScopedModelDescendant<SchoolModel>(
                    builder: (context, child, model){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Align(alignment: Alignment.centerLeft, child: Text("Register", style: TextStyle(fontFamily: 'Montserrat', fontSize: 30.0, color: Colors.blue),)),
                          SizedBox(height: 20.0,),
                          TextFormField(
                            style: style,
                            controller: nameController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              enabledBorder: border,
                              labelText: 'Name',
                              labelStyle: hintStyle,
                            ),
                            validator: nameValidator,
                          ),
                          SizedBox(height: 20.0,),
                          TextFormField(
                            style: style,
                            controller: emailInputController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              enabledBorder: border,
                              labelText: 'Email',
                              labelStyle: hintStyle,
                            ),
                            validator: emailValidator,
                          ),
                          SizedBox(height: 20.0,),
                          TextFormField(
                            style: style,
                            //key: passKey,
                            controller: passwordController,
                            obscureText: true,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              enabledBorder: border,
                              labelText: 'Password',
                              labelStyle: hintStyle,
                            ),
                            validator: passwordValidator,
                          ),
                          SizedBox(height: 20.0,),
                          TextFormField(
                            style: style,
                            controller: confirmPasswordController,
                            obscureText: true,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              enabledBorder: border,
                              labelText: 'Confirm Password',
                              labelStyle: hintStyle,
                            ),
                            validator: (value){
                              if(value != passwordController.text){
                                return "Password does not match";
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () async {
                                if(_formKey.currentState.validate())
                                {
                                  final email = emailInputController.text.toString().trim();
                                  final password = passwordController.text.toString().trim();
                                  final name = nameController.text.toString().trim();

                                  var page = FutureBuilder(
                                    future: model.registerUserWithEmail(email, password, name),
                                    builder: (context, snapshot){
                                      if(snapshot.connectionState == ConnectionState.done && snapshot.data == true){
                                        return HomePage(name: name);
                                      }
                                      else if(snapshot.connectionState == ConnectionState.done && snapshot.data == false){
                                        return Scaffold(backgroundColor: Colors.white,
                                            body: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("Error in Registration. Please check your connection and try after some time", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue),),
                                                    SizedBox(height: 10.0),
                                                    RaisedButton(
                                                      color: Colors.blue,
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "BACK",
                                                        style: TextStyle(color: Colors.white),
                                                      ),),
                                                  ],
                                                )));
                                      }
                                      else{
                                        return Scaffold(
                                          backgroundColor: Colors.white,
                                          body: Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new CircularProgressIndicator(),
                                                new SizedBox(height: 20.0,),
                                                new Text("Loading", style: TextStyle(color: Colors.blue),),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );

                                  if(page != null){
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                          builder: (context)
                                          {
                                            return page;
                                          },
                                        ));
                                  }
                                  else if(page == null)
                                  {

                                  }

                                }
                              },
                              color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Submit', style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 25.0,
                                    color: Colors.white),),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }

    return aWidget;
  }
}