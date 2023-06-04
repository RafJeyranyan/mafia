import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mafia/consts/consts.dart';

import '../models/groups.dart';

class DataBaseService {
  final String? uid;

  DataBaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  // LBr8pPaX1EdohcF9nnJO
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  Future saveGroupData(GroupData groupData) async {
    String? id;
    await groupCollection.add(groupData.toJson()).then((value) => id = value.id);
    return id;
  }




  Future saveUserData(
    String name,
    email, {
    String cardType = "",
    int index = -1,
    GroupData? groups,
  }) async {
    return await userCollection.doc(uid).set({
      GameDBConsts.playerUID: uid,
      GameDBConsts.playerEmail: email,
      GameDBConsts.playerCardType: cardType,
      GameDBConsts.playerIndex: index,
      GameDBConsts.playerName: name,
      GameDBConsts.groups: groups
    });
  }

  Future updateUserData(
    String name,
    email, {
    String cardType = "",
    int index = -1,
    String? groups,
  }) async {
    return await userCollection.doc(uid).update({
      GameDBConsts.playerUID: uid,
      GameDBConsts.playerEmail: email,
      GameDBConsts.playerCardType: cardType,
      GameDBConsts.playerIndex: index,
      GameDBConsts.playerName: name,
      GameDBConsts.groups: groups
    });
  }

  Future setUserCardType(String cardType) async {
    return await userCollection.doc(uid).set({
      GameDBConsts.playerCardType: cardType,
    });
  }

  Future setUserIndex(int index) async {
    return await userCollection.doc(uid).set({
      GameDBConsts.playerIndex: index,
    });
  }

  Future setUserGroupData(GroupData groups) async {
    return await userCollection.doc(uid).set({
      GameDBConsts.groups: groups,
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
