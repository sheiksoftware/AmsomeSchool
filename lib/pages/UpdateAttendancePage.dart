import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateAttendancePage extends StatefulWidget {

  final DateTime dateTime = DateTime.now();

  @override
  State<StatefulWidget> createState() {
    return UpdateAttendancePageState(day: dateTime.day.toString(), month: dateTime.month.toString(), year: dateTime.year.toString());
  }
}

class UpdateAttendancePageState extends State<UpdateAttendancePage> {

  final studentsList = [{"AHMED HAROON" : "Y"}, {"SANA AYISHA" : "Y"}, {"HANAA AYISHA" : "Y"}, {"ASARUDEEN" : "N"}];

  UpdateAttendancePageState({this.day, this.month, this.year});

  var day = "00";
  var month = "00";
  var year = "0000";
  bool checkBoxState = false;

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
        title: Text("MARK ATTENDANCE", style: GoogleFonts.merriweather( color: Colors.white, fontWeight: FontWeight.w600),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Text(
                "CURRENT DATE : " + day + "-" + month + "-" + year,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: RaisedButton(
                  child: Text("CHANGE DATE", style: TextStyle(color: Colors.white),),
                  color: Colors.red,
                  onPressed: () {
                    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2120)).then(
                        (date){
                          setState(() {
                            day = date.day.toString();
                            month = date.month.toString();
                            year = date.year.toString();

                            if(day.length == 1)
                              day = "0" + day;

                            if(month.length == 1)
                              month = "0" + month;
                          });
                        }
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: studentsList.length,
                itemBuilder: (BuildContext context, int index){
                  return StudentsAttendanceList(
                    studentName: studentsList[index].keys.toString(),
                    present: studentsList[index].values.toString(),
                  );
                }
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class StudentsAttendanceList extends StatefulWidget {

  final String studentName;
  final String present;


  StudentsAttendanceList({this.studentName, this.present,});

  @override
  State<StatefulWidget> createState() {

    bool aPresentState = false;
    bool aAbsentState = false;

    if(present == "(Y)")
    {
      aPresentState = true;
      aAbsentState = false;
    }
    else
    {
      aPresentState = false;
      aAbsentState = true;
    }

    return StudentsAttendanceListState(aPresentState: aPresentState, aAbsentState: aAbsentState);
  }
}

class StudentsAttendanceListState extends State<StudentsAttendanceList>
{

  bool aPresentState = false;
  bool aAbsentState = false;

  StudentsAttendanceListState({this.aPresentState, this.aAbsentState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox( width: 200,child: Text(widget.studentName, maxLines: 1,)),
            Checkbox(
              value: aPresentState,
              onChanged: (state){
                aPresentState = state;
                aAbsentState = !state;
                setState(() {
                });
              },
              checkColor: Colors.white,
              activeColor: Colors.green,
            ),
            Checkbox(
              value: aAbsentState,
              onChanged: (state){
                setState(() {
                  aAbsentState = state;
                  aPresentState = !state;
                });
              },
              checkColor: Colors.white,
              activeColor: Colors.red,
            ),
//            Checkbox(
//              value: aAbsentState,
//              onChanged: (state){
//                aAbsentState = !aAbsentState;
//                setState(() {
//                });
//              },
//              checkColor: Colors.white,
//              activeColor: Colors.red,
//            )
          ],
        ),
      ),
    );

//    return Padding(
//      padding: const EdgeInsets.all(4.0),
//      child: Container(
//        decoration: BoxDecoration(
//          shape: BoxShape.rectangle,
//          color: Colors.white,
//        ),
//        child: Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text(studentName),
//              IconButton(
//                icon: Icon(
//                  Icons.brightness_1,
//                  color: (aEnablePresent) ? Colors.green : Colors.blueGrey,
//                ),
//              ),
//              IconButton(
//                icon: Icon(
//                Icons.brightness_1,
//                  color: (aEnableAbsent) ? Colors.green : Colors.blueGrey,
//              )
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
  }
}