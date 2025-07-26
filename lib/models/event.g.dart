// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      eventName: json['eventName'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      eventType: json['eventType'] as String,
      category: json['category'] as String,
      date: EventModel._fromJson((json['date'] as num).toInt()),
      totalTickets: (json['totalTickets'] as num).toInt(),
      availableTickets: (json['availableTickets'] as num).toInt(),
      attendees: json['attendees'] == null
          ? []
          : EventModel._attendeesFromJson(json['attendees']),
      organizerId: json['organizerId'] as String,
      ticketsType: json['ticketsType'] == null
          ? []
          : EventModel._ticketsTypeFromJson(json['ticketsType']),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'eventName': instance.eventName,
      'description': instance.description,
      'location': instance.location,
      'eventType': instance.eventType,
      'category': instance.category,
      'organizerId': instance.organizerId,
      'date': EventModel._toJson(instance.date),
      'totalTickets': instance.totalTickets,
      'availableTickets': instance.availableTickets,
      'attendees': instance.attendees.map((e) => e.toJson()).toList(),
      'ticketsType': instance.ticketsType,
    };
