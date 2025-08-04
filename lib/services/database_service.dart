import 'package:firebase_database/firebase_database.dart';
import 'package:project/models/attendee.dart';
import 'package:project/models/event.dart';
import 'package:project/models/ticket.dart';
import 'package:project/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/services/auth_service.dart';

class DatabaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();
  final _auth = FirebaseAuth.instance;

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
        final data = Map<String, dynamic>.from(snapshot.value as Map);

        final user = UserModel.fromJson(Map<String, dynamic>.from(data));

        return {
          'totalCommission': user.totalCommission ?? 0,
          'totalEventsCreated': user.totalEventsCreated ?? 0,
          'ticketsSold': user.ticketsSold ?? 0,
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

  Future<List<EventModel>> fetchUpcomingEvents() async {
  try {
    final snapshot = await _db.child('events').get();
    if (!snapshot.exists) return [];
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    final data = Map<String, dynamic>.from(snapshot.value as Map);
    final events = data.values
        .map((e) => EventModel.fromJson(Map<String, dynamic>.from(e)))
        .where((event) {
          final date = DateTime(event.date.year, event.date.month, event.date.day);
          return !date.isBefore(todayDate);
        })
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return events;
  } catch (e) {
    rethrow;
  }
}


  Future<List<EventModel>> fetchOrganizerEventsByID(String organizerId) async {
    try {
      final snapshot = await _db
          .child('events')
          .orderByChild('organizerId')
          .equalTo(organizerId)
          .get();

      List<EventModel> events = [];

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        data.forEach((key, value) {
          events.add(EventModel.fromJson(Map<String, dynamic>.from(value)));
        });

        events.sort((a, b) => b.date.compareTo(a.date));
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
    required String organizerId,
    required String category,
    required DateTime date,
    required int totalTickets,
    required List<Map<String, dynamic>> ticketsType,
  }) async {
    try {
      final DatabaseReference ref = _db.child("events");
      final organizerRef = _db.child('users/${AuthService().currentUser?.uid}');
      final newEventRef = ref.push();
      final String eventId = newEventRef.key!;
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
        organizerId: organizerId,
      );
      final snapshot = await organizerRef.get();
      final user =
          UserModel.fromJson(Map<String, dynamic>.from(snapshot.value as Map));
      final updatedUser = user.copyWith(
        totalEventsCreated: user.totalEventsCreated! + 1,
      );

      await organizerRef.set(updatedUser.toJson());
      await newEventRef.set(event.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventModel>> fetchTodayEventsByOrganizer(
      String organizerId) async {
    try {
      final snapshot = await _db
          .child('events')
          .orderByChild('organizerId')
          .equalTo(organizerId)
          .get();
      List<EventModel> events = [];
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);

        final now = DateTime.now();
        final startOfDay =
            DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
        final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
            .millisecondsSinceEpoch;

        data.forEach((key, value) {
          final map = Map<String, dynamic>.from(value);
          final eventDate = map['date'];
          if (eventDate is int &&
              eventDate >= startOfDay &&
              eventDate <= endOfDay) {
            final event = EventModel.fromJson(map);
            events.add(event);
          }
        });
        events.sort((a, b) => b.date.compareTo(a.date));
      }
      return events;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEventInDatabase(EventModel event) async {
    try {
      await _db.child('events').child(event.id).update(event.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEventFromDatabase(String eventId) async {
    try {
      await _db.child('events').child(eventId).remove();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String phone,
    String? organizationName,
  }) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception('User not authenticated');

      final ref = _db.child('users/$uid');

      await ref.update({
        'name': name,
        'phone': phone,
        'organizationName': organizationName,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getOrganizerById(String organizerId) async {
    try {
      final snapshot = await _db.child('users/$organizerId').get();
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

  Future<void> handleSuccessfulPurchase({
    required EventModel event,
    required int ticketsBought,
    required double ticketPrice,
    required String buyerId,
    required String ticketType,
    required String organizerName,
  }) async {
    try {
      final eventRef = _db.child('events/${event.id}');
      final attendeesRef = eventRef.child('attendees');
      final organizerRef = _db.child('users/${event.organizerId}');
      final buyerTicketsRef = _db.child('tickets/$buyerId');

      if (event.availableTickets < ticketsBought) {
        throw Exception('Not enough tickets available');
      }

      final newAttendeeRef = attendeesRef.push();
      final attendeeId = newAttendeeRef.key!;
      final attendee = AttendeeModel(
        id: attendeeId,
        uid: buyerId,
        ticketsBought: ticketsBought,
        timestamp: DateTime.now(),
        isChecked: false,
      );
      await newAttendeeRef.set(attendee.toJson());

      await eventRef.update({
        'availableTickets': event.availableTickets - ticketsBought,
      });

      final organizerSnapshot = await organizerRef.get();
      if (!organizerSnapshot.exists) {
        throw Exception('Organizer not found');
      }

      final organizerModel = UserModel.fromJson(
        Map<String, dynamic>.from(organizerSnapshot.value as Map),
      );

      final updatedOrganizer = organizerModel.copyWith(
        ticketsSold: (organizerModel.ticketsSold ?? 0) + ticketsBought,
        totalCommission: (organizerModel.totalCommission ?? 0.0) +
            (ticketPrice * ticketsBought),
      );
      await organizerRef.set(updatedOrganizer.toJson());

      final creatorRef = _db.child('users/${event.organizerId}');
      final creatorSnapshot = await creatorRef.get();

      if (creatorSnapshot.exists) {
        final creatorModel = UserModel.fromJson(
          Map<String, dynamic>.from(creatorSnapshot.value as Map),
        );

        final updatedCreator = creatorModel.copyWith(
          totalCommission: (creatorModel.totalCommission ?? 0.0) +
              (ticketPrice * ticketsBought),
        );
        await creatorRef.set(updatedCreator.toJson());
      }

      final newTicketRef = buyerTicketsRef.push();
      final ticketId = newTicketRef.key!;
      final ticket = TicketModel(
        id: ticketId,
        imageUrl: event.imageUrl,
        eventName: event.eventName,
        location: event.location,
        datePurchased: DateTime.now(),
        dateOfEvent: event.date,
        ticketType: ticketType,
        eventOrganizer: organizerName,
        price: ticketPrice,
        numberOfTickets: ticketsBought,
        eventId: event.id,
        attendeeId: attendeeId,
      );

      await newTicketRef.set(ticket.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TicketModel>> fetchUserTickets(String uid) async {
    try {
      final ref = _db.child('tickets/$uid');
      final snapshot = await ref.get();

      if (!snapshot.exists) return [];

      final map = Map<String, dynamic>.from(snapshot.value as Map);
      final events = map.entries.map((e) {
        final ticketJson = Map<String, dynamic>.from(e.value);
        return TicketModel.fromJson(ticketJson);
      }).toList();

      events.sort((a, b) => b.datePurchased.compareTo(a.datePurchased));
      return events;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AttendeeModel>> fetchEventAttendees(String eventId) async {
    try {
      final snapshot = await _db.child('events/$eventId/attendees').get();

      if (!snapshot.exists) return [];

      final data = Map<String, dynamic>.from(snapshot.value as Map);

      final attendees = data.entries.map((e) {
        final attendeeData = Map<String, dynamic>.from(e.value);
        return AttendeeModel.fromJson(attendeeData);
      }).toList();

      return attendees;
    } catch (e) {
      rethrow;
    }
  }
}
