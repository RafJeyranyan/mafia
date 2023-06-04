import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

import '../../../Consts/consts.dart';
import '../../../widgets/button.dart';
import '../../helpers/helperFuncs.dart';
import '../../services/auth_service.dart';
import '../../widgets/snack_bar.dart';
import '../../widgets/text_input.dart';
import '../game/enter_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPassNotVisible = true;
  bool _isLoading = false;
  AuthService authService = AuthService();
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final TextEditingController nameInputController = TextEditingController();

  // login() {
  //   if (formKey.currentState!.validate()) {}
  // }

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
                  "Registration",
                  style: TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 8,
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nameInputController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: ProjectTexts.name,
                    prefixIcon: ProjectIcons.personIcon,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                  onPress: () {
                    register();
                  },
                  text: "Register",
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text.rich(
                  TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(
                          color: Colors.white30, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Login now",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const LoginPage()),
                                      (route) => false);

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

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailAndPass(nameInputController.text,
          emailInputController.text, passwordInputController.text)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(emailInputController.text);
          await HelperFunctions.saveUserNameSF(nameInputController.text);
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
}
