import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mafia/pages/auth/login_page.dart';
import 'package:mafia/pages/game/enter_page.dart';
import 'package:mafia/providers/player_provider.dart';
import 'package:provider/provider.dart';

import 'helpers/helperFuncs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => PlayerProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    getUserLoggedInStatus();
    super.initState();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mafia',
      theme: ThemeData.dark(),

      home: _isSignedIn ? const EnterPage() : const LoginPage(),
      // home: EnterPage(),
    );
  }
}
