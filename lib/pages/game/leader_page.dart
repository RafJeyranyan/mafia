import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mafia/helpers/helperFuncs.dart';
import 'package:mafia/providers/player_provider.dart';
import 'package:mafia/services/auth_service.dart';
import 'package:mafia/services/db_service.dart';
import 'package:provider/provider.dart';

class LeaderPage extends StatefulWidget {
  const LeaderPage({Key? key})
      : super(key: key);


  @override
  State<LeaderPage> createState() => _LeaderPageState();
}

class _LeaderPageState extends State<LeaderPage> {
  String? uid;

  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool waiting = false;

  @override
  void initState() {
    // fetchData().then((value) {
    //   uid = value;
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(builder: (context,provider, _) {
      return Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () async {
              // TODO:
              // await startGame();


            },
            child: Container(
              // margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent,
                      blurRadius: 20.0,
                      spreadRadius: 4,
                      // offset: Offset(4, 6),
                    ),
                  ]),
              child: const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(child: Text("GAME STARTED", style: TextStyle(fontSize: 40),)),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Future<String?> fetchData() async {
  //   return await HelperFunctions.getUserUIDSF();
  // }

  Future<dynamic> startGame()async{
// TODO:

  }

}
