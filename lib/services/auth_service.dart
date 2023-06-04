import 'package:firebase_auth/firebase_auth.dart';
import '../helpers/helperFuncs.dart';
import 'db_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  Future registerUserWithEmailAndPass(
      String fullname, String email, String password) async {
    try {
      User? user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        await DataBaseService(uid: user.uid)
            .saveUserData(fullname, email);
        await HelperFunctions.saveUserUIDSF(user.uid);

        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserNameSF("");
      await HelperFunctions.saveUserEmailSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
