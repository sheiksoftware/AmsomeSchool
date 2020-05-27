import 'package:amsome_school/pages/UpdateAttendancePage.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AttendancePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AttendancePageState();
  }
}

class AttendancePageState extends State<AttendancePage>
{
  Map<String, double> aAttendanceData = new Map();

  var decoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    shape: BoxShape.rectangle,
    color: Colors.white,
  );

  var colorList = [Colors.green, Colors.red];

  getFormattedDate(){
    var dateTime = DateTime.now().toLocal();
    var date = dateTime.day.toString() + "/" + dateTime.month.toString() + "/" + dateTime.year.toString();

    return date;
  }

  updateAttendancePIEChartData(){
    aAttendanceData.putIfAbsent("PRESENT", ()=> 80);
    aAttendanceData.putIfAbsent("ABSENT", ()=> 20);
  }

  Widget getTopAttendanceCards(String iText, bool iUpward) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 150.0,
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                (iUpward) ? Icons.arrow_upward : Icons.arrow_downward,
                color: (iUpward) ? Colors.green : Colors.red,
                size: 50,
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                },
                child: Text(
                  iText,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.blue,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUpdateAttendancePageTransition(String iText){

    return OpenContainer(
        closedColor: Colors.white,
        openColor: Colors.white,
        closedElevation: 0.0,
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 1500),
        openBuilder: (context, action){
          return UpdateAttendancePage();
        },
        closedBuilder: (context, action){
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      iText,
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 15.0),
                    ),
                  ),
                ),
              );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    updateAttendancePIEChartData();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Text("ATTENDANCE PERCENTAGE"),
                  Text("FOR THE YEAR 2020-2021"),
                  SizedBox(height: 20,),
                  PieChart(
                    animationDuration: Duration(milliseconds: 700),
                    dataMap: aAttendanceData,
                    chartType: ChartType.ring,
                    chartLegendSpacing: 30.0,
                    chartRadius: MediaQuery.of(context).size.width/2,
                    legendPosition: LegendPosition.bottom,
                    colorList: colorList,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          getUpdateAttendancePageTransition("MARK ATTENDANCE ON " + getFormattedDate()),
          SizedBox(
            height: 5.0,
          ),
          getUpdateAttendancePageTransition("MARK PREVIOUS ATTENDANCE"),
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: 150.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                getTopAttendanceCards("TOP ATTENDEES OF THE MONTH", true),
                getTopAttendanceCards("TOP ATTENDEES OF THE YEAR", true),
                getTopAttendanceCards("TOP NON-ATTENDEES OF THE MONTH", false),
                getTopAttendanceCards("TOP NON-ATTENDEES OF THE YEAR", false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}