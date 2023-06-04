import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mafia/consts/roles.dart';
import 'package:mafia/models/player.dart';
import 'package:mafia/pages/auth/login_page.dart';
import 'package:mafia/pages/game/leader_page.dart';
import 'package:mafia/pages/game/player_page.dart';
import 'package:mafia/providers/player_provider.dart';
import 'package:mafia/widgets/snack_bar.dart';
import 'package:mafia/widgets/text_input.dart';
import 'package:provider/provider.dart';

import '../../helpers/helperFuncs.dart';

class EnterPage extends StatefulWidget {
  const EnterPage({Key? key}) : super(key: key);

  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  String? uid;
  String? email;
  String? name;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final TextEditingController valueController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  @override
  void initState() {
    fetchData().then((value) {
      setState(() {});
    });
    super.initState();
  }

  Future<String?> fetchData() async {
    await HelperFunctions.getUserUIDSF().then((value) => uid = value);
    await HelperFunctions.getUserEmailSF().then((value) => email = value);
    await HelperFunctions.getUserNameSF().then((value) => name = value);
  }

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery
        .of(context)
        .size;
    return Consumer<PlayerProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Create or Join"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        Center(child: AlertDialog(
                          // contentPadding: EdgeInsets.all(100),
                          title: const Text("Log Out ?"),
                          alignment: Alignment.center,
                          backgroundColor: Colors.black,
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "No",
                                  style: TextStyle(color: Colors.red),
                                )),
                            TextButton(
                                onPressed: () async {
                                  await provider.logOut();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => const LoginPage()), (
                                      route) => false);
                                },
                                child: const Text("Yes")),
                          ],
                        ),),
                  );
                },
              ),
            )
          ],
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),

              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        SingleChildScrollView(
                          child: AlertDialog(
                            // contentPadding: EdgeInsets.all(100),
                            content: SizedBox(
                              height: devSize.height / 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: valueController,
                                    decoration: const InputDecoration(
                                      hintText: "ID",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  TextField(
                                    controller: countController,
                                    decoration: const InputDecoration(
                                      hintText: "Count",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: const Text(
                                "Enter group ID and players count"),
                            alignment: Alignment.center,
                            backgroundColor: Colors.black,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    if (valueController.text.isNotEmpty &&
                                        countController.text.isNotEmpty) {
                                      try {
                                        int val = int.parse(
                                            valueController.text);
                                        int count = int.parse(
                                            countController.text);
                                        provider.player.uid = uid;
                                        provider.player.email = email;
                                        provider.player.name = name;
                                        provider.player.playerIndex = -1;
                                        provider.groupData.groupID = val;
                                        provider.groupData.playerCount = count;
                                        provider.groupData.leadersID = uid;
                                        // for(int i = 0; i < 100; i++){
                                        //   print(Random().nextInt(count));
                                        // }

                                        await provider.createGame();
                                        //  provider.createGame();
                                        nextScreen(context, const LeaderPage());
                                      } catch (e) {


                                        print(e);


                                        showSnackBar(context, Colors.green,
                                            "Something went wrong");
                                      }
                                    }
                                  },
                                  child: const Text("Done")),
                            ],
                          ),
                        ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                ),
                child: SizedBox(
                  // alignment: Alignment.center,
                  height: devSize.height / 10,
                  width: devSize.width / 2,
                  child: const Center(
                    child: Text(
                      "Create Game",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        SingleChildScrollView(
                          child: AlertDialog(
                            // contentPadding: EdgeInsets.all(100),
                            content: SizedBox(
                              height: devSize.height / 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller: valueController,
                                    decoration: const InputDecoration(
                                      hintText: "ID",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  TextField(
                                    controller: countController,
                                    decoration: const InputDecoration(
                                      hintText: "Number",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: const Text("Enter group ID and your number"),
                            alignment: Alignment.center,
                            backgroundColor: Colors.black,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    if (valueController.text.isNotEmpty &&
                                        countController.text.isNotEmpty) {
                                      try {
                                        // id
                                        int val = int.parse(
                                            valueController.text);
                                        // number
                                        int count = int.parse(
                                            countController.text);
                                        provider.player.uid = uid;
                                        provider.player.email = email;
                                        provider.player.name = name;
                                        provider.player.playerIndex = count;
                                        provider.groupData.groupID = val;

                                        await provider.joinTheGame();

                                        nextScreen(context, const PlayerPage());
                                      } catch (e) {
                                        print(e);
                                        showSnackBar(context, Colors.green,
                                            "ID and count must be numbers");
                                      }
                                    }
                                  },
                                  child: const Text("Done")),
                            ],
                          ),
                        ),
                  );
                },
                child: Container(
                  height: devSize.height / 10,
                  width: devSize.width / 2,
                  child: const Center(
                    child: Text(
                      "Join Game",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      );
    });
  }
}
