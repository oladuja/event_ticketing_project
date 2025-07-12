import 'package:json_annotation/json_annotation.dart';
import 'package:project/models/attendee.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class EventModel {
  final String id;
  final String title;
  final String location;
  final DateTime date;
  final int price;
  final int totalTickets;
  final int availableTickets;
  final List<AttendeeModel> attendees;

  EventModel({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.price,
    required this.totalTickets,
    required this.availableTickets,
    required this.attendees,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
