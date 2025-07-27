// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendeeModel _$AttendeeModelFromJson(Map<String, dynamic> json) =>
    AttendeeModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      ticketsBought: (json['ticketsBought'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$AttendeeModelToJson(AttendeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'ticketsBought': instance.ticketsBought,
      'timestamp': instance.timestamp.toIso8601String(),
      'isChecked': instance.isChecked,
    };
