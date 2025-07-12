import 'package:firebase_database/firebase_database.dart';
import 'package:project/models/user.dart';

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
  }

  Future<List<Map<String, dynamic>>> fetchLiveEvents(String uid) async {
    final snapshot = await _db.child('events').child(uid).get();
    List<Map<String, dynamic>> events = [];

    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      data.forEach((key, value) {
        events.add(Map<String, dynamic>.from(value));
      });
    }

    return events;
  }
}
