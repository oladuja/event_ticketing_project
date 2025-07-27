// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      ticketName: json['ticketName'] as String,
      location: json['location'] as String,
      datePurchased:
          TicketModel._fromJson((json['datePurchased'] as num).toInt()),
      dateOfEvent: TicketModel._fromJson((json['dateOfEvent'] as num).toInt()),
      ticketType: json['ticketType'] as String,
      eventOrganizer: json['eventOrganizer'] as String,
      price: (json['price'] as num).toDouble(),
      numberOfTickets: (json['numberOfTickets'] as num).toInt(),
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'ticketName': instance.ticketName,
      'location': instance.location,
      'datePurchased': TicketModel._toJson(instance.datePurchased),
      'dateOfEvent': TicketModel._toJson(instance.dateOfEvent),
      'ticketType': instance.ticketType,
      'eventOrganizer': instance.eventOrganizer,
      'price': instance.price,
      'numberOfTickets': instance.numberOfTickets,
    };
