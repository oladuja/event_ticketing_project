import 'package:json_annotation/json_annotation.dart';
import 'package:project/models/attendee.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class EventModel {
  final String id;
  final String imageUrl;
  final String eventName;
  final String description;
  final String location;
  final String eventType;
  final String category;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime date;

  final int totalTickets;
  final int availableTickets;
  final List<AttendeeModel> attendees;
  final List ticketsType;

  EventModel({
    required this.id,
    required this.imageUrl,
    required this.eventName,
    required this.description,
    required this.location,
    required this.eventType,
    required this.category,
    required this.date,
    required this.totalTickets,
    required this.availableTickets,
    required this.attendees,
    required this.ticketsType,
  });

  static DateTime _fromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);

  static int _toJson(DateTime dateTime) =>
      dateTime.toUtc().millisecondsSinceEpoch;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
