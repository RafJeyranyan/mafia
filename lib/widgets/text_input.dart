import 'package:flutter/material.dart';

import '../consts/consts.dart';

const textInputDecoration = InputDecoration(
    labelStyle: TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ProjectColors.primaryColor, width: 2)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ProjectColors.primaryColor, width: 2)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ProjectColors.errorColor, width: 2)
    ),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: ProjectColors.primaryColor, width: 2))
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page
  ));
}