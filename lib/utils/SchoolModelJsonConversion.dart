class SchoolModelJson
{
  final String className;

  SchoolModelJson({this.className});

  Map<String,dynamic> toMap(){
    return {"ClassName":this.className};
  }
}

class ClassModelJson
{
  final String studentName;
  final String studentID;

  ClassModelJson({this.studentName, this.studentID});

  Map<String,dynamic> toMap(){
    return {"studentName":this.studentName, "studentID":this.studentID};
  }
}