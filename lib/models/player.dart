import 'package:json_annotation/json_annotation.dart';
import 'package:mafia/consts/player_data_enums.dart';
import 'package:mafia/models/groups.dart';

part 'player.g.dart';

@JsonSerializable()
class Player {
  int? playerIndex;
  CardType? cardType;
  String? email;
  String? name;
  String? groups;
  String? uid;



  Player(
      {this.playerIndex, this.cardType, this.email, this.groups, this.uid, this.name});

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
