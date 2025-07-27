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

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? phoneNumber,
    String? role,
    String? organizationName,
    int? totalEventsCreated,
    double? ticketsSold,
    double? totalCommission,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      organizationName: organizationName ?? this.organizationName,
      totalEventsCreated: totalEventsCreated ?? this.totalEventsCreated,
      ticketsSold: ticketsSold ?? this.ticketsSold,
      totalCommission: totalCommission ?? this.totalCommission,
    );
  }

  UserModel({
    required this.uid,
    required this.phoneNumber,
    required this.email,
    required this.name,
    required this.role,
    required this.organizationName,
    this.totalEventsCreated,
    this.ticketsSold,
    this.totalCommission,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
