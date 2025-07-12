// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      date: DateTime.parse(json['date'] as String),
      price: (json['price'] as num).toInt(),
      totalTickets: (json['totalTickets'] as num).toInt(),
      availableTickets: (json['availableTickets'] as num).toInt(),
      attendees: (json['attendees'] as List<dynamic>)
          .map((e) => AttendeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
      'date': instance.date.toIso8601String(),
      'price': instance.price,
      'totalTickets': instance.totalTickets,
      'availableTickets': instance.availableTickets,
      'attendees': instance.attendees.map((e) => e.toJson()).toList(),
    };
