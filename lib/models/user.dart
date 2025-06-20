import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String phoneNumber;
  final String role;
  final String? organizationName;
  final int? totalEventsCreated;
  final double? ticketsSold;
  final double? totalCommission;

  UserModel({
    required this.uid,
    required this.phoneNumber,
    required this.email,
    required this.name,
    required this.role,
    this.organizationName,
    this.totalEventsCreated,
    this.ticketsSold,
    this.totalCommission,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
