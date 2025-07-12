import 'package:json_annotation/json_annotation.dart';

part 'attendee.g.dart';

@JsonSerializable()
class AttendeeModel {
  final String id;
  final String name;
  final String imageUrl;
  final bool isCheckedIn;

  AttendeeModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isCheckedIn,
  });

  factory AttendeeModel.fromJson(Map<String, dynamic> json) =>
      _$AttendeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendeeModelToJson(this);
}
