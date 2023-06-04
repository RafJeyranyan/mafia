import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mafia/pages/auth/register_page.dart';
import '../../consts/consts.dart';
import '../../helpers/helperFuncs.dart';
import '../../services/auth_service.dart';
import '../../services/db_service.dart';
import '../../widgets/button.dart';
import '../../widgets/snack_bar.dart';
import '../../widgets/text_input.dart';
import '../game/enter_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool isPassNotVisible = true;
  bool _isLoading = false;

  final AuthService authService = AuthService();
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithEmailAndPassword(
              emailInputController.text, passwordInputController.text)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(emailInputController.text.toLowerCase());
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(emailInputController.text);
          await HelperFunctions.saveUserNameSF(
              snapshot.docs[0][GameDBConsts.playerName]);

          nextScreen(context, const EnterPage());
          setState(() {
            _isLoading = false;
          });
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    passwordInputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: emailInputController,
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Please enter a valid email";
                        },
                        decoration: textInputDecoration.copyWith(
                          labelText: ProjectTexts.email,
                          prefixIcon: ProjectIcons.emailIcon,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: passwordInputController,
                        obscureText: isPassNotVisible,
                        validator: (val) {
                          if (val!.length < 6) {
                            return "Password must be at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                        decoration: textInputDecoration.copyWith(
                            labelText: ProjectTexts.password,
                            prefixIcon: ProjectIcons.passwordIcon,
                            suffix: GestureDetector(

                                // padding: EdgeInsets.zero,
                                onTap: () {
                                  setState(() {
                                    isPassNotVisible = !isPassNotVisible;
                                  });
                                },
                                child: isPassNotVisible
                                    ? ProjectIcons.eyeOpenIcon
                                    : ProjectIcons.eyeCloseIcon)),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomButton(
                        onPress: () async {
                          login();

                        },
                        text: "Sign in",
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text.rich(
                        TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(
                                color: Colors.white30, fontSize: 14),
                            children: [
                              TextSpan(
                                text: "Register here",
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, const RegisterPage());
                                  },
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
