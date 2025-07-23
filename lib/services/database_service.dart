import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import 'package:project/models/event.dart';
import 'package:project/models/user.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  Future<void> saveUser(UserModel user) async {
    try {
      await _db.child('users').child(user.uid).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      final snapshot = await _db.child('users').child(uid).get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return UserModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchOrganizerStats(String uid) async {
    try {
      final snapshot = await _db.child('users').child(uid).get();
      if (snapshot.exists) {
        final data = snapshot.value as Map;
        return {
          'totalCommission': data['totalCommission'] ?? 0,
          'totalEventsCreated': data['totalEventsCreated'] ?? 0,
          'ticketsSold': data['ticketsSold'] ?? 0,
        };
      } else {
        return {
          'totalCommission': 0,
          'totalEventsCreated': 0,
          'ticketsSold': 0,
        };
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventModel>> fetchEvents() async {
    try {
      final snapshot = await _db.child('events').get();
      List<EventModel> events = [];
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        data.forEach((key, value) {
          events.add(EventModel.fromJson(Map<String, dynamic>.from(value)));
        });
      }
      return events;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveEventToDatabase({
    required String imageUrl,
    required String eventName,
    required String description,
    required String location,
    required String eventType,
    required String category,
    required DateTime date,
    required int totalTickets,
    required List<Map<String, dynamic>> ticketsType,
  }) async {
    try {
      final DatabaseReference ref = FirebaseDatabase.instance.ref("events");
      final String eventId = const Uuid().v4();
      final EventModel event = EventModel(
        id: eventId,
        imageUrl: imageUrl,
        eventName: eventName,
        description: description,
        location: location,
        eventType: eventType,
        category: category,
        date: date,
        totalTickets: totalTickets,
        availableTickets: totalTickets,
        attendees: [],
        ticketsType: ticketsType,
      );

      await ref.child(eventId).set(event.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventModel>> fetchEventsToday() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(Duration(days: 1));

      final startAt = startOfDay.millisecondsSinceEpoch;
      final endAt = endOfDay.millisecondsSinceEpoch;

      final snapshot = await _db
          .child('events')
          .orderByChild('date')
          .startAt(startAt)
          .endAt(endAt)
          .get();

      List<EventModel> events = [];
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        data.forEach((key, value) {
          events.add(EventModel.fromJson(Map<String, dynamic>.from(value)));
        });

        events.sort((a, b) => a.date.compareTo(b.date));
      }

      Logger().d(events.length);
      for (var event in events) {
        Logger().d(event.toJson());
      }

      return events;
    } catch (e) {
      rethrow;
    }
  }
}
