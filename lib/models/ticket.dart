import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class TicketModel {
  final String id;
  final String eventId;
  final String ticketName;
  final String location;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime datePurchased;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime dateOfEvent;
  final String ticketType;

  final String eventOrganizer;
  final double price;
  final int numberOfTickets;

  TicketModel({
    required this.id,
    required this.eventId,
    required this.ticketName,
    required this.location,
    required this.datePurchased,
    required this.dateOfEvent,
    required this.ticketType,
    required this.eventOrganizer,
    required this.price,
    required this.numberOfTickets,
  });

  static DateTime _fromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);

  static int _toJson(DateTime dateTime) =>
      dateTime.toUtc().millisecondsSinceEpoch;

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
