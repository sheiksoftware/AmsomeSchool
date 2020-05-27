import 'package:amsome_school/pages/AttendancePage.dart';
import 'package:amsome_school/utils/SchoolModelJsonConversion.dart';
import 'package:amsome_school/utils/backgroundPaint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class ClassHomePage extends StatefulWidget{

  final aClassName;

  ClassHomePage({this.aClassName});

  @override
  ClassHomePageState createState() {
    // TODO: implement createState
    return ClassHomePageState();
  }
}

class ClassHomePageState extends State<ClassHomePage> with SingleTickerProviderStateMixin{

  TextEditingController idController =  new TextEditingController();
  TextEditingController studentNameController =  new TextEditingController();
  TextEditingController studentAgeController =  new TextEditingController();
  TextEditingController studentSexController =  new TextEditingController();
  TextEditingController studentDOBController =  new TextEditingController();

  TabController tabsController;

  @override
  void initState() {
    tabsController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  final hintStyle = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.blue.withAlpha(250));
  final border = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  );

  void insertDocFields(final students, final collectionID) {
    Firestore fireStore = Firestore.instance;

    fireStore.collection(widget.aClassName).add(students).then(
            (DocumentReference documentRef){
          print(documentRef.documentID);
        }
    ).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        automaticallyImplyLeading: false,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.blue, Colors.lightBlueAccent],
        ),
        title: Text(widget.aClassName, style: GoogleFonts.merriweather( color: Colors.white, fontWeight: FontWeight.w600),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),),
        ),
        bottom: TabBar(
          controller: tabsController,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(child: Text("STUDENTS", style: TextStyle(color: Colors.white),),),
            Tab(child: Text("ATTENDANCE", style: TextStyle(color: Colors.white),),),
            Tab(child: Text("HOMEWORK", style: TextStyle(color: Colors.white),),),
            Tab(child: Text("FEES", style: TextStyle(color: Colors.white),),),
            Tab(child: Text("EXAMS", style: TextStyle(color: Colors.white),),),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: (){
              showDialog(context: context,
                  barrierDismissible: true,
                  builder:(BuildContext context){
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("Please enter the student details", style: TextStyle(color: Colors.blue)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                  controller: studentNameController,
                                    decoration: InputDecoration(
                                      enabledBorder: border,
                                      labelText: 'Student Name',
                                      labelStyle: hintStyle,
                                    ),
                                ),
                                  TextFormField(
                                    controller: idController,
                                    decoration: InputDecoration(
                                      enabledBorder: border,
                                      labelText: 'Student ID',
                                      labelStyle: hintStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('ADD'),
                          onPressed: () {
                            if(idController.text.isNotEmpty && studentNameController.text.isNotEmpty){
                              final studentName = studentNameController.text;
                              final studentID = idController.text;

                              studentNameController.clear();
                              idController.clear();

                              insertDocFields(ClassModelJson(studentID: studentID, studentName: studentName).toMap(), studentID);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    );
                  }
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      ),

      body: Container(
        child: TabBarView(
          controller: tabsController,
          children: <Widget>[
            //Students tab
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection(widget.aClassName).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot){

                if(querySnapshot.hasError){
                  return Center(child: Text("Error reading the Data", style: TextStyle(color: Colors.blue), textAlign: TextAlign.center,));
                }

                if(querySnapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                else
                {
                  final studentsList = querySnapshot.data.documents;

                  return ListView.builder(
                      //separatorBuilder: (BuildContext context, int index) => SizedBox(height: 5,),
                      itemBuilder: (BuildContext context, int index) => StudentItem(aStudentID: studentsList[index]["studentID"], aStudentName: studentsList[index]["studentName"],),
                      itemCount: studentsList.length);
                }

              },
            ),

            //Attendance tab
            AttendancePage(),

            //HomeWork tab
            Container(),
            Container(),

            //Fees Tab

            //Exams Tab
            CustomPaint(
              painter: BackgroundPaint(),
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            ),

          ],
        ),
      ),
    );
  }
}


class StudentItem extends StatefulWidget{

  final String aStudentName, aStudentID;

  StudentItem({this.aStudentName, this.aStudentID});

  @override
  StudentItemState createState() {
    return StudentItemState();
  }
}

class StudentItemState extends State<StudentItem>{

  bool aSelected = false;
  String aSelectedString = "";

  Future<void> deleteData(final className) async{
//    Firestore fireStore = Firestore.instance;
//
//    final querySnapShot = await fireStore.collection("school").document(widget.class);
//    final list = querySnapShot.documents;
//
//    for(var index =0 ; index < list.length; index++){
//      if(list[index].documentID == className){
//        list[index].reference.delete().whenComplete((){
//        });
//      }
//    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Opacity(
        opacity: 0.9,
        child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          child: Center(
            child: ListTile(
              contentPadding: EdgeInsets.all(8.0),
              title: Text(widget.aStudentName.toUpperCase(), maxLines: 1, style: TextStyle( fontSize: 15.0, fontWeight: FontWeight.w400),),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("ID: " + widget.aStudentID, maxLines: 1, style: TextStyle( fontSize: 13.0, fontWeight: FontWeight.normal),),
                    Text("DOB: 13-06-1991", maxLines: 1, style: TextStyle( fontSize: 13.0, fontWeight: FontWeight.normal),),
                  ],),
              leading: Container(
                child: CircleAvatar(
                  backgroundColor: Colors.blue.withAlpha(220),
                  maxRadius: 50.0,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              dense: false,
            ),
          ),
        ),
      ),
    );

    //return Card(
//      elevation: 2.0,
//      color: Colors.white,
//      shape: RoundedRectangleBorder(
//        //borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), bottomLeft: Radius.circular(25.0)),
//        borderRadius: BorderRadius.all(Radius.circular(25.0)),
//      ),
//      child: FlatButton(
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), bottomLeft: Radius.circular(25.0)),
//        ),
//        onPressed: (){
//        },
//        onLongPress: (){
//          if(aSelected){
//            aSelected = false;
//            aSelectedString = "";
//          }else{
//            aSelectedString = widget.aStudentName;
//            aSelected = true;
//          }
//          setState(() {
//          });
//        },
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              children: <Widget>[
//                SizedBox(height: 10.0,),
//                Align(alignment: Alignment.topLeft, child: Text("Name: " + widget.aStudentName, style: GoogleFonts.merriweather( color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w600),)),
//                SizedBox(height: 10.0,),
//                Align(alignment: Alignment.bottomLeft, child: Text("ID       : " + widget.aStudentID, style: GoogleFonts.merriweather( color: Colors.black, fontWeight: FontWeight.w600),)),
//                SizedBox(height: 10.0,),
//                Align(alignment: Alignment.topLeft, child: Text("DOB:  12-09-2000", style: GoogleFonts.merriweather( color: Colors.black, fontWeight: FontWeight.w600),)),
//                SizedBox(height: 10.0,),
//              ],
//            ),
//            aSelected ? IconButton(
//                icon: Icon(Icons.delete),
//                color: Colors.blue,
//                onPressed: () {
//                  deleteData(aSelectedString);
//                  aSelectedString = "";
//                  aSelected = false;
//                }
//            ) : Container(),
//          ],
//        ),
//      ),
//    );
  }
}