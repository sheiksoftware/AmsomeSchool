import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SchoolModel extends Model{

  //Properties
  String userName;

  setName(String iValue){
    userName = iValue;
    notifyListeners();
  }

  //Functions
  Future<FirebaseUser> loginUserwithEmail(String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      setName(user.displayName);

      return user;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future<bool> registerUserWithEmail(String email, String password, String name) async {

    //Getting the instance of Firebase Auth
    FirebaseAuth _auth = FirebaseAuth.instance;

    try{

      //Actual Registration happens with firebase here
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //after registration, update the user profile
      UserUpdateInfo userInfo = UserUpdateInfo();
      userInfo.displayName = name;

      user.updateProfile(userInfo);

      return true;
    }
    catch(e)
    {
      print(e);
      return false;
    }
  }

}