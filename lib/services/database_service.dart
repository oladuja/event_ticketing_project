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

      final userModel = UserModel.fromJson(
          Map<String, dynamic>.from(organizerSnapshot.value as Map));
      final updatedOrganizer = userModel.copyWith(
        ticketsSold: (userModel.ticketsSold ?? 0) + ticketsBought,
        totalCommission:
            (userModel.totalCommission ?? 0.0) + (ticketPrice * ticketsBought),
      );
      await organizerRef.set(updatedOrganizer.toJson());

      final newTicketRef = buyerTicketsRef.push();
      final ticketId = newTicketRef.key!;
      final ticket = TicketModel(
        id: ticketId,
        imageUrl: event.imageUrl,
        eventName: event.eventName,
        location: event.location,
        eventId: event.id,
        attendeeId: attendeeId,
        datePurchased: DateTime.now(),
        dateOfEvent: event.date,
        ticketType: ticketType,
        eventOrganizer: organizerName,
        price: ticketPrice,
        numberOfTickets: ticketsBought,
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
      return map.entries.map((e) {
        final ticketJson = Map<String, dynamic>.from(e.value);
        return TicketModel.fromJson(ticketJson);
      }).toList();
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
