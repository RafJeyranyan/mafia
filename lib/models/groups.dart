import 'package:json_annotation/json_annotation.dart';

part 'groups.g.dart';

@JsonSerializable()
class GroupData {
  int? groupID;
  int? donID;
  int? sheriffID;
  int? playerCount;
  String? leadersID;
  List<String>? players;

  List<int>? blacks;

  List<int>? reds;

  GroupData(
      {this.donID,
      this.sheriffID,
      this.playerCount,
      this.players,
      this.blacks,
      this.groupID,
      this.reds});

  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataToJson(this);
}
