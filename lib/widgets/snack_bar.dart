import 'package:flutter/material.dart';

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,style: TextStyle(color: color),),
    backgroundColor: Theme.of(context).primaryColor,
    duration: const Duration(seconds: 2),
    action: SnackBarAction(label: "OK", onPressed: (){},),
  ));
}