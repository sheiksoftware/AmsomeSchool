import 'package:amsome_school/pages/classHomePage.dart';
import 'package:amsome_school/utils/SchoolModelJsonConversion.dart';
import 'package:amsome_school/utils/backgroundPaint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';

class SchoolHomePage extends StatefulWidget{
  @override
  SchoolHomePageState createState() {
    return SchoolHomePageState();
  }
}

class SchoolHomePageState extends State<SchoolHomePage>{

  TextEditingController classNameController =  new TextEditingController();

  String url;
  int currentBarIndex = 0;

  void initState() {
    super.initState();
    var refImage = FirebaseStorage.instance.ref().child('animatedSchoolUpdate.jpg');
    refImage.getDownloadURL().then((iUrl){
      url = iUrl;
      setState(() {
      });
    });
  }

  void insertDoc(final classes) {
    Firestore fireStore = Firestore.instance;

    fireStore.collection("school").document(classes).setData({"CLASS NAME":classes});

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: GradientBottomNavigationBar(
        currentIndex: currentBarIndex, // this will be set when a new tab is tapped
        backgroundColorStart: Colors.blue,
        backgroundColorEnd: Colors.lightBlueAccent,
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
          currentBarIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home, color: ((currentBarIndex == 0) ? Colors.white : Colors.white70),),
            title: new Text('Home', style: TextStyle(color: Colors.white),),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.event, color: ((currentBarIndex == 1) ? Colors.white : Colors.white70),),
            title: new Text('Events', style: TextStyle(color: Colors.white),),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections, color: ((currentBarIndex == 2) ? Colors.white : Colors.white70),),
              title: Text('Gallery', style: TextStyle(color: Colors.white),),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: ((currentBarIndex == 3) ? Colors.white : Colors.white70),),
              title: Text('Settings', style: TextStyle(color: Colors.white),),
          ),
        ],),

      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: CustomPaint(
          painter: BackgroundPaint(),
          size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("school").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot){

          if(querySnapshot.hasError){
            return Center(child: Text("Error reading the Data", style: TextStyle(color: Colors.blue), textAlign: TextAlign.center,));
          }

          if(querySnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else{
            final list = querySnapshot.data.documents;

            return CustomScrollView(
              slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white.withAlpha(200),
                title: Text("SCHOOL HOME", style: GoogleFonts.merriweather( color: Colors.blue, fontWeight: FontWeight.w600),),
                pinned: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.blue,
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
                              Text("Please enter the Class Name", style: TextStyle(color: Colors.blue)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: classNameController,
                                ),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('ADD'),
                              onPressed: () {
                                if(classNameController.text.isNotEmpty){
                                  final className = classNameController.text;
                                  classNameController.clear();
                                  //await insertData(SchoolModelJson(className: className).toMap());
                                  insertDoc(className);
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
                  icon: Icon(Icons.select_all),
                  color: Colors.blue,
                  onPressed: (){
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.blue,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
              expandedHeight: 280.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  //height: 50.0,
                  child: (url == null || url.isEmpty) ? Container() : Container()/** : Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[Image.network(url)])**/,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index){

                      var className = list[index].documentID;
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClassItem(aClassName: className,),
                      );
                    },
                  childCount: list.length,
              ),
            ),
          ],
          );
          }
          }
          ),
        ),
      ),
    );
  }
}

class ClassItem extends StatefulWidget{

  final String aClassName;

  ClassItem({this.aClassName});

  @override
  ClassItemState createState() {
    return ClassItemState();
  }
}

class ClassItemState extends State<ClassItem>{

  bool aSelected = false;
  String aSelectedString = "";

  Future<void> deleteData(final className) async{
    Firestore fireStore = Firestore.instance;

    final querySnapShot = await fireStore.collection("school").getDocuments();
    final list = querySnapShot.documents;

    for(var index =0 ; index < list.length; index++){
      if(list[index].documentID == className){
        list[index].reference.delete().whenComplete((){
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Card(
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), bottomLeft: Radius.circular(25.0)),
        ),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), bottomLeft: Radius.circular(25.0)),
          ),
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (context)
                  {
                    return ClassHomePage(aClassName: widget.aClassName,);
                  },
                ));
          },
          onLongPress: (){
            if(aSelected){
              aSelected = false;
              aSelectedString = "";
            }else{
              aSelectedString = widget.aClassName;
              aSelected = true;
            }
            setState(() {
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    Align(alignment: Alignment.centerLeft, child: Text(widget.aClassName, style: GoogleFonts.merriweather( color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w400),)),
                    SizedBox(height: 10.0,),
                    Align(alignment: Alignment.centerLeft, child: Text("STUDENTS COUNT: 40", style: GoogleFonts.raleway( color: Colors.black, fontWeight: FontWeight.w400),)),
                    SizedBox(height: 10.0,),
                    Align(alignment: Alignment.centerLeft, child: Text("STAFF:  Sheik Ibrahim", style: GoogleFonts.raleway( color: Colors.green, fontWeight: FontWeight.w400),)),
                    SizedBox(height: 10.0,),
                  ],
                ),
              ),
              aSelected ? IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.blue,
                  onPressed: () {
                    deleteData(aSelectedString);
                    aSelectedString = "";
                    aSelected = false;
                  }
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}