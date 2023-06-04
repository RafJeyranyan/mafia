import 'package:flutter/material.dart';

abstract class GameDBConsts {
  static const String playerIndex = "playerIndex";
  static const String playerCardType = "cardType";
  static const String playerName = "name";
  static const String playerUID = "uid";
  static const String playerEmail = "email";
  static const String groups = "groups";


}

abstract class ProjectTexts {
  static const String email = "Email";
  static const String login = "Login";
  static const String password = "Password";
  static const String name = "Name";
}

abstract class ProjectColors {
  static const primaryColor = Color(0x9f000000);
  static const errorColor = Color(0xC0CB0D0D);
}

abstract class ProjectIcons {
  static const Icon emailIcon = Icon(
    Icons.email,
    color: Colors.black,
  );
  static const Icon passwordIcon = Icon(
    Icons.lock,
    color: Colors.black,
  );
  static const Icon personIcon = Icon (
    Icons.person,
    color: Colors.black,
  );
  static const Icon eyeOpenIcon = Icon (

    Icons.visibility,
    color: Colors.black,
  );
  static const Icon eyeCloseIcon = Icon (
    Icons.visibility_off,
    color: Colors.black,
  );
}