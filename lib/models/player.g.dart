// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      playerIndex: json['playerIndex'] as int?,
      cardType: $enumDecodeNullable(_$CardTypeEnumMap, json['cardType']),
      email: json['email'] as String?,
      groups: json['groups'] as String?,
      uid: json['uid'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'playerIndex': instance.playerIndex,
      'cardType': _$CardTypeEnumMap[instance.cardType],
      'email': instance.email,
      'name': instance.name,
      'groups': instance.groups,
      'uid': instance.uid,
    };

const _$CardTypeEnumMap = {
  CardType.red: 'red',
  CardType.black: 'black',
  CardType.don: 'don',
  CardType.sheriff: 'sheriff',
  CardType.leader: 'leader',
};
