// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupData _$GroupDataFromJson(Map<String, dynamic> json) => GroupData(
      donID: json['donID'] as int?,
      sheriffID: json['sheriffID'] as int?,
      playerCount: json['playerCount'] as int?,
      players:
          (json['players'] as List<dynamic>?)?.map((e) => e as String).toList(),
      blacks: (json['blacks'] as List<dynamic>?)?.map((e) => e as int).toList(),
      groupID: json['groupID'] as int?,
      reds: (json['reds'] as List<dynamic>?)?.map((e) => e as int).toList(),
    )..leadersID = json['leadersID'] as String?;

Map<String, dynamic> _$GroupDataToJson(GroupData instance) => <String, dynamic>{
      'groupID': instance.groupID,
      'donID': instance.donID,
      'sheriffID': instance.sheriffID,
      'playerCount': instance.playerCount,
      'leadersID': instance.leadersID,
      'players': instance.players,
      'blacks': instance.blacks,
      'reds': instance.reds,
    };
