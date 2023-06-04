import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userUID = "USERUID";

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }
  static Future<bool> saveUserNameSF(String userName) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }
  static Future<bool> saveUserEmailSF(String email) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, email);
  }



  static Future<bool> saveUserUIDSF(String uid) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userUID, uid);
  }




  static Future<bool?> getUserLoggedInStatus () async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(userLoggedInKey);
  }

  static Future<String?> getUserUIDSF () async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userUID);
  }

  static Future<String?> getUserNameSF() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey) ;
  }
  static Future<String?> getUserEmailSF() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey) ;
  }


}