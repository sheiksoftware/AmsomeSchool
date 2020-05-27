import 'package:amsome_school/model/school_model.dart';
import 'package:flutter/material.dart';
import 'package:amsome_school/pages/InitialPage.dart';
import 'package:amsome_school/pages/adminPage.dart';
import 'package:scoped_model/scoped_model.dart';


void main() {
  //After the new flutter upgrade, this initialisation required for any async
  WidgetsFlutterBinding.ensureInitialized();

  final schoolModel = SchoolModel();

  return runApp(ScopedModel<SchoolModel>(
      model: schoolModel,
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management System',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AmsomeSchool(),
    );
  }
}

class AmsomeSchool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (true) ? InitialPage() : AdminPage();
  }
}
