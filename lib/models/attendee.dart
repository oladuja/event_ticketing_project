import 'package:json_annotation/json_annotation.dart';

part 'attendee.g.dart';

@JsonSerializable()
class AttendeeModel {
  final String id;
  final String uid;
  final int ticketsBought;
  final DateTime timestamp;
  final bool isChecked;

  AttendeeModel({
    required this.id,
    required this.uid,
    required this.ticketsBought,
    required this.timestamp,
    this.isChecked = false,
  });

  factory AttendeeModel.fromJson(Map<String, dynamic> json) =>
      _$AttendeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendeeModelToJson(this);
}
