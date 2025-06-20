// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      organizationName: json['organizationName'] as String?,
      totalEventsCreated: (json['totalEventsCreated'] as num?)?.toInt(),
      ticketsSold: (json['ticketsSold'] as num?)?.toDouble(),
      totalCommission: (json['totalCommission'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
      'organizationName': instance.organizationName,
      'totalEventsCreated': instance.totalEventsCreated,
      'ticketsSold': instance.ticketsSold,
      'totalCommission': instance.totalCommission,
    };
