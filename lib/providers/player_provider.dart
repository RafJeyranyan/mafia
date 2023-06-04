import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mafia/consts/player_data_enums.dart';
import 'package:mafia/helpers/helperFuncs.dart';
import 'package:mafia/models/groups.dart';
import 'package:mafia/services/db_service.dart';

import '../models/player.dart';

class PlayerProvider with ChangeNotifier {
  Player player = Player();
  GroupData groupData = GroupData();
  String? imageURL;

 Future createGame() async {
    int count = groupData.playerCount!;
    List<CardType> rules = List.filled(count, CardType.red, growable: false);
    print(rules);
    int blackCount = 3;
    if (count > 0 && count <= 7) {
      blackCount = 1;
    }
    if (count > 7 && count <= 9) {
      blackCount = 2;
    }
    int rand = Random().nextInt(count);
    rules[rand] = CardType.sheriff;
    bool donChosen = false;
    while (blackCount > 0) {
      rand = Random().nextInt(count);
      if (rules[rand].name == CardType.red.name) {
        if (donChosen == false) {
          rules[rand] = CardType.don;
          donChosen = true;
          --blackCount;
          continue;
        }

        rules[rand] = CardType.black;
        --blackCount;

      }
    }

    groupData.blacks = [];
    groupData.reds = [];
    groupData.players = [];

    for(int i = 0; i < count; i++){
      switch (rules[i]) {
        case CardType.black:
          groupData.blacks!.add(i + 1);
          break;
        case CardType.don:
          groupData.donID = i + 1;
          break;
        case CardType.sheriff:
          groupData.sheriffID = i + 1;
          break;
        case CardType.red:
          groupData.reds!.add(i + 1);
          break;
      }
    }



   await DataBaseService(uid: player.uid).saveGroupData(groupData);

    // await DataBaseService(uid: player.uid).updateUserData(
    //     player.name!, player.email, cardType: CardType.leader.name,
    //     index: -1,
    //     groups: id);
  }

  Future joinTheGame() async {
    final CollectionReference groupCollection =
        FirebaseFirestore.instance.collection("groups");
    QuerySnapshot query = await groupCollection
        .where("groupID", isEqualTo: groupData.groupID)
        .get();
    // jsonDecode(query.docs[0].data());
    groupData =
        GroupData.fromJson(query.docs[0].data() as Map<String, dynamic>);
    player.groups = query.docs[0].id;
    // await DataBaseService(uid: player.uid).fetchGroupData(groupData.groupID);


   if(groupData.reds!.contains(player.playerIndex)){
     imageURL = "assets/cards/red.png";
     return;
   }

   if(groupData.blacks!.contains(player.playerIndex)){
     imageURL = "assets/cards/black.png";
     return;
   }
   if (groupData.donID == player.playerIndex){
     imageURL = "assets/cards/don.png";
     return;
   }
   if(groupData.sheriffID == player.playerIndex){
     imageURL = "assets/cards/sheriff.jpeg";
     return;
   }

  }

  logOut() async{
   await HelperFunctions.saveUserEmailSF("");
   await HelperFunctions.saveUserLoggedInStatus(false);
   await HelperFunctions.saveUserNameSF("");
   await HelperFunctions.saveUserUIDSF("");

  }
}
