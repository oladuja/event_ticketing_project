// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendeeModel _$AttendeeModelFromJson(Map<String, dynamic> json) =>
    AttendeeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      isCheckedIn: json['isCheckedIn'] as bool,
    );

Map<String, dynamic> _$AttendeeModelToJson(AttendeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'isCheckedIn': instance.isCheckedIn,
    };
