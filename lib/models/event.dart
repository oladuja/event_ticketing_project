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
  final String organizerId;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime date;

  final int totalTickets;
  final int availableTickets;

  @JsonKey(fromJson: _attendeesFromJson, defaultValue: [])
  final List<AttendeeModel> attendees;

  @JsonKey(fromJson: _ticketsTypeFromJson, defaultValue: [])
  final List<Map<String, dynamic>> ticketsType;

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
    required this.organizerId,
    required this.ticketsType,
  });

  EventModel copyWith({
    String? id,
    String? imageUrl,
    String? eventName,
    String? description,
    String? location,
    String? eventType,
    String? organizerId,
    String? category,
    DateTime? date,
    int? totalTickets,
    int? availableTickets,
    List<AttendeeModel>? attendees,
    List<Map<String, dynamic>>? ticketsType,
  }) {
    return EventModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      eventName: eventName ?? this.eventName,
      description: description ?? this.description,
      location: location ?? this.location,
      eventType: eventType ?? this.eventType,
      category: category ?? this.category,
      date: date ?? this.date,
      totalTickets: totalTickets ?? this.totalTickets,
      organizerId: organizerId ?? this.organizerId,
      availableTickets: availableTickets ?? this.availableTickets,
      attendees: attendees ?? this.attendees,
      ticketsType: ticketsType ?? this.ticketsType,
    );
  }

  static DateTime _fromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);

  static int _toJson(DateTime dateTime) =>
      dateTime.toUtc().millisecondsSinceEpoch;

  static List<AttendeeModel> _attendeesFromJson(dynamic json) {
    if (json == null) return [];
    return (json as List)
        .map((e) => AttendeeModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static List<Map<String, dynamic>> _ticketsTypeFromJson(dynamic json) {
    if (json == null) return [];
    return (json as List).map((e) => Map<String, dynamic>.from(e)).toList();
  }

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
